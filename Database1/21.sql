--create table parachute(
--id int primary key identity,
--exercise int,
--x float,
--y float,
--z float
--);
--insert into parachute values (1, 0.0000, 0.0000, 0.0000),
--(1, 0.0000, 0.0000, 1.0900),
--(1, 0.0000, 0.0000, 2.1800),
--(1, 0.0000, 0.0000, 3.2700),
--(1, 0.0000, 0.0000, 4.3600),
--(1, 0.0000, 0.0000, 5.4500),
--(1, 0.0000, 0.0000, 6.5400),
--(1, 0.0000, 0.0000, 7.6300),
--(1, 0.0000, 0.0000, 8.7200),
--(1, 0.0000, 0.0000, 9.8100),
--(2, 0.0000, 0.0000, 0.0000),
--(2, 0.0000, 0.0000, 1.0900),
--(2, 3.0000, 3.0000, 3.1800),
--(2, 4.0000, 4.0000, 4.2700),
--(3, 0.0000, 0.0000, 1.3600),
--(3, 0.0000, 2.0000, 2.4500),
--(3, 0.0000, 3.0000, 3.5400),
--(3, 0.0000, 7.0000, 7.6300),
--(3, 10.0000, 10.0000, 8.7200),
--(3, 10.0000, 10.0000, 9.8100),
--(4, 0.0000, 0.0000, 0.0000),
--(4, 1.0000, 1.0000, 1.0900),
--(4, 2.0000, 2.0000, 2.1800),
--(5, 0.0000, 0.0000, 8.7200),
--(5, 6.0000, 6.0000, 6.8100),
--(5, 7.0000, 7.0000, 7.0000),
--(5, 8.0000, 8.0000, 8.0900),
--(5, 12.0000, 12.0000, 21.1800);

with g1 as(
select sqrt((x*x)+(y*y)+(z*z)) as speed, exercise, id from parachute
),
g2 as (
select 'close' as parachute_status, exercise, id from g1 where speed<9
),
g3 as (
select speed, exercise, id from g1 where speed>=9
),
g4 as (
select min(speed) as min_speed, exercise as exercise0  from g3 group by exercise
),
g5 as (
 select 'open' as parachute_status, exercise, min(id) as id from g4
 left join g3
 on g4.exercise0=g3.exercise where min_speed>=9
 group by exercise
),
g6 as (
select * from g2 union select * from g5
)
select * from g6 order by exercise, id, parachute_status;