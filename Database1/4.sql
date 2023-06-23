
--Paternity/Maternity tests use gel electrophoresis to separate DNA fragments by size, forming several discrete bands. The most likely match for a parent is the person with the most bands in the same position as the child.
--Given the band patterns (all length 30) for a child and a pool of adults, find the most likely mother and father.
--Input
--Line 1: The child's pattern C. Bands are indicated by the '|' symbol.
--Line 2: The number N of possible parents.
--Next N lines: Sex, Name, and Pattern of possible parents.
--Output
--One line giving the name of the mother and father.
--Constraints
--N ≤ 100
--Example
--Input
--|*|***||****|****||*|**|*||**|
--4
--M Scott |*****|||***|**||*|*|****|***|
--F Jennifer ****|*|**|*||***|*|*||*|*|||||
--M Juan ****|**|***|*|**|*****|****|**
--F Natalie ***|**|**|****|*|*****|***|*||
--Output
--Jennifer Scott
-----------------------------------------------
--CREATE FUNCTION [dbo].[str_coincidences]
--(   
--    @myString1 varchar(MAX),
--    @myString2 varchar(MAX)
--)
--RETURNS int
--AS
--BEGIN
--    declare @solution int=0;
--    declare @count int = len(@myString1);
--    declare @i int = 0;
--    while @i<@count
--    BEGIN
--        if SUBSTRING (@myString1, @i, 1) =  SUBSTRING (@myString2, @i, 1)
--        begin
--            set @solution=@solution+1;
--        end
--        set @i=@i+1;
--    END
--    RETURN @solution;
--END
--GO
--create table parents
--(
--id int primary key identity,
--[name] varchar(MAX),
--gender varchar(1),
--dna varchar(30)
--)

--create table children
--(
--id int primary key identity,
--dna varchar(30)
--)


--create table candidates
--(
--id_parent int,
--id_child int,
-- CONSTRAINT pk_candidates PRIMARY KEY (id_parent, id_child),
-- CONSTRAINT fk_id_parent FOREIGN KEY (id_parent)
--  REFERENCES parents(id),
--  CONSTRAINT fk_id_child FOREIGN KEY (id_child)
--  REFERENCES children(id)
--)
--delete candidates;
--delete parents;
--delete children;

--declare @LastInsertedId int;
--INSERT INTO parents ([name], gender, dna)
--VALUES ('Scott', 'M','|*****|||***|**||*|*|****|***|'),
--('Jennifer', 'F','****|*|**|*||***|*|*||*|*|||||'),
--('Juan', 'M','****|**|***|*|**|*****|****|**'),
--('Natalie', 'F','***|**|**|****|*|*****|***|*||');

--INSERT INTO children (dna)
--VALUES ('|*|***||****|****||*|**|*||**|');

--set @LastInsertedId = (SELECT SCOPE_IDENTITY());
--insert into candidates(id_parent, id_child) select top 4 id, @LastInsertedId from parents order by id desc;

--INSERT INTO parents ([name], gender, dna)
--VALUES ('John', 'M','|||||||||||||||***************'),
--('Carla', 'F','*****|||||*****|||||*****|||||'),
--('Ivannia', 'F','*********|||||||||||**********'),
--('Jessifer', 'F','*|*|*|*|*|*|*|*|*|*|*|*|*|*|*|');

--INSERT INTO children (dna)
--VALUES ('|*|*|*|*|*|*|*|*|*|*|*|*|*|*|*');

--set @LastInsertedId = (SELECT SCOPE_IDENTITY());
--insert into candidates(id_parent, id_child) select top 4 id, @LastInsertedId from parents order by id desc;



with q1 as(
select dbo.str_coincidences(p.dna,h.dna) as coincidences, c.id_parent, p.[name], p.gender, c.id_child from  parents p
inner join candidates c
on p.id=c.id_parent
inner join children h
on c.id_child=h.id),
q2 as(
select max(q1.coincidences) as coincidences, q1.gender, q1.id_child from q1
group by q1.gender, q1.id_child
),
q3 as(
select q1.[name], q1.gender, q1.id_child from q1
inner join q2
on q1.coincidences=q2.coincidences and q1.id_child=q2.id_child and q1.gender=q2.gender)
select concat((select top 1 q4.[name] from q3 as q4 where q4.gender='F' and q4.id_child=q3.id_child), ' ', (select top 1 q5.[name] from q3 as q5 where q5.gender='M' and q5.id_child=q3.id_child)) as 'parents', q3.id_child from
q3
group by q3.id_child;