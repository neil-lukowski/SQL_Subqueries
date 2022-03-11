--Filename: create_table.sql
--Authors: James Nelson & Neil Lukowski
--Date: 2/27/2022
--Description: This file creates three tables and defines the data
--organizational schema


create table sailors(
    sid         int,
    sname       varchar(20),
    rating      int,
    height      numeric(3,1),
    primary key (sid));

create table boats(
    bid         int,
    bname       varchar(15),
    color       varchar(20),
    primary key (bid));

create table reserves(
    sid         int,
    bid         int,
    day         date,
    primary key (sid, bid),
    foreign key (sid) references sailors,
    foreign key (bid) references boats);

