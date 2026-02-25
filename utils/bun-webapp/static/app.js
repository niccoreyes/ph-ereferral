async function fetchSummary() {
  const res = await fetch('/api/summary')
  return res.json()
}

function renderCounts(counts) {
  const el = document.getElementById('counts')
  el.innerHTML = ''
  const list = document.createElement('div')
  list.className = 'counts'
  const max = Math.max(...Object.values(counts), 1)
  for (const [k,v] of Object.entries(counts)) {
    const item = document.createElement('div')
    item.className = 'count'
    const bar = `<div class="bar" style="width:${Math.round((v/max)*120)}px"></div>`
    item.innerHTML = `<strong>${k}</strong>: ${v} ${bar}`
    list.appendChild(item)
  }
  el.appendChild(list)
}

function renderSummaryCards(data) {
  document.getElementById('total').textContent = 'Total Items: ' + (data.total || 0)
  const critical = (data.instances||[]).filter(i => i.classification === 'critical').length
  document.getElementById('critical').textContent = 'Critical: ' + critical
}

function renderTable(instances) {
  const wrap = document.getElementById('tablewrap')
  wrap.innerHTML = ''
  // group by type for readability
  const grouped = {}
  for (const it of instances) {
    (grouped[it.type||'Unknown'] = grouped[it.type||'Unknown']||[]).push(it)
  }
  for (const [type, items] of Object.entries(grouped)) {
    const heading = document.createElement('h3')
    heading.textContent = `${type} (${items.length})`
    wrap.appendChild(heading)
    const table = document.createElement('table')
    const thead = document.createElement('thead')
    thead.innerHTML = '<tr><th>Name/ID</th><th>Source</th><th>Class</th></tr>'
    table.appendChild(thead)
    const tbody = document.createElement('tbody')
    for (const it of items) {
      const tr = document.createElement('tr')
      tr.innerHTML = `<td><a href="#" data-id="${it.id}">${it.id}</a></td><td>${it.source}</td><td><span class="badge ${it.classification||''}">${it.classification||''}</span></td>`
      tr.dataset.item = encodeURIComponent(JSON.stringify(it))
      tbody.appendChild(tr)
      // add placeholder for generated examples subrow (will be expanded on click)
    }
    table.appendChild(tbody)
    wrap.appendChild(table)
  }

  // click to show detail or expand subrow
  wrap.querySelectorAll('tr').forEach(tr => {
    tr.addEventListener('click', async (e) => {
      const it = JSON.parse(decodeURIComponent(tr.dataset.item))
      // toggle existing expanded row
      const next = tr.nextElementSibling
      if (next && next.classList.contains('expanded')) { next.remove(); return }
      // remove other expanded rows
      document.querySelectorAll('tr.expanded').forEach(r=>r.remove())
      const exp = document.createElement('tr')
      exp.className = 'expanded'
      const td = document.createElement('td')
      td.colSpan = 4
      const pre = document.createElement('pre')
      pre.textContent = it.snippet || ''
      // add references list
      const refs = document.createElement('div')
      refs.innerHTML = '<strong>References:</strong> ' + ((it.references||[]).join(', ') || 'none')
      td.appendChild(refs)
      td.appendChild(pre)
      exp.appendChild(td)
      tr.parentNode.insertBefore(exp, tr.nextSibling)
      // show detail pane as well
      const res = await fetch('/api/resource?id=' + encodeURIComponent(it.id))
      const j = await res.json()
      document.getElementById('detailpane').textContent = JSON.stringify(j, null, 2)
    })
  })
}

function applyFilter(instances) {
  const f = document.getElementById('filter')
  f.addEventListener('input', () => {
    const q = f.value.trim().toLowerCase()
    if (!q) return renderTable(instances)
    const filtered = instances.filter(i => (i.id||'').toLowerCase().includes(q) || (i.type||'').toLowerCase().includes(q) || (i.classification||'').toLowerCase().includes(q))
    renderTable(filtered)
  })
}

async function init() {
  const data = await fetchSummary()
  renderCounts(data.countsByType || {})
  renderSummaryCards(data)
  renderTable(data.instances || [])
  applyFilter(data.instances || [])
  renderRelationships(data)
}

function renderRelationships(data) {
  const wrap = document.getElementById('relationwrap')
  wrap.innerHTML = ''
  // Render each instance with detailed References and Referenced-By tables
  for (const it of data.instances || []) {
    const item = document.createElement('div')
    item.className = 'relitem'
    const title = document.createElement('h4')
    title.textContent = `${it.id} (${it.type})`
    item.appendChild(title)

    const container = document.createElement('div')
    container.className = 'rel-container'

    // References table
    const refsWrap = document.createElement('div')
    refsWrap.className = 'rel-block'
    refsWrap.innerHTML = '<h5>References</h5>'
    const refsTable = document.createElement('table')
    refsTable.innerHTML = '<thead><tr><th>Target</th><th>Path</th><th>Raw</th></tr></thead>'
    const refsBody = document.createElement('tbody')
    const refs = it.references || []
    if (refs.length === 0) {
      const tr = document.createElement('tr')
      tr.innerHTML = '<td colspan="3">none</td>'
      refsBody.appendChild(tr)
    } else {
      for (const r of refs) {
        const tr = document.createElement('tr')
        tr.innerHTML = `<td>${r.target||''}</td><td>${r.path||''}</td><td>${r.raw||''}</td>`
        refsBody.appendChild(tr)
      }
    }
    refsTable.appendChild(refsBody)
    refsWrap.appendChild(refsTable)

    // Referenced by table
    const revWrap = document.createElement('div')
    revWrap.className = 'rel-block'
    revWrap.innerHTML = '<h5>Referenced By</h5>'
    const revTable = document.createElement('table')
    revTable.innerHTML = '<thead><tr><th>From</th><th>Path</th><th>Raw</th></tr></thead>'
    const revBody = document.createElement('tbody')
    const revs = it.reverseReferences || []
    if (revs.length === 0) {
      const tr = document.createElement('tr')
      tr.innerHTML = '<td colspan="3">none</td>'
      revBody.appendChild(tr)
    } else {
      for (const r of revs) {
        const tr = document.createElement('tr')
        tr.innerHTML = `<td>${r.from||''}</td><td>${r.path||''}</td><td>${r.raw||''}</td>`
        revBody.appendChild(tr)
      }
    }
    revTable.appendChild(revBody)
    revWrap.appendChild(revTable)

    container.appendChild(refsWrap)
    container.appendChild(revWrap)
    item.appendChild(container)
    wrap.appendChild(item)
  }
}

init().catch(e => {
  document.getElementById('detailpane').textContent = 'Error: ' + e.message
})
