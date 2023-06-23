--create table questions(
--id int primary key identity,
--question varchar(MAX)
--)
--insert into questions values ('abcdefg'), ('hello world'), (''), ('P@$$w0rd'), ('ABCDEFG')
--create table questions_counter(
--question_id int,
--ch_id int,
--ch varchar,
--total int,
--FOREIGN KEY (question_id) REFERENCES dbo.questions(id),
--FOREIGN KEY (ch_id) REFERENCES dbo.chars(id)
--)
--create table chars (id int primary key identity, ch varchar(1));
--insert into chars select chr from to_char_array('abcdefghijklmnopqrstuvwxyz');
truncate table questions_counter;
DECLARE @id int=0;
DECLARE @question varchar(max)='';
DECLARE cursorQuestions CURSOR FOR select * from questions;
OPEN cursorQuestions;
FETCH NEXT FROM cursorQuestions INTO @id, @question;
WHILE @@FETCH_STATUS = 0
BEGIN
  --here your logic for the 
  with q1 as (select chr as ch from to_char_array(@question)),
  q2 as (select q1.ch as ch, chars.id as id from
  q1 right join chars
  on LOWER(q1.ch)=chars.ch)
  insert into questions_counter select @id, q2.id, LOWER(q2.ch), count(q2.ch) from q2 group by q2.id, q2.ch having count(q2.ch)>0;
  --group by @id, q2.id, q2.ch;

  FETCH NEXT FROM cursorQuestions INTO @id, @question; --this should be always the last one
END
CLOSE cursorQuestions;
DEALLOCATE cursorQuestions;

select question_id, ch, total from questions_counter order by question_id, ch_id;