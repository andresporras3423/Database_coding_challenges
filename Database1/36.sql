    --You're a Game Master, and you are preparing a brand new scenario for your players.
    --You want To create your own rules, And create a ton Of dice conditions For them.
    --To save some time, you'd like to code a little program to calculate the range of the dice result , and the average (rounded down).
    --To avoid filling the table with dice, we'll limit the number of dice to 10 , printing TOO MANY DICE if exceeded
    --By the way, we're only using regular dices, so they can't have less than 4 faces, or an odd number of faces so in this case ,just print Error
    --As an example, one fireball (from AD&D) does 4d6 damage.
    --How can we Get the result ?
    --the lowest value Of a 6-faces dice Is 1, the biggest Is 6;
    --as we're throwing 4 of them, the lowest value will be 4*1, the maximum value 4*6.
    --the average Of the dice Is 3,5 ((1+6)/2) so the average For 4 dice Is 14
    --the output should Then be :Range 4-24,average 14
    --Input
    --first line one Integer N, the number Of lines To test
    --following N lines 1 String to_test
    --the syntax Of the String Is XdY where X Is the number Of this type Of dice, And Y the number Of faces, With a plus + between Each type Of dice
    --Output
    --N lines
    --For Each line : Range followed by a space, min And max values separated by a minus sign,
    --a comma And the word average, followed by a space, And the average value.
    --Or TOO MANY DICE Or Error
    --Constraints
    --Example
    --Input
    --1
    --4d6
    --Output
    --Range 4-24,average 14



--    create table dices (
--    id int identity(1,1) primary key, 
--    lines int)
--    insert into dices values (1), (3), (2)
--    create table dice_lines (
--    id int identity(1,1) primary key,
--    dices_id int,
--    str_ varchar(255),
--    FOREIGN KEY (dices_id)
--REFERENCES dices (id)
--    );
--    insert into dice_lines values (1, '4d6')
--    insert into dice_lines values (2, '1d8 2d6')
--    insert into dice_lines values (2, '4d4 1d2 6d8')
--    insert into dice_lines values (2, '2d4 8d8')
--    insert into dice_lines values (3, '4d8 1d6 6d2 8d10 6d20')
--    insert into dice_lines values (3, '10d16');
declare @solutions table (dice_id int,str_ varchar(max), lines varchar(max), sol float);
declare @dice_id int=0;
declare @str_ varchar(max)='';
declare @lines varchar(max)='';
DECLARE cursorDices CURSOR FOR select dl.dices_id, dl.str_, d.lines from dices d
inner join dice_lines dl
on d.id=dl.dices_id
OPEN cursorDices;
FETCH NEXT FROM cursorDices INTO @dice_id, @str_, @lines;
WHILE @@FETCH_STATUS = 0
BEGIN
  declare @sol float=0;
  with q1 as (
  select v2.value d from STRING_SPLIT(@str_, ' ') v2
  ),
  q2 as (
  select 
  (
  ((select EXP(SUM(LOG(CONVERT(float,v1.value)))) from  STRING_SPLIT(d, 'd') v1)+(SELECT TOP 1 CONVERT(float,v1.value) from  STRING_SPLIT(d, 'd') v1))/(SELECT TOP 1 CONVERT(float,v1.value) from  STRING_SPLIT(d, 'd') v1)) average
  from q1
  )
  select @sol=sum(average) from q2;
  insert into @solutions select @dice_id, @str_, @lines, @sol;
  FETCH NEXT FROM cursorDices INTO @dice_id, @str_, @lines; --this should be always the last one
END
CLOSE cursorDices;
DEALLOCATE cursorDices;
select * from @solutions
order by dice_id;