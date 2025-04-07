--Altering anythin is not recommended (tring to alter using new user after getting ownership)
alter TABLE sales.students RENAME column student_name to name;

--it will give an error "ERROR:  must be owner of table students"

--after gettin ownership it can alter/modify
alter TABLE sales.students RENAME column student_name to name;

-- can not insert data into a temporary table which is created by other user 
-- even if a session is finished we can not access that table (local temporary Table)
INSERT INTO new_tbl
(id, name)
VALUES
(1, 'Bacd'),
(2, 'Abcd');


select * FROM new_tbl;
