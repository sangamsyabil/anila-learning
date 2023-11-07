-- Lab 9 (Anila Regmi)

-- A - Querying tables city and country:
-- 1. Using INNER JOIN ..ON, write a query that displays the name of cities, the cities' population and cities' continent. Sort the result by continent, then by city population, then by city name.
-- Note: the field called 'name' is present in the two tables, use a table alias to resolve the conflict.
SELECT cty.Name AS city_name, cty.Population AS city_population, co.continent AS city_continent
FROM City AS cty INNER JOIN Country AS co ON cty.CountryCode = co.Code ORDER BY co.continent, cty.Population, cty.Name;

-- 2. Rewrite the previous query using WHERE/FROM instead of INNER JOIN.
SELECT cty.Name AS city_name, cty.Population AS city_population, co.continent AS city_continent
FROM City AS cty, Country AS co WHERE cty.CountryCode = co.Code ORDER BY co.continent, cty.Population, cty.Name;

-- 3. Rewrite the query in question 1 to filter countries that became independent in 1960.
SELECT c.name AS city_name, c.population AS city_population, co.continent AS city_continent
FROM city AS c INNER JOIN country AS co ON c.countrycode = co.code
WHERE co.IndepYear = 1960 ORDER BY co.continent, c.population, c.name;

-- 4. Rewrite the previous query using WHERE/FROM instead of INNER JOIN.
SELECT c.name AS city_name, c.population AS city_population, co.continent AS city_continent
FROM city AS c, country AS co WHERE c.countrycode = co.code
AND co.IndepYear = 1960 ORDER BY co.continent, c.population, c.name;

-- 5. Using INNER JOIN ..ON, write a query that displays, for the city of Ottawa, the name of the city and the head of state of its country.
SELECT cty.Name AS city_name, co.HeadOfState FROM city AS cty
INNER JOIN country AS co ON cty.CountryCode = co.Code WHERE cty.Name = 'Ottawa';

-- 6. Using INNER JOIN ..ON, write a query that displays the name of the city, the city population, the continent, and the country population of the city of Toronto.
SELECT cty.Name AS city_name, cty.Population AS city_population, co.Continent AS city_continent, co.Population AS country_population
FROM city AS cty INNER JOIN country AS co ON cty.CountryCode = co.Code WHERE cty.Name = 'Toronto';


-- B - Querying tables city and countryLanguage:
-- 1. Using INNER JOIN ..ON, write a query that answers the following question. What languages along with their percentage are spoken in the city of Ottawa?
SELECT cl.language, cl.Percentage FROM city AS c
INNER JOIN countryLanguage AS cl ON c.CountryCode = cl.CountryCode WHERE c.Name = 'Ottawa';

-- 2. Using WHERE/FROM, write a query that answers the following question. What official languages along with their percentage are spoken in the city of Ottawa?
SELECT cl.language, cl.Percentage FROM city AS c, countryLanguage AS cl
WHERE c.CountryCode = cl.CountryCode AND c.Name = 'Ottawa' AND cl.isOfficial = 'T';

-- 3. Using INNER JOIN ..ON, write a query that reports the percentage of people speaking an official language in the city of Ottawa as well as the percentage of people speaking Polish in the city of Ottawa
SELECT
    SUM(CASE WHEN cl.isOfficial = 'T' THEN cl.Percentage ELSE 0 END) AS official_language_percentage,
    SUM(CASE WHEN cl.language = 'Polish' THEN cl.Percentage ELSE 0 END) AS polish_percentage
FROM city AS c
INNER JOIN countryLanguage AS cl ON c.CountryCode = cl.CountryCode WHERE c.Name = 'Ottawa';

-- 4. Using INNER JOIN ..ON and SUM, write a query that reports the total percentage of people speaking an official language as well as speaking Italian in the city of Ottawa
SELECT
    SUM(CASE WHEN cl.isOfficial = 'T' THEN cl.Percentage ELSE 0 END) AS total_official_language_percentage,
    SUM(CASE WHEN cl.language = 'Italian' THEN cl.Percentage ELSE 0 END) AS italian_percentage
FROM city AS c
INNER JOIN countryLanguage AS cl ON c.CountryCode = cl.CountryCode WHERE c.Name = 'Ottawa';

-- C - Querying tables city, country and countryLanguage:
-- 1. Using INNER JOIN ..ON the three tables, write a query that displays the name of the city, the city continent, the city head of state, the year of independence and the total number of people who speak Italian in the city of Toronto.
SELECT cty.Name AS city_name, co.Continent AS city_continent, co.HeadOfState AS city_head_of_state, co.IndepYear, 
       SUM(cl.Percentage) AS total_italian_speakers
FROM city AS cty INNER JOIN country AS co ON cty.CountryCode = co.Code
LEFT JOIN countryLanguage AS cl ON cty.CountryCode = cl.CountryCode AND cl.Language = 'Italian'
WHERE cty.Name = 'Toronto' GROUP BY cty.Name, co.Continent, co.HeadOfState, co.IndepYear;

-- 2. Rewrite the previous query using WHERE/FROM instead of INNER JOIN.
SELECT cty.Name AS city_name, co.Continent AS city_continent, co.HeadOfState AS city_head_of_state, co.IndepYear, 
       SUM(cl.Percentage) AS total_italian_speakers
FROM city AS cty, country AS co, countryLanguage AS cl
WHERE cty.CountryCode = co.Code
      AND cty.CountryCode = cl.CountryCode
      AND cl.Language = 'Italian'
      AND cty.Name = 'Toronto'
GROUP BY cty.Name, co.Continent, co.HeadOfState, co.IndepYear;

-- 3. Using LEFT JOIN ..ON the three tables, write a query that displays the city continent, the country the city is in, the city name and the language spoken in that city
SELECT co.Continent AS city_continent, co.Name AS country_name, cty.Name AS city_name, cl.Language AS spoken_language
FROM city AS cty
LEFT JOIN country AS co ON cty.CountryCode = co.Code
LEFT JOIN countryLanguage AS cl ON cty.CountryCode = cl.CountryCode;

-- Thank you!
