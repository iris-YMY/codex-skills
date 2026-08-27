# Official JD API catalog

Documentation last reviewed: **2026-08-27**. These are candidates from official documentation, not guaranteed entitlements. Recheck the current console and documentation at execution time and perform a minimum call.

| Interface | Intended use | Candidate identity | Permission status | Minimum call | Constraint |
|---|---|---|---|---|---|
| `jingdong.market.bdp.OLShopSum.query` | own-store platform traffic and transaction daily report | merchant/`vender`; verify | not verified | not verified | belongs to a migrated/retired Data API grouping; permission and identity restrictions apply |
| `jingdong.market.bdp.saleVenderSkuRank.query` | store SKU sales ranking | POP/`vender`; verify | not verified | not verified | documentation says it does not support self-operated store business |
| `jingdong.vss.report.jos.searchBrandPerformanceInfo` | VC supplier brand performance | `supplier`; verify | not verified | not verified | supplier/whitelist or business approval may be required |
| `jingdong.vc.item.product.get` | self-operated product details | self-operated supplier; verify | not verified | not verified | only self-operated products; completeness depends on product maintenance |
| `jingdong.category.read.findAttrsByCategoryIdUnlimitCate` | category attribute definitions | application-dependent | not verified | not verified | vocabulary only, not market share |
| `jingdong.category.read.findValuesByAttrIdUnlimit` | values for a category attribute | application-dependent | not verified | not verified | vocabulary only, not performance |
| `jingdong.pop.order.search` | POP order search | POP/`vender`; verify | not verified | not verified | do not assume applicability to VC/self-operated supplier business |

For every future verification, record `last_verified_on`, `permission_status`, `minimum_call_status`, and the successful request identity outside this static catalog. Never store credentials.

Official references:

- JOS onboarding: https://jos.jd.com/commondoc?listId=298
- Application creation: https://jos.jd.com/commondoc?listId=160
- Permission packages: https://jos.jd.com/commondoc?listId=170
- OAuth2: https://jos.jd.com/commondoc?listId=32
- Signing and calling: https://jos.jd.com/commondoc?listId=33
- SDK: https://jos.jd.com/commondoc?listId=167
- New JD Retail Open Platform: https://open.jd.com/

No verified general public API was found for Shangzhi industry overview, industry rankings, industry keyword performance, industry attribute shares, or industry forecast. Do not claim otherwise without current official documentation and a successful authorized call.
