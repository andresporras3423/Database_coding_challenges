--If the input number n is even, divide it by two, and if the result is still even repeat the process k times, until the resulting number p is odd, and output p.
--Input
--n an integer
--Output
--p an odd integer such as n=(2^k)*p
--Constraints
--1≤n<2^31
--0≤k<31
--Example
--Input
--6
--Output
--3
-------------------------------------------------------------------
--create table numbers
--(
--number int
--)
--insert into numbers values(6),(3),(333),(8),(12),(120)
declare @temp table(num int, i int);
 DECLARE @num int=0;
DECLARE cursorNumbers CURSOR FOR select * from numbers;
OPEN cursorNumbers;
FETCH NEXT FROM cursorNumbers INTO @num;
WHILE @@FETCH_STATUS = 0
BEGIN
  declare @i int = @num
  while @i % 2 = 0
  begin
  set @i = @i/2
  end
  insert into @temp select @num as num, @i as i;
  FETCH NEXT FROM cursorNumbers INTO @num; --this should be always the last one
END
CLOSE cursorNumbers;
DEALLOCATE cursorNumbers;
select * from @temp;