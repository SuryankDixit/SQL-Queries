-- Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.

SELECT t3.rep_name, t3.region_name, t3.total_amt
FROM(SELECT region_name, MAX(total_amt) total_amt
     FROM(SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
             FROM sales_reps s
             JOIN accounts a
             ON a.sales_rep_id = s.id
             JOIN orders o
             ON o.account_id = a.id
             JOIN region r
             ON r.id = s.region_id
             GROUP BY 1, 2) t1
     GROUP BY 1) t2
JOIN (SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
     FROM sales_reps s
     JOIN accounts a
     ON a.sales_rep_id = s.id
     JOIN orders o
     ON o.account_id = a.id
     JOIN region r
     ON r.id = s.region_id
     GROUP BY 1,2
     ORDER BY 3 DESC) t3
ON t3.region_name = t2.region_name AND t3.total_amt = t2.total_amt;



--2. For the region with the largest (sum) of sales total_amt_usd, how many total (count) orders were placed?
select r.name "region name", sum(total_amt_usd), count(*)
from region r
join sales_reps s
on s.region_id = r.id
join accounts a
on a.sales_rep_id = s.id
join orders o
on a.id = o.account_id
group by 1
order by 2 desc
limit 1;


-- answer 2:
-- The first query I wrote was to pull the total_amt_usd for each region.
SELECT r.name region_name, SUM(o.total_amt_usd) total_amt
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
JOIN region r
ON r.id = s.region_id
GROUP BY r.name;

-- Then we just want the region with the max amount from this table. There are two ways I considered getting this amount. One was to pull the max using a subquery. Another way is to order descending and just pull the top value.
SELECT MAX(total_amt)
FROM (SELECT r.name region_name, SUM(o.total_amt_usd) total_amt
             FROM sales_reps s
             JOIN accounts a
             ON a.sales_rep_id = s.id
             JOIN orders o
             ON o.account_id = a.id
             JOIN region r
             ON r.id = s.region_id
             GROUP BY r.name) sub;

-- Finally, we want to pull the total orders for the region with this amount:
SELECT r.name, COUNT(o.total) total_orders
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
JOIN region r
ON r.id = s.region_id
GROUP BY r.name
HAVING SUM(o.total_amt_usd) = (
      SELECT MAX(total_amt)
      FROM (SELECT r.name region_name, SUM(o.total_amt_usd) total_amt
              FROM sales_reps s
              JOIN accounts a
              ON a.sales_rep_id = s.id
              JOIN orders o
              ON o.account_id = a.id
              JOIN region r
              ON r.id = s.region_id
              GROUP BY r.name) sub);
-- This provides the Northeast with 2357 orders.



--3. How many accounts had more total purchases than the account name which has bought the most standard_qty paper throughout their lifetime as a customer?
select a.name, count(o.total)
from accounts a
join orders o
on a.id = o.account_id
group by 1
Having Sum(o.total)>(
     select Max(Total)
     from(
          select a.name ,Sum(o.standard_qty) standard_max, Sum(o.total) Total
          from accounts a
          join orders o
          on a.id = o.account_id
          group by 1
          order by 2 desc
          limit 1
     )q1)


--4. For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events did they have for each channel?
select name_,w.channel,count(*)
from web_events w
join (select a.name name_,a.id id_ ,sum(o.total_amt_usd)
     from accounts a
     join orders o
     on a.id=o.account_id
     group by 1,2
     order by 3 desc
     limit 1) t1
on w.account_id = t1.id_
group by 1,2;



--5. What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?
select avg(top_accounts)
from(
     select a.name,Sum(o.total_amt_usd)top_accounts
     from accounts a
     join orders o
     on a.id=o.account_id
     group by 1
     order by 2 desc
     limit 10
)q1;


--6. What is the lifetime average amount spent in terms of total_amt_usd, including only the companies that spent more per order, on average, than the average of all orders.
select Avg(top_amt)
from(
     select a.name, AVG(o.total_amt_usd) top_amt
     from accounts a
     join orders o
     on a.id = o.account_id
     group by 1
     having Avg(o.total_amt_usd) > (
                              select Avg(total_amt_usd)
                              from orders
                              )
     )q1;