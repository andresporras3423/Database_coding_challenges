----Given an integer N, print the smallest prime number that's strictly bigger than it.
----Input
----Line 1: An integer N
----Output
----Line 1: A prime number P, strictly bigger than N
----Constraints
----0<=N<=2^26-1
----Example
----Input
----1
----Output
----2
--create table floor_prime(
--number int
--)
--insert into floor_prime values (7),(1),(2),(10),(120),(60),(1700)
declare @top_limit int = (select max(number)*2 from floor_prime);
declare @prime_candidates table (num int, status_ bit);

WITH NumberList AS (
    SELECT 2 AS Number
    UNION ALL
    SELECT Number + 1
    FROM NumberList
    WHERE Number < @top_limit
)
insert into @prime_candidates SELECT Number, 1
FROM NumberList
OPTION (MAXRECURSION 0);
declare @i int = 2;
while @i<=@top_limit 
begin
  if (select top 1 status_ from @prime_candidates where num=@i)=1
  begin
    declare @non_prime int = @i*2
    while @non_prime<@top_limit
    begin
      update @prime_candidates set status_=0 where num=@non_prime
      set @non_prime= @non_prime+@i
    end
  end
  set @i=@i+1
end;

with primes as (
select num from @prime_candidates where status_=1
)
select number, (select min(num) from primes where num>number) from floor_prime;