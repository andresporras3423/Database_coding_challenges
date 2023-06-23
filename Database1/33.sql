    ----You must print every number up To n, n times
    ----Examples:
    ----1 -> 1
    ----3 -> 123123123
    ----5 -> 1234512345123451234512345
    ----Input
    ----The number
    ----Output
    ----Every number up To n, n times
    ----Constraints
    ----0<n<=20
    ----Example
    ----Input
    ----1
    ----Output
    ----1
--create table question (num int);
--insert into question values (1), (2), (10), (20), (3), (5);
declare @solutions table (num int, sol varchar(max));
declare @num int;
DECLARE cursorNums CURSOR FOR select * from question;
OPEN cursorNums;
FETCH NEXT FROM cursorNums INTO @num;
WHILE @@FETCH_STATUS = 0
BEGIN
  declare @temp varchar(max)='';
  declare @i int=1;
  while @i<=@num
  begin
  set @temp = CONCAT(@temp,@i);
  set @i = @i+1;
  end
   set @i=0;
   declare @sol varchar(max)='';
  while @i<@num
  begin
  set @sol = CONCAT(@sol,@temp);
  set @i = @i+1;
  end
  insert into @solutions select @num, @sol;
  FETCH NEXT FROM cursorNums INTO @num; --this should be always the last one
END
CLOSE cursorNums;
DEALLOCATE cursorNums;
select * from @solutions;