# CR Analyser (India)

Conversion Rate dashboard for redBus India BUS.

```bash
./START_HERE.sh
# open http://127.0.0.1:8080
```

| Path | Role |
|---|---|
| `frontend/index.html` | Dashboard UI |
| `backend/main.py` | FastAPI APIs + RCA chat |
| `backend/csv_data_engine.py` | KPIs, funnel, dimensions, mix-shift |
| `backend/sql/live_cr_grain_1d.sql` | Live Iceberg/Athena grain |
| `skills/cr-analyser` | SQL CR contracts |
| `SKILLS.md` | RCA / product feature log |

**CR = TIN / SRP.** Funnel: SRP → SL → CI → TCO → PAY → PAY_NOW → CONFIRM.
