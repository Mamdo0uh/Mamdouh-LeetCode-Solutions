select user_id ,email               
from Users
where email like '%@%.com'
and email NOT like '%[^a-zA-Z0-9_]%@%'
and email not like '%@%[^a-zA-Z]%.com'
and email not like '%@.com'
order by user_id asc