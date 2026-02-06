CREATE DATABASE social_media_analysis;
USE social_media_analysis;

-- Check total influencers
SELECT COUNT(*) AS total_influencers FROM insta_data;

-- Preview first 10 rows
SELECT * FROM insta_data LIMIT 10;

-- QUERIES

-- Top 10 Influencers by Followers
SELECT 
    rank_no,
    channel_info AS username,
    followers,
    avg_likes,
    country
FROM insta_data
ORDER BY followers DESC
LIMIT 10;

-- Count Influencers by Country
SELECT 
    country,
    COUNT(*) AS total_influencers
FROM insta_data
WHERE country IS NOT NULL AND country != ''
GROUP BY country
ORDER BY total_influencers DESC
LIMIT 10;

-- Average Influence Score
SELECT 
    ROUND(AVG(influence_score), 2) AS avg_influence_score,
    MAX(influence_score) AS highest_score,
    MIN(influence_score) AS lowest_score
FROM insta_data;

-- Top 15 Influencers by Total Likes
SELECT 
    rank_no,
    channel_info AS username,
    total_likes,
    followers,
    posts,
    country
FROM insta_data
ORDER BY total_likes DESC
LIMIT 15;

-- High Influence Score Influencers (Score 90+)
SELECT 
    rank_no,
    channel_info AS username,
    influence_score,
    followers,
    avg_likes,
    country
FROM insta_data
WHERE influence_score >= 90
ORDER BY influence_score DESC, followers DESC;

-- Classify Influencers by Follower Size
SELECT 
    CASE 
        WHEN followers LIKE '%00.%m' OR followers LIKE '%10.%m' OR followers LIKE '%20.%m' 
             OR followers LIKE '%30.%m' OR followers LIKE '%40.%m' OR followers LIKE '%50.%m'
             OR followers > '300' THEN 'Mega Influencer (300M+)'
        WHEN followers > '100' THEN 'Large Influencer (100M-300M)'
        WHEN followers > '50' THEN 'Medium Influencer (50M-100M)'
        ELSE 'Small Influencer (Under 50M)'
    END AS influencer_category,
    COUNT(*) AS total_count,
    ROUND(AVG(influence_score), 2) AS avg_influence_score
FROM insta_data
WHERE followers IS NOT NULL AND followers != ''
GROUP BY influencer_category
ORDER BY total_count DESC;

-- Compare Top 3 Countries - USA vs India vs Brazil
SELECT 
    country,
    COUNT(*) AS total_influencers,
    ROUND(AVG(influence_score), 2) AS avg_influence_score,
    MAX(followers) AS highest_followers,
    MIN(followers) AS lowest_followers
FROM insta_data
WHERE country IN ('United States', 'India', 'Brazil')
GROUP BY country
ORDER BY total_influencers DESC;