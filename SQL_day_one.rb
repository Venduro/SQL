# The following are SQL Opperations used during the LEARN Academy
#SQL Day 1
#Comments provided by https://github.com/christinasirena
#inserts data into the database

INSERT INTO
	persons(given_name, family_name, dob, address, email)
VALUES
	('Christina', 'Bonos', '1956-01-30', '1225 Pennysaver Ave', 'christinaonesd@gmail.com'),
	('Jason', 'Bledsoe', '1978-09-18', '1234 Mango St Kansas city', 'ontn@gmail.com'),
	('Vincent', 'Joson', '1978-11-24', '3845 Strawberry st. San Diego', 'fontb57ce@gmail.com'),
	('Justin', 'New', '1954-01-17', '8923 Avacado St. San Diego', 'hijusting@gmail.com')

#selects the data we just created
SELECT id, given_name, family_name, dob
FROM persons;

# adds some conditions to your search (Where)
SELECT id, given_name, family_name, dob
FROM persons
WHERE lower(family_name) = 'nguyen';

# 2.  What is the sum of surface area of the 10 biggest countries in the world? The 10 smallest?

#Ten biggest countries
SELECT name, surfacearea
FROM country
ORDER BY surfacearea DESC
LIMIT 10;

#ten Smallest countries
SELECT name, surfacearea
FROM country
ORDER BY surfacearea ASC
LIMIT 10;

# get the sum of the largest countries surface area
# 1st create top ten then nest within the "with"
# with creates a (variable) with this amount of data create/do... using AS()
WITH
largest AS(SELECT name, surfacearea FROM country
ORDER BY surfacearea DESC
LIMIT 10)
SELECT SUM(surfacearea) FROM largest

# sum of surface area
sum = 8.41836e+07

# get the sum of the Smallest surface area
# change DESC to ASC and FROM to Smallest
WITH
smallest AS(SELECT name, surfacearea FROM country
ORDER BY surfacearea ASC
LIMIT 10)
SELECT SUM(surfacearea) FROM smallest

# sum of surface area
sum = 150.9

# 3. List the countries in africa that have a population smaller than 30,000,000 and a life expectancy of more than 45

# value with in column coninent is making value ID (africa) lower case to search for anything upper or lower and & boolean to include lifeexpectanct and population to create the table.
# includes the selected colomns needed to pull the necessary information from the country table.

SELECT name, continent, lifeexpectancy, population
FROM country
WHERE LOWER(continent)='africa' and lifeexpectancy > 45 and population < 30000000;

# How many countries gained independence after 1910 that are also a republic?
#COUNT() calculates the sum of intenties within a column(how many countries found independence after 1910 and are republic).
WITH
independence AS(SELECT name, indepyear
From country
WHERE indepyear > 1910 and governmentform ='Republic')
SELECT COUNT(name) From independence;

#Which region has the highest ave gnp?
# SELECT AVG requests the average of the the gnp colomn, and the region
# AS

SELECT AVG (gnp), region AS gnpaverage
FROM country
GROUP BY region
ORDER BY gnpaverage DESC

# Who are the heads of state for the Top 10 highest ave gnp?
SELECT name, headofstate, gnp
FROM country
ORDER BY gnp DESC
LIMIT 10;

# SELECT headofstate, sum(gnp)
FROM country
ORDER BY gnp DESC limit 10
#  <> not smaller or bigger
WHERE headofstate <> ''
GROUP BY headofstate
ORDER BY sum(gnp) DESC

# What are the forms of government for the top ten countries by surface area?
SELECT name, surfacearea, governmentform
FROM country
ORDER BY surfacearea DESC
LIMIT 10;

# Which fifteen countries have the lowest life expectancy?
SELECT name, lifeexpectancy
FROM country
ORDER BY lifeexpectancy ASC
LIMIT 15;

# Which five countries have the lowest population density?
SELECT name, population
FROM country
ORDER BY population ASC
LIMIT 5;

# Which countries are in the top 5% in terms of area?
SELECT name, surfacearea
FROM country
ORDER BY surfacearea DESC
LIMIT 239 * 0.05;
