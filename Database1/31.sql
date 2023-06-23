----Print the product of all digits of a number n.
----Input
----Line 1: The integer n
----Output
----Line 1: The product of all digits
----Constraints
----Example
----Input
----1234
----Output
----24
--create table product_numbers(
--number bigInt
--);
--insert into product_numbers values (1234),(0),(5),(12340),(55555),(666666)

with q1 as (
select convert(varchar(500),number) str_num from product_numbers
), q2 as (
select str_num as question, 0 solution from  q1 where str_num like '%0%'
),
q3 as (
select str_num as question from  q1 where str_num not like '%0%'
)
select question, solution from q2
union
select question,
(select ROUND(EXP(sum(log(CONVERT(float,chr)))),0) from to_char_array(question)) solution from q3;