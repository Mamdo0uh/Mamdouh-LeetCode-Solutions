select employee_id,salary as bonus
from Employees
where employee_id % 2 <> 0 and name not like 'M%'
union
select employee_id, salary =0
from Employees
where employee_id % 2 = 0 or name like 'M%'

