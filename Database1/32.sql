﻿----Figure out how much sugar Johny ate, given the time he took in seconds and the speed he ate it at in grams per minute.
----Example:
----If time is 30 and speed is 20, you need to output 10.
----Input
----Line 1: An integer time for the time Johny was eating sugar.
----Line 2: An integer speed for the speed he ate at in grams per minute.
----Output
----Line 1: The amount in grams.
----Constraints
----1 ≤ time ≤ 9^9
----1 ≤ speed ≤ 9^9
----Example
----Input
----30
----20
----Output
----10
--create table total_sugar(
--total_time int,
--speed int
--)
--insert into total_sugar values (20,20),(30,20),(20,10),(6,10),(60,1),(100,0),(0,1000),(15,10),(5,30)
select total_time, speed, total_time*speed/60.0 as total from total_sugar;