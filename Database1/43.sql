--''01 Test 1
--    ''Input
--    ''Expected output
--    ''1
--    ''.*.
--    ''.*.
--    ''02 Test 2
--    ''Input
--    ''Expected output
--    ''3
--    ''...*...
--    ''..***..
--    ''.*****.
--    ''...*...
--    ''03 Test 3
--    ''Input
--    ''Expected output
--    ''5
--    ''.....*.....
--    ''....***....
--    ''...*****...
--    ''..*******..
--    ''.*********.
--    ''.....*.....
--    ''04 Test 4
--    ''Input
--    ''Expected output
--    ''12
--    ''............*............
--    ''...........***...........
--    ''..........*****..........
--    ''.........*******.........
--    ''........*********........
--    ''.......***********.......
--    ''......*************......
--    ''.....***************.....
--    ''....*****************....
--    ''...*******************...
--    ''..*********************..
--    ''.***********************.
--    ''............*............
--create table tree_size(size int);
--insert into tree_size values (1),(2),(3),(5),(12)
--USE challenges
select 
CASE
WHEN NUMBER<=SIZE
then concat(replicate('.',SIZE-NUMBER+1),replicate('*',Number*2-1),replicate('.',SIZE-NUMBER+1))
ELSE concat(replicate('.',SIZE),'*',replicate('.',SIZE))
END,
SIZE
from tree_size ts
CROSS APPLY create_range(ts.size+1)
ORDER BY SIZE, NUMBER;

--CREATE FUNCTION create_range(@size INT)
--RETURNS TABLE
--AS
--RETURN
--(
--    WITH NumbersCTE AS (
--        SELECT 1 AS Number
--        UNION ALL
--        SELECT Number + 1
--        FROM NumbersCTE
--        WHERE Number < @size
--    )
--    SELECT Number
--    FROM NumbersCTE
--)
