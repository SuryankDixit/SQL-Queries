/*
Enter your query here.
*/
select Round(min(LAT_N),4)
from station
where LAT_N > 38.7780;