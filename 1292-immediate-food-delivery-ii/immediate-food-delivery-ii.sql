select cast(sum ( case when order_date=customer_pref_delivery_date
then 1 else 0 end) *100.00/count(distinct customer_id)  as decimal(18,2)) as immediate_percentage 
from (select *, row_number() over (partition by customer_id order by order_date asc) as RN
from Delivery) as newtable
where RN=1