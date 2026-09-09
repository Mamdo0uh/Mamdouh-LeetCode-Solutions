select product_id,product_name,description
from products
where (description collate latin1_general_cs_as like 'SN[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]' 
 or description collate latin1_general_cs_as like 'SN[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9] %'
 or description collate latin1_general_cs_as like '% SN[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'
 or description collate latin1_general_cs_as like '% SN[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9] %'
 )
and description not like '%SN[0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]%'
and description not like '%SN[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][0-9]%'
order by product_id asc;