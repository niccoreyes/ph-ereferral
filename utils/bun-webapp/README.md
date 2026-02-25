# PH eReferral — Bun webapp

Lightweight Bun webapp to preview FSH `input/fsh/*.fsh` instances and `fsh-generated/data/fsh-index.json` output.

Run (from this folder):

```bash
cd utils/bun-webapp
bun server.js
```

Then open http://localhost:3000

Notes:
- The server reads FSH source files in `input/fsh` and the generated JSON at `fsh-generated/data/fsh-index.json` dynamically.
- API endpoints:
  - `GET /api/summary` — aggregated counts and instances
  - `GET /api/resource?id=<name|id>` — detail for a named instance or generated resource
