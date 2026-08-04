select product_id,price
from (
 select product_id,new_price as price,change_date,row_number() over (partition by product_id order by change_date desc) as rn
from Products
where change_date <= '2019-08-16'
) as newtable
where rn=1
union 
select product_id,10 as price
from Products
WHERE product_id NOT IN (
    SELECT product_id 
    FROM Products 
    WHERE change_date <= '2019-08-16'
)