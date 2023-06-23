--You have to transform a hexagonal maze from a rectangular view to a hexagonal view, just to better see the good path to go from start to the end.
--To do this, you have to add spaces between every character.
--Input | Output
--------+-------
--ABCD  | A B C D     Line 0
--EFGH  |  E F G H    Line 1
--IJKL  | I J K L     Line 2
--MNOP  |  M N O P    Line 3
--Even lines are left aligned, odd lines are right aligned.
--Note that there is not necessary an even number of lines.
--Input
--First Line: two integers W and H space separated
--H following lines: the maze containing only #, _, S and E characters, with no space.
--Output
--H lines: the same maze with a hexagonal view.
--Constraints
--1 < W, H < 25
--Example
--Input
--5 6
--#####
--#S#E#
--#_#_#
--#_#_#
--#___#
--#####
--Output
--# # # # #
-- # S # E #
--# _ # _ #
-- # _ # _ #
--# _ _ _ #
-- # # # # #

DECLARE @current_rect VARCHAR(MAX);
DECLARE cursorRectangle CURSOR FOR select * from rectangles;
OPEN cursorRectangle;
FETCH NEXT FROM cursorRectangle INTO @current_rect;
WHILE @@FETCH_STATUS = 0
BEGIN

  DECLARE @output TABLE (
  line varchar(MAX)
  );
  delete from @output;
  DECLARE @current_id int=0;
  DECLARE @current_line VARCHAR(MAX);
DECLARE cursorLine CURSOR FOR select * from STRING_SPLIT(@current_rect,CHAR(10));
OPEN cursorLine;
FETCH NEXT FROM cursorLine INTO @current_line;
WHILE @@FETCH_STATUS = 0
BEGIN
  if(@current_id%2=0)
  begin
  insert into @output select STRING_AGG(CONCAT(chr,' '), '') FROM dbo.to_char_array(@current_line);
  end
  else
  begin
  insert into @output select STRING_AGG(CONCAT(' ',chr), '') FROM dbo.to_char_array(@current_line);
  end
  set @current_id = @current_id + 1
  FETCH NEXT FROM cursorLine INTO @current_line; --this should be always the last one
END
CLOSE cursorLine;
DEALLOCATE cursorLine;
 select STRING_AGG(line, CHAR(10)) FROM @output;
  FETCH NEXT FROM cursorRectangle INTO @current_rect; --this should be always the last one
END
CLOSE cursorRectangle;
DEALLOCATE cursorRectangle;
