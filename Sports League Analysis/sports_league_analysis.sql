create database sports_league;
use sports_league;

-- Check total matches
SELECT COUNT(*) AS total_matches FROM football_matches;

-- Preview data
SELECT * FROM football_matches LIMIT 10;

-- Check seasons
SELECT season, COUNT(*) AS matches_per_season 
FROM football_matches 
GROUP BY season 
ORDER BY season;

-- Highest Scoring Matches 
SELECT 
    match_id,
    match_date,
    season,
    home_team,
    away_team,
    home_goals,
    away_goals,
    (home_goals + away_goals) AS total_goals,
    result,
    CONCAT(home_team, ' ', home_goals, '-', away_goals, ' ', away_team) AS match_summary
FROM football_matches
ORDER BY total_goals DESC, match_date DESC
LIMIT 20;

-- Match Results Distribution (Home/Away/Draw)
SELECT 
    result,
    CASE 
        WHEN result = 'H' THEN 'Home Win'
        WHEN result = 'A' THEN 'Away Win'
        WHEN result = 'D' THEN 'Draw'
    END AS result_type,
    COUNT(*) AS match_count,
    ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM football_matches)), 2) AS percentage
FROM football_matches
GROUP BY result
ORDER BY match_count DESC;

-- Season-by-Season Performance Trends
SELECT 
    season,
    COUNT(*) AS total_matches,
    SUM(home_goals + away_goals) AS total_goals,
    ROUND(AVG(home_goals + away_goals), 2) AS avg_goals_per_match,
    SUM(CASE WHEN result = 'H' THEN 1 ELSE 0 END) AS home_wins,
    SUM(CASE WHEN result = 'A' THEN 1 ELSE 0 END) AS away_wins,
    SUM(CASE WHEN result = 'D' THEN 1 ELSE 0 END) AS draws,
    ROUND(SUM(CASE WHEN result = 'H' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS home_win_percentage,
    ROUND(AVG(home_shots), 2) AS avg_home_shots,
    ROUND(AVG(away_shots), 2) AS avg_away_shots,
    MAX(home_goals + away_goals) AS highest_scoring_match
FROM football_matches
GROUP BY season
ORDER BY season;

-- Average Goals Per Match by Season
SELECT 
    season,
    COUNT(*) AS total_matches,
    SUM(home_goals + away_goals) AS total_goals,
    ROUND(AVG(home_goals + away_goals), 2) AS avg_goals_per_match,
    MAX(home_goals + away_goals) AS highest_scoring_match,
    MIN(home_goals + away_goals) AS lowest_scoring_match
FROM football_matches
GROUP BY season
ORDER BY season;

-- Top 10 Teams by Total Wins
SELECT 
    home_team AS team_name,
    COUNT(*) AS total_wins,
    SUM(home_goals) AS total_goals_scored
FROM football_matches
WHERE result = 'H'
GROUP BY home_team

UNION ALL

SELECT 
    away_team AS team_name,
    COUNT(*) AS total_wins,
    SUM(away_goals) AS total_goals_scored
FROM football_matches
WHERE result = 'A'
GROUP BY away_team

ORDER BY total_wins DESC
LIMIT 10;
