WITH CTE1 AS (
select *,row_number() over (partition by student_id ,subject order by exam_date  asc) as RN ,count(*) over (partition by student_id ,subject) as CT
from Scores
)
, cte2 as (
select student_id,subject , max(case when RN =1 then score end) as first_score,
max(case when RN =CT then score end) as latest_score , COUNT(*) as ct 

from CTE1
group by student_id,subject
)
select student_id,subject,first_score,latest_score
from cte2
where first_score < latest_score and ct > 1
order by student_id, subject asc