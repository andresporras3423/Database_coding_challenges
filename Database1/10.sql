--You are given a string s of even length, with characters in bqunpdozx. Rotate it 180 degrees!
--Examples:
--1. dddd   -->  pppp
--2. bpbooo -->  oooqdq
--3. ubbqqn -->  ubbqqn
--4. ooxx   -->  xxoo
--5. zbbp   -->  dqqz
--Input
--Line 1: A string s to rotate.
--Output
--The string s rotated.
--Constraints
--The length of s is even.
--The length of s is <= 20.
--Every character of s is in bqunpdozx.
--Example
--Input
--dddd
--Output
--pppp
--create table valid_pairs(
--item1 varchar(1),
--item2 varchar(1)
--);
--insert into valid_pairs values ('b','q'),('u','n'),('p','d'),
--('o','o'),('z','z'),('x','x');

--create table rotate(
--id int primary key identity,
--texto varchar(max)
--);
--insert into rotate values ('dddd'),('bpbooo'),('ubbqqn'),('ooxx'),('zbbp')

with q1 as (select item1, item2 from valid_pairs
union select item2 as item1, item1 as item2 from  valid_pairs),
q2 as (select distinct * from q1)
select (select string_agg(q2.item2,'') from to_char_array(texto) as line 
left join q2 on line.chr=q2.item1) as sol from rotate;
--bqunpdozx