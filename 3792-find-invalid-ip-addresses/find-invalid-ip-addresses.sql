with cte1 as
(
select *
from logs
where (select count(*) from STRING_SPLIT(ip, '.')) = 4
)
,cte2 as
(
select *
from cte1
cross apply STRING_SPLIT(ip, '.') octets
where CAST(octets.value as bigint) >= 0 and CAST(octets.value as bigint) <= 255 and 
((LEN(octets.value) > 1 and CHARINDEX('0', octets.value) <> 1 ) or LEN(octets.value) = 1)
)
,cte3 as
(
select log_id
from cte2
group by log_id
having count(*) = 4
)
select ip, count(*) invalid_count
from logs
where log_id not in (select log_id from cte3)
group by ip
order by count(*), ip desc