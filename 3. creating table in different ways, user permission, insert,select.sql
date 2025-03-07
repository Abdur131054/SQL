--creating regular table and temporary table and drop table
create table sales.new_tbl (id int, name text);
drop table sales.new_tbl;

--creating temporary table and temporary table and drop table
create temporary table  new_tbl (id int, name text);

INSERT INTO new_tbl
(id, name)
VALUES
(1, 'Bacd'),
(2, 'Abcd');

drop table new_tbl

select * FROM new_tbl;

-- reating partioned table

create table new_tbl 
(id int, name text, creation_date date)
partition by range(creation_date);

--inserting data into partion table
insert into new_tbl
(id, name, creation_date)
VALUES
(1, 'abcd', '2025-03-7'),
(2, 'bcd', '2025-03-8');

create table new_tbl_2025_03_08 partition of new_tbl default;

--want to see in information schema have how many tables

select * from information_schema.tables;

-- indexing

create index order_id_idx on sales.orders (order_id);

--Drop Index
drop index order_id_idx;

--creating table with primary column
create table sales.new_tbl (id int primary key , name text)

--create tabele employees
create table sales.employees (id serial primary key, emp_name VARCHAR, emp_id int, created_at date);--here employees mentioned as id 
drop TABLE sales.employees ;

create table sales.departments(id serial primary key, dept_name VARCHAR, emp_id serial, created_at date);--here employees id mentioned as emp_id, but kept data type same , so we can use different columns names in primary and foreign key but data type should be same


--as we not define foriegn key on departments table before creating departments table , now we can modify this table 

--Alter table using constraits 

alter table sales.departments
ADD CONSTRAINT fk_dept_emp
FOREIGN KEY (emp_id)
references sales.employees(id);


--inserting some values on employees table

insert into sales.employees 
(id, emp_name, created_at )
VALUES
(2,'Abcd',CURRENT_DATE);

--read values from employees tables
select * from sales.employees;

--copy table along with data
select emp_name, now() as created_at into sales.employees_copy from sales.employees;

--creating table by importing data 
-- tested by Dbvear(created import table by importing csv file)


--creating table by another way

create table sales.created_from_emp
as 
select * from sales.import 
limit 1;