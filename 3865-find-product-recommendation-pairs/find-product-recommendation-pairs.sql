with cte as (
select p1.product_id as product1_id ,p2.product_id as product2_id , count(*) as customer_count 
from ProductPurchases p1  , ProductPurchases p2 
where p1.user_id =p2.user_id and p1.product_id <p2.product_id
group by p1.product_id,p2.product_id 
having count(*) >2 )
select product1_id,product2_id,p1.category as product1_category ,p2.category as product2_category ,customer_count
from cte c inner join ProductInfo p1
on c.product1_id =p1.product_id inner join ProductInfo p2
on c.product2_id =p2.product_id  
order by customer_count desc ,product1_id asc ,product2_id asc 
