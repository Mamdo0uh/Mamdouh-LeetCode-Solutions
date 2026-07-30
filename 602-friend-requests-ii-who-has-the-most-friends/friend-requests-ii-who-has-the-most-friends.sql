select top(1) requester_id as id,count(accepter_id) as num
from (
    select requester_id,accepter_id ,accept_date
    from RequestAccepted
    union all
    select accepter_id,requester_id,accept_date 
    from RequestAccepted
) as newtable
group by requester_id
order by num desc