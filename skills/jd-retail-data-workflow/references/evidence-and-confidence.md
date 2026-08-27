# Evidence chain and confidence

## Evidence record

Each claim should be traceable through:

`claim_id -> evidence_type -> source_id(s) -> raw values -> transformation/calculation -> result -> interpretation -> claim_status -> confidence -> limitations`

Minimum record:

| Field | Meaning |
|---|---|
| claim_id | stable identifier used in report/chart notes |
| claim | concise factual statement |
| evidence_type | observed / calculated / platform_forecast / extrapolated / proxy / unavailable |
| claim_status | draft / supported / unsupported / blocked |
| source_ids | exact source rows/files/modules |
| observation | raw or normalized values with dates and units |
| calculation | formula, base period, and filters |
| result | calculated change/share/rank |
| interpretation | what the result does and does not imply |
| confidence | high / medium / low |
| limitation | missing period, partial scope, proxy, or metric mismatch |

## Evidence types

- `observed`: directly present in a verified source.
- `calculated`: reproducible calculation from compatible observed values.
- `platform_forecast`: forecast explicitly produced by JD Shangzhi for its stated horizon.
- `extrapolated`: modelled beyond the platform horizon; must include assumptions and uncertainty.
- `proxy`: indirect signal such as keyword themes, product counts, titles, or images.
- `unavailable`: required evidence could not be obtained or verified.

`supported` claims require compatible `observed` or `calculated` evidence. A forecast claim may use `platform_forecast` or `extrapolated` only when the horizon and assumptions are explicit. `proxy` evidence may add context but cannot support an attribute or market trend by itself.

## Confidence guide

- **High:** direct compatible time series, complete interval, official/exported source, calculation reproducible.
- **Medium:** compatible but partial series, visible chart transcription, or one strong direct measure plus supporting signal.
- **Low:** proxy, small sample, title/image coding, keyword-only evidence, or unmatched periods.

Minimum evidence rules:

- Directional historical claim: one direct time-series measure or two compatible observations.
- Attribute trend claim: attribute-level performance over time; product counts alone are insufficient.
- Forecast claim: observed base, model/source horizon, assumption, and uncertainty.
- Competitor reference: label as example unless supported by ranking/sales evidence.
- A claim with missing required evidence must be `unsupported` or `blocked`, never silently omitted from the evidence table.
