# bus-product-analysis

Cursor Agent skills for redBus India bus analyses that sit outside CR, filter-usage, metro, and the older query banks.

| Skill | Covers |
|---|---|
| `women-funnel-analytics` | Women SRP vs Regular vs Female/Male SVOC, QoQ funnel, single-women DOJ, 14-day return |
| `return-tier-pilgrim` | Mehar city tiers, onward-booker return funnel, pilgrim high/low, UPSRTC |
| `lmb-newbus-analytics` | DBD-0 LMB vs rest-of-day, New Bus (persuasion 68), unfiltered SRP rank shares |
| `experiment-coverage-analytics` | Insurance Lite AB, Primo operators, Mobweb login/signup |

## Install

```bash
cp -R women-funnel-analytics ~/.cursor/skills/
cp -R return-tier-pilgrim ~/.cursor/skills/
cp -R lmb-newbus-analytics ~/.cursor/skills/
cp -R experiment-coverage-analytics ~/.cursor/skills/
```

Each skill runs the SQL in its `references/` folder. Change only the date window the user asks for. Default country is IND. Confirmed tickets use `transaction.bus_ticket_events` with `event_type = 101`.
