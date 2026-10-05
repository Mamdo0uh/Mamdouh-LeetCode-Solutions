with o as
(select user_id,action_date,max(action)action 
from activity 
group by user_id,action_date 
having count(1)=1)
,f as(select user_id,action_date,action,action_date-cast(row_number()over(partition by user_id order by action_date)as int)g from o)
,s as(select user_id,action,min(action_date)start_date,max(action_date)end_date,count(1)streak_length 
from f 
group by user_id,action,g 
having count(1)>4)select user_id,action,streak_length,start_date,end_date from s f 
where streak_length>=(select max(streak_length)
from s f1 
where f.user_id=f1.user_id
)
order by streak_length desc,user_id asc