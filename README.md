# Coca-Cola Data Analysis — SQL Portfolio

## Project Overview
SQL analysis of Coca-Cola stock prices, brand sentiment from social media, 
and product portfolio data using PostgreSQL.

Built as part of my SQL learning journey, working with real datasets 
and hands-on database management in pgAdmin 4.

## Database
- **Tool:** PostgreSQL 17 + pgAdmin 4
- **Total rows:** 149,192 across 6 tables

## Tables
| Table | Rows | Description |
|---|---|---|
| coca_cola_stock | 1,258 | Daily stock prices 2019–2023 |
| tweets | 87,619 | Social media sentiment data |
| imdb_reviews | 50,000 | Product/brand reviews |
| yelp_reviews | 10,000 | Business reviews |
| brand_sentiment_summary | 300 | Sentiment aggregated by country and month |
| products | 15 | Coca-Cola product catalog |

## Key Findings
- Coca-Cola stock dropped 28% during COVID (March 2020) but recovered within months
- Public sentiment on Twitter is consistently ~23% positive across 2022–2024
- Negative tweets outnumber positive ones 2:1 — typical for social media data
- 2022 was the best stock year, averaging $61–62 with a high of $67.20

## SQL Concepts Covered
- SELECT, WHERE, GROUP BY, ORDER BY, LIMIT
- Aggregate functions: COUNT, SUM, AVG, MIN, MAX, ROUND
- CASE WHEN statements
- Subqueries
- UNION ALL
- EXTRACT for date analysis

## Tools Used
- PostgreSQL 17
- pgAdmin 4
- Data sources: Kaggle, TweetEval, Sentiment140
