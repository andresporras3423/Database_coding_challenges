----Three numbers A, B And C are the inputs. Write a program To find second largest among them.
----Input
----Line 1 N Is an Integer
----Line N A, B, C are Integer.
----Output
----display the second largest among A, B And C, In a New line.
----Constraints
----1 ≤ A,B,C ≤ 1000000
----Example
----Input
----1
----10 3 450
----Output
----10
--create table three_numbers(
--id int primary key identity,
--a int,
--b int,
--c int
--)
--insert into three_numbers values (10, 3, 450),
--(5, 5, 5),
--(3, 3, 7),
--(4, 9, 9),
--(-2, 0, 1),
--(0, 2, 1),
--(7, 3, 2)
select (
SELECT val
FROM (
    VALUES (a), (b), (c)
) AS tbl(val) order by val OFFSET 1 ROWS
FETCH NEXT 1 ROWS ONLY
)
as sol from three_numbers;