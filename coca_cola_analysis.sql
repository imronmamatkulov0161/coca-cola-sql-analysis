-- ============================================================
-- Coca-Cola Data Analysis — SQL Portfolio
-- Author: [Your Name]
-- Database: PostgreSQL 17
-- Dataset: Stock prices, tweets, reviews, products
-- ============================================================


-- ============================================================
-- SECTION 1: BASIC EXPLORATION
-- First step in any analysis — understand what you have
-- ============================================================

-- 1.1 How many rows in each table?
SELECT 'coca_cola_stock'        AS table_name, COUNT(*) AS rows FROM coca_cola_stock
UNION ALL
SELECT 'products',               COUNT(*) FROM products
UNION ALL
SELECT 'brand_sentiment_summary',COUNT(*) FROM brand_sentiment_summary
UNION ALL
SELECT 'tweets',                 COUNT(*) FROM tweets
UNION ALL
SELECT 'yelp_reviews',           COUNT(*) FROM yelp_reviews
UNION ALL
SELECT 'imdb_reviews',           COUNT(*) FROM imdb_reviews;

-- 1.2 What date range does the stock data cover?
SELECT 
    MIN(date) AS earliest_date,
    MAX(date) AS latest_date,
    MAX(date) - MIN(date) AS days_covered
FROM coca_cola_stock;

-- 1.3 What Coca-Cola products do we have?
SELECT product_name, category, launch_year, calories_per_100ml
FROM products
ORDER BY launch_year ASC;


-- ============================================================
-- SECTION 2: SENTIMENT ANALYSIS
-- Understanding how people feel about the brand
-- ============================================================

-- 2.1 Overall sentiment breakdown across all tweets
SELECT 
    sentiment,
    COUNT(*) AS total_tweets,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM tweets), 1) AS percentage
FROM tweets
GROUP BY sentiment
ORDER BY total_tweets DESC;

-- 2.2 Sentiment by country — which country is most positive?
SELECT 
    country,
    COUNT(*) AS total_tweets,
    SUM(CASE WHEN sentiment = 'positive' THEN 1 ELSE 0 END) AS positive,
    SUM(CASE WHEN sentiment = 'negative' THEN 1 ELSE 0 END) AS negative,
    ROUND(SUM(CASE WHEN sentiment = 'positive' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS positive_pct
FROM tweets
GROUP BY country
ORDER BY positive_pct DESC;

-- 2.3 Sentiment trend over time — how does it change by year?
SELECT 
    EXTRACT(YEAR FROM created_at) AS year,
    COUNT(*) AS total_tweets,
    SUM(CASE WHEN sentiment = 'positive' THEN 1 ELSE 0 END) AS positive,
    SUM(CASE WHEN sentiment = 'negative' THEN 1 ELSE 0 END) AS negative,
    ROUND(SUM(CASE WHEN sentiment = 'positive' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS positive_pct
FROM tweets
GROUP BY year
ORDER BY year ASC;

-- 2.4 Which tweets got the most engagement (likes)?
SELECT 
    tweet_text,
    sentiment,
    country,
    likes,
    retweets
FROM tweets
ORDER BY likes DESC
LIMIT 10;

-- 2.5 Average likes by sentiment — do positive tweets get more likes?
SELECT 
    sentiment,
    ROUND(AVG(likes), 0)    AS avg_likes,
    ROUND(AVG(retweets), 0) AS avg_retweets,
    MAX(likes)              AS max_likes
FROM tweets
GROUP BY sentiment
ORDER BY avg_likes DESC;


-- ============================================================
-- SECTION 3: STOCK PRICE ANALYSIS
-- Understanding Coca-Cola's stock performance
-- ============================================================

-- 3.1 Best single trading days (biggest price gain)
SELECT
    date,
    ROUND(open, 2)  AS open,
    ROUND(close, 2) AS close,
    ROUND((close - open), 2) AS daily_change,
    CASE 
        WHEN close > open THEN 'Price went up'
        WHEN close < open THEN 'Price went down'
        ELSE 'No change'
    END AS direction
FROM coca_cola_stock
ORDER BY daily_change DESC
LIMIT 10;

-- 3.2 Worst single trading days (biggest price drop)
SELECT
    date,
    ROUND(open, 2)  AS open,
    ROUND(close, 2) AS close,
    ROUND((close - open), 2) AS daily_change
FROM coca_cola_stock
ORDER BY daily_change ASC
LIMIT 10;

-- 3.3 Average stock price by year
SELECT
    EXTRACT(YEAR FROM date) AS year,
    ROUND(AVG(open), 2)     AS avg_open,
    ROUND(AVG(close), 2)    AS avg_close,
    ROUND(MIN(low), 2)      AS yearly_low,
    ROUND(MAX(high), 2)     AS yearly_high
FROM coca_cola_stock
GROUP BY year
ORDER BY year ASC;

-- 3.4 Highest volume trading days (most shares traded)
SELECT
    date,
    volume,
    ROUND(close, 2) AS close_price
FROM coca_cola_stock
ORDER BY volume DESC
LIMIT 10;


-- ============================================================
-- SECTION 4: PRODUCT ANALYSIS
-- Understanding the Coca-Cola product portfolio
-- ============================================================

-- 4.1 Products by category
SELECT 
    category,
    COUNT(*) AS number_of_products,
    ROUND(AVG(calories_per_100ml), 0) AS avg_calories
FROM products
GROUP BY category
ORDER BY number_of_products DESC;

-- 4.2 Active vs discontinued products
SELECT
    CASE WHEN still_active = 1 THEN 'Active' ELSE 'Discontinued' END AS status,
    COUNT(*) AS products
FROM products
GROUP BY still_active;

-- 4.3 Lowest calorie products (healthiest options)
SELECT 
    product_name,
    category,
    calories_per_100ml
FROM products
ORDER BY calories_per_100ml ASC
LIMIT 5;


-- ============================================================
-- SECTION 5: ADVANCED — JOINING TABLES
-- Combining data from multiple tables for deeper insights
-- ============================================================

-- 5.1 Sentiment summary joined with monthly trends
SELECT 
    b.country,
    b.year,
    b.month,
    b.total_mentions,
    b.positive_count,
    b.negative_count,
    ROUND(b.positive_count * 100.0 / b.total_mentions, 1) AS positive_pct
FROM brand_sentiment_summary b
WHERE b.total_mentions > 10
ORDER BY b.positive_pct DESC
LIMIT 20;

-- 5.2 Yelp reviews — rating distribution
SELECT
    rating,
    COUNT(*)  AS reviews,
    sentiment,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM yelp_reviews), 1) AS pct
FROM yelp_reviews
GROUP BY rating, sentiment
ORDER BY rating DESC;

-- 5.3 IMDB reviews sentiment breakdown
SELECT
    sentiment,
    COUNT(*) AS reviews,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM imdb_reviews), 1) AS percentage
FROM imdb_reviews
GROUP BY sentiment
ORDER BY reviews DESC;
