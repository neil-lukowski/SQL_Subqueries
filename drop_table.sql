--Filename: drop_table.sql
--Authors: James Nelson & Neil Lukowski
--Date: 2/27/2022 

--Description: This file checks if certain tables exist and drops
--them if found in an order that preserves the foreign key constraints

drop table if exists reserves;
drop table if exists boats;
drop table if exists sailors;
