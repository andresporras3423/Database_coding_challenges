----A, B and C are 3 non-negative integers.
----Return the result of maximum value of A, B, C to the power of the minimum value of A, B, C.
----Input
----Line 1: A non-negative integer
----Line 2: B non-negative integer
----Line 3: C non-negative integer
----Output
----Result
----Constraints
----0 <= A <= 500
----0 <= B <= 500
----0 <= C <= 500
----Example
----Input
----5
----2
----3
----Output
----25
--create table min_max(
--a int,
--b int,
--c int
--)
--insert into min_max values (5,2,3), (2,4,3), (3,1,5), (3,3,3), (0,9,3)
select a, b, c,
(
SELECT POWER(max(val),min(val))
FROM (
    VALUES (a), (b), (c)
) AS tbl(val)
) as sol
from min_max;