select session_id,user_id,datediff(minute, min(event_timestamp), max(event_timestamp)) as session_duration_minutes,sum(case when event_type = 'scroll' then 1 else 0 end) as scroll_count
from app_events
group by session_id, user_id
having datediff(minute, min(event_timestamp), max(event_timestamp)) > 30 and sum(case when event_type = 'scroll' then 1 else 0 end) >= 5 and sum(case when event_type = 'click' then 1 else 0 end) * 1.0 / sum(case when event_type = 'scroll' then 1 else 0 end) < 0.20 and sum(case when event_type = 'purchase' then 1 else 0 end) = 0
order by scroll_count desc, session_id asc