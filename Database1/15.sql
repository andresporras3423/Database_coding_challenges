--His Majesty Mathew the IX went mad with his maths obsession. To survive in his realm, you must prove your maths skills even under the worst circumstances. For instance, if you call 999 for an emergency alert, an answering machine asks you to enter a digit s defined as 9 modulo some integer, where that integer is formed by successively summing the digits of a larger number..
--Given a non-zero single digit a (1..9), a multiple of 9 b (b mod 9 = 0) and a random positive integer N, the formed number is obtained by concatenating a with N repetitions of b.
--Example:
--Answering machine ==> 6 72 2
--The first iteration of the summed digits gives "6"+"72"x2 ==> 6+7+2+7+2 = 24
--The second iteration gives "24" ==> 2+4 = 6 which is a single digit.
--Finally, 9 mod 6 = 3 is the digit that the caller must press to reach the Royal Emergency Service (REScue).
--Input
--Line 1 (integers): The 3 integers a, b, and N from the answering machine, are separated by a space.
--Output
--The digit s that the the caller must enter.
--Constraints
--1<=a<=9
--9<=b<2^53
--0<=N<2^53
--Example
--Input
--1 9 1
--Output
--0
--create table math_obssesion(
--id int primary key identity,
--numbers varchar(150)
--);
--insert into math_obssesion values ('6 72 2'), ('1 9 1'), ('4 1 4')

declare @solutions table(id int, sol int)

DECLARE @id int=0;
DECLARE @numbers varchar(150)='';
DECLARE cursorNumbers CURSOR FOR select * from math_obssesion;
OPEN cursorNumbers;
FETCH NEXT FROM cursorNumbers INTO @id, @numbers;
WHILE @@FETCH_STATUS = 0
BEGIN
  --here your logic for the 
  IF OBJECT_ID('tempdb..#nums') IS NOT NULL
  begin
  DROP TABLE #nums;
  end
  create table #nums (id int primary key identity, val varchar(150));
  insert into #nums select * from string_split(@numbers,' ');
  declare @current int = (select CONVERT(INT,val) from #nums where id=1)+replicate((select val from #nums where id=2),(select CONVERT(INT,val) from #nums where id=3));
  while @current>9
  BEGIN
  WITH z1 as (
  select sum(CONVERT(INT,chr)) as total from to_char_array(CONVERT(varchar,@current)))
  select @current=total from z1;
  END
  insert into @solutions select @id, 9%@current;
  FETCH NEXT FROM cursorNumbers INTO @id, @numbers; --this should be always the last one
END
CLOSE cursorNumbers;
DEALLOCATE cursorNumbers;

select * from @solutions;