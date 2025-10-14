create schema sales;
-- creating orders table (DDL)
CREATE TABLE sales.orders
(order_id serial , cust_name VARCHAR , amount FLOAT);
-- Inserting some values into table (DML)
insert into sales.orders
(order_id , cust_name , amount)
VALUES 
(123, 'Abc', 55.6),
(124, 'BCD', 54.6),
(125,'CDE', 59.7);

--inserting some values which will not affected for wrong sequence of value input(will give error)
insert into sales.orders
(order_id , cust_name , amount)
VALUES 
( 'Abc', 123,55.6),
( 'BCD',124, 54.6),
('CDE',125, 59.7);

-- Inserting some values without giving column name


insert into sales.orders

VALUES 
(126, 'DEF', 55.6),
(127, 'EFG', 54.6),
(128,'FGI', 59.7);

--Inserting some values without giving column name and odrer_id as we set data type as serial (Will give error)

insert into sales.orders

VALUES 
('DEF', 85.6),
('EFG', 58.6),
('FGI', 99.7);

-- Inserting some values without  odrer_id as we set data type as serial wont give error if we mention column name without order_id

insert into sales.orders
( cust_name , amount)
VALUES 
('DEF', 85.6),
('EFG', 58.6),
('FGI', 99.7);

--SQL Writting Sequence 
--SELECT – Defines the columns to retrieve.
--FROM – Specifies the source table(s).
--WHERE – Filters rows before grouping.
--GROUP BY – Groups data based on specified columns.
--HAVING – Filters grouped data.
--ORDER BY – Sorts the final output.
--LIMIT – Restricts the number of rows returned.


-- Example 

--SELECT – Defines the columns to retrieve.
SELECT * --DQL
--FROM – Specifies the source table(s).
FROM sales.orders
--WHERE – Filters rows before grouping.
where amount> 50
--GROUP BY – Groups data based on specified columns.
--HAVING – Filters grouped data.
--ORDER BY – Sorts the final output.
--LIMIT – Restricts the number of rows returned.
LIMIT 2;






