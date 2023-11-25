-- Lab 11 (Anila Regmi)

-- Task A - Querying World
-- 1. Using a UNION query, create a report that lists the name, population, and the country code of the cities
-- in Canada (code CAN) and the Netherlands (code NLD).
-- - For Cities in Canada, display only those with a population greater than 500k people
-- - For Cities in Netherlands, display only those with a population lesser than 100k people
-- - Sort the results by country code and then by population (in descending order)
-- Note: this query can be written without using a UNION. The purpose of this question is to practice using UNION.
SELECT Name, Population, CountryCode FROM city WHERE CountryCode = 'CAN' AND Population > 500000
UNION
SELECT Name, Population, CountryCode FROM city WHERE CountryCode = 'NLD' AND Population < 100000
ORDER BY CountryCode, Population DESC;

-- 2. Using a subquery, list the name of the city, the country code, and the population of all cities with a population less than the average population.
SELECT Name, CountryCode, Population FROM city
WHERE Population < (SELECT AVG(Population) FROM city);

-- Task B - Querying Sakila
-- 1. Using JOIN and subquery, list the film ID, title, length, rating and number of actors.
-- - Sort the results by number of actors in descending order, and then by length, also in descending order.
SELECT f.film_id, f.title, f.length, f.rating, actor_count.num_actors AS num_actors FROM film f
JOIN (SELECT film_id, COUNT(actor_id) AS num_actors FROM film_actor GROUP BY film_id) AS actor_count ON f.film_id = actor_count.film_id
ORDER BY num_actors DESC, f.length DESC;


-- Using JOIN and subqueries, write a query that lists all actors (first and last name)
-- and the number of PG-13 movies (rating = 'PG-13') they worked on.
-- Sort the results by actor's first name and then last name. Your result set should look like this:
SELECT a.first_name, a.last_name, COUNT(fm.film_id) AS num_PG13_movies
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id 
JOIN film fm ON fa.film_id = fm.film_id
WHERE fm.rating = 'PG-13'
GROUP BY a.actor_id, a.first_name, a.last_name ORDER BY a.first_name, a.last_name;

-- Task C - Querying Algonquify
-- 1. Using JOIN and GROUP BY, calculate the number of plays per song (title) and artist (name)
-- for February 2023. Sort the results by number of plays in descending order and then by artist name.
-- Display only the top 10 results.
SELECT s.title AS song_title, a.name AS artist_name, COUNT(*) AS plays_count
FROM user_song_listen usl
JOIN song s ON usl.song_id = s.id
JOIN artist a ON usl.artist_id = a.id
WHERE MONTH(usl.start_time) = 2 AND YEAR(usl.start_time) = 2023 
GROUP BY s.title, a.name ORDER BY plays_count DESC, a.name LIMIT 10;

-- 2. Create a query that displays the artist name, artist's genre, total number of songs and the average duration of their songs (in seconds).
-- - Sort results by average duration and number of songs, both in descending order
SELECT a.name AS artist_name, g.name AS artist_genre,
    COUNT(s.id) AS total_songs,
    AVG(s.duration_ms / 1000) AS avg_duration_seconds
FROM artist a
JOIN genre g ON a.genre_id = g.id
JOIN song s ON s.artist_id = a.id
GROUP BY a.name, g.name ORDER BY avg_duration_seconds DESC, total_songs DESC;

-- 3. Using JOIN and subquery, list the song title, artist name, artist genre, album genre, duration and release year of all songs with a duration longer than the average duration of all songs and that have album genre different than the artist genre.
SELECT s.title AS song_title, a.name AS artist_name, ag.name AS artist_genre,
       al.genre_id AS album_genre, s.duration_ms / 1000 AS duration_seconds,
       YEAR(al.release_date) AS release_year
FROM song s
JOIN artist a ON s.artist_id = a.id
JOIN genre ag ON a.genre_id = ag.id
JOIN album al ON s.album_id = al.id
WHERE s.duration_ms > (SELECT AVG(duration_ms) FROM song) AND al.genre_id != a.genre_id ORDER BY s.title;

-- Thank you :)
