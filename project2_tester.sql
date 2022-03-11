-- use the psql command

-- \i project2_tester.sql
-- to load and run this batch file
-- -------------------------------------------------
-- Project Two Part Two: Tester
-- Use the sail database
-- @author Neil Lukowski & James Nelson
-- @version 1 March 2022
-- @description The code in this file is used to query the sailors database
--              using a variety of different SQL operations including
--              correlated subqueries, with statements, and exist clauses. This
--              file was created according to the requirements of CS453.
-- -------------------------------------------------

\echo '\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
\echo 'Problem 1: '
\echo 'Find the names of sailors who have reserved boat 103.'
\echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
\echo '\nResult should be:\nsname\n-----\nDustin\nLubber\nHoratio\n'

select distinct sname
from sailors
where sid in (select sid
              from reserves
              where bid = 103);

-- ---------------------------------------------------------------

\echo '\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
\echo 'Problem 2: '
\echo 'Find the name of sailors who have reserved a red boat.'
\echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
\echo 'Result should be:\nsname\n------\nDustin\nLubber\nHoratio\n'

with red_boats(bid) as (select bid
                        from boats
                        where color = 'red')
select distinct sname
from sailors
where sid in (select sid
              from reserves, red_boats
              where red_boats.bid = reserves.bid);

-- ---------------------------------------------------------------

\echo '\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
\echo 'Problem 3: '
\echo 'Find the names of sailors who have not reserved a red boat.'
\echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
\echo 'Result should be:\nsname\n------\nBrutus\nAndy\nRusty\nZorba\nHoratio\nArt\nBob\n'

with red_boats(bid) as (select bid
                        from boats
                        where color = 'red')
select distinct sname
from sailors
where sid not in (select sid
                  from reserves, red_boats
                  where red_boats.bid = reserves.bid);

-- ---------------------------------------------------------------------

\echo '\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
\echo 'Problem 4:'
\echo 'Find the names of sailors who have reserved boat number 103.'
\echo 'Yes, this is the same query as Problem 1 above but your answer must be '
\echo 'substantially different with respect to the form of the nested subquery '
\echo 'and the connective that you use.'
\echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
\echo '\nResult should be:\nsname\n------\nDustin\nLubber\nHoratio\n'

--This is a correlated subquery, as the inner subquery refers to an alias of
--      the sailors relation which was defined in the outer query. This alias
--      is then compared to another alias of sailors, thus reevaluating the
--      inner subquery for each row of the R103 sailors relation.

select distinct R103.sname
from sailors as R103
where exists (select *
              from sailors as S, reserves
              where reserves.bid = 103 and
                    S.sid = reserves.sid and
                    R103.sname = S.sname);

-- ---------------------------------------------------------------------

\echo '\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
\echo 'Problem 5: '
\echo 'Find the sailors whose rating is better than some sailor called Horatio.'
\echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
\echo 'Result should be:'
\echo '\nsname | sid\n---------------\nLubber | 31\nAndy | 32\nRusty | 58\nZorba | 71 \nHoratio | 74\n'

select distinct sname, sid
from sailors
where rating > some (select rating
                     from sailors
                     where sname = 'Horatio');

-- ----------------------------------------------------------------------

\echo '\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
\echo 'Problem 6: '
\echo 'Find the sailors whose rating is better than all the sailors called Horatio.'
\echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
\echo 'Result should be:\nsname | sid\n-------------\nRusty | 58\nZorba | 71\n'

select distinct sname, sid
from sailors
where rating > all (select rating
                    from sailors
                    where sname = 'Horatio');

-- ----------------------------------------------------------------------

\echo '\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
\echo 'Problem 7: '
\echo 'Find sailors with the highest rating.'
\echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
\echo 'Result should be:\nsname | sid\n-------------\nRusty | 58\nZorba | 71\n'

select distinct sname, sid
from sailors
where rating >= all (select rating
                     from sailors);
                        
-- ---------------------------------------------------------------------

\echo '\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
\echo 'Problem 8: '
\echo 'Find the names of sailors who have reserved both a red and a green boat.'
\echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
\echo 'Result should be:\nsname\n------\nDustin\nLubber\n'

--This query is correlated because the inner subquery refers to an alias
--      of the sailors relation defined in the outer query to check each row of
--      the relation for expected values. The inner subquery is reevaluated for
--      each row of the outer query.

select distinct R.sname
from sailors as R, boats, reserves
where boats.color = 'red' and
      reserves.bid = boats.bid and
      R.sid = reserves.sid and
      exists (select *
              from sailors as G, boats, reserves
              where boats.color = 'green' and
              reserves.bid = boats.bid and
              G.sid = reserves.sid and
              R.sid = G.sid);

-- ---------------------------------------------------------------------

\echo '\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
\echo 'Problem 9: '
\echo 'Find the names of sailors who have reserved both a red and a green boat.'
\echo 'Yes, this is the same query as the previous query above but your answer must be '
\echo 'substantially different with respect to the form of the nested subquery '
\echo 'and the connective that you use.'
\echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
\echo 'Result should be:\nsname\n------\nDustin\nLubber\n'

select distinct sname
from sailors natural join boats natural join reserves
where color = 'red' and
      sid in (select sid
              from sailors natural join boats natural join reserves
              where color = 'green');

-- ---------------------------------------------------------------------

\echo '\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
\echo 'Problem 10: '
\echo 'Find the names of sailors who have reserved all boats.'
\echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
\echo 'Result should be:\nsname\n------\nDustin\n'

--This query is correlated because the inner subquery uses the alias of a
--      relation defined in the outer query to check each row of the sailors
--      relation for expected values; therefore, the inner subquery is
--      reevaluated for each row of the outer query.

select distinct R.sname 
from sailors as R
where not exists ((select bid
                   from reserves)
                   except
                  (select bid
                   from sailors as S, reserves
                   where S.sid = reserves.sid and
                         R.sname = S.sname)); 

-- ---------------------------------------------------------------------------

\echo '\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
\echo 'Problem 11: Find the names of sailors who have reserved all boats.'
\echo 'Same query as the previous one but your answer must be a substantively '
\echo 'different nested subquery.'
\echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
\echo 'Result should be:\n------\nsname\nDustin\n'

select distinct sname
from sailors natural join reserves
group by sid
having count(bid) >= (select count(bid)
                      from boats);

