--You are given integers n and m.
--You need to find out if the digitwise products modulo 43 are the same for both of them.
--The digitwise product of a number is all digits of a number multiplied together. For example, the digitwise product of 95 would be: 9 * 5 = 45.
--The modulo operation returns the remainder or signed remainder of a division. For our example, it would be: 45 mod 43 = 2, so we see that the digitwise product of 95 mod 43 would be 2.
--Input
--Line 1: The integer n.
--Line 2: The integer m.
--Output
--Line 1: One of the digitwise products modulo 43 if the two digitwise products are the same modulo 43, and -1 otherwise.
--Constraints
--0 ≤ n, m < 2^32
--Example
--Input
--436
--89
--Output
--29
--create table digitwise(
--id int primary key identity,
--num1 int,
--num2 int
--);
--insert into digitwise values (436, 89), (436, 437), (95, 96), (95, 2);
with q1 as(
select ROUND((select EXP(SUM(LOG(CONVERT(float,chr)))) from to_char_array(CONVERT(VARCHAR(MAX),num1))),2) as prod1,
ROUND((select EXP(SUM(LOG(CONVERT(float,chr)))) from to_char_array(CONVERT(VARCHAR(MAX),num2))),2) as prod2 FROM digitwise
)
select IIF((CONVERT(int,prod1) % 43)=(CONVERT(int,prod2) % 43),CONVERT(int,prod1) % 43,-1) as sol from q1;