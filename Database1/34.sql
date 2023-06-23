--01 Test 1
--Input
--Expected output
--abcdef
--fedcba
--02 Test 2
--Input
--Expected output
--abc123
--cba123
--03 Test 3
--Input
--Expected output
--hi123are559887fine11
--ih123era559887enif11
--create table quest_str (string varchar(255))
--insert into quest_str values ('abcdef'), ('abc123'), ('hi123are559887fine11'), (''), ('a'), ('12')
declare @solutions table (quest varchar(255), sol varchar(255));
declare @quest varchar(255);
DECLARE cursorStrs CURSOR FOR select * from quest_str;
OPEN cursorStrs;
FETCH NEXT FROM cursorStrs INTO @quest;
WHILE @@FETCH_STATUS = 0
BEGIN
  insert into @solutions select @quest, ISNULL(STRING_AGG(REVERSE(StringValue),''),'') from regexSplit(@quest, '([0-9]+|[^0-9]+)') where StringValue<>'';
  FETCH NEXT FROM cursorStrs INTO @quest; --this should be always the last one
END
CLOSE cursorStrs;
DEALLOCATE cursorStrs;
select * from @solutions;
