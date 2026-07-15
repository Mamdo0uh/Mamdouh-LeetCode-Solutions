select Department, Employee, Salary
from(select d.name as Department ,e.name as Employee ,e.salary as Salary,dense_rank() over (partition by d.id order by e.salary desc) as DN
from Employee e join Department d
on(e.departmentId = d.id)) as newtable
where (DN <=3)
order by salary