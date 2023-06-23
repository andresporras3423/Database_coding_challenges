--create table words_numbers(
--id int primary key identity,
--word varchar(500)
--);
--insert into words_numbers values ('H3ll0 w0r1d !'), ('h3110 w0r1d !'), ('byebye'), ('12345678');
select id, (SELECT SUM(CONVERT(INT,CONCAT('0',StringValue))) FROM regexSplit(word,'[^0-9]')) as total from words_numbers;