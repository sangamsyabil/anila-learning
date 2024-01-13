-- Lab 13 (Anila Regmi)
-- 1. Create a view named "view_artist_info" that displays the artist (name it "artist"), artist genre ("genre"), number of songs ("songs") and average duration of their songs (in seconds - "avg_duration_secs").
CREATE OR REPLACE VIEW view_artist_info AS
SELECT a.name AS artist, g.name AS genre, COUNT(s.id) AS songs, AVG(s.duration_ms / 1000) AS avg_duration_secs
FROM artist a JOIN genre g ON a.genre_id = g.id LEFT JOIN song s ON a.id = s.artist_id
GROUP BY a.id;

-- 2. Using "view_artist_info", write a query that lists all artist names, genres, number of songs and average duration of songs of artists that have more than 75 songs and that have an average song duration of more than 4 minutes. 
-- Sort the results by average duration and songs, both in descending order.
SELECT artist, genre, songs, avg_duration_secs
FROM view_artist_info
WHERE songs > 75 AND avg_duration_secs > 240
ORDER BY avg_duration_secs DESC, songs DESC;

-- 3. Create a view named "view_user_stat" that lists user IDs, their country of origin, their plan, and their age. 
-- Executing a select over this view should display results like the following:
CREATE OR REPLACE VIEW view_user_stat AS
SELECT id, country, plan, TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) AS age, birth_date FROM user;

-- 4. Using "view_user_stat", write a query that displays the number of users based on their country, plan, and age range, i.e., users between 50-59 should be in a group named "50s", between 20-29 in a group named "20s", etc.
-- Sort the results by number of users in descending order, then age range in descending order, and lastly by country name.
SELECT country, plan, COUNT(*) AS users,
    CASE 
        WHEN age >= 80 AND age <= 89 THEN '70s'
        WHEN age >= 70 AND age <= 79 THEN '70s'
        WHEN age >= 60 AND age <= 69 THEN '60s'
        WHEN age >= 50 AND age <= 59 THEN '50s'
        WHEN age >= 40 AND age <= 49 THEN '40s'
        WHEN age >= 30 AND age <= 39 THEN '30s'
        WHEN age >= 20 AND age <= 29 THEN '20s'
        ELSE 'Other'
    END AS age_range
FROM view_user_stat
GROUP BY age_range, country, plan
ORDER BY users DESC, age_range DESC, country;

-- 5. Create a view named "view_month_rock_metal" that aggregates the number 
-- of plays per year, month, artist, genre, and number of songs of all "Metal" and "Rock" artists.
-- Querying your view should return a result-set like the one below:
CREATE OR REPLACE VIEW view_month_rock_metal AS
SELECT 
    YEAR(u.start_time) AS year_play, 
    MONTH(u.start_time) AS month_play, 
    a.name AS artist, 
    g.name AS genre, 
    COUNT(u.artist_id) AS plays,
    COUNT(u.song_id) AS songs
FROM user_song_listen u
JOIN artist a ON u.artist_id = a.id
JOIN genre g ON a.genre_id = g.id
WHERE g.name IN ('Metal', 'Rock');

-- 6. Using "view_month_rock_metal", write a query that returns the top 10 artists (that were listened to the most) in February 2023 in the genre "Rock". 
-- Sort the results by number of plays in descending order, number of songs in descending order, and then by artist.
SELECT artist,plays,songs FROM view_month_rock_metal
WHERE genre = 'Rock' AND year_play = 2023 AND month_play = 2
ORDER BY plays DESC, songs DESC, artist LIMIT 10;

-- 7. Using "view_month_rock_metal", write a query that answers the question: "Which genre is more popular?"
-- Your query should compare the total number of plays of rock and metal songs for the months of October, November, and December of 2023.
-- Sort the results by year, month, and then total number of plays.
SELECT year_play, month_play,
    SUM(CASE WHEN genre = 'Rock' THEN plays ELSE 0 END) AS rock_plays,
    SUM(CASE WHEN genre = 'Metal' THEN plays ELSE 0 END) AS metal_plays
FROM view_month_rock_metal
WHERE (year_play = 2023 AND month_play IN (10, 11, 12))
GROUP BY year_play, month_play
ORDER BY 
    year_play,
    month_play,
    SUM(CASE WHEN genre = 'Rock' THEN plays ELSE 0 END) + SUM(CASE WHEN genre = 'Metal' THEN plays ELSE 0 END) DESC;

-- 8. Using at least one subquery, write a query that lists all artists that released an album where the genre of the album is different from the genre of the artist and the album 
-- has more than 30 songs.
-- Display the artist name, the album title, the album and the artist genre, and the number of songs in the album.
-- Sort the results by number of songs in descending order, and then artist name
SELECT 
    a.name AS artist_name,
    al.name AS album_title,
    al.album_type AS album_type,
    g_artist.name AS artist_genre,
    g_album.name AS album_genre,
    COUNT(s.id) AS num_songs
FROM artist a
JOIN album al ON a.id = al.artist_id
JOIN genre g_artist ON a.genre_id = g_artist.id
JOIN genre g_album ON al.genre_id = g_album.id
JOIN song s ON al.id = s.album_id
WHERE al.genre_id != a.genre_id AND COUNT(s.id) > 30
GROUP BY a.name, al.name, al.album_type, g_artist.name, g_album.name
ORDER BY COUNT(s.id) DESC, a.name;

-- Thank you :)
