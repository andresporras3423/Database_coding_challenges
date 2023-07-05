    ----Initially output equals 0. Iterate through Each number In the input And perform the following operation
    ----If the number Is odd: Multiply it To output
    ----If the number Is even: Add it To the output
    ----Input
    ----Line 1: An integer count which represents the amount of given numbers.
    ----Line 2: A list Of Integer numbers Of length count seperated by space.
    ----Output
    ----Line 1: An integer output
    ----Constraints
    ----0 < count <= 100
    -----10000 <= number <= 10000
    -----2147483648 < output < 2147483648
    ----Example
    ----Input
    ----5
    ----2 4 8 10 6
    ----Output
    ----30

--create table lista_numbers (
--id int identity(1,1) primary key,
--total int,
--numbers varchar(255)
--);
--insert into lista_numbers values (5, '2 4 8 10 6'), (4, '-1 1 -1 1'), (1, '10'), (0, ''), (6, '-3 -2 -1 1 2 3');

declare @solutions table (id int, numbers varchar(255), sol int);
declare @id int=0;
declare @numbers varchar(255)='';
DECLARE cursorNumbers CURSOR FOR select id, numbers from lista_numbers;
OPEN cursorNumbers;
FETCH NEXT FROM cursorNumbers INTO @id, @numbers;
WHILE @@FETCH_STATUS = 0
BEGIN
  declare @temp table (num varchar(10));
  delete @temp;
  insert into @temp select * from string_split(@numbers, ' ');
  declare @num varchar(10)='';
  declare @sol int;
  set @sol=0;
  DECLARE cursorNum CURSOR FOR select * from @temp;
OPEN cursorNum;
FETCH NEXT FROM cursorNum INTO @num;
WHILE @@FETCH_STATUS = 0
BEGIN
  declare @int_num int= CONVERT(INT, @num);
  if(@int_num % 2 = 0)
  Begin
  set @sol = @sol + @int_num;
  End
  Else
  begin
  set @sol = @sol * @int_num;
  end
  FETCH NEXT FROM cursorNum INTO @num; --this should be always the last one
END
CLOSE cursorNum;
DEALLOCATE cursorNum;

  insert into @solutions select @id, @numbers, @sol;
  FETCH NEXT FROM cursorNumbers INTO @id, @numbers; --this should be always the last one
END
CLOSE cursorNumbers;
DEALLOCATE cursorNumbers;
select * from @solutions;