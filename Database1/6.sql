--Tell how much time in seconds a person spends on the elevator, going from their floor to floor 0.
--Going down each floor takes 3 seconds per. Each stop adds another 2 seconds, plus 2 more seconds for each person getting on the elevator
--Input
--Line 1: The initial floor as integer F the person is on
--Line 2: An integer N for the number of stops the elevator makes
--Line 3: A space-seperated list with N number of A integers, determining how many people get on the elevator
--Output
--Line 1: The time in seconds the person spends on the elevator
--Constraints
--1 ≤ A, F ≤ 50
--0 ≤ N ≤ 50
--Example
--Input
--6
--0
--Output
--18
----------------------------------------------------------------------------------------------
--create table elevators(
--id int primary key identity,
--floor_ int,
--stops int,
--persons varchar(MAX)
--)
--insert into elevators values (6,0,''), (5,2,'2 2'), (3,1,'5'), (10,4,'5 2 1 3');
select id, floor_*3+(stops*2)+(2*(
select SUM(CONVERT(int,value)) from string_split(persons,' ')
)) as total_time FROM elevators;