import { readFile, readdir } from 'fs/promises'
import path from 'path'

const repoRoot = new URL('../../', import.meta.url).pathname
const fshInputDir = path.join(repoRoot, 'input', 'fsh')
const fshGeneratedJson = path.join(repoRoot, 'fsh-generated', 'data', 'fsh-index.json')
const staticDir = new URL('./static/', import.meta.url).pathname

async function readFSHInstances() {
  const out = []
  try {
    const files = await readdir(fshInputDir)
    for (const f of files) {
      if (!f.endsWith('.fsh')) continue
      const p = path.join(fshInputDir, f)
      const txt = await readFile(p, 'utf8')
      const instances = []
      const lines = txt.split(/\r?\n/)
      for (let i = 0; i < lines.length; i++) {
        const line = lines[i].trim()
        const m = line.match(/^Instance:\s*(.+)/)
        if (m) {
          const name = m[1].trim()
          // find end of this instance block (next 'Instance:' or EOF)
          let end = lines.length
          for (let k = i+1; k < lines.length; k++) {
            if (lines[k].trim().match(/^Instance:\s*/)) { end = k; break }
          }
          // find InstanceOf within this block
          let type = null
          for (let j = i+1; j < end; j++) {
            const m2 = lines[j].trim().match(/^InstanceOf:\s*(.+)/)
            if (m2) { type = m2[1].trim(); break }
          }
          const snippet = lines.slice(i, end).join('\n')
          instances.push({ name, type, sourceFile: f, snippet })
          i = Math.max(i, end-1)
        }
      }
      out.push(...instances)
    }
  } catch (e) {
    // ignore if folder missing
  }
  return out
}

function extractSnippet(lines, idx) {
  const start = Math.max(0, idx-1)
  const end = Math.min(lines.length, idx+6)
  return lines.slice(start, end).join('\n')
}

async function readGeneratedIndex() {
  try {
    const txt = await readFile(fshGeneratedJson, 'utf8')
    const j = JSON.parse(txt)
    // Assume j contains an array or object with resources
    if (Array.isArray(j.resources)) return j.resources
    if (Array.isArray(j)) return j
    // maybe the file is an object with entries
    return j
  } catch (e) {
    return null
  }
}

function collectReferencesFromObject(obj, curPath = '', out = []) {
  // Recursively collect { raw, target, path } objects from a JS object
  if (!obj) return out
  if (Array.isArray(obj)) {
    for (let i = 0; i < obj.length; i++) {
      collectReferencesFromObject(obj[i], `${curPath}[${i}]`, out)
    }
    return out
  }
  if (typeof obj === 'object') {
    for (const [k, v] of Object.entries(obj)) {
      const nextPath = curPath ? `${curPath}.${k}` : k
      if (k.toLowerCase() === 'reference' && (typeof v === 'string' || typeof v === 'number')) {
        let raw = String(v)
        let target = raw
        if (raw.includes('/')) target = raw.split('/').pop()
        target = target.replace(/^urn:uuid:/i, '')
        out.push({ raw, target, path: nextPath })
      } else {
        collectReferencesFromObject(v, nextPath, out)
      }
    }
  }
  return out
}

function classify(item) {
  // Simple classification to help decision-making
  const resourceType = (item.type || item.resourceType || '')
  const criticalTypes = ['Condition','Observation','Procedure','ServiceRequest','MedicationAdministration']
  const isCritical = criticalTypes.includes(resourceType)
  return { resourceType, classification: isCritical ? 'critical' : 'routine' }
}

function jsonResponse(body, status=200) {
  return new Response(JSON.stringify(body, null, 2), {
    status,
    headers: { 'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*' }
  })
}

async function serveStatic(req) {
  const url = new URL(req.url)
  let p = url.pathname === '/' ? path.join(staticDir, 'index.html') : path.join(staticDir, url.pathname)
  try {
    const data = await readFile(p)
    const ext = path.extname(p).toLowerCase()
    const map = {'.html':'text/html','.js':'application/javascript','.css':'text/css','.png':'image/png','.json':'application/json'}
    return new Response(data, { headers: { 'Content-Type': map[ext] || 'application/octet-stream' } })
  } catch (e) {
    return new Response('Not found', { status: 404 })
  }
}

const server = Bun.serve({
  port: 3000,
  fetch: async (req) => {
    const url = new URL(req.url)
    if (url.pathname.startsWith('/api/')) {
      try {
        if (url.pathname === '/api/summary') {
          const fsh = await readFSHInstances()
          const gen = await readGeneratedIndex()
          const generatedCount = Array.isArray(gen) ? gen.length : (gen ? 1 : 0)
          const byType = {}
          for (const i of fsh) {
            const t = i.type || 'Unknown'
            byType[t] = (byType[t]||0)+1
          }
          if (Array.isArray(gen)) {
            for (const r of gen) {
              const t = r.resourceType || 'Unknown'
              byType[t] = (byType[t]||0)+1
            }
          }
          const instances = []
          // FSH instances: parse references from snippet
          for (const i of fsh) {
            const refs = []
            try {
              const lines = (i.snippet || '').split(/\r?\n/)
              for (const L of lines) {
                const line = L.trim()
                const m = line.match(/^\*?\s*([\w\[\]\.\-]+\.?reference)\s*=\s*"([^"]+)"/i)
                if (m) {
                  const pathStr = m[1].trim()
                  const raw = m[2].trim()
                  let target = raw
                  if (raw.includes('/')) target = raw.split('/').pop()
                  target = target.replace(/^urn:uuid:/i, '')
                  refs.push({ raw, target, path: pathStr, line: line })
                }
              }
            } catch (e) {}
            instances.push({ id: i.name, type: i.type || 'Unknown', source: 'fsh', snippet: i.snippet, references: refs })
          }
          // Generated resources
          if (Array.isArray(gen)) {
            for (const r of gen) {
              let refs = collectReferencesFromObject(r)
              const gid = r.id || r.name || ((r.resourceType && r.resourceType + '-' + Math.random().toString(36).slice(2,8)) || '(generated)')
              instances.push({ id: gid, type: r.resourceType || 'Unknown', source: 'generated', snippet: JSON.stringify(r, null, 2), references: refs })
            }
          }

          // Build reverse references map with context
          const reverse = {}
          for (const it of instances) {
            for (const ref of it.references || []) {
              const target = ref && ref.target ? ref.target : ref
              reverse[target] = reverse[target] || []
              reverse[target].push({ from: it.id, path: ref.path || null, raw: ref.raw || ref })
            }
          }

          const classified = instances.map(it => ({...it, ...classify(it), reverseReferences: reverse[it.id] || []}))
          return jsonResponse({ countsByType: byType, total: instances.length, instances: classified, reverseMap: reverse })
        }

        if (url.pathname === '/api/resource') {
          const q = url.searchParams.get('id') || url.searchParams.get('name')
          if (!q) return jsonResponse({ error: 'missing id/name param' }, 400)
          const fsh = await readFSHInstances()
          const found = fsh.find(x => x.name === q)
          if (found) return jsonResponse({ source: 'fsh', ...found })
          const gen = await readGeneratedIndex()
          if (Array.isArray(gen)) {
            const fg = gen.find(r => (r.id === q || r.name === q || (r.meta && r.meta.id===q)))
            if (fg) return jsonResponse({ source: 'generated', resource: fg })
          }
          return jsonResponse({ error: 'not found' }, 404)
        }

        return jsonResponse({ error: 'unknown api endpoint' }, 404)
      } catch (e) {
        return jsonResponse({ error: e.message }, 500)
      }
    }
    // static
    return serveStatic(req)
  }
})

console.log('PH eReferral Bun webapp running at http://localhost:3000')
