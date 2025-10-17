-- Constraint
-- primary key
-- Unique key
-- Foreign Key
-- Check
-- Not null 
--0
--''
--null
/*cntrl + shift+/*/
--cntrl +/

create table practice.employees
(
emp_no serial not null,
birth_date date,
first_name varchar,
last_name varchar,
gender varchar,
hire_date date,
manager varchar,
primary key (emp_no)
);


drop table practice.employees;

-- adding constraints

alter table practice.employees
add constraint emp_check_gender
check (gender in('M','F') );

select * from practice.employees
limit 5;

-- creating schema

create schema stage;

select distinct(gender)
from stage.employees;

update
stage.employees
set gender='F'
where gender='Female';

truncate table practice.employees;

-- inserting values from employees table of stage schema
insert into practice.employees
select * from stage.employees;

select * from practice.employees
limit 5;

drop table practice.employees;

CREATE TABLE IF NOT EXISTS practice.employees 
(
emp_no serial not null,
birth_date date,
first_name varchar,
last_name varchar,
gender varchar check(gender in ('M','N')),
hire_date date,
manager varchar,
primary key (emp_no)
);

-- this won't work on postgres
CREATE or replace table practice.employees 
(
emp_no serial not null,
birth_date date,
first_name varchar,
last_name varchar,
gender varchar check(gender in ('M','N')),
hire_date date,
manager varchar,
primary key (emp_no)
);

--

DROP TABLE IF EXISTS practice.employees;

CREATE table practice.employees 
(
emp_no serial not null,
birth_date date,
first_name varchar,
last_name varchar,
gender varchar check(gender in ('M','N')),
hire_date date,
manager varchar,
primary key (emp_no)
);

-- unique constraint


CREATE table practice.employees 
(
emp_no serial not null,
birth_date date,
first_name varchar,
last_name varchar,
gender varchar check(gender in ('M','N')),
hire_date date,
manager varchar,
nid bigint unique,
primary key (emp_no)
);

--

CREATE table practice.employees 
(
emp_no serial not null,
birth_date date,
first_name varchar,
last_name varchar,
gender varchar check(gender in ('M','N')),
hire_date date,
manager varchar,
nid bigint,
primary key (emp_no)
unique(nid)
);

ALTER TABLE practice.employees ADD dep varchar NULL;

-- Foreign key needed to protect invalid data 

alter table practice.employees
add constraint emp_dep_fk
foreign key (dep)
references practice.department (dept_no);

-- above code will give error, because in department table dept_no is not set to primary key

alter table practice.department
add constraint dep_no_pk
primary key(dept_no);

-- data type should be same for foreign key
-- data should exist in main/reference table

-- DDL
-- created_at
-- is_deleted

alter table practice.department
add created_at timestamp;


alter table practice.department
add is_deleted bool
default false;

alter table practice.department
drop created_at;

alter table practice.department
add created_at timestamp
default now();


update practice.department
set is_deleted=true
where dept_no='d007';







