select id  as id  ,movie as movie,description as description  ,rating as rating
from Cinema
where id % 2<>0 and description <>'boring'
order by rating desc