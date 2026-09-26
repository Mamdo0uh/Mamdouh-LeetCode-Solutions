with rankedsessions as (
select student_id,subject,session_date,hours_studied,row_number() over (partition by student_id order by session_date) as rn
from study_sessions
),
cycledetector as (
select r1.student_id,r1.rn - 1 as cycle_length
from rankedsessions r1
join rankedsessions r2 on r1.student_id = r2.student_id and r2.rn = 1 and r1.subject = r2.subject and r1.rn > 1
where not exists (
select 1
from rankedsessions curr
join rankedsessions next_s on curr.student_id = next_s.student_id and next_s.rn = curr.rn + 1
where curr.student_id = r1.student_id and datediff(day, curr.session_date, next_s.session_date) > 2
)
),
validcycles as (
select cd.student_id,cd.cycle_length
from cycledetector cd
where cd.cycle_length >= 3
and (
select count(distinct subject)
from rankedsessions
where student_id = cd.student_id and rn <= cd.cycle_length
) = cd.cycle_length
and not exists (
select 1
from rankedsessions s1
left join rankedsessions s2 on s1.student_id = s2.student_id and s2.rn = s1.rn + cd.cycle_length
where s1.student_id = cd.student_id and s1.rn <= cd.cycle_length and (s2.subject is null or s1.subject <> s2.subject)
)
),
studenttotalhours as (
select student_id,sum(hours_studied) as total_study_hours
from study_sessions
group by student_id
)
select vc.student_id,s.student_name,s.major,vc.cycle_length,sth.total_study_hours
from validcycles vc
join students s on vc.student_id = s.student_id
join studenttotalhours sth on vc.student_id = sth.student_id
order by vc.cycle_length desc, sth.total_study_hours desc, vc.student_id asc