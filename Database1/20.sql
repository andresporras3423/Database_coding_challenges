----You have to convert Polar coordinates (θ, r) to normal (x, y) coordinates.
----Input
----Line 1: The angle θ in degree
----Line 2: The magnitude r
----Output
----One line: x, y separated by ", " (comma and space)
----The x and y coordinates will have to be rounded of to one decimal place even if there are no decimals.
----Constraints
----0 < θ < 360
----0 < r
----Example
----Input
----30
----12
----Output
----10.4, 6.0
--drop table polar;
--create table polar(
--id int primary key identity,
--radius float,
--angle float
--)
--INSERT INTO polar VALUES (12.0, 30.0), (24.0, 210.0), (1.0, 90.0), (10.0, 540.0), (45.0, 45.0), (5.0, -45.0);
with x1 as (
select angle-(FLOOR(angle/90.0)*90) as a2, (90.0-(angle-(FLOOR(angle/90.0)*90))) as a3, radius from polar
)
select
FORMAT(ROUND(sin(RADIANS(a2))*radius,1),'N1') as 'x',
FORMAT(ROUND(sin(RADIANS(a3))*radius,1),'N1') as 'y' from x1;