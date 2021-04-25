select concat(Name,'(',substring(Occupation,1,1),')') as Name
from occupations
order by Name;

select concat('There are a total of ',count(Occupation),' ', lower(Occupation),'s.') as total
from occupations
group by Occupation
order by total;