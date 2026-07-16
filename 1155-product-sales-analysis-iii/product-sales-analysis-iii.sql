select product_id,first_year,quantity,price
from (select product_id,year as first_year,quantity,price ,dense_rank() over (partition by product_id order by year asc) as DR
from Sales
) as newtable
where DR = 1 