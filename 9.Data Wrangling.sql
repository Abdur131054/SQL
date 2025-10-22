-- select first 5 rows
SELECT * FROM
practice.employees_dump
LIMIT 5;

-- 1. concatenation
-- without space
SELECT
first_name,
last_name,
emp.first_name || emp.last_name full_name
FROM practice.employees_dump emp;

-- with space
SELECT
first_name,
last_name,
emp.first_name || ' ' ||emp.last_name full_name
FROM practice.employees_dump emp;

-- using concat
SELECT 
emp.first_name,
emp.last_name,
concat (emp.first_name,' ', emp.last_name) as full_name
FROM practice.employees_dump emp;

-- 3. Left and Right string functions

SELECT
LEFT(first_name,2) as left_2,
RIGHT(first_name,2)as right_2,
first_name
FROM practice.employees_dump;

SELECT
LEFT(hire_date,2) as left_2,
RIGHT(hire_date,2)as right_2,
hire_date
FROM practice.employees_dump;

-- In PostgreSQL, the LEFT() and RIGHT() functions only work on text (string) data types
-- will give error as bonus is int type
SELECT
LEFT(bonus,2) as left_2,
RIGHT(bonus,2)as right_2,
bonus
FROM practice.employees_dump;

--type casting 

SELECT
LEFT(bonus::TEXT,2) as left_2,
RIGHT(bonus::TEXT,2)as right_2,
bonus::TEXT
FROM practice.employees_dump;


-- 4. Length of first name
SELECT
first_name,
LENGTH(first_name) as name_len
FROM practice.employees_dump;


SELECT
bonus::TEXT,
LENGTH(bonus::TEXT) as bonus_len
FROM practice.employees_dump;

-- 5. Combining LEFT + LENGTH

SELECT 
    emp.first_name,
    LEFT(emp.first_name, 2) AS left_two,
    LENGTH(LEFT(emp.first_name, 2)) AS left_length
FROM practice.employees_dump emp;


-- 6. LPAD & RPAD examples

SELECT
  e.first_name,
  e.salary,
  LPAD(e.salary::VARCHAR, 7, '0') as lpad_salary,
  RPAD(e.salary::VARCHAR, 6, '*') as rpad_salary
FROM
  practice.employees_dump e;


-- 7. Position of substring

SELECT
e.first_name,
POSITION('lex' IN e.first_name) as substring_position
FROM practice.employees_dump e;

-- 8. LTRIM, RTRIM, TRIM

SELECT
e.first_name,
ltrim(e.first_name) as left_trim,
rtrim(e.first_name) as right_trim,
TRIM(e.first_name) as trimmed
FROM practice.employees_dump e;

-- 9. Filtering by last name
SELECT 
*
from practice.employees_dump 
where last_name='Chen';



-- 10. LOWER and UPPER usage
SELECT
e.first_name,
lower(e.first_name) as lower_first,
upper(e.first_name) as upper_first
from practice.employees_dump e
--WHERE last_name = $user_input;

-- 11. Case-insensitive comparison
SELECT *
FROM practice.employees_dump
WHERE LOWER(last_name) = LOWER($user_input);

-- 12. LIKE examples (pattern matching)

SELECT *
FROM practice.employees emp
WHERE UPPER(first_name) LIKE UPPER('%ex%');


SELECT *
FROM practice.employees emp
WHERE first_name LIKE '%ex%';


SELECT *
FROM practice.employees emp
WHERE UPPER(first_name) LIKE UPPER('lE%');
-- this won't work
SELECT *
FROM practice.employees emp
WHERE first_name LIKE 'lE%';

SELECT *
FROM practice.employees emp
WHERE first_name LIKE '%a';
-- Query goal: Select all rows from the practice.employees_dump table
-- where the 'first_name' matches a pattern, ignoring case sensitivity.
--     '_'  → matches exactly one character (any letter)
--     'EX' → the next two characters must be 'E' and 'X'
--     '%'  → matches zero or more characters after that
SELECT *
FROM practice.employees_dump emp
WHERE UPPER(first_name) LIKE UPPER('_ex%');

--   '_' → matches exactly ONE character (any letter or symbol).
--   '__' → two underscores at the start mean: skip the first two characters.
--   'EX' → the 3rd and 4th characters must be 'E' and 'X' (case-insensitive because of UPPER()).
--   '__' → the last two underscores mean: there must be exactly two more characters after 'EX'.
SELECT *
FROM practice.employees_dump emp
WHERE UPPER(first_name) LIKE UPPER('__ex__');

-- 13. Date Functions Demonstration
SELECT 
    NOW(),                         -- Returns the current date and time (timestamp with time zone)
    CURRENT_TIMESTAMP,              -- Same as NOW(), returns current date and time
    CURRENT_DATE,                   -- Returns only the current date (without time)
    NOW()::DATE,                    -- Converts current timestamp to just a date (casts to DATE)
    NOW() - INTERVAL '18 years',    -- Subtracts 18 years from the current date & time (useful for age calculations)
    NOW()::DATE - INTERVAL '18 years', -- Subtracts 18 years from today’s date only (no time portion)
    NOW() + INTERVAL '1 month',     -- Adds 1 month to the current timestamp
    NOW() + INTERVAL '2 week';      -- Adds 2 weeks to the current timestamp
