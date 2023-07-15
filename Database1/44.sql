use challenges;
--generate random password of length 12
--the password must have at least one uppercase, one lowercase, one number and one special character from the next list: !@#$%^&*-_+=~`|/:;.,?
    -----------------------------
    declare @temp_random as table (number0 int, number int);
    with randCTE AS (
        SELECT 1 as number0, FLOOR((RAND() * 9) + 1) as number
        UNION ALL
        SELECT number0+1, number+(SELECT FLOOR((RAND() * (9+number0-number)) + 1)) FROM randCTE
        WHERE number0<3
        ),
        randCTE2 as (select * from randCTE
        union all
        select 4, 12)
        insert into @temp_random select * from randCTE2;
        with q0 as (SELECT t1.number0, t1.number - ISNULL(t2.number, 0) AS rand_
FROM @temp_random t1
LEFT JOIN @temp_random t2 ON t1.number0 = t2.number0 + 1),
 q1 as(    
    select top (select top 1 rand_ from q0 where number0=1) * from to_char_array('ABCDEFGHIJKLMNOPQRSTUVWXYZ') order by NEWID()
    UNION ALL
select top (select top 1 rand_ from q0 where number0=2) * from to_char_array('abcdefghijklmnopqrstuvwxyz') order by NEWID()
UNION ALL
select top (select top 1 rand_ from q0 where number0=3) * from to_char_array('0123456789') order by NEWID()
UNION ALL
select top (select top 1 rand_ from q0 where number0=4) * from to_char_array('!@#$%^&*-_+=~`|/:;.,?') order by NEWID()
    ),
    Q2 AS (select chr from q1 order by NEWID() OFFSET 0 ROWS)
    select string_agg(chr,'') from Q2;
 