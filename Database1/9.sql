--Provided is a space-separated Fibonacci-like sequence with a number missing. You need to determine what that number is!
--The Fibonacci sequence is a sequence of numbers in which each number is the sum of the previous two, with a starting pair of 0 and 1. These "Fibonacci-like" sequences use the same progression rule, but different seed values.
--For example: 0, 1, 1, 2, 3, 5, 8, 13, ...
--(0 and 1 are seed items, 0+1=1, 1+1=2, 1+2=3, 2+3=5, etc)
--Input
--Line 1: a space-separated Fibonacci-like sequence with one number replaced by a question mark (?)
--Output
--Line 1: The number replaced by a question mark
--Constraints
--There will always be 3 or more numbers given (counting the question mark), and only one number will ever be replaced by a question mark.
--Example
--Input
--0 1 1 2 ?
--Output
--3
--create table missing_fibonacci(
--id int primary key identity,
--fibonacci varchar(max)
--);
--insert into missing_fibonacci values ('0 1 ?'), ('? 3 5'), ('13 ? 34'), ('144 233 ? 610 987'), ('21 ? 55 89'), ('8 13 ? 34'), ('144 233 ? 610 987')
--delete from missing_fibonacci where id=4
--select * from missing_fibonacci;
declare @table table (id int, sol int);
DECLARE @id int=0;
DECLARE @fibonacci varchar(max)=0;
DECLARE cursorNumbers CURSOR FOR select * from missing_fibonacci;
OPEN cursorNumbers;
FETCH NEXT FROM cursorNumbers INTO @id, @fibonacci;
WHILE @@FETCH_STATUS = 0
BEGIN
  with t1 as(
  select ROW_NUMBER() OVER(order by (SELECT NULL)) as i, value as num from string_split(@fibonacci, ' ')
  ),
  t2 as(
  select top 1 i as i0 from t1 where num='?'
  )
  insert into @table  select @id, IIF(i0=1,
  (select top 1 CONVERT(INT,num) from t1 where i=3)-(select top 1 CONVERT(INT,num) from t1 where i=2)
  ,
  IIF(i0=(SELECT MAX(i) from t1),
  (select top 1 CONVERT(INT,num) from t1 where i=i0-1)+(select top 1 CONVERT(INT,num) from t1 where i=i0-2),
  (select top 1 CONVERT(INT,num) from t1 where i=i0+1)-(select top 1 CONVERT(INT,num) from t1 where i=i0-1))
  ) from t2;
 FETCH NEXT FROM cursorNumbers INTO @id, @fibonacci; --this should be always the last one
END
CLOSE cursorNumbers;
DEALLOCATE cursorNumbers;
select * from @table;