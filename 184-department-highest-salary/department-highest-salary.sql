select dname as Department,empname as Employee ,empsalary as Salary 
from (select e.id as empid, e.name as empname , e.salary as empsalary, d.id as did, d.name as dname ,dense_rank() over (partition by d.name order by e.salary desc) as DN
from Employee e join Department d
on(e.departmentId = d.id )) as newtable
where DN=1


