select round(sum(case when RN=1 AND DATEDIFF(day, event_date, next_date) = 1 then 1 else 0 end) *1.00 / count(distinct do),2) as fraction
from(
    select player_id as do,device_id,event_date,games_played,row_number() over (partition by player_id order by event_date) as RN,
    LEAD(event_date) OVER (PARTITION BY player_id ORDER BY event_date ASC) AS next_date
from Activity   
) as newtable