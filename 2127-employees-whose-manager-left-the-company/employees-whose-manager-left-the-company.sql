select employee_id
from Employees
where manager_id NOT IN (select distinct employee_id from Employees) and salary <30000
order by employee_id asc