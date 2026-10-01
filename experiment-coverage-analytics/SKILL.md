---
name: experiment-coverage-analytics
description: >-
  redBus India experiment and coverage SQL: Insurance Lite AB funnel and attach,
  Primo (hft = 2) operator coverage on a fixed SD list, and Mobweb daily login
  and signup funnels. Use when the user asks about Insurance Lite, INSURANCE_LITE_AB,
  Primo BO, Primo operator, Mobweb login, Mobweb signup, or mweb funnel.
---

# Insurance Lite, Primo, Mobweb

Run [`references/`](references/) on Data Platform / Iceberg. Change only the date window. Default country IND. IST day start = previous day `18:30` UTC unless the file states a UTC window explicitly.

## Insurance Lite AB

Variant from `channel_exp_info` on `search_route_details`:

`INSURANCE_LITE_AB:V0` / `V1` / `V2` / `V3`. Anything else is `others`. Take `MAX` of the CASE so one session has one variant.

Channel is Android IND. Confirmed step in the Q1 funnel is `confirm_order_details`. Later files add FC, TI, TG, premium, coverage, ASP bucket, and RAP revenue. Keep the file's metric; do not swap confirm_order for `bus_ticket_events` inside these queries.

| Ask | File |
|---|---|
| Funnel by variant | [insurance_lite_ab_q1_funnel.sql](references/insurance_lite_ab_q1_funnel.sql) |
| Coverage attach | [insurance_lite_ab_part1_coverage_attach.sql](references/insurance_lite_ab_part1_coverage_attach.sql) |
| ASP bucket × TI | [insurance_lite_ab_part2_asp_bucket_ti.sql](references/insurance_lite_ab_part2_asp_bucket_ti.sql) |
| FC / TI / TG attach | [insurance_lite_ab_q2_fc_ti_tg_attach.sql](references/insurance_lite_ab_q2_fc_ti_tg_attach.sql) |
| TI premium and coverage attach | [insurance_lite_ab_q2_ti_premium_coverage_attach.sql](references/insurance_lite_ab_q2_ti_premium_coverage_attach.sql) |
| RAP revenue | [insurance_lite_ab_q2b_rap_rev.sql](references/insurance_lite_ab_q2b_rap_rev.sql) |
| ASP × TI | [insurance_lite_ab_q3_asp_ti.sql](references/insurance_lite_ab_q3_asp_ti.sql) |
| ASP bucket / variant | [insurance_lite_ab_q3a_asp_bucket.sql](references/insurance_lite_ab_q3a_asp_bucket.sql), [insurance_lite_ab_q3b_asp_variant.sql](references/insurance_lite_ab_q3b_asp_variant.sql) |
| GA funnel | [insurance_lite_ab_q4_ga_funnel.sql](references/insurance_lite_ab_q4_ga_funnel.sql) |

## Primo operators

`transaction.bus_ticket_events`: `country_code = 'IND'`, `event_type = 101`, `hft = 2` (Primo). `BO_ID` = `operator_id`. SD list is the `VALUES` block in the file (263 SDs in the detailed file). Do not drop or extend that list unless the user supplies new pairs.

| Ask | File |
|---|---|
| All listed SDs × Primo operator | [primo_sd_bo_id_queries.sql](references/primo_sd_bo_id_queries.sql) |
| Compact all-SD BO list | [primo_all_sds_bo_id.sql](references/primo_all_sds_bo_id.sql) |

## Mobweb login and signup

Login = `capi.uid_login_action` with channel in `MOBILE_WEB`, `MOBWEB`, `MWEB`, `MOB_WEB`. `login_datetime` is treated as UTC; the SQL adds 330 minutes for the IST day. Same-day funnel joins that IST date to Mobweb sessions and transactions.

| Ask | File |
|---|---|
| Daily logins → sessions, funnel, transactions (about 6 months) | [mobweb_daily_logins_funnel_6m.sql](references/mobweb_daily_logins_funnel_6m.sql) |
| Daily signups, same shape | [mobweb_daily_signups_funnel_6m.sql](references/mobweb_daily_signups_funnel_6m.sql) |
