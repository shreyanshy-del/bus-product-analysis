# bus-product-analysis

Cursor Agent skills for redBus India bus analyses, including **CR Analyser**.

| Skill | Covers |
|---|---|
| `cr-analyser` | **CR Analyser** — India BUS CR = TIN/SRP; ordered throughput SRP→SL→CI→TCO→PAY→PAY_NOW→CONFIRM; product identity |
| `women-funnel-analytics` | Women SRP vs Regular vs Female/Male SVOC, QoQ funnel, single-women DOJ, 14-day return |
| `return-tier-pilgrim` | Mehar city tiers, onward-booker return funnel, pilgrim high/low, UPSRTC |
| `lmb-newbus-analytics` | DBD-0 LMB vs rest-of-day, New Bus (persuasion 68), unfiltered SRP rank shares |
| `experiment-coverage-analytics` | Insurance Lite AB, iOS addons payment-page AB, Primo operators, Mobweb login/signup |
| `toilet-cohort-analytics` | Toilet-on-SL vs amenity vs India, pre/post Aug 2026 (OMS) |
| `seat-bus-images` | Seat-utility image CTR, NewBusImageLoaded coverage, route txn share |
| `metro-surface-analytics` | Metro Home, Card, and Sticky on bus buddy after a metro ticket |

## Install

```bash
cp -R cr-analyser ~/.cursor/skills/
cp -R women-funnel-analytics ~/.cursor/skills/
cp -R return-tier-pilgrim ~/.cursor/skills/
cp -R lmb-newbus-analytics ~/.cursor/skills/
cp -R experiment-coverage-analytics ~/.cursor/skills/
cp -R toilet-cohort-analytics ~/.cursor/skills/
cp -R seat-bus-images ~/.cursor/skills/
cp -R metro-surface-analytics ~/.cursor/skills/
```

Or install CR Analyser from GitHub (after publish):

```bash
gh skill install shreyanshy-del/bus-product-analysis cr-analyser
```

## Publish (gh skill, preview)

```bash
gh skill publish --tag v1.0.0
```

Each skill runs the SQL in its `references/` folder. Change only the date window the user asks for. Default country is IND. Confirmed tickets use `transaction.bus_ticket_events` with `event_type = 101`.
