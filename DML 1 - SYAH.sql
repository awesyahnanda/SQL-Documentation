show databases;

use world;

show tables;
describe countrylanguage;

# DISTINCT
select distinct countrycode
from city;

# LIMIT
select *
from city
limit 2;

# COUNT
select count(Name)
from city;

# AVG
select avg(Population)
from city;

# SUM
select sum(Population)
from city;

# ---------------------------------
# WHERE
select *
from city
where CountryCode = 'ARG' and Population > 10000;

select *
from city
where Population < 1000;

# LIKE
select *
from city
where Name like 'Y%';

select *
from city
where Name like 'K%y';

# BETWEEN
select *
from city
where population = 10000;

select *
from city
where population < 10000;

select *
from city
where population between 10000 and 100000;

# ----------------------------

# ORDER BY
select *
from city
where population between 10000 and 100000
order by Population desc;

select *
from city
order by Population desc
limit 10;


# --------------------------------
# Query 1: Show me the 10 countries with the highest proportion of official English speakers?
# Query Code:

select * 
from countrylanguage
where Language = 'English' 
order by Percentage desc
limit 10;

# --------------------------------
# Query 2: A country with a republican system in Asia with all the 'n''s in the back and with the greatest life expectancies?
# Query Code:

select * 
from country
where Continent = 'Asia' and Name like '%n' and GovernmentForm = 'Republic'
order by LifeExpectancy desc;

# ------------------------------------------
# GROUP BY
select countrycode, avg(Population)
from city
group by countrycode;

# Hierarchy GROUP BY
select Name, LifeExpectancy
from country;

select 
	CountryCode, 
    avg(Percentage) as avg_percentage, 
    sum(Percentage) as sum_percentage
from countrylanguage
where 
	CountryCode = 'ABW' or 
    CountryCode = 'AFG'
group by CountryCode;

# HAVING
select District, avg(Population) as AveragePopulation
from city
group by District;

select District, avg(Population) as AveragePopulation 
from city
where CountryCode = 'IDN'
group by District
having AveragePopulation < 100000;

# Query 3: 10 countries that have the most cities in each country ?
# Query Code:
SELECT CountryCode, COUNT(ID) as jumlah
FROM City
GROUP BY CountryCode
order by jumlah desc
limit 10;

# --------------------------
# Query 4: Average Population per province in Indonesia with an average population above 500000?
# Query Code:

SELECT avg(population) as Rata_rata, District as Provinsi
FROM city
where Countrycode = 'IDN'
Group by provinsi
having Rata_rata > 500000;


# ----------------------
# Query 5: Average Population per province in Indonesia prefixed with the letter K?
# Query Code:

select avg(population) as rata_rata, district as provinsi
from city
where countrycode = 'IDN'
group by provinsi
having provinsi like 'k%'
order by rata_rata desc;

# ---------------------------
# Query 6: Average population of each country that has at least 5 districts?
# Query Code:

SELECT countrycode as negara, avg(population) as rata_rata
FROM city
group by negara
having count(district) >= 5
order by rata_rata desc;

# -----------------------------
# Query 7: Average GNP of each continent, but only for countries with populations above 100,000?
# Query Code:

select Continent as asia, avg(GNP) as average_gnp
from country
where Population > 100000
group by Continent;


# -----------------------------
# Query 8: Number of countries per continent and their average gnp with continents having a minimum number of 10 countries?
# Query Code:

SELECT continent, count(continent) as jumlah_negara, avg(GNP) as ratarata_gnp
FROM country
group by continent
having jumlah_negara > 10;

# -----------------
# Query 9: The continent with the highest average life expectation but only counting countries that became independent before 1950?
# Query Code:

select continent as benua,count(name) as jmlh_negara, avg(LifeExpectancy) as harapan_hidup
from country
where IndepYear < 1950
group by continent
order by harapan_hidup desc;


# -----------------
# Query 10: Total population per province with at least 500k population in Indonesia?
# Query Code:

select district, sum(population) as total_populasi
from city
where countrycode = 'IDN'
group by district
having total_populasi > 500000;







