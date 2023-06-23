--A, B and C are 3 non-negative integers.
--You will create a division where the numerator is the maximum value of A, B, C and the denominator is the minimum value of A, B, C.
--If the denominator is equal to 0, replace it by 1.
--The inputs have been chosen such that the numerator will always be divisible by the denominator, and so the result
--Return the result.
--Input
--Line 1: A non-negative integer
--Line 2: B non-negative integer
--Line 3: C non-negative integer
--Output
--Result
--Constraints
--0 <= A <= 50
--0 <= B <= 50
--0 <= C <= 50
--Example
--Input
--4
--2
--3
--Output
--2
--create table division(
--id int primary key identity,
--num1 int,
--num2 int,
--num3 int
--);
--insert into division values (2,4,3),(0,1,5),(0,2,6),(1,2,4),(12,6,3),(0,9,0)

select id,
(SELECT max(val)/(min(val)+1 - SIGN(min(val)))
FROM (
    VALUES (num1), (num2), (num3)
) AS tbl(val)) as div from division;

--SELECT max(val)
--FROM (
--    VALUES (2), (4), (3)
--) AS tbl(val)