
----if ( then +1, else -1
----input:
----(())
----output:
----0
--create table parentheses_counter(
--question varchar(255)
--)
--insert into parentheses_counter values ('())(//((((((('),('(H(/GY/G)GY)&/)((((((((('),('(())'),('(('),('))'),('I(/&(('),(''),('('),(')'),('owfjrwofj76/&/')
select question, LEN(question)-(LEN(REPLACE(question,'(',''))*2) sol from parentheses_counter