--k
select p.project_id,cast(avg(experience_years*1.0) as decimal(10,2)) as average_years
from Project p join Employee e
on(p.employee_id=e.employee_id)
group by p.project_id ;
