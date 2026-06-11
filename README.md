# Coca-Cola Stock & Sentiment Analysis (SQL)

PostgreSQL analysis of Coca-Cola's 2019–2023 stock performance and sentiment patterns in labeled social-media data — 149,192 rows across 6 tables, queried in PostgreSQL 17 / pgAdmin 4.

All queries: [`coca_cola_analysis.sql`](coca_cola_analysis.sql) · Schema: [`schema.sql`](schema.sql)

## Key findings

- **The stock fell 37.5% peak-to-trough in the early-2020 COVID crash** and did not close above its pre-crash peak again until **4 January 2022** — a recovery of nearly two years. *(§3.5–3.6)*
- **2022 was the strongest year** in the window: average close $61–62, yearly high $67.20. *(§3.3)*
- **Sentiment in the tweet corpus is ~23% positive**, with negative tweets outnumbering positive roughly 2:1 — a typical skew for social-media text. *(§2.1)*
- **Corpus sentiment does not track the stock.** Monthly positive-tweet share stayed in a narrow ~22–24% band across all of 2022–2023 while the average close moved between $56.63 and $64.53 — no co-movement. This is the expected result: the corpus is general social-media text, not Coca-Cola mentions (see Limitations). *(§6.1)*

## Data

| Table | Rows | Contents |
|---|---|---|
| `coca_cola_stock` | 1,258 | Daily OHLCV prices, Jan 2019 – Dec 2023 |
| `tweets` | 87,619 | Sentiment-labeled tweets with country, likes, retweets — dated Jan 2022 – Jun 2024 |
| `brand_sentiment_summary` | 300 | Monthly positive/negative mention counts across 10 countries |
| `products` | 15 | Coca-Cola product catalog: category, launch year, calories, status |
| `yelp_reviews` | 10,000 | Supplementary sentiment-labeled review corpus (not Coca-Cola-specific) |
| `imdb_reviews` | 50,000 | Supplementary sentiment-labeled movie-review corpus (not Coca-Cola-specific) |

Stock and tweet data overlap only in **2022–2023**, so all cross-table analysis (§6) is restricted to that window.

**Sources:** Kaggle (stock, products), TweetEval / Sentiment140-style labeled corpora (text data). Sentiment labels ship with the source datasets — no classification model was run in this project.

## Questions the analysis answers

Each section of `coca_cola_analysis.sql` answers a concrete question:

1. **Exploration** — What's in the database? Row counts, date coverage, product catalog.
2. **Sentiment** — How does sentiment split overall, by country, and by year? Do positive tweets earn more likes and retweets than negative ones?
3. **Stock** — What were the best and worst trading days? How did yearly averages, highs, and lows evolve? How deep was the 2020 drawdown, and when did the price truly recover?
4. **Products** — How does the portfolio break down by category and calories? How many products are discontinued?
5. **Supplementary corpora** — Rating and sentiment distributions in the Yelp and IMDB sets.
6. **Cross-table** — Joining daily tweet sentiment to daily closing price: did monthly sentiment and average price move together across 2022–2023?

## Reproduce

1. PostgreSQL 17 + pgAdmin 4
2. Run `schema.sql` to create the six tables
3. Import the source CSVs (pgAdmin → Import/Export)
4. Run `coca_cola_analysis.sql` section by section

## Limitations

- Sentiment labels are inherited from the upstream datasets, not computed here; label quality is that of the source corpora.
- **The tweet corpus is general labeled Twitter text, not Coca-Cola mentions** — confirmed by inspecting the highest-engagement tweets (§2.4), which cover sports, music, TV, and politics. Several top tweets reference events that predate their timestamps, so the date, country, and engagement fields appear to be assigned by the dataset rather than original tweet metadata. No brand-level conclusions are drawn from this table.
- The tweet and stock datasets overlap only in 2022–2023; sentiment around the 2020 crash cannot be examined with this data.
- The Yelp and IMDB tables are unrelated to Coca-Cola; they are included only as additional labeled corpora for sentiment-distribution queries.
- All findings are descriptive aggregations over historical data — no causal claims.

## Possible next steps

- Build a corpus of genuine Coca-Cola mentions (e.g., keyword-filtered brand data) and rerun §6 against real brand sentiment.
- Compute sentiment directly in Python (VADER or a transformer model) instead of relying on pre-assigned labels, and compare against them.

---

**Author:** Imron Mamatkulov · [GitHub](https://github.com/imronmamatkulov0161) · [LinkedIn](https://linkedin.com/in/imron-mamatkulov)
