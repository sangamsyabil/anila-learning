-- 1. (world) Retrieve country codes, official languages, and the percentage of the population that speaks them.
--    - Sort the results in descending order based on the percentage of the population speaking the language.
--    - Include only languages spoken by more than 0% but not exceeding 20% of the population.

SELECT countrycode, language, percentage
FROM countrylanguage
WHERE percentage > 0 AND percentage <= 20
ORDER BY percentage DESC;

-- 2. (sakila) Retrieve movie titles, descriptions, durations, and ratings from the Sakila database.
--    - Include only movies with descriptions containing the word "dog" but not "man."
--    - Include movies rated "NC-17" or "R."
--    - Sort the results by movie duration in ascending order.
SELECT
    film.title AS MovieTitle,
    film.description AS MovieDescription,
    film.length AS MovieDuration,
    film.rating AS MovieRating
FROM film
WHERE film.description LIKE '%dog%' AND film.description NOT LIKE '%man%'
    AND (film.rating = 'NC-17' OR film.rating = 'R')
ORDER BY film.length ASC;

-- 3. (sakila) Create a report displaying:
--    - The number of films (name it "films").
--    - The average rental rate (name it "avg_rate").
--    - The shortest film length (name it "shortest_film").
--    - The longest film length (name it "longest_film") for each movie rating.
--    - Only include movies with a length of at least 2 hours (length is stored in minutes).
--    - Sort results in descending order based on the average rental rate.
SELECT
    f.rating AS MovieRating,
    COUNT(f.film_id) AS films,
    AVG(f.rental_rate) AS avg_rate,
    MIN(f.length) AS shortest_film,
    MAX(f.length) AS longest_film
FROM film AS f
WHERE f.length >= 120
GROUP BY f.rating
ORDER BY avg_rate DESC;

-- 4. (world) Retrieve:
--    - Languages.
--    - The average percentage of speakers.
--    - The number of countries where each language is spoken.
--    - The maximum percentage of speakers.
--    - Include only non-official languages.
--    - Include languages with speakers ranging from 45% to 60%.
--    - Exclude language names containing the word "English."
--    - Sort the results in descending order based on the number of countries where the language is spoken, followed by the maximum percentage of speakers.
SELECT
    Language,
    AVG(Percentage) AS AvgPercentageOfSpeakers,
    COUNT(DISTINCT CountryCode) AS NumCountries,
    MAX(Percentage) AS MaxPercentageOfSpeakers
FROM countrylanguage
WHERE IsOfficial = 'F' AND Percentage >= 45 AND Percentage <= 60 AND Language NOT LIKE '%English%'
GROUP BY Language
ORDER BY NumCountries DESC, MaxPercentageOfSpeakers DESC;

-- 5. (world) Create a report displaying:
--    - Country names.
--    - Continents.
--    - The average life expectancy for countries in each continent.
--    - Only include continents with at least two countries.
--    - Sort the results in descending order based on the average life expectancy.
SELECT
    co.Name AS CountryName,
    co.Continent AS Continent,
    AVG(co.LifeExpectancy) AS AvgLifeExpectancy
FROM country AS co
WHERE
    co.Continent IN (
        SELECT Continent
        FROM country
        GROUP BY Continent
        HAVING COUNT(*) >= 2
    )
GROUP BY co.CountryCode, co.Continent
ORDER BY AvgLifeExpectancy DESC;

-- 6. (world) Write an SQL statement that retrieves the average population, minimum population, maximum population, and total population of all districts.
--    - The results should only include records where the district name contains at least 2 characters (do NOT use the LENGTH function).
--    - Only display districts where the total population is an odd number and the minimum population is more than 1,250,000.
SELECT
    AVG(population) AS average_population,
    MIN(population) AS minimum_population,
    MAX(population) AS maximum_population,
    SUM(population) AS total_population
FROM city
WHERE CHAR_LENGTH(district) >= 2
GROUP BY district
HAVING total_population % 2 = 1 AND minimum_population > 1250000
ORDER BY total_population DESC;
