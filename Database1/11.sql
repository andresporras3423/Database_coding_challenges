--Raymond forgets things very often, so he keeps track of a to-do list. However each day he still forgets to do things from his to-do list. Given a daily to-do list (of length T) and what he did for the day (of length N), remind Raymond by outputting what he forgot about, sorted ALPHABETICALLY.
--Input
--Line 1: An integer T, the length of the to-do list.
--Next T lines: Each task in the to-do list.
--Line T+2: An integer N, the amount of tasks Raymond completed.
--Next N lines: Each task of the to-do list that Raymond completed.
--Output
--Every task that Raymond forgot for each line, sorted alphabetically.
--Constraints
--1 ≤ T ≤ 10
--1 ≤ N ≤ 10
--Example
--Input
--4
--Take out the rubbish
--Walk the dog
--Do the dishes
--Clean the living room
--3
--Take out the rubbish
--Clean the living room
--Do the dishes
--Output
--Walk the dog

--create table task_todo(
--day_ int,
--task varchar(500),
--);
--create table task_done(
--day_ int,
--task varchar(500)
--);
--CREATE UNIQUE INDEX idx_unique_task_todo ON task_todo (day_, task);
--CREATE UNIQUE INDEX idx_unique_task_done ON task_done (day_, task);

--drop table task_todo;
--drop table task_done;
--insert into task_todo values (1, 'Take out the rubbish'), (1, 'Walk the dog'),  (1, 'Do the dishes'),  (1, 'Clean the living room');
--insert into task_done values (1, 'Walk the dog'),  (1, 'Do the dishes'),  (1, 'Clean the living room');
--insert into task_todo values (2, 'a'), (2, 'b'),  (2, 'c');
--insert into task_done values (2, 'a'), (2, 'b'),  (2, 'c');
--insert into task_todo values (3, 'aaaa'), (3, 'bbbb')

select td.day_ as 'day', td.task from
task_todo td
left join
task_done dn
on td.day_=dn.day_ and td.task=dn.task
where dn.day_ is null;

