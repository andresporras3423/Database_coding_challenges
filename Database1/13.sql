--Give the Hollerith string of s.
--To build the Hollerith string of s we first split s into chunks of length at most n. We then prepend the length of the chunk plus the character H (for Hollerith). The chunks are then joined with the character , (comma) and finally the whole string is prefixed and suffixed with /.
--Example:
--4
--HELLO WORLD
--(1) HELL O WO RLD         (split into chunks of length <= 4)
--(2) 4HHELL 4HO WO 3HRLD   (prepend the chunk's length + H)
--(3) 4HHELL,4HO WO,3HRLD   (join by comma)
--(4) /4HHELL,4HO WO,3HRLD/ (prepend and append /)
--Input
--Line 1: An integer n for the maximum length of a chunk.
--Line 2: A string s.
--Output
--The Hollerith string of s as described in the statement.
--Constraints
--Every character in s is a space character or an uppercase letter in the alphabet.
--0 < n < 50
--0 < length(s) < 100
--Example
--Input
--4
--HELLO WORLD
--Output
--/4HHELL,4HO WO,3HRLD/
--create table hollerith(
--id int primary key identity,
--chunks_size int,
--word varchar(500)
--)
--insert into hollerith values (4, 'HELLO WORLD'), (3, 'BYE BYE'), (10,'A MESSAGE'), (2,'abcdef')
declare @solutions table (id int, sol varchar(500));
DECLARE @id int=0;
DECLARE @chunks_size int=0;
DECLARE @word varchar(500)='';
DECLARE cursorHollerith CURSOR FOR select * from hollerith;
OPEN cursorHollerith;
FETCH NEXT FROM cursorHollerith INTO @id, @chunks_size, @word;
WHILE @@FETCH_STATUS = 0
BEGIN
  --here your logic for the row
  --print @word
  declare @start int = 1;
  declare @chunks table (id int primary key identity, chunk varchar(500));
  delete @chunks;
  while @start<=len(@word)
  begin
  declare @len int = (select min(val) from  (VALUES (@chunks_size), (len(@word)-@start+1)) AS tbl(val));
  insert into @chunks SELECT SUBSTRING(@word,@start,@len);
  set @start=@start+@chunks_size;
  end
  insert into @solutions select @id,CONCAT('\',(select STRING_AGG(concat(CONVERT(VARCHAR(500),len(chunk)),'H',chunk),',') from @chunks),'\'); 
  FETCH NEXT FROM cursorHollerith INTO @id, @chunks_size, @word; --this should be always the last one
END
CLOSE cursorHollerith;
DEALLOCATE cursorHollerith;
select * from @solutions;