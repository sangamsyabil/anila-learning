-- Lab 12 (Anila Regmi)

-- 1. (world) Display the name, GNP, head of state and continent of all countries with a GNP that is greater than the average GNP of all countries. Sort the results by GNP in descending order
SELECT Name, GNP, HeadOfState, Continent FROM country
WHERE GNP > (SELECT AVG(GNP) FROM country) ORDER BY GNP DESC;

-- 2. (world) List the name of all countries in South America. For each country, also display the name of their capital, the population of this capital, and the name of the most populated city of said country. Sort the results by country name, in ascending order
SELECT co.Name AS country, ci.Name AS capital, ci.Population AS capital_pop, mc.Name AS most_pop_city
FROM country co
JOIN city ci ON co.Capital = ci.ID JOIN city mc ON co.Code = mc.CountryCode WHERE co.Continent = 'South America'
AND mc.Population = (SELECT MAX(c.Population) FROM city c WHERE c.CountryCode = co.Code) ORDER BY co.Name ASC;

-- 3. (world) List all languages spoken in countries (do not display the same language more than once), along with the number of countries that consider this language official (name this column "count_official"). Also display the number of countries that speak said language but do not consider it an official language. Sort the results by number of official languages and then by unofficial languages, both in descending order.
SELECT Language,
    COUNT(CASE WHEN IsOfficial = 'T' THEN CountryCode END) AS count_official,
    COUNT(CASE WHEN IsOfficial = 'F' THEN CountryCode END) AS count_unofficial
FROM countrylanguage GROUP BY Language ORDER BY count_official DESC, count_unofficial DESC;

-- 4. (algonquify) Display all artist names, the name of the genre they are associated with, along with the number of albums and the number of songs existing in the database. Sort the results by number of songs in descending order, number of albums also in descending order and lastly by artist name.
SELECT a.name AS artist, g.name AS genre,
       COUNT(DISTINCT alb.id) AS albums,
       COUNT(DISTINCT s.id) AS songs
FROM artist a
JOIN genre g ON a.genre_id = g.id LEFT JOIN album alb ON a.id = alb.artist_id LEFT JOIN song s ON a.id = s.artist_id
GROUP BY a.id, g.id ORDER BY songs DESC, albums DESC, artist;

-- 5. (sakila) List all film titles, their category, the number of times each film was rented (name it "rentals") and the film duration (length). Display only movies rented more than 30 times sorting the top 20 movies according to number of rentals in descending order, by lenght also in descending order and then title.
SELECT title, name, 
       COUNT(r.rental_id) AS rentals, f.length AS length
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id HAVING rentals > 30 ORDER BY rentals DESC, f.length DESC, f.title LIMIT 20;

-- Thank you :)
