select max(salary) AS SecondHighestSalary
from
( select id,salary,dense_rank() over (order by salary desc) as DN
from Employee
) AS newtable
where DN =2