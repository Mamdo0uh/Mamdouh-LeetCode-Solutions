select  s.student_id as student_id ,s.student_name as student_name,su.subject_name as subject_name ,count(e.student_id) as attended_exams
from Students s  cross join subjects su
left join Examinations e
on(s.student_id = e.student_id
    AND e.subject_name = su.subject_name)
 group by s.student_id,s.student_name,su.subject_name 
 order by s.student_id,su.subject_name 