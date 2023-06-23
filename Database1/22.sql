--create table multiply_and_sum(
--id int primary key identity,
--number int
--);
--insert into multiply_and_sum values ('12345'), ('999999'),('10'),('200'),('33333');
WITH x1 as (
select id, CONVERT(INT,SUBSTRING(CONVERT(VARCHAR(MAX),number),1,1)) as first_, SUBSTRING(CONVERT(VARCHAR(MAX),number),2,LEN(CONVERT(VARCHAR(MAX),number))-1) as rest from multiply_and_sum
)
select id, first_*(select sum(CONVERT(INT,chr)) from to_char_array(rest)) as solution from x1
select EXP(SUM(LOG(CONVERT(INT,chr)))) from to_char_array('3333') --return 81
--EXP(SUM(LOG(CONVERT(INT,chr))))