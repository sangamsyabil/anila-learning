-- Lab 10 (Anila Regmi)

-- 1. (world) - Calculate the number of people that speak English in 'Brasilia', 'Ottawa', 'Paris' and 'Washington'.
-- - Display the results as integers. (Use the COALESCE function do display  NULL values as zeros)
-- - (For the purposes of this query, consider that the percentage of English speakers in these cities is the same as in their respective countries)
SELECT
  city.name AS city_name,
  COALESCE(CAST(SUM(country.population * countrylanguage.percentage / 100) AS SIGNED), 0) AS english_speakers
FROM city JOIN country ON city.countrycode = country.code
LEFT JOIN countrylanguage ON country.code = countrylanguage.countrycode
WHERE city.name IN ('Brasilia', 'Ottawa', 'Paris', 'Washington') AND countrylanguage.language = 'English'
GROUP BY city.name;

-- 1. (world) Using a UNION query, create a report that lists the name and the district of the cities
-- in Canada (code CAN) and the Netherlands (code NLD).
-- Note that this query can be written without using a UNION. The purpose of this question is to use UNION.
SELECT Name AS CityName, District FROM city WHERE CountryCode = 'CAN'
UNION
SELECT Name AS CityName, District FROM city WHERE CountryCode = 'NLD';

-- 2. (world) Using a JOIN, create a report that list the name of cities, the country and the indepyear of all countries whose indepYear field is not null.
SELECT
    city.Name AS CityName,
    country.Name AS CountryName,
    country.indepYear
FROM city JOIN country ON city.CountryCode = country.Code WHERE country.indepYear IS NOT NULL;

-- 3. (flights) - Write a query that:
-- - Lists the top 5 most common arrival airports based on the number of flights
-- - Calculates the number of flights that arrive at these airports
-- - Calculates the number of departure airports that arrive at these airports
SELECT
    arrival AS arrival_airport,
    COUNT(*) AS number_flights,
    COUNT(DISTINCT departure) AS number_departure_airport
FROM flights GROUP BY arrival ORDER BY number_flights DESC LIMIT 5;

-- 4. (world) Using a JOIN, write a query that displays, for the city of Toronto, the name of the city and the head of state of its country.
SELECT
    city.Name AS CityName,
    country.HeadOfState
FROM city JOIN country ON city.CountryCode = country.Code WHERE city.Name = 'Toronto';

-- 5. Write query that returns the first and last names of actors who played in a film involving a “Shark”.
-- - Include in your result set the title and the release year of the movie.
-- - Sort the result by movie title and then actor last name
SELECT actor.first_name, actor.last_name, film.title, film.release_year
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film_actor.film_id = film.film_id
WHERE LOWER(film.description) LIKE '%shark%'
ORDER BY film.title, actor.last_name;

-- 6. (flights) Using LEFT JOIN, create a report that displays departure airport (code and name), arrival airport (code and name), their days of operation, departure time, flight number, duration, and aircraft (code and corresponding name). (Use the CONCAT function to concatenate strings)
SELECT
    CONCAT(dep_airport.code, ' - ', dep_airport.name) AS DepartureAirport,
    CONCAT(arr_airport.code, ' - ', arr_airport.name) AS ArrivalAirport,
    flights.day_op AS DaysOfOperation,
    flights.dep_time AS DepartureTime,
    flights.flightnum AS FlightNumber,
    flights.duration AS Duration,
    CONCAT(aircraft.code, ' - ', aircraft.name) AS Aircraft
FROM flights
LEFT JOIN airports AS dep_airport ON flights.departure = dep_airport.code
LEFT JOIN airports AS arr_airport ON flights.arrival = arr_airport.code
LEFT JOIN aircrafts AS aircraft ON flights.aircraft = aircraft.code;

-- 7. (flights) Create a report of the airlines sorted by the most flights per airline in ascending order. Make sure to include the airline name. only include airlines that are based in the uk (country code 'gb').
SELECT 
    a.`name` AS airline_name,
    COUNT(*) AS num_flights
FROM flights f JOIN airlines a ON f.`airline` = a.`code` WHERE a.`country` = 'gb'  
GROUP BY airline_name ORDER BY num_flights ASC;  

-- 8. (sakila) Using JOIN, list the film ID, title, length, rating and film category.
-- Sort the results by length in descending order.
SELECT 
    f.film_id, f.title, f.length, f.rating, c.name AS category
FROM film AS f JOIN film_category AS fc ON f.film_id = fc.film_id 
JOIN category AS c ON fc.category_id = c.category_id ORDER BY f.length DESC;

-- 9. (flights) Create a query that shows which are the top 5 aircraft most used (higher number of flights per aircraft).
-- Your result set must contain two columns, one with the aircraft name and other with total number of flights
SELECT
    aircraft,
    COUNT(*) AS total_flights
FROM flights GROUP BY aircraft ORDER BY total_flights DESC LIMIT 5;

-- 10. (flights) Write a query that returns a result set similar to the Flight Information Displays in the airports. The result must be properly sorted, show only the next 10 flights considering the current time (use NOW() or CURTIME() to get the current time and TIME_FORMAT() to convert the time to match the value in the flights table), and only flights departing from Toronto (YYZ).
-- The columns must be named: Flight_number, Destination, Scheduled, Company
SELECT
    flightnum AS Flight_number,
    arrival AS Destination,
    TIME_FORMAT(dep_time, '%H:%i') AS Scheduled,
    carrier AS Company
FROM flights
WHERE departure = 'YYZ' AND dep_time > TIME_FORMAT(NOW(), '%H:%i')
ORDER BY dep_time LIMIT 10;

-- Thank you :)
