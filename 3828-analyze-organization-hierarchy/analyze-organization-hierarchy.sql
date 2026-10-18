with cte_manager as (select employee_id,employee_name,manager_id,salary,department,1 as level 
from employees 
where manager_id is null 
union all 
select e1.employee_id,e1.employee_name,e1.manager_id,e1.salary,e1.department,e2.level+1 as level 
from employees e1 inner join cte_manager e2
on e1.manager_id=e2.employee_id)
,cte_calcu as
(select employee_id as employee,manager_id as manager,employee_name,salary,department 
from cte_manager 
union all 
select manager_id,employee_id,employee_name,salary,department 
from cte_manager)
,cte_calcu_total as 
(select e1.manager_id,count(c1.employee_name) as team_size,sum(c1.salary) as budget 
from employees e1 join cte_calcu c1 
on e1.employee_id=c1.employee 
where e1.manager_id is not null 
group by e1.manager_id) 
select e.employee_id,e.employee_name,c1.level,iif(e.manager_id is null,(select count(employee_id) 
from cte_manager 
where manager_id is not null),isnull(team_size,0)) as team_size,iif(e.manager_id is null,(select sum(salary) 
from cte_manager),isnull(e.salary,0)+isnull(budget,0)) as budget 
from employees e left join cte_calcu_total c 
on e.employee_id=c.manager_id left join cte_manager c1 
on e.employee_id=c1.employee_id 
order by level asc,budget desc,employee_name asc;