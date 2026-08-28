---
name: jd-retail-data-workflow
description: Plan, collect, validate, and analyze JD platform data from JD Shangzhi, authorized JD Open Platform APIs, exports, and user files. Use when a task requires 京东商智、京东开放平台、京东行业/自店/供应商数据或可追溯证据链. Do not use for ordinary JD shopping, generic competitor-image research, or non-JD trend research.
---

# JD Retail Data Workflow

Use this Skill as a routing and evidence discipline, not as a promise that every JD dataset has a public API.

## 1. Choose one operating mode

Identify the current mode from the user's instruction and existing task state. Do not restart completed work.

| Mode | Use when | Required behavior |
|---|---|---|
| `AUDIT` | The user asks what data is available, where it comes from, or what remains missing | Produce a capability/data inventory; do not infer trends |
| `COLLECT` | The user asks to pull, export, or inspect data, especially “先取数，不要分析” | Collect and verify only; interpretation is prohibited until the user advances the task |
| `ANALYZE` | Compatible data already exists or the user explicitly asks for findings | Analyze only the verified scope; record gaps instead of restarting collection |
| `EVIDENCE` | The user asks for proof, calculations, source notes, charts, or a report handoff | Link every claim to data, calculation, evidence type, and limitation |

Use [data-pull-manifest.csv](assets/data-pull-manifest.csv) as the checkpoint for multi-round work. Before continuing, read the current manifest and report completed items, blockers, user actions, and remaining rounds. Update status with only: `planned`, `in_progress`, `waiting_user`, `exported`, `verified`, or `unavailable`.

Do not enter `ANALYZE` from `COLLECT` merely because some data has arrived. Advance only when the user asks for analysis or the original request explicitly included it and the required data is verified.

## 2. Route the data source

Read [source-router.md](references/source-router.md), then classify the requested object:

- Industry market, rankings, search terms, attribute shares, or industry forecast: use JD Shangzhi first.
- Own POP store: test an authorized official API only when the account, application, identity, permission package, and endpoint are verified; otherwise use Shangzhi export.
- JD self-operated / VC supplier: prefer APIs that explicitly support `supplier` or `userPin`; do not substitute POP endpoints.
- Existing exports or user files: analyze them first and reopen Shangzhi only for a documented gap.

For a new `AUDIT` or `COLLECT` task, state category scope, time windows, comparison periods, grain, metrics, source module, extraction method, and expected limitations. In `ANALYZE`, use existing verified files first and collect only documented gaps.

## 3. Collect from JD Shangzhi

Read [shangzhi-module-map.md](references/shangzhi-module-map.md).

- Use the user's signed-in browser session only through normal page interactions.
- Prefer page export and Download Center retrieval over manual transcription.
- If export is unavailable, capture the visible table or chart values and record that method.
- Never read, store, or replay cookies, local storage, passwords, tokens, AppKey, AppSecret, or private network requests.
- Do not describe an internal page request as a stable or official API.
- When a page is blank, stale, migrated, or errors repeatedly, follow [troubleshooting.md](references/troubleshooting.md) and preserve the blocker.

## 4. Use official JD APIs conservatively

Read [official-api-catalog.md](references/official-api-catalog.md) and [identity-and-permissions.md](references/identity-and-permissions.md).

An endpoint is only a candidate until a minimum authenticated call succeeds in the user's current application. Before calling it, verify:

1. account and enterprise identity;
2. application type and status;
3. authorized permission package;
4. OAuth/access-token requirement;
5. business identity supported by the endpoint (`vender`, `supplier`, or `userPin`);
6. exact documented request and response schema;
7. metric compatibility with Shangzhi.

Do not expose secrets in logs or artifacts. Do not create applications, request permissions, change platform configuration, or send production requests without user authorization.

## 5. Normalize before analysis

Read [metric-dictionary.md](references/metric-dictionary.md) and [time-window-and-seasonality.md](references/time-window-and-seasonality.md).

Every dataset must retain:

- source system, module, URL or interface name;
- business identity and account scope;
- category/product scope;
- start and end date, grain, timezone, and MTD/full-period status;
- raw metric name, normalized metric, value, unit, and currency;
- comparison definition, extraction method, and quality note.

Never combine transaction GMV, paid amount, financial revenue, sales quantity, or inventory value without an explicit reconciliation note. Label partial periods and unmatched intervals.

## 6. Analyze in evidence order

For product-trend work, use this order:

1. market scale and momentum;
2. seasonal comparison;
3. category, price-band, and product-attribute structure;
4. search demand and conversion signals;
5. built-in forecast and seasonal extrapolation;
6. brand and competitor evidence;
7. own-store or supplier validation.

For luxury work, read [luxury-category-attributes.md](references/luxury-category-attributes.md). Derive category scope from the current brief or an explicitly continued project; do not turn a prior project's exclusions into global defaults. Keep selected categories separate in collection, charts, and conclusions.

## 7. Build the evidence chain

Read [evidence-and-confidence.md](references/evidence-and-confidence.md). Each conclusion must link to one or more source rows, calculations, and a confidence label. A directional claim needs at least two compatible observations or one direct time-series measure. A forecast must separate:

- observed history;
- JD Shangzhi's available forecast horizon;
- extrapolation beyond that horizon;
- assumptions and uncertainty.

Classify evidence as `observed`, `calculated`, `platform_forecast`, `extrapolated`, `proxy`, or `unavailable`. A proxy cannot support a trend claim by itself. Do not turn data gaps into conclusions; use `unavailable` or “not verified” when appropriate.

## 8. Deliverables

Use [data-request-checklist.md](assets/data-request-checklist.md) for collection planning and [evidence-table-template.csv](assets/evidence-table-template.csv) for traceability. Deliver:

- data inventory and gaps;
- normalized source table;
- calculation notes;
- evidence-linked findings;
- confidence and limitations;
- source links or file references.

Stop and ask for user action only when login, export completion, a permission grant, or an account/business identity decision is genuinely required.
