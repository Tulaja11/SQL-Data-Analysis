CREATE DATABASE music_stream_analysis;
use music_stream_analysis;

-- Check total songs
SELECT COUNT(*) AS total_songs FROM `spotify-2023`;

-- Preview data
SELECT * FROM `spotify-2023` LIMIT 10;

-- Top 10 Most Streamed Songs
SELECT 
    track_name,
    `artist(s)_name` AS artist_name,
    streams,
    released_year,
    in_spotify_playlists
FROM `spotify-2023`
ORDER BY streams DESC
LIMIT 10;

-- Most Popular Artists by Stream Count
SELECT 
    `artist(s)_name` AS artist_name,
    COUNT(*) AS song_count,
    SUM(streams) AS total_streams,
    ROUND(AVG(streams), 0) AS avg_streams_per_song,
    MAX(streams) AS biggest_hit_streams
FROM `spotify-2023`
GROUP BY `artist(s)_name`
ORDER BY total_streams DESC
LIMIT 15;

-- Songs Released by Year Distribution
SELECT 
    released_year,
    COUNT(*) AS song_count,
    SUM(streams) AS total_streams,
    ROUND(AVG(streams), 0) AS avg_streams
FROM `spotify-2023`
GROUP BY released_year
ORDER BY released_year DESC;

-- Audio Features Analysis (Danceability vs Energy)
SELECT 
    CASE 
        WHEN `danceability_%` >= 80 THEN 'Highly Danceable (80-100)'
        WHEN `danceability_%` >= 60 THEN 'Moderately Danceable (60-79)'
        WHEN `danceability_%` >= 40 THEN 'Low Danceability (40-59)'
        ELSE 'Not Danceable (0-39)'
    END AS danceability_level,
    COUNT(*) AS song_count,
    ROUND(AVG(streams), 0) AS avg_streams,
    ROUND(AVG(`energy_%`), 2) AS avg_energy,
    ROUND(AVG(`valence_%`), 2) AS avg_valence
FROM `spotify-2023`
GROUP BY danceability_level
ORDER BY avg_streams DESC;

-- Platform Presence Analysis
SELECT 
    track_name,
    `artist(s)_name` AS artist_name,
    streams,
    in_spotify_playlists,
    in_apple_playlists,
    in_deezer_playlists,
    in_shazam_charts,
    (in_spotify_playlists + in_apple_playlists + in_deezer_playlists) AS total_playlists
FROM `spotify-2023`
ORDER BY total_playlists DESC
LIMIT 20;

-- Emotional Tone (Valence) Analysis
SELECT 
    CASE 
        WHEN `valence_%` >= 70 THEN 'Very Positive (70-100)'
        WHEN `valence_%` >= 50 THEN 'Positive (50-69)'
        WHEN `valence_%` >= 30 THEN 'Neutral (30-49)'
        ELSE 'Negative/Sad (0-29)'
    END AS mood,
    COUNT(*) AS song_count,
    ROUND(AVG(streams), 0) AS avg_streams
FROM `spotify-2023`
GROUP BY mood
ORDER BY avg_streams DESC;
