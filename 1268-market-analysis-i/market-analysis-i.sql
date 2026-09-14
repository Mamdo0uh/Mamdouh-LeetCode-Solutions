select o.buyer_id,u.join_date,sum(case when year (o.order_date)=2019 then 1 else 0 end) as orders_in_2019 
from Users u join Orders o
on(u.user_id = o.buyer_id)
group by o.buyer_id,u.join_date
union
select u.user_id,u.join_date,0
from Users u
where u.user_id not in (select r.buyer_id
from Users s join Orders r
on(s.user_id = r.buyer_id)
group by r.buyer_id)

