/*
Enter your query here.
* 
* * 
* * * 
* * * * 
* * * * *
*/
set @number=0;

select repeat('* ', @number := @number + 1) 
from information_schema.tables
where @number<20;


/*
Enter your query here.
* * * * * 
* * * * 
* * * 
* * 
*
*/
set @number=21;

select repeat('* ', @number := @number - 1) 
from information_schema.tables;