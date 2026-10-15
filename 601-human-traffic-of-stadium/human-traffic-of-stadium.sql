with cte1 as (
select *,id - row_number() over(order by id) as groupid
from stadium
where people >= 100
)
select id,visit_date,people
from cte1
where groupid in (
select groupid
from cte1
group by groupid
having count(*) >= 3
)
order by visit_date asc;