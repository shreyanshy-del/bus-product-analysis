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

## Layout

```
skills/
  cr-analyser/                 # CR Analyser
  cr-dim-*/                    # first dimension cuts
  women-funnel-analytics/      # also mirrored under skills/ for Agent Skills
  return-tier-pilgrim/
  lmb-newbus-analytics/
  experiment-coverage-analytics/
  toilet-cohort-analytics/
  seat-bus-images/
  metro-surface-analytics/
  filter-usage-analytics/
  syed-athena-queries/
women-funnel-analytics/        # root-level kept for backward compat
…
```

## Install

```bash
cp -R skills/cr-analyser ~/.cursor/skills/cr-analyser
cp -R skills/cr-dim-* ~/.cursor/skills/
for s in women-funnel-analytics return-tier-pilgrim lmb-newbus-analytics          experiment-coverage-analytics toilet-cohort-analytics seat-bus-images          metro-surface-analytics filter-usage-analytics syed-athena-queries; do
  cp -R "skills/$s" ~/.cursor/skills/"$s"
done
# root-level packs still work:
# cp -R women-funnel-analytics ~/.cursor/skills/
```

Or install CR Analyser from GitHub:

```bash
gh skill install shreyanshy-del/bus-product-analysis cr-analyser
```

## Publish (gh skill, preview)

```bash
gh skill publish --tag v1.0.0
```

Each skill runs the SQL in its `references/` folder. Change only the date window the user asks for. Default country is IND. Confirmed tickets use `transaction.bus_ticket_events` with `event_type = 101`.

## CR Analyser dashboard

```bash
./START_HERE.sh
# http://127.0.0.1:8080
```

Dashboard lives in **this existing repo**. Do not use `shreyanshy-del/CR-Analytics`.

## Mac (simplest)

Double-click [`CR_Analyser.html`](CR_Analyser.html) — no server needed. See [`OPEN_ON_MAC.md`](OPEN_ON_MAC.md).
