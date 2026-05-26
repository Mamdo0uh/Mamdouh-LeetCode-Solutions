SELECT MAX(num) AS num
FROM(
select num
from MyNumbers
group by num
having count(num)=1 and num >= ALL (select num
from MyNumbers
group by num
having count(num)=1)) AS SubQueryResult