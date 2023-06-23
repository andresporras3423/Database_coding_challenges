--Output the number of cakes produced by the cake machine.
--Cake ingredients arrive 1 at a time and are stored, taking up 1 unit of space each. They are of type 0, 1, 2, up to recipeLength-1. Once at least one of each type of ingredient is stored, the machine consumes one of each type of ingredient and produces one cake (which is not stored).
--The machine cannot process an ingredient that it does not have space to store, and does not eject spare ingredients.
--Input
--recipeLength: Number of unique ingredients types for this cake recipe.
--storageSpace: Number of ingredients that the machine can store simultaneously.
--queueLength: Number of ingredients that are on their way to the machine.
--Next queueLength inputs: The types of each incoming ingredient, in the order they are arriving.
--Output
--Single integer: the number of cakes produced before the cake machine runs out of space.
--Constraints
--2 <= recipeLength <= 50
--2 <= storageSpace <= 500
--5 <= queueLength <= 2000
--There are no ingredients incoming other than the ones in the recipe.
--Example
--Input
--3
--5
--12
--0 1 2 0 0 0 1 1 1 2 2 2
--Output
--1
--drop table recipe_machine;
--create table recipe_machine(
--id int primary key identity,
--recipe_length int,
--machine_space int,
--queue_length int,
--queue_items varchar(max)
--);
--insert into recipe_machine values (3,5,12,'0 1 2 0 0 0 1 1 1 2 2 2'),
--(4,4,16,'0 1 2 3 0 1 2 3 1 2 2 2 3 0 0 0'),
--(2,6,8,'0 0 0 0 0 0 1 1'),
--(6,8,21,'0 0 1 2 3 4 5 2 2 5 4 3 1 0 0 0 1 2 3 4 5');
--select * from recipe_machine;
--3
--5
--12
--0 1 2 0 0 0 1 1 1 2 2 2
declare @solutions table (id int, sols int)
DECLARE @id int=0;
DECLARE @recipe_length int=0;
DECLARE @queue_length int=0;
DECLARE @machine_space int=0;
DECLARE @queue_items varchar(max)='';
DECLARE cursorMachine CURSOR FOR select * from recipe_machine;
OPEN cursorMachine;
FETCH NEXT FROM cursorMachine INTO @id, @recipe_length, @machine_space, @queue_length, @queue_items;
WHILE @@FETCH_STATUS = 0
BEGIN
  --here your logic for the row
  declare @table table (item varchar(max));
  delete @table;
  insert into @table select value from string_split(@queue_items,' ');
  -----------------------------------------------------
  declare @in_machine table (item varchar(1), total int);
  delete @in_machine;
  with t1 as (select distinct item from @table) insert into @in_machine select t1.item, 0 from t1;
 DECLARE @item varchar(max)='';
 declare @sol int = 0;
DECLARE cursorQueue CURSOR FOR select * from @table;
OPEN cursorQueue;
FETCH NEXT FROM cursorQueue INTO @item;
WHILE @@FETCH_STATUS = 0
BEGIN
  update @in_machine set total = total + 1 where item=@item;
  if (select count(*) from @in_machine where total=0)=0 and (select sum(total) from @in_machine)<=@machine_space
  begin
  set @sol = @sol + 1;
  update @in_machine set total = total - 1;
  end
  --here your logic for the row
  FETCH NEXT FROM cursorQueue INTO @item; --this should be always the last one
END
CLOSE cursorQueue;
DEALLOCATE cursorQueue;
  insert into @solutions select @id, @sol;
  ---------------------------------------------------
  FETCH NEXT FROM cursorMachine INTO @id, @recipe_length, @machine_space, @queue_length, @queue_items; --this should be always the last one
END
CLOSE cursorMachine;
DEALLOCATE cursorMachine;
select * from @solutions;