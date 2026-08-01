select top(1) person_name
from (select person_name , sum(weight) over (order by turn asc) as wezo
from Queue
) as newtable
where wezo <= 1000
order by wezo desc
