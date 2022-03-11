# CS453 - PROJECT 2 README
---

Authors: Neil Lukowski & James Nelson
Date: 1 March 2022

---
Description:

This project utilizes the sailing database to examine the
usefulness of several SQL operations including correlated
subqueries, with statements, and exists clauses. Files were
generated to drop tables, create tables, fill tables with sample
data, and execute query statements. The code in this project was
compiled in accordance with the standards of project 2 of CS453.

---

File Description
----------------
drop_table.sql - PSQL batch file used to drop tables with respect to foreign
                 key constraints.
create_table.sql - PSQL batch file used to create tables representing the
                   sailing database structure.
populate.sql - PSQL batch file used to populate tables in a manner consistent
               with foreign key constraints designed in create_table.sql
project2_tester.sql - PSQL batch file containing a set of SQL query statements
                      examining different aspects of the sailing database
                      system.

File Run Instructions
---------------------
1. Activate PSQL by running command 'psql' in Linux shell
2. Run drop_table.sql to remove existing tables as '\i drop_table.sql'
3. Create tables for sail database by running command '\i create_table.sql'
4. Populate tables with sample data by running command '\i populate.sql'
5. Engage SQL suite of queries by running command '\i project2_tester.sql'
6. When finished, exit PSQL by using command '\q'

