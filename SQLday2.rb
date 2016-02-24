# What languages are spoken in the 20 poorest (GNP/ capita) countries in the world?

SELECT name, gnp
FROM country
ORDER BY gnp ASC
LIMIT 20;

# c.code = cl.countrycode states that the country codes in countrylanguage table match the code in the country table.
SELECT
	c.name AS country,
	c.gnp AS GNP,
	cl.language AS language
FROM
	country c JOIN
	countrylanguage cl ON c.code = cl.countrycode
ORDER BY
	gnp ASC
LIMIT 20;

# What are the cities in the countries with no official language?
SELECT
	c.name AS cities,
	cl.language AS language,
	cl.isofficial AS notoffical
FROM
	city c OUTER JOIN
	countrylanguage cl ON c.countrycode = cl.countrycode

WHERE cl.isofficial = false;

#SECOND TRY
WITH
(SELECT
	c.countrycode AS cities,
	cl.language AS language,
	cl.isofficial AS notoffical
FROM
	city c JOIN
	countrylanguage cl ON c.countrycode = cl.countrycode
EXCEPT
SELECT
	c.countrycode AS cities,
	cl.language AS language,
	cl.isofficial AS notoffical
FROM
	city c JOIN
	countrylanguage cl ON c.countrycode = cl.countrycode
WHERE
	cl.isofficial = true);

# Which languages are spoken in the ten largest (area) countries?
WITH
largestcountries AS
(SELECT code, surfacearea
FROM country
ORDER BY
surfacearea DESC
LIMIT 10)

SELECT DISTINCT
	cl.language AS language,
	c.surfacearea AS area

FROM
	largestcountries c JOIN
	countrylanguage cl ON (c.code = cl.countrycode)
ORDER BY
	area DESC;

#What is the total city population in
#countries where English is an official language?
#Spanish?

WITH english AS
(SELECT
countrycode, language, isofficial
FROM
countrylanguage
WHERE isofficial = true and language = 'Spanish')

SELECT population AS pop
FROM english e JOIN country cl ON (e.countrycode = cl.code)

# Are there any countries without an official language?
SELECT
	countrycode,
	language,
	isofficial
FROM
	countrylanguage
EXCEPT
SELECT
	countrycode,
	language,
	isofficial
FROM
	countrylanguage
Where
	isofficial =  True;

#How many countries have no cities?
SELECT
	c.name AS Cityname,
	cl.name AS Countrycode
FROM
	city c RIGHT JOIN country cl ON (c.countrycode = cl.code)
WHERE
	c.name is null
ORDER BY
	Cityname;

#Which countries have the 100 biggest cities in the world?
WITH population AS
(SELECT
	countrycode
FROM
	city
ORDER BY
	population DESC
LIMIT 100)

SELECT DISTINCT
	c.name AS country_name
FROM	population ci JOIN
	country c ON (c.code = ci.countrycode)

ORDER BY
	country_name DESC;

  # What languages are spoken in the countries with the 100 biggest cities in the world?
  WITH population AS
(SELECT
	countrycode
FROM
	city
ORDER BY
	population DESC
LIMIT 100)

SELECT DISTINCT
	lang.language AS language
FROM	countrylanguage lang JOIN population pop ON (lang.countrycode = pop.countrycode)

ORDER BY
	language DESC;

  #Which countries have the highest proportion of official language speakers?
WITH highestlang AS(SELECT
	countrycode,
	percentage
FROM
	countrylanguage
WHERE
	percentage = 100 and isofficial = true
ORDER BY
	percentage DESC)
SELECT
	c.name
FROM
	highestlang high JOIN country c ON high.countrycode = c.code
ORDER BY
	c.name ASC;

#Which countries have the lowest proportion of official language speakers?
WITH highestlang AS(SELECT
	countrycode,
	percentage
FROM
	countrylanguage
WHERE
	isofficial = true
ORDER BY
	percentage ASC)
SELECT
	c.name
FROM
	highestlang high JOIN country c ON high.countrycode = c.code
ORDER BY
	c.name ASC;
