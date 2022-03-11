--Filename: populate.sql
--Authors: James Nelson & Neil Lukowski
--Date: 2/27/2022
--Description: This file populates three tables with data from
--specific text source files

\copy sailors from 'data/sailors_data.txt';
\copy boats from 'data/boats_data.txt';
\copy reserves from 'data/reserves_data.txt';
