----You must convert given binary into hexadecimal.
----Input
----A single binary number T (0b followed by a string of 1's and 0's). The string length is N.
----Output
----A hexadecimal representation of the binary number (0x followed by a string of chars in 0123456789abcdef)
----Constraints
----1≤N≤15
----Example
----Input
----0b1010
----Output
----0xa
--drop table hex;
--create table hex(
--num int,
--val varchar(30)
--)
--insert into hex values (0,'0'), (1,'1'), (2,'2'), (3,'3'), (4,'4'), (5,'5'), (6,'6'), (7,'7'), (8,'8'), (9,'9'), (10,'A'), (11,'B')
--, (12,'C'), (13,'D'), (14,'E'), (15,'F')
--CREATE TABLE [dbo].[hex_questions](
--	[question] [varchar](255) NULL
--)
--truncate table hex_questions;
--insert into hex_questions values ('0b1010'),('0b10'),('0b1100'),('0b11001100'),('0b100010001000'),('0b11100'),('0b111001111')
declare @sols table (question varchar(255), solution varchar(255))
DECLARE @num int=0;
declare @question varchar(255)=''
DECLARE cursorNumbers CURSOR FOR select * from hex_questions;
OPEN cursorNumbers;
FETCH NEXT FROM cursorNumbers INTO @question;
WHILE @@FETCH_STATUS = 0
BEGIN
  --here your logic for the row
  declare @new_question varchar(255) = reverse(SUBSTRING(reverse(@question),1,LEN(@question)-2))
  declare @to_add int = (4 - (len(@new_question) % 4)) % 4
  set @new_question = CONCAT(REPLICATE('0', @to_add),@new_question)
  declare @sol varchar(255) = '0x'
  declare @i int = 0
  while (@i*4)+4<=len(@new_question)
  begin
    declare @sub_question varchar(4) = substring(@new_question,(@i*4)+1,4);
    declare @hex_num varchar(1) = '';
    with q1 as (
    select ROW_NUMBER() over(order by (select null)) as row_index, chr from to_char_array(reverse(@sub_question))
    ),
    q2 as (
    select sum(POWER(2,row_index-1)*CONVERT(int,chr)) as total from q1
    )
    select @hex_num= (select val from hex inner join q2 on hex.num=q2.total)
    set @sol = CONCAT(@sol,@hex_num)
    set @i=@i+1
  end
  insert into @sols select @question, @sol
  FETCH NEXT FROM cursorNumbers INTO @question; --this should be always the last one
END
CLOSE cursorNumbers;
DEALLOCATE cursorNumbers;
select * from @sols;