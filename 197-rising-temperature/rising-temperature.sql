select b.id as Id
from Weather a join Weather b
on (datediff(day, a.recordDate, b.recordDate) = 1)
where a.temperature<b.temperature