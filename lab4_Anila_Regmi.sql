-- Lab 4 (Anila Regmi)

-- Q1. (countries) Write a query that calculates the number of countries in Asia. Name the column "countries_in_asia"
SELECT COUNT(*) AS countries_in_asia
FROM countries WHERE continent = 'Asia';

-- Q2. (airlines) Write a query that calculates the number of airlines per country. Filter the results to calculate only based on airline names ending in "Airlines" or in "Airways". Sort the results by number of airlines in descending order.
SELECT country, COUNT(*)
FROM airlines WHERE name LIKE '%Airlines' OR name LIKE '%Airways' 
GROUP BY country ORDER BY country DESC;

-- Q3. (airports) Write a query that displays the airport code, the airport name, and the country code of all the airports that do not contain the word "Airport" in their name and that are located in Great Britain (hint: use the country code).
SELECT code, name, country
FROM airports WHERE country = 'GB' AND name NOT LIKE '%Airport%';

-- Q4. (airports) Write a query that calculates the number of airports in Brazil, Canada, and Portugal combined. Rename the resulting column: “Number of airports in Brazil, Canada, and Portugal".
SELECT count(*) AS "Number of airports in Brazil, Canada, and Portugal"
FROM airports WHERE country ='br' or country='ca' or country='pt';

-- Q5. (airlines) Write a query that displays everything that is known (all the fields) from the airlines that do not have "Air" in their name and that are located in Canada, United States, or Mexico. Sort the results by airline name
SELECT * FROM airlines WHERE country IN ('us', 'ca', 'mx') 
AND name NOT LIKE '%Air%' ORDER BY name;

-- Q6. (airports) Write a query that displays the code and state of all the airports whose code starts with the letter B. Do not display the records whose state is empty or not given. Sort the output by state in descending order.
SELECT code, state FROM airports WHERE code LIKE 'B%' 
AND state IS NOT NULL AND state != '' ORDER BY state DESC;

-- Q7. (airports) Write a query to calculate the number of airports per country. Sort the results by number of airports and then by country to display records between the 5th and 15th position.
SELECT country, COUNT(*) AS num_airports
FROM airports GROUP BY country ORDER BY num_airports DESC, country LIMIT 10 OFFSET 4;

-- Q8. (flights) Write a query that displays the departure airport, arrival airport, departure time, the flight duration of all flights whose flight duration is between 150 and 300 minutes (both included) and flying only on Fridays. Display only flights arriving in airports in Portugal (hint: query the airports table to discover the airport codes) Sort the output by descending duration order and by airline code in ascending order;
SELECT departure, arrival, dep_time, duration FROM flights
WHERE duration BETWEEN 150 AND 300 AND day_op = 5 
AND arrival in('FAO','LIS','OPO') order by duration desc ,airline asc ;

-- Q9. (flights) Write a query that calculates the maximum duration time of a flight, the minimal duration of a flight and the average duration of all flights that arrived in Cape Town and Johannesburg. Your calculations should not consider flights departing from Port Elizabeth. The results for each arrival airport should be displayed in separate rows.
SELECT
  'Cape Town' AS "Arrival Airport", MAX(duration) AS "Maximum Duration",
  MIN(duration) AS "Minimum Duration", AVG(duration) AS "Average Duration"
FROM flights WHERE arrival IN ('CPT', 'JNB') AND departure != 'PLZ'
UNION
SELECT 'Johannesburg' AS "Arrival Airport", MAX(duration) AS "Maximum Duration",
  MIN(duration) AS "Minimum Duration", AVG(duration) AS "Average Duration"
FROM flights WHERE arrival IN ('CPT', 'JNB') AND departure != 'PLZ';

-- Q10. (countries) Write a query to compute the number of countries per continent for continents with at least 5 countries and no more than 20 countries. Sort the results by the number of countries in descending order.
SELECT continent, COUNT(*) AS num_countries
FROM countries GROUP BY continent HAVING num_countries BETWEEN 5 AND 20
ORDER BY num_countries DESC;

-- Thank you!
