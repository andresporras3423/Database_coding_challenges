--Goal
--You must output the average of the Lucas numbers between two numbers.
--Lucas numbers are like the Fibonacci numbers (every number is the sum of the 2 numbers appearing before it), but the first number in the series is 1, and the second is 3. 1,3,4,7,11,18…
--Input
--S and F, meaning start & finish, the indexes of the start and the finish of the sub-series (the index of the first number in the series is 1, not 0)
--Output
--The average of the Lucas numbers between S & F, inclusive (round down to nearest number)
--Constraints
--1 ≤ S,F ≤ 25
--S ≤ F
--Example
--Input
--1
--3
--Output
--2
--create table lucas_range(
--id int primary key identity,
--initial int,
--final int
--)
--insert into lucas_range values (0,0),(2,7), (7,30),(30,30),(47,48), (1,3)
declare @sols table (id int, sol int);
DECLARE @initial int=0;
DECLARE @final int=0;
DECLARE @id int=0;
DECLARE cursorNumbers CURSOR FOR select * from lucas_range;
OPEN cursorNumbers;
FETCH NEXT FROM cursorNumbers INTO @id, @initial, @final;
WHILE @@FETCH_STATUS = 0
BEGIN
  --here your logic for the row
  declare @first int = 1;
  declare @second int = 3;
  declare @sol int = 0;
  declare @added int = 0;
  while @first<=@final
  begin
      if @first>=@initial
      begin
        set @sol=@sol+@first
        set @added = @added +1;
      end
      declare @temp int = @second
      set @second = @second + @first
      set @first = @temp
  end
  insert into @sols select @id, iif(@sol=0,@sol,@sol/@added); 
  FETCH NEXT FROM cursorNumbers INTO @id, @initial, @final; --this should be always the last one
END
CLOSE cursorNumbers;
DEALLOCATE cursorNumbers;
select * from @sols;