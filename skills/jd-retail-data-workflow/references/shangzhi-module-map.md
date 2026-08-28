# JD Shangzhi module map

## Industry modules

| Module | Typical output | Preferred extraction |
|---|---|---|
| Industry overview | transaction scale, buyers, orders, growth, time series | export, then visible chart/table |
| Industry feature | price band, product and consumer attributes; fields vary by category | export, then visible table |
| Product ranking | SKU/product ranking and change | export |
| Brand ranking | brand ranking and change | export; migrated pages may require replacement module |
| Store ranking | store ranking and change | export |
| Hot keywords | hot, rising, and new terms | export |
| Keyword query | search, click, conversion or related indicators | export |
| Sales forecast | platform forecast, commonly a limited forward horizon | export or visible chart values |

## Store and competition modules

Use own-store, product, traffic, transaction, competition, and supplier views when the account has access. Their metrics are not automatically interchangeable with industry modules.

## Extraction protocol

1. Confirm category path, date range, comparison, and filters in the page.
2. Export once and record the task name/time.
3. Retrieve the completed file from Download Center.
4. Preserve the original file; normalize in a separate working file.
5. Record module name, page URL, export time, date coverage, and any screen-level filters.
6. If export fails, retry only after checking login, date range, category, and task status. Then use visible values and label the method.

Known limitations: fields vary by category and account edition; some ranking pages migrate; downloadable files may be asynchronous; page rendering can fail without implying the underlying data does not exist.
