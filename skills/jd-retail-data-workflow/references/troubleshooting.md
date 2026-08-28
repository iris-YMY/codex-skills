# Troubleshooting

## Shangzhi page is blank, stale, or errors

1. Verify the user is logged in and the page itself loads normally.
2. Confirm category, date range, and account edition.
3. Navigate to the current replacement module if the page was migrated.
4. Try the normal export and check Download Center.
5. Use visible table/chart values if available and record the extraction method.
6. After repeated failure, record the unavailable field and continue with other evidence.

Do not request screenshots when exports, downloads, visible-page reading, or user files can solve the task. Do not use cookies or internal requests as a workaround.

## Export is missing or delayed

- Check task status and file date/category before retrying.
- Avoid duplicate concurrent exports.
- Preserve the original downloaded file.
- If the export never completes, report the exact module and filters that failed.

## Documented API call fails

- `401/authorization`: refresh approved OAuth credentials; never print tokens.
- permission/identity error: verify permission package and `vender`/`supplier`/`userPin` scope.
- retired/migrated endpoint: mark unavailable and route to Shangzhi export or data-application product.
- empty result: verify identity, date, merchant/supplier scope, and whether the metric is populated.
- schema drift: reopen current official documentation and update field mappings before parsing.

Retry only transient network/rate-limit failures with bounded backoff. Do not loop on permission or product-scope errors.
