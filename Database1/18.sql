--create table squares(
--id int primary key identity,
--list varchar(MAX)
--);
--insert into squares values ('4 16'), ('0'), ('9 4 25') , ('100 10000 1000000 100000000')
select (select SUM(SQRT(CONVERT(INT, value))) from string_split(list, ' ')) sol from squares;