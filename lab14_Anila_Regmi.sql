-- Lab 13 (Anila Regmi)
-- 1. (sakila) - Display the first and last name (in a single column) of all actors whose first name is 5 letters long and their last name does not contain the letter "E"
SELECT CONCAT(first_name, ' ', last_name) AS actor_name FROM actor
WHERE LENGTH(first_name) = 5 AND last_name NOT LIKE '%e%';

-- 2. (flights) Calculate the average number of airlines by continent by rounding that number to 2 digits after the decimal point and naming it avg_airlines. Calculate also the largest number of airlines (max_airlines) and the total number of airlines (total_airlines) per continent.
SELECT 
    c.continent,
    ROUND(AVG(airlines_per_continent), 2) AS avg_airlines,
    MAX(airlines_per_continent) AS max_airlines,
    SUM(airlines_per_continent) AS total_airlines
FROM countries c
LEFT JOIN (
    SELECT 
        a.country,
        COUNT(DISTINCT a.code) AS airlines_per_continent
    FROM airlines a
    GROUP BY a.country
) AS airline_count ON c.code = airline_count.country
GROUP BY c.continent;

-- 3. (world) Write a query that lists the 4 most common initial letters in country names. Display the number of countries with each initial and how many of these countries have a year of independence.
SELECT 
    SUBSTRING(name, 1, 1) AS initial_letter,
    COUNT(*) AS country_count,
    SUM(IF(indepyear IS NOT NULL, 1, 0)) AS countries_with_independence
FROM country
GROUP BY initial_letter
ORDER BY country_count DESC
LIMIT 4;

-- 4. (world) Using CASE or IF, write a query that calculates the number of official languages and unofficial languages in Canada, Brazil, USA and France. Official languages should be displayed as "Official Languages" and unofficial languages should be listed as "Others".
SELECT 
    countrycode AS Name,
    CASE
        WHEN countrycode IN ('CAN', 'BRA', 'USA', 'FRA') THEN
            CASE
                WHEN IsOfficial = 'T' THEN 'Official Languages'
                ELSE 'Others'
            END
        ELSE 'Not Considered'
    END AS Status,
    COUNT(*) AS Languages
FROM countrylanguage
WHERE countrycode IN ('CAN', 'BRA', 'USA', 'FRA')
GROUP BY countrycode, IsOfficial;

-- 5. (world) Using COALESCE and GROUP_CONCAT, list all 7 Continents, the total number of official languages spoken in the continent, as well as their names. Display an 'N/A' if there are no official languages spoken in the continent. Sort continents in ascending alphabetical order.
SELECT
    COALESCE(c.continent, 'N/A') AS continent,
    COALESCE(COUNT(cl.language), 0) AS total,
    COALESCE(GROUP_CONCAT(DISTINCT cl.language ORDER BY cl.language SEPARATOR ', '), 'N/A') AS languages
FROM
    country c
LEFT JOIN
    countrylanguage cl ON c.code = cl.countrycode AND cl.IsOfficial = 'T'
GROUP BY
    c.continent
ORDER BY
    continent ASC;

-- 6. (algonquify) Using CONCAT, DIV, and LPAD, list the top 10 longest songs. Display the name of the artist and the title of the song in a single column and display the duration of the song in 00:00 format (i.e., minutes, then seconds - separated by a colon). Filter out song titles that contain the word "commentary".
SELECT
    CONCAT(a.name, ' - ', s.title) AS song,
    LPAD(duration_ms DIV 60000, 2, '0') 
    || ':' || LPAD((duration_ms DIV 1000) % 60, 2, '0') AS duration
FROM
    song s
JOIN
    artist a ON s.artist_id = a.id
WHERE
    s.title NOT LIKE '%commentary%'
ORDER BY
    duration_ms DESC
LIMIT 10;

-- Thank you :)
