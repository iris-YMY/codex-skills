# Native Feishu document delivery

Use this reference only for creating a new Feishu-native text document. Do not use it to edit an existing document.

## Content format

Write the body as Feishu DocxXML. Pass the title separately; do not include a `<title>` block in the body.

Use standard structural tags:

- paragraphs: `<p>`;
- real document sections: `<h1>` through `<h6>`;
- unordered and ordered lists: `<ul>`, `<ol>`, `<li>`;
- data with genuine rows and columns: `<table>`;
- critical warnings only: `<callout>`;
- quotations: `<blockquote>`;
- code: `<pre lang="..."><code>...</code></pre>`.

Escape text inside tags: `&` as `&amp;`, `<` as `&lt;`, and `>` as `&gt;`. Do not escape the tags themselves.

## Writing style

- Prefer coherent paragraphs for explanation, analysis, and argument.
- Use lists only for genuinely parallel items, steps, or checklists.
- Use headings only for sections worth appearing in the outline.
- Use tables only for real row-and-column data.
- Keep callouts, columns, colors, and other rich components restrained.
- Use one numbering system consistently and do not skip levels.
- Avoid duplicating the document title as the first body heading.
- Keep `AI生成，须人工审核` visible, normally as the final muted paragraph unless project rules specify another placement.

## Creation contract

The connector accepts at most 60,000 XML characters by default. For a longer document, shorten or split it into separately versioned deliverables; do not silently truncate it.

The prepare step binds all of these values for 30 minutes:

- exact title;
- XML body hash and character count;
- exact project root;
- authorized destination folder.

The create step consumes the one-time approval. It rechecks project routing, destination mode, content hash, and same-title collisions before creating the document.

Only the create step writes to Feishu. The prepare step is read-only.
