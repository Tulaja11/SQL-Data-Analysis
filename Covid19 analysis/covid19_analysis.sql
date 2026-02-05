-- database creation

CREATE DATABASE covid19_analysis;
USE covid19_analysis;

-- Counting Records
SELECT COUNT(*) AS total_countries FROM country_wise_latest;

-- Preview data
SELECT * FROM country_wise_latest LIMIT 10;

-- Queries
-- Top 10 Countries with Most COVID Cases
SELECT 
    `Country/Region` AS country_name,
    Confirmed AS total_cases,
    Deaths AS total_deaths,
    Recovered AS total_recovered,
    Active AS active_cases
FROM country_wise_latest
ORDER BY Confirmed DESC
LIMIT 10;

-- Global COVID-19 Summary
SELECT 
    SUM(Confirmed) AS worldwide_total_cases,
    SUM(Deaths) AS worldwide_total_deaths,
    SUM(Recovered) AS worldwide_total_recovered,
    SUM(Active) AS worldwide_active_cases,
    ROUND((SUM(Deaths) / SUM(Confirmed)) * 100, 2) AS global_death_rate_percent
FROM country_wise_latest;

-- Count Countries by WHO Region
SELECT 
    WHO_Region,
    COUNT(*) AS number_of_countries,
    SUM(Confirmed) AS total_cases_in_region
FROM country_wise_latest
WHERE WHO_Region IS NOT NULL
GROUP BY WHO_Region
ORDER BY total_cases_in_region DESC;

-- Countries with Highest Death Rates
SELECT 
    `Country/Region` AS country_name,
    Confirmed AS total_cases,
    Deaths AS total_deaths,
    `Deaths/100 Cases` AS death_rate_percentage,
    WHO_Region
FROM country_wise_latest
WHERE Confirmed >= 1000
ORDER BY `Deaths/100 Cases` DESC
LIMIT 15;

-- Top 15 Countries with Most Active Cases
SELECT 
    `Country/Region` AS country_name,
    Active AS active_cases,
    Confirmed AS total_cases,
    Recovered AS total_recovered,
    Deaths AS total_deaths,
    WHO_Region
FROM country_wise_latest
WHERE Active > 0
ORDER BY Active DESC
LIMIT 15;

-- Countries with Best Recovery Rates
SELECT 
    `Country/Region` AS country_name,
    Confirmed AS total_cases,
    Recovered AS total_recovered,
    `Recovered/100 Cases` AS recovery_rate_percentage,
    `Deaths/100 Cases` AS death_rate_percentage,
    WHO_Region
FROM country_wise_latest
WHERE Confirmed >= 5000
ORDER BY `Recovered/100 Cases` DESC
LIMIT 20;

-- Countries with Fastest Weekly Growth
SELECT 
    `Country/Region` AS country_name,
    Confirmed_last_week AS cases_last_week,
    Confirmed AS cases_current,
    `1_week_change` AS new_cases_this_week,
    `1_week_%_increase` AS weekly_growth_percentage,
    WHO_Region
FROM country_wise_latest
WHERE `1_week_%_increase` > 0
ORDER BY `1_week_%_increase` DESC
LIMIT 20;

-- India Detailed Analysis
SELECT 
    `Country/Region` AS country_name,
    Confirmed AS total_cases,
    Deaths AS total_deaths,
    Recovered AS total_recovered,
    Active AS active_cases,
    New_cases AS new_cases_today,
    New_deaths AS new_deaths_today,
    New_recovered AS new_recoveries_today,
    `Deaths/100 Cases` AS death_rate_percent,
    `Recovered/100 Cases` AS recovery_rate_percent,
    `1_week_change` AS weekly_case_increase,
    `1_week_%_increase` AS weekly_growth_percent,
    WHO_Region
FROM country_wise_latest
WHERE `Country/Region` = 'India';

-- Countries by Risk Level Based on New Cases
SELECT 
    `Country/Region` AS country_name,
    New_cases AS daily_new_cases,
    New_deaths AS daily_new_deaths,
    Confirmed AS total_cases,
    CASE 
        WHEN New_cases >= 5000 THEN 'Critical'
        WHEN New_cases >= 1000 THEN 'High Risk'
        WHEN New_cases >= 100 THEN 'Medium Risk'
        WHEN New_cases > 0 THEN 'Low Risk'
        ELSE 'Stable'
    END AS risk_category,
    WHO_Region
FROM country_wise_latest
ORDER BY New_cases DESC
LIMIT 10;

-- Top 5 Countries in Each WHO Region
SELECT 
    WHO_Region,
    `Country/Region` AS country_name,
    Confirmed AS total_cases,
    Deaths AS total_deaths,
    `Deaths/100 Cases` AS death_rate
FROM (
    SELECT 
        WHO_Region,
        `Country/Region`,
        Confirmed,
        Deaths,
        `Deaths/100 Cases`,
        ROW_NUMBER() OVER (PARTITION BY WHO_Region ORDER BY Confirmed DESC) AS rank_in_region
    FROM country_wise_latest
    WHERE WHO_Region IS NOT NULL
) AS ranked_data
WHERE rank_in_region <= 5
ORDER BY WHO_Region, rank_in_region;
