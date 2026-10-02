select t.request_at as day,round(sum(case when t.status like 'cancelled%' then 1.0 else 0 end) / count(*),2) as [cancellation rate]
from trips t
join users c on t.client_id = c.users_id and c.banned = 'no'
join users d on t.driver_id = d.users_id and d.banned = 'no'
where t.request_at between '2013-10-01' and '2013-10-03'
group by t.request_at;