# Metric dictionary and provenance

## Required provenance columns

`source_id, source_system, source_module, source_url_or_api, source_file, extraction_time, extraction_method, business_identity, category_path, product_scope, start_date, end_date, grain, timezone, period_status, raw_metric, normalized_metric, value, unit, currency, comparison_type, comparison_period, filter_notes, quality_notes`

## Metrics that must remain distinct

- transaction GMV / 商智成交金额;
- paid amount / payment amount;
- order amount before or after discount;
- financial sales or revenue;
- units sold;
- order count and buyer count;
- gross profit and gross margin;
- inventory quantity and inventory value;
- search volume/index, clicks, visitors, and conversion rate.

## Comparison rules

- Preserve whether growth is YoY, MoM, WoW, versus previous period, or versus an indexed base.
- Recalculate growth only when both numerator and denominator are available and compatible.
- Mark month-to-date and other incomplete periods; compare MTD only to an aligned MTD interval.
- If source dates use inclusive bounds, preserve them exactly.
- Do not merge different category paths, currencies, or business identities without an explicit aggregation rule.
