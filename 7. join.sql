-- Join
-- inner join
-- equi join
-- theta join
-- self join
-- outer join
   -- left join 
   -- right join\
   -- full outer join
-- cross join

-- natural join
--Use NATURAL JOIN only in small, well-structured databases where same-named columns are guaranteed to be true keys.
--Otherwise, use INNER JOIN ... ON ... for clarity and safety.

select *
from 
practice.employees emp
natural join
practice.department dep;

select * from practice.department dep;
-- inner join /equi join
select *
from 
practice.employees emp
inner join
practice.department dep
on emp.dept_no=dep.dept_no;

-- theta join (<>.>,<,,=,>=)
select * from 
practice.departments d 
join practice.employees e 
on e.dept_no <>d.department_id::character varying;

-- outer join
-- left join
select * from 
practice.departments d left join practice.employees e 
on d.department_id::text =e.dept_no;

-- right join
select * from 
joinpractice.departments d right join joinpractice.employees e
on d.department_id = e.dept_no;

-- full outer join
select * from 
joinpractice.departments d full outer join joinpractice.employees e
on d.department_id = e.dept_no;

select * from 
joinpractice.departments d full join joinpractice.employees e
on d.department_id = e.dept_no;

-- cross join (Cartesian Join)
-- A CROSS JOIN returns the Cartesian product of two tables —
-- it combines every row from the first table with every row from the second table.
-- Often used for generating combinations (e.g., all possible pairs).
-- to generate dummy data or create combinations

select * from joinpractice.employees e 
cross join joinpractice.departments d; 

-- self join
-- A SELF JOIN is a regular join where a table is joined with itself
-- It is useful when you want to compare rows within the same table — for example, 
-- finding relationships between employees (like who reports to whom).
-- we must use aliases to differentiate the two references
select * from joinpractice.employees e join joinpractice.employees m
on m.emp_no=e.manager ;
-- 
select 
e.emp_no,
e.first_name,
m.emp_no manager_no,
m.first_name manager_name
from joinpractice.employees e join joinpractice.employees m
on m.emp_no=e.manager ;


-- above query without joining(using where clause)
SELECT 
    e.emp_no,
    e.first_name,
    m.emp_no AS manager_no,
    m.first_name AS manager_name
FROM joinpractice.employees e, joinpractice.employees m
WHERE m.emp_no = e.manager;




