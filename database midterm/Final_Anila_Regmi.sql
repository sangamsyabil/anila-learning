-- Anila Regmi (Final Exam)

-- 1. (algonquify) Write a report that:
-- - displays the title, duration (in seconds) and genre of all songs
-- - only for songs that contain "I'm" in their titles but do not contain "Live"
-- - sorts the results by title length, in ascending order
-- - displays only the first 10 records
SELECT title, ROUND(duration_ms / 1000) AS duration_seconds, g.name AS genre
FROM song s JOIN genre g ON s.artist_id = g.id
WHERE title LIKE '%I\ m%' AND title NOT LIKE '%Live%' ORDER BY LENGTH(title) ASC LIMIT 10;

-- 2. (world) Write a report that:
-- - lists the most spoken languages in Europe
-- - calculates the total number of people who speak each language (name it "speakers"). - round the result to whole numbers.
-- - filters only languages where the result is greater than 10 million speakers and that are odd numbers.
-- - sort the results by number of speakers in descending order.
SELECT cl.Language, ROUND(SUM(c.Population * cl.Percentage / 100)) AS speakers
FROM countrylanguage AS cl
JOIN country AS c ON cl.CountryCode = c.Code
WHERE c.Continent = 'Europe' GROUP BY cl.Language
HAVING speakers > 10000000 AND speakers % 2 != 0 ORDER BY speakers DESC;

-- 3. (algonquify) Find the most common song title and display:
-- - the name of all artists that have a song with this title
-- - the genre of the album in which this song was released by this artist
-- - the date the album containing the song was released
-- - the duration of the song in milliseconds.
-- - sort the results by duration in descending order
SELECT a.name AS artist_name, g.name AS genre, al.release_date AS album_release_date, s.duration_ms AS song_duration
FROM (SELECT title,  COUNT(*) AS title_count FROM song GROUP BY title ORDER BY COUNT(*) DESC LIMIT 1) AS most_common
JOIN song s ON most_common.title = s.title JOIN artist a ON s.artist_id = a.id 
JOIN album al ON s.album_id = al.id JOIN genre g ON al.genre_id = g.id ORDER BY s.duration_ms DESC;

-- 4. (algonquify) Create a view that:
-- - calculates the number of songs played ("plays") by genre ("genre_id"),
-- year ("year") and month ("month")
-- - that also displays the id of the most played song of this genre for this period (name it " top1_song_genre_id").
-- - that fetch only records from July 2023
-- - Sort the results by year, month and genre.
-- - Name the view "view_song_genre_july2023".
CREATE OR REPLACE VIEW view_song_genre_july2023 AS
SELECT a.genre_id, YEAR(usl.start_time) AS year, MONTH(usl.start_time) AS month,
    COUNT(*) AS plays,
    (
        SELECT usl.song_id FROM user_song_listen usl_inner
        JOIN song s_inner ON usl_inner.song_id = s_inner.id
        JOIN album a_inner ON s_inner.album_id = a_inner.id
        WHERE a_inner.genre_id = a.genre_id
        AND usl_inner.start_time >= '2023-07-01' AND usl_inner.start_time < '2023-08-01'
        GROUP BY a_inner.genre_id ORDER BY COUNT(*) DESC LIMIT 1
    ) AS top1_song_genre_id
FROM user_song_listen usl
JOIN song s ON usl.song_id = s.id JOIN album a ON s.album_id = a.id
WHERE usl.start_time >= '2023-07-01' AND usl.start_time < '2023-08-01'
GROUP BY a.genre_id, YEAR(usl.start_time), MONTH(usl.start_time)
ORDER BY YEAR(usl.start_time), MONTH(usl.start_time), a.genre_id;

-- 5. (algonquify) Using "view_song_genre_july2023", display:
-- - The year, month, genre (description, not the ID)
-- - Also display number of plays, and the artist and song title (separated by a hyphen, in a single column - name it "top_song"), the year the song was released, and which day of the week it was released (Monday, Friday, etc.)
-- - Sort results by year, month, both in ascending order, followed by the year the songs were released, in descending order
SELECT 
    v.year, v.month, g.name AS genre_description, v.plays,
    CONCAT(a.name, ' - ', s.title) AS top_song, YEAR(al.release_date) AS release_year,
    DAYNAME(al.release_date) AS release_day_of_week
FROM view_song_genre_july2023 v
JOIN genre g ON v.genre_id = g.id JOIN album al ON v.genre_id = al.genre_id
JOIN song s ON v.top1_song_genre_id = s.id JOIN artist a ON s.artist_id = a.id
ORDER BY v.year ASC, v.month ASC, release_year DESC;

-- 6. (sakila) In a single report, display the 3 most common first names followed by the 3 most common last names of film actors.
-- Display the name and the number of actors (name it 'actors') that share the same first/last name.
SELECT first_name AS name, COUNT(*) AS actors FROM actor GROUP BY first_name ORDER BY actors DESC LIMIT 3;
SELECT last_name AS name, COUNT(*) AS actors FROM actor GROUP BY last_name ORDER BY actors DESC LIMIT 3;

-- 7. (algonquify) Write a query that:
-- - calculates the number of songs released per decade (1950s, 1960s, ...) and genre,
-- - calculates the average length of songs of each period (name it "average_duration") and maximum length ("longest_song") of songs 
-- - Sort records by decade and genre.
SELECT 
    CONCAT(LEFT(YEAR(al.release_date), 3), '0s') AS decade, g.name AS genre,
    COUNT(s.id) AS number_of_songs, AVG(s.duration_ms) AS average_duration, 
    MAX(s.duration_ms) AS longest_song
FROM song s
JOIN album al ON s.album_id = al.id JOIN genre g ON al.genre_id = g.id
GROUP BY decade, g.name ORDER BY decade, genre;

-- THANK YOU :)
-- December 12, 2023
