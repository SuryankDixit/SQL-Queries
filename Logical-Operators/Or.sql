-- Find all the company names that start with a 'C' or 'W', and the primary contact contains 'ana' or 'Ana', but it doesn't contain 'eana'.


select *
from accounts
where (name like 'C%' or name like 'W%') and (primary_poc like '%ana%' or primary_poc like '%Ana%') and (primary_poc not like '%eana%');