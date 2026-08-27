# Time windows and seasonality

For a six-month forward product-trend brief, use four windows:

1. **Recent momentum:** latest six complete months or weeks available.
2. **Same period last year:** aligned calendar dates to control for current-season effects.
3. **Future-season analogue:** the most recent historical period matching the coming six-month season.
4. **Prior analogue:** the matching season one year earlier, when available, to measure seasonal trend evolution.

Example: if the observed period is spring/summer but the forecast horizon is autumn/winter, recent momentum alone is insufficient. Add last autumn/winter and the preceding autumn/winter.

## Forecast split

- Use the built-in Shangzhi forecast for the horizon it actually supplies, often roughly 12 weeks.
- Treat months 4–6 as seasonal extrapolation, not as Shangzhi forecast output, unless the product explicitly supplies them.
- Build extrapolation from matched seasonal history and current momentum; document weights and scenarios.
- Report point estimates only when uncertainty can be quantified. Otherwise use direction/range and confidence.

## Calendar controls

Annotate 618, Double 11, Lunar New Year, Qixi, National Day, markdown periods, and major launches. Match full periods to full periods and MTD to aligned MTD.
