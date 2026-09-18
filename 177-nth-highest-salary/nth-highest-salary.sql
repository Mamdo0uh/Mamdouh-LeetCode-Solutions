create function getNthHighestSalary(@n int) returns int as
begin
declare @result int;
with rankedsalaries as (
select salary, dense_rank() over (order by salary desc) as dn
from employee
)
select @result = (
select distinct salary
from rankedsalaries
where dn = @n
);
return @result;
end