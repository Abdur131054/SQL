-- DCL
--ceating user
--password setting
--validity of password
--changing ownership

--creating user(Role)
CREATE USER abdur WITH PASSWORD 'abcd'
VALID UNTIL '2025-12-30';

--giving permission to schema
GRANT USAGE ON SCHEMA sales to abdur;
--giving permission to students table
GRANT SELECT ON TABLE sales.students to abdur;
--giving permission to orders table
GRANT SELECT ON TABLE sales.orders to abdur;
-- withdrawing permission from a table

REVOKE SELECT ON TABLE sales.orders FROM abdur;

--modify/alter role
ALTER USER abdur
VALID UNTIL 'infinity';
--giving ownership to a user 
alter table sales.students owner to abdur;


