
-- ------- Array ----------------

-- creating table

create table practice.students
(
id serial,
stud_name VARCHAR,
sub_name VARCHAR,
numbers int[] -- array (list) of integers
);

-- inserting values to students table
INSERT into practice.students
(stud_name,sub_name,numbers)
VALUES
('Mr. A','Bangla','{45,60,78}'),
('Mr. B','Bangla','{65,50,68}'),
('Mr. C','Math','{67,55,85}');

-- select operation
SELECT 
std.stud_name,
std.sub_name,
std.numbers
from practice.students std;

-- select operation
SELECT 
std.stud_name,
std.sub_name,
std.numbers[2]  --second index
from practice.students std;

-- update array
UPDATE practice.students
set numbers='{67,55,90}'
WHERE stud_name='Mr. C';

-- update according to index
-- update array
UPDATE practice.students
set numbers[2]=60
WHERE stud_name='Mr. C';

-- update second class test to 80 if number is 79
UPDATE practice.students
set numbers[2]=80
WHERE numbers[2]=79;



-- create table 
create table practice."sections"
(
id serial,
section_name VARCHAR,
enrolled_students int[]
);

INSERT INTO practice."sections"
(section_name, enrolled_students)
VALUES
('sec a', '{1,2}'),
('sec b', '{3,4}');

-- INSERT INTO practice.students
-- (stud_name,sub_name,numbers)
-- VALUES
-- ('Mr. D','Bangla','{46,69,79}');


-- join
SELECT 
std.stud_name,sec.section_name
FROM practice.students std
JOIN 
practice."sections"  sec 
-- <@ is the “is contained by” operator in PostgreSQL for arrays.
on array[std.id]<@sec.enrolled_students; -- checks if the student's ID exists inside the section's enrolled_students array

SELECT
    std.sub_name,
    sec.section_name,
    std.teachers
FROM practice.students std
JOIN practice.sections section_name
-- && is the array overlap operator
    ON std.teachers && sec.teachers;-- checks if teacher arrays have any common elements



---------Json--------------
-- json = plain text( slow for selection)( Whitesapace and order)
-- jsonb= binary (fast query)( slow for insert/update)( whitesapce and order not stored)

'{
"name":"Mr. A",
"age":32,
"skills":["sql","python", "Excell"]
}'

-- creating table
create table practice.profile
(
id serial 
,user_data JSONB

);


insert into practice.profile(user_data)
VALUES (
'{
  "name": "Mr. A",
  "age": 32,
  "skills": ["sql","python","Excel"]
}'
);


insert into practice.profile(user_data)
VALUES (
'{
  "name": "Mr. B",
  "age": 33,
  "skills": ["Power BI","python","Excel"]
}'
),
 (
'{
  "full_name": "Mr. c",
  "age": 32,
  "skill": ["Bangla","English","Excel"]
}'
)
;

SELECT * from 
practice.profile;

SELECT 
up.user_data->'name'
FROM practice.profile up;

SELECT 
up.user_data->'name',
up.user_data->'full_name'
FROM practice.profile up;


-- select name and full name without double quote
SELECT 
up.user_data->>'name', -- >> for absolute value
up.user_data->>'full_name'
FROM practice.profile up;


-- select name and full name both under one column
SELECT 
CASE
	WHEN up.user_data->>'name' is not null then up.user_data->>'name'
	else up.user_data->>'full_name'
END as "Name"
FROM practice.profile up;

SELECT
up.user_data->>'name' as "name"
FROM
practice.profile up 
where up.user_data->>'name' is not null;

SELECT
up.user_data->>'full_name' as "name"
FROM practice.profile up 
WHERE up.user_data->>'full_name' is not null;

-- union
-- Retrieves all profile names by checking both 'name' and 'full_name' keys from the JSON column.

SELECT
up.user_data->>'name' as "name"
FROM
practice.profile up 
where up.user_data->>'name' is not null
UNION ALL
SELECT
up.user_data->>'full_name' as "name"
FROM practice.profile up 
WHERE up.user_data->>'full_name' is not null;


SELECT * FROM
practice.profile
WHERE profile.user_data?'age';


SELECT * FROM
practice.profile
WHERE profile.user_data?'full_name';


-- Retrieves all profile names by checking both 'name' and 'full_name' keys from the JSON column.
-- this is more efficient because the '?' operator checks key existence directly, avoiding null extraction overhead.
SELECT
up.user_data->>'full_name' as "name" 
FROM
practice.profile UP
WHERE up.user_data?'full_name'
UNION ALL

SELECT
up.user_data->>'name' as name 
FROM
practice.profile up 
where up.user_data? 'name';


SELECT
up.user_data->>'name' as name,
up.user_data->>'skills',
up.user_data->>'skill'
FROM practice.profile up;


-- selecting specific element

SELECT
up.user_data->>'name' as "name",
up.user_data->'skills'->>1
FROM practice.profile up;


SELECT
up.user_data->>'name' as "name",
up.user_data->'skills'->>1
FROM practice.profile up;





