--Find middle point from given coordinates
--create table coordinates(
--id int primary key identity,
--x1 int,
--y1 int,
--x2 int,
--y2 int,
--)
--insert into coordinates values (-2,-2,2,2), (-2,-2,1,3), (3,3,1,1), (2,4,0,2), (0,0,0,3), (0,0,1,3), (4,2,3,1)
select (x2+x1)/2.0 as x, (y2+y1)/2.0 as y, id from coordinates;