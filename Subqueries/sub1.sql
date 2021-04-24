--1. Which channels send the most traffic per day on avg to Parch and Posey?
select channel, avg(channel_used_count)
from 
    (
    select w.channel,count(channel) channel_used_count, date_trunc('day',w.occurred_at)
    from web_events w
    group by 1,3
    ) sub
group by 1;



-- 2. Return only those orders that occurred in the same month as Parch and Posies frist Order ever.
select *
from orders
where Date_Trunc('month',occurred_at) = (
                                        SELECT DATE_TRUNC('month',min(occurred_at))
                                        FROM orders)
order by occurred_at;


-- 3. Return only those orders that occurred in the same month as Parch and Posies frist Order ever and pull the avg of each type of paper qty in this month.
select avg(standard_qty) s, avg(poster_qty) p, avg(gloss_qty) g
from orders
where Date_Trunc('month',occurred_at) = (SELECT DATE_TRUNC('month',min(occurred_at))
FROM orders)


--4. The total amount spent on all orders on the first month that any order was placed in the orders table (in terms of usd).
ELECT SUM(total_amt_usd)
FROM orders
WHERE DATE_TRUNC('month', occurred_at) = 
      (SELECT DATE_TRUNC('month', MIN(occurred_at)) FROM orders);