with cte1 as
 (
    select p.category,s.quantity,s.price,case when month(s.sale_date) in (12,1,2) then 'Winter' when month(s.sale_date) in (3,4,5) then 'Spring' when month(s.sale_date) in (6,7,8) then 'Summer' when month(s.sale_date) in (9,10,11) then 'Fall' end as season from sales s join products p 
    on s.product_id=p.product_id)
    ,cte2 as
     (
        select season,category,sum(quantity) as total_quantity,sum(quantity*price) as total_revenue,row_number() over (partition by season order by sum(quantity) desc,sum(quantity*price) desc,category asc) as rn
         from cte1 
         group by season,category) 
         select season,category,total_quantity,total_revenue 
         from cte2
          where rn=1 
          order by case when season='Fall' then 1 when season='Spring' then 2 when season='Summer' then 3 when season='Winter' then 4 end;