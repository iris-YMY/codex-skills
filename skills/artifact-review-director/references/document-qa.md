# DOCX and PDF QA

Use the installed Documents Skill for DOCX and the installed PDF Skill for PDF. Follow their render-and-inspect requirements as the authoritative technical gate.

## QA

- Render every final page and inspect it at full readable size.
- Check clipping, overlap, missing glyphs, broken images, table defects, and unexpected blank pages.
- Check page breaks, orphaned headings, stranded captions, excessive gaps, and awkward section transitions.
- Confirm headers, footers, page numbers, title treatment, margins, and heading hierarchy are consistent.
- Confirm tables use readable geometry, wrapping, padding, alignment, and sensible page breaks.
- Confirm images are sharp, correctly cropped, captioned when needed, and kept with related text.
- Confirm contents lists, internal references, numbering, citations, and links match the document.
- For PDF, confirm page count, rendering, readable fonts, usable links when required, and form-field behavior when applicable.
- For DOCX, preserve real styles, numbering, tables, and template structure rather than visual approximations.

If the owning Skill allows a documented render fallback, report `passed with limitations`; do not imply visual QA occurred.

## User review

- Up to about 10 pages: show all page renders inline when practical.
- Medium documents: show a montage plus full-size pages with material choices.
- Long documents: show outline, executive summary, montage, and flagged or decision-heavy pages.

Invite feedback by page and section. Keep the DOCX/PDF working file internal until approval unless the user explicitly asks for a draft attachment.

User judgment includes narrative emphasis, tone, level of detail, audience fit, and whether material may be published. Objective layout defects remain QA work.
