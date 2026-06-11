-- Table: public.coca_cola_stock

-- DROP TABLE IF EXISTS public.coca_cola_stock;

CREATE TABLE IF NOT EXISTS public.coca_cola_stock
(
    date date,
    open numeric,
    high numeric,
    low numeric,
    close numeric,
    adj_close numeric,
    volume bigint
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.coca_cola_stock
    OWNER to postgres;
-- Table: public.tweets

-- DROP TABLE IF EXISTS public.tweets;

CREATE TABLE IF NOT EXISTS public.tweets
(
    tweet_text text COLLATE pg_catalog."default",
    sentiment text COLLATE pg_catalog."default",
    source text COLLATE pg_catalog."default",
    tweet_id integer,
    country text COLLATE pg_catalog."default",
    platform text COLLATE pg_catalog."default",
    created_at date,
    likes integer,
    retweets integer,
    brand_mention text COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tweets
    OWNER to postgres;
-- Table: public.products

-- DROP TABLE IF EXISTS public.products;

CREATE TABLE IF NOT EXISTS public.products
(
    product_id integer,
    product_name text COLLATE pg_catalog."default",
    category text COLLATE pg_catalog."default",
    calories_per_100ml integer,
    launch_year integer,
    still_active integer,
    global_rank numeric
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.products
    OWNER to postgres;
-- Table: public.brand_sentiment_summary

-- DROP TABLE IF EXISTS public.brand_sentiment_summary;

CREATE TABLE IF NOT EXISTS public.brand_sentiment_summary
(
    country text COLLATE pg_catalog."default",
    year integer,
    month integer,
    total_mentions integer,
    positive_count integer,
    negative_count integer,
    neutral_count integer,
    avg_likes numeric,
    avg_retweets numeric
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.brand_sentiment_summary
    OWNER to postgres;
-- Table: public.yelp_reviews

-- DROP TABLE IF EXISTS public.yelp_reviews;

CREATE TABLE IF NOT EXISTS public.yelp_reviews
(
    review_id text COLLATE pg_catalog."default",
    rating numeric,
    review_text text COLLATE pg_catalog."default",
    date date,
    user_id text COLLATE pg_catalog."default",
    cool integer,
    useful integer,
    funny integer,
    sentiment text COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.yelp_reviews
    OWNER to postgres;
-- Table: public.imdb_reviews

-- DROP TABLE IF EXISTS public.imdb_reviews;

CREATE TABLE IF NOT EXISTS public.imdb_reviews
(
    review text COLLATE pg_catalog."default",
    sentiment text COLLATE pg_catalog."default",
    review_id integer,
    source text COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.imdb_reviews
    OWNER to postgres;