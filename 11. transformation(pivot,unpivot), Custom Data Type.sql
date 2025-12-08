----Transformation--------
-----pivoting------------

-- creating table
create table practice.sales
(
id serial,
year int,
amount int,
quarter int
);

-- inserting values
insert into
  practice.sales (year, quarter, amount)
values
  (2023, 1, 300),
  (2023, 2, 600),
  (2023, 3, 400),
  (2022, 3, 500);
  
-- selecting all rows  
SELECT s.*
FROM practice.sales s;

-- tablefunc extension/ crosstab function

-- creating extension
create extension  if not EXISTS tablefunc;


--The crosstab() function in PostgreSQL pivots rows into columns — similar to pivot tables in Excel or Power BI.

select * from crosstab(
'select year,quarter,amount from practice.sales order by 1,2 asc', -- main SQL query → provides row name, category, and value
'select distinct quarter from practice.sales order by 1') -- tells PostgreSQL what columns to create in the pivot table
as ct (
year int,
quarter1 int, quarter2 int, quarter3 int
); -- explicitly define the output table structure



-- order by year desc
select * from crosstab(
'select year,quarter,amount from practice.sales order by 1,2 asc',
'select distinct quarter from practice.sales order by 1')
as ct (
year int,
quarter1 int, quarter2 int, quarter3 int
) order by year desc; 


-- using case for pivoting

SELECT
year,
case when quarter=1 then amount end as quarter1,
case when quarter=2 then amount end as quarter2,
case when quarter=3 then amount end as quarter3
from 
practice.sales;

--aggregate pivot


SELECT
year,
sum(case when quarter=1 then amount end) as quarter1,
sum(case when quarter=2 then amount end) as quarter2,
sum(case when quarter=3 then amount end) as quarter3
from 
practice.sales
group by year 
order by year desc;

-- creating a table

SELECT
year,
sum(case when quarter=1 then amount end) as quarter1,
sum(case when quarter=2 then amount end) as quarter2,
sum(case when quarter=3 then amount end) as quarter3
into practice.sales_pivoted
from 
practice.sales
group by year 
order by year desc;

-- want to back previos format

-- unpivoting 
select
  sp."year",
  sp.quarter1 as amount,
  1 as quarter
from
  practice.sales_pivoted sp
where sp.quarter1 is not null

UNION ALL

select
  sp."year",
  sp.quarter2 as amount,
  2 as quarter
from
  practice.sales_pivoted sp
where
  sp.quarter2 is not null
UNION ALL
select
  sp."year",
  sp.quarter3 as amount,
  3 as quarter
from
  practice.sales_pivoted sp
where
  sp.quarter3 is not null;


 --- ### CUSTOM DATA TYPE

-- COMPOSITE TYPE

CREATE TYPE deptinfo AS (
dept_name varchar,
mgr_id int,
dept_desc text
)

CREATE TABLE practice.dept 
(
    id serial,
    dept_info deptinfo,
    location int
);

INSERT INTO practice.dept (dept_info, location)
VALUES 
(('English',765,'This dept was created for bla bla bla'),76547),
(('BANGLA',76576,'This dept was created for this hois this'),79599),
(('MATH',43324,'This dept was created for this hois this'),543);


SELECT * FROM practice.dept;

-- ENUM TYPE
CREATE TYPE emotion_type AS ENUM('happy','sad','nutral');

CREATE TABLE practice.emotions
(
    id serial,
    emotion emotion_type,
    human_name varchar
);


INSERT INTO practice.emotions (emotion, human_name)
VALUES 
('happy','Mr X'),
('sad','Mr Y'),
('nutral','Ms Z'),
('happy','Ms A');

SELECT * FROM practice.emotions;


-- RANGE type
create type callduration as RANGE (subtype= TIME);

CREATE TABLE practice.call_history
(
    chid serial,
    duration callduration,
    _user int,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO practice.call_history (duration, _user)
VALUES 
('[10:20, 10:28)',5376),
('[09:34, 09:36)',765);


SELECT *
FROM practice.call_history
WHERE duration @> '10:25'::time;


SELECT *
FROM practice.call_history
WHERE duration && '[09:35, 09:36)'::callduration;


-- Q&A Composite Type
CREATE TYPE practice.qatype AS (
    q varchar,
    a varchar
);

CREATE TABLE practice.auto_generated_qa
(
    qaid serial,
    qa practice.qatype,
    is_deleted bool DEFAULT FALSE,
    qa_added_by int,
    created_at timestamp DEFAULT now(),
    updated_at timestamp DEFAULT CURRENT_TIMESTAMP
);


INSERT INTO practice.auto_generated_qa (qa, qa_added_by)
VALUES 
(('What''s you cat name?', 'Sequel'),67456),
(('How old is your dog', '10 YO'),6546);


SELECT (qa).a
FROM practice.auto_generated_qa
WHERE (qa).q = 'How old is your dog';













