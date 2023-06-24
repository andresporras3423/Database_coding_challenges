    --You are given a String s consisting Of only lowercase letters And spaces. You are Then given another String krap also consisting Of only lowercase letters And spaces. You are To remove all instances Of krap from s, Then print s
    --Input
    --Line 1: A string - s
    --Line 2: A string - krap
    --Output
    --Line 1: s after all instances Of krap are removed from it
    --Constraints
    --0 < length s < 200
    --0 < length krap < 50
    --0 <= Instances of krap in s < 200
    --Example
    --Input
    --qyrjkrapbnxhfuyjnkrapnfhrjgkkrapdjgkrapjntjgnd
    --krap
    --Output
    --qyrjbnxhfuyjnnfhrjgkdjgjntjgnd

--create table kraps(
--str_ varchar(255),
--krap varchar(255)
--)
--insert into kraps values ('ab','ab'), ('abcd','ab'), ('ab','abcdef'), ('b c',' '), ('ab cd',''),('','as'),('qyrjkrapbnxhfuyjnkrapnfhrjgkkrapdjgkrapjntjgnd','krap');


declare @solutions table (str_ varchar(255), krap varchar(255), sol varchar(max));
declare @str_ varchar(255);
declare @krap varchar(255);
DECLARE cursorKraps CURSOR FOR select * from kraps;
OPEN cursorKraps;
FETCH NEXT FROM cursorKraps INTO @str_, @krap;
WHILE @@FETCH_STATUS = 0
BEGIN
  declare @temp varchar(max)=@str_;
  with q1 as(
  select chr from to_char_array(CONCAT('|',@krap,'|')) -- don't know why but it seems to remove leading and end empty spaces.
  )
   select @temp=REPLACE(@temp,chr,'') from q1;
  insert into @solutions select @str_, @krap, @temp;
  FETCH NEXT FROM cursorKraps INTO  @str_, @krap; --this should be always the last one
END
CLOSE cursorKraps;
DEALLOCATE cursorKraps;
select * from @solutions;