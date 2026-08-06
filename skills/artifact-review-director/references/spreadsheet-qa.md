# Spreadsheet QA

Use the installed Spreadsheets Skill for standalone XLSX/XLS/CSV/TSV artifacts. Its formula inspection, render verification, and export requirements are authoritative.

## QA

- Confirm expected sheets, tables, named areas, inputs, calculations, and outputs exist.
- Inspect key ranges with values and formulas, not screenshots alone.
- Scan for `#REF!`, `#DIV/0!`, `#VALUE!`, `#NAME?`, `#N/A`, unintended circular references, and broken external links.
- Check off-by-one ranges, copied-formula consistency, absolute/relative references, edge cases, and period/unit conversions.
- Reconcile key totals to source definitions or independently computed control totals.
- Confirm raw inputs are typed values and derived results remain formulas where auditability matters.
- Check dates, identifiers, percentages, currencies, precision, and units.
- Check missing values, duplicates, outliers, row counts, filters, hidden sheets/rows/columns, and stale sample data as relevant.
- Verify chart ranges, labels, units, ordering, and agreement with displayed data.
- Render every material sheet or representative working area and fix clipped labels, unreadable formats, broken charts, blank default sheets, and oversized columns/rows.
- Flag macros, data connections, hidden logic, or external references; do not remove them unless authorized.

## User review

Show:

- workbook structure and sheet purpose;
- representative key ranges as tables;
- important formulas and assumptions in plain language;
- reconciled totals and detected anomalies;
- dashboard or chart previews when visually material;
- business choices requiring confirmation.

Invite feedback by sheet and cell/range. User review confirms business definitions, assumptions, priority metrics, and usability; it does not replace formula QA or professional audit.

CSV/TSV usually need QA only unless they feed production, contain consequential data, or the user requests review.
