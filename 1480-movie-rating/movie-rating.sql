select results
from ( 
    select top (1) u.name as results
from users u join MovieRating mr
on(u.user_id = mr.user_id)
group by u.name
order by count (mr.created_at) desc , u.name asc
 ) as p1
union all
select results
from
( 
    select top (1) m.title as results
from Movies m join MovieRating mr
on(m.movie_id=mr.movie_id)
where left(created_at,7)='2020-02'
group by m.title
order by avg(mr.rating*1.00) desc ,m.title asc
) as p2