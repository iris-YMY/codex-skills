---
name: consulting-deck-strategist
description: Plan hypothesis-led business consulting decks before production. Use only when a request involves strategy, market, growth, investment, operating-model, or management analysis and needs an evidence-backed storyline, issue tree, claim-evidence map, or page blueprint. Do not use for routine PPT creation, formatting, template filling, visual redesign, or editing. Hand the resulting blueprint to the installed Presentations skill for production.
---

# Consulting Deck Strategist

Structure the business argument before slide production. Own problem framing, hypotheses, evidence boundaries, and page logic; never own PPTX implementation.

## Workflow

1. Infer the decision, audience, scope, evidence, and intended use from supplied context. Ask only when a missing choice would materially change the argument.
2. State one decision question and a provisional answer or set of competing hypotheses.
3. Build a compact MECE issue tree. Prioritize branches that could change the decision.
4. Classify material claims as fact, calculation, hypothesis, scenario, constraint, or recommendation.
5. Create a claim-evidence map and mark missing or insufficient evidence. Never render a hypothesis as established fact.
6. Create a page blueprint ordered by argument dependency. Give every page one action title, one narrative job, one proof object, and an explicit evidence boundary.
7. Continue directly when the requested direction is clear. Request confirmation only for a material unresolved choice such as mutually exclusive storylines or delivery formats.
8. Hand the settled blueprint, source ledger, calculations, brand direction, and editing requirements to the installed `presentations:Presentations` Skill.

## Routing Boundary

- Use `presentations:Presentations` alone for routine creation, editing, template filling, redesign, rendering, or QA.
- Use this Skill before Presentations only for hypothesis-led consulting or management analysis.
- If the user explicitly requires full-slide images with no editable objects, use `imagegen` for the images and Presentations for PPTX packaging and QA. Do not create another PPT production workflow.
- Do not invoke `ppt-master`, `ppt-workflow`, or `rw-consulting-ppt` as production owners.

## Reference

Read [references/consulting-blueprint.md](references/consulting-blueprint.md) when building the issue tree, claim-evidence map, blueprint, or final argument QA.