-- 14. Extract and DATE_PART Demonstration
SELECT 
    CURRENT_DATE,                         -- Returns today’s date
    EXTRACT(DAY FROM CURRENT_DATE) AS extract_day,    -- Extracts the day (1-31) from the date
    DATE_PART('DAY', CURRENT_DATE) AS datepart_day;  -- Alternative way to extract the day (1-31)
    
    
-- 15. Handling NULL with COALESCE
SELECT 
    em.first_name,
    em.salary,
    em.bonus,
    (COALESCE(NULLIF(em.commission_pct, '')::numeric, 0) * em.salary) AS commission,
    (em.salary + COALESCE(em.bonus, 0) + COALESCE(NULLIF(em.commission_pct, '')::numeric, 0) * em.salary) AS "TOTAL AMOUNT"
FROM practice.employees_dump em;

-- 15. Handling NULL and empty strings using COALESCE
SELECT 
    em.first_name,  
    -- Select the employee's first name
    
    em.salary,  
    -- Select the employee's salary
    
    em.bonus,  
    -- Select the employee's bonus (may be NULL)
    
    (COALESCE(NULLIF(em.commission_pct, '')::numeric, 0) * em.salary) AS commission,  
    -- Calculate commission:
    -- 1. NULLIF(em.commission_pct, '') → Converts empty strings '' to NULL
    -- 2. ::numeric → Cast the value to numeric type
    -- 3. COALESCE(..., 0) → Replace NULL with 0
    -- 4. Multiply by salary to get commission amount
    
    (em.salary + COALESCE(em.bonus, 0) + COALESCE(NULLIF(em.commission_pct, '')::numeric, 0) * em.salary) AS "TOTAL AMOUNT"  
    -- Calculate total amount:
    -- 1. Take salary
    -- 2. Add bonus (if NULL, treated as 0)
    -- 3. Add commission (after handling empty strings and NULLs)
FROM practice.employees_dump em;


-- Improved version with COALESCE (handles null values)
SELECT 
    em.first_name,
    em.salary,
    em.bonus,
    (COALESCE(NULLIF(em.commission_pct, '')::numeric, 0) * em.salary) AS commission,
    (em.salary 
     + COALESCE(em.bonus, 0) 
     + COALESCE(NULLIF(em.commission_pct, '')::numeric, 0) * em.salary
    ) AS "TOTAL AMOUNT"
FROM practice.employees_dump em;


-- 15. Improved version: Handling NULL and empty strings using COALESCE
SELECT 
    em.first_name,
    em.salary,  
    em.bonus,
    
    (COALESCE(NULLIF(em.commission_pct, '')::numeric, 0) * em.salary) AS commission,  
    -- Calculate commission safely:
    -- 1. NULLIF(em.commission_pct, '') → Converts empty strings '' to NULL
    -- 2. ::numeric → Casts the value to numeric type for multiplication
    -- 3. COALESCE(..., 0) → Replaces NULL (or former empty strings) with 0
    -- 4. Multiply by salary to get actual commission amount
    
    (em.salary 
     + COALESCE(em.bonus, 0) 
     + COALESCE(NULLIF(em.commission_pct, '')::numeric, 0) * em.salary
    ) AS "TOTAL AMOUNT"  
    -- Calculate total amount:
    -- 1. Take salary
    -- 2. Add bonus (treat NULL as 0)
    -- 3. Add commission (safely handling NULLs and empty strings)
FROM practice.employees_dump em;


-- 
SELECT
MAX(e.salary)
FROM practice.employees_dump e;

--
SELECT
e.department_id,
MAX(e.salary)
FROM practice.employees_dump e
GROUP BY e.department_id;


-- subquery(employees maximum salary)
SELECT
e.first_name,
e.salary
FROM practice.employees_dump e
WHERE e.salary=(
SELECT
MAX(e.salary)
FROM practice.employees_dump e
);


-- correlated/ synchronized subquery(department wise max salary of employees)

SELECT
e.first_name,
e.department_id,
max(e.salary)
FROM practice.employees_dump e
GROUP by 1,2;


SELECT
e.first_name,
e.department_id,
e.salary
FROM practice.employees_dump e;

SELECT
e.department_id,
max(e.salary)
FROM practice.employees_dump e
GROUP by 1;
-- maximum salary
SELECT
e.first_name,
e.department_id,
e.salary
FROM practice.employees_dump e
WHERE e.salary in 
(
SELECT
max(e.salary)
FROM practice.employees_dump e
);

-- department wise maximum salary
SELECT
e.first_name,
e.department_id,
e.salary
FROM practice.employees_dump e
WHERE e.salary =
(
SELECT
max(em.salary)
FROM practice.employees_dump em
WHERE e.department_id=em.department_id
);