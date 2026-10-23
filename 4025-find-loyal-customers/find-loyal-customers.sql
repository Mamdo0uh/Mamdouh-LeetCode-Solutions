select customer_id
from customer_transactions
group by customer_id
having count(case when transaction_type = 'purchase' then 1 else null end) >= 3
and datediff(day, min(transaction_date), max(transaction_date)) >= 30
and (count(case when transaction_type = 'refund' then 1 else null end)  * 1.0 / count(transaction_type)) < 0.20