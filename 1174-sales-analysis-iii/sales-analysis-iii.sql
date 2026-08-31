select distinct p.product_id,p.product_name 
from Product p join Sales s
on(p.product_id=s.product_id)
where sale_date between '2019-01-01' and '2019-03-31'
and p.product_id not in (
select distinct sa.product_id as pi
from Sales sa
where sale_date not between '2019-01-01' and '2019-03-31'
)