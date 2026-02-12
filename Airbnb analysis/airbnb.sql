-- database creation
CREATE DATABASE air_bnb_analysis;
use air_bnb_analysis;

-- QUERIES

-- Total Listings
SELECT COUNT(*) AS total_listings
FROM airbnb_records;

-- Average Price by City
SELECT city,
       ROUND(AVG(price),2) AS avg_price
FROM airbnb_records
GROUP BY city
ORDER BY avg_price DESC;

-- Most Expensive City
SELECT city,
       MAX(price) AS highest_price
FROM airbnb_records
GROUP BY city
ORDER BY highest_price DESC
LIMIT 1;

-- Room Type Distribution
SELECT room_type,
       COUNT(*) AS total_listings
FROM airbnb_records
GROUP BY room_type;

-- Top 10 Most Reviewed Listings
SELECT listing_id,
       number_of_reviews
FROM airbnb_records
ORDER BY number_of_reviews DESC
LIMIT 10;

-- Hosts with Most Listings
SELECT host_id,
       COUNT(*) AS listings
FROM airbnb_records
GROUP BY host_id
ORDER BY listings DESC
LIMIT 10;

-- Budget vs Luxury Listings
SELECT
    CASE
        WHEN price < 100 THEN 'Budget'
        WHEN price BETWEEN 100 AND 250 THEN 'Mid-range'
        ELSE 'Luxury'
    END AS price_category,
    COUNT(*) AS listings
FROM airbnb_records
GROUP BY price_category;

-- Availability Impact on Price
SELECT
    CASE
        WHEN availability_365 < 100 THEN 'Low'
        WHEN availability_365 BETWEEN 100 AND 200 THEN 'Medium'
        ELSE 'High'
    END AS availability_level,
    ROUND(AVG(price),2) AS avg_price
FROM airbnb_records
GROUP BY availability_level;

-- High Rated Listings Count
SELECT COUNT(*) AS top_rated
FROM airbnb_records
WHERE rating >= 4.5;

-- Price vs Rating Trend
SELECT rating,
       ROUND(AVG(price),2) AS avg_price
FROM airbnb_records
GROUP BY rating
ORDER BY rating DESC;


