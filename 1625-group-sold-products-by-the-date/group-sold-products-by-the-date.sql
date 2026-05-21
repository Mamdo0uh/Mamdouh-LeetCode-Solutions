
select sell_date, count(*) as num_sold, string_agg(product, ',') as products
from (
    select distinct sell_date, product
    from activities
) a
group by sell_date