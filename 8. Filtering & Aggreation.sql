-- copying data from one table to new table
select * into practice.duplicate_employees
from joinpractice.employees; 

-- insert some values for duplicate entries
INSERT INTO "practice"."duplicate_employees" ("emp_no", "birth_date", "first_name", "last_name", "gender", "manager", "dept_no") VALUES
(10036, '1959-08-10', 'Adamantios', 'Portugali', 'M', 10045, NULL),
(10036, '1959-08-10', 'Adamantios', 'Portugali', 'M', 10045, NULL);




-- selecting three colum to manually see duplicates name
select 
de.first_name, gender
from practice.duplicate_employees de;

-- use distinct to see distinct/unique value
SELECT DISTINCT
first_name, gender
FROM practice.duplicate_employees;

-- use distinct on(first_name), to see distinct name 

SELECT 
DISTINCT ON (first_name)
de.first_name, de.gender
FROM practice.duplicate_employees de;

SELECT 
DISTINCT ON (gender)
de.first_name, de.gender
FROM practice.duplicate_employees de;


-- use groupby rather using distinct 

SELECT
first_name, gender
FROM practice.duplicate_employees
group by first_name, gender;

EXPLAIN ANALYZE
SELECT DISTINCT first_name, gender
FROM practice.duplicate_employees;

EXPLAIN ANALYZE
SELECT first_name, gender
FROM practice.duplicate_employees
GROUP BY first_name, gender;



-- count all rows including duplicates
SELECT 
count(*)
FROM practice.duplicate_employees;

-- to find which first_name appears more than once

SELECT first_name, COUNT(*) AS total
FROM practice.duplicate_employees
GROUP BY first_name
HAVING COUNT(*) > 1;

-- Find duplicates based on multiple columns
SELECT first_name, gender, COUNT(*) AS total
FROM practice.duplicate_employees
GROUP BY first_name, gender
HAVING COUNT(*) > 1;


-- to see exact rows that are duplicated across all columns
SELECT *, COUNT(*) AS total
FROM practice.duplicate_employees
GROUP BY emp_no,birth_date,first_name,last_name,gender,manager,dept_no
HAVING COUNT(*) > 1;


-- 
SELECT 
e.gender,
COUNT(*)
FROM practice.duplicate_employees e 
GROUP by e.gender;

-- calculating age
SELECT 
e.first_name,
AGE(e.birth_date) emp_age

FROM practice.duplicate_employees e;

-- extract year 
SELECT 
e.first_name,
EXTRACT( year from AGE(e.birth_date)) emp_age

FROM practice.duplicate_employees e;

SELECT 
e.gender,
EXTRACT( year from AGE(e.birth_date)) emp_age

FROM practice.duplicate_employees e;

SELECT 
e.gender,
EXTRACT( year from AGE(e.birth_date)) emp_age
FROM practice.duplicate_employees e
GROUP by e.gender, e.birth_date;



SELECT
e.gender,
MAX(EXTRACT(year from AGE(e.birth_date))) emp_max_age
FROM practice.duplicate_employees e 
GROUP by e.gender;


INSERT INTO "practice"."duplicate_employees" ("emp_no", "birth_date", "first_name", "last_name", "gender", "manager", "dept_no") VALUES
(10026, '1953-04-03', 'Yongqiao', 'Berztiss', 'Male', 10035, NULL),
(10030, '1958-07-14', 'Elvis', 'Demeyer', 'Male', 10039, 150),
(10032, '1960-08-09', 'Jeong', 'Reistad', 'f', 10041, 160),
(10033, '1956-11-14', 'Arif', 'Merlo', 'm', 10042, NULL),
(10034, '1962-12-29', 'Bader', 'Swan', 'm', 10043, NULL),
(10037, '1963-07-22', 'Pradeep', 'Makrucki', 'Male', 10046, NULL),
(10038, '1960-07-20', 'Huan', 'Lortz', 'Female', 10047, NULL);


-- 
SELECT
DISTINCT
gender 
FROM practice.duplicate_employees;

-- find out distinct gender
SELECT
    DISTINCT
    CASE
        WHEN e.gender = 'M' THEN 'Male'
        WHEN e.gender = 'm' THEN 'Male'
        WHEN e.gender = 'Male' THEN 'Male'
        ELSE 'Female'
        end 
FROM
practice.duplicate_employees e;

-- 
SELECT
    DISTINCT
    CASE
        WHEN e.gender in('m','M','Male')
        THEN 'Male'
        ELSE 'Female'
        end 
FROM
practice.duplicate_employees e;



-- to project sallary (not null)
SELECT
e.sallary
 FROM practice.duplicate_employees e
where sallary is not null;

-- 
SELECT
sallary,
COUNT(*)
FROM practice.duplicate_employees
WHERE sallary is not NULL
GROUP by sallary;


SELECT
gender,sallary,
COUNT(*)
FROM practice.duplicate_employees
WHERE sallary is not NULL
GROUP by gender,sallary;

-- Use WHERE to filter before grouping (raw rows).
SELECT
gender,sallary,
COUNT(*)
FROM practice.duplicate_employees
WHERE sallary> 560000
GROUP by gender,sallary;

-- Use HAVING to filter after grouping (aggregated results).
SELECT
gender,sallary,
COUNT(*)
FROM practice.duplicate_employees
--WHERE sallary> 560000
GROUP by gender,sallary
HAVING sallary>560000;



select 
emp.gender,
sum(emp.sallary) as sallary
from practice.duplicate_employees emp 
GROUP BY emp.gender
HAVING sum(emp.sallary)<5000000;

select 
emp.gender,
sum(emp.sallary) as sallary
from practice.duplicate_employees emp 
WHERE sallary < 5000000
GROUP BY emp.gender;

SELECT gender, sallary from practice.duplicate_employees
WHERE duplicate_employees.sallary is not null;

-- WHERE clause filters indivisual records before group by 
-- Having filters after group by (filters after aggretation)
