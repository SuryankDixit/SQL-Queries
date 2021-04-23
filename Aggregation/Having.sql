-- How many of the sales reps have more than 5 accounts that they manage?
select s.id,count(a.sales_rep_id)
from sales_reps s
join accounts a
on s.id = a.sales_rep_id
group by s.id
having count(a.sales_rep_id)>5
order by 2;

SELECT s.id, s.name, COUNT(*) num_accounts
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.id, s.name
HAVING COUNT(*) > 5
ORDER BY num_accounts;


-- How many accounts have more than 20 orders?
select a.name, count(o.account_id)
from accounts a
join orders o
on a.id = o.account_id
group by a.name
having count(o.account_id)>20
order by 2;

SELECT a.id, a.name, COUNT(*) num_orders
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING COUNT(*) > 20
ORDER BY num_orders;


-- Which account has the most orders?
select a.name,count(*)
from accounts a
join orders o
on a.id=o.account_id
group by a.name
order by 2 desc
limit 1;


-- Which accounts spent more than 30,000 usd total across all orders?
SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING SUM(o.total_amt_usd) > 30000
ORDER BY total_spent;

-- Which accounts spent less than 1,000 usd total across all orders?
SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING SUM(o.total_amt_usd) < 1000
ORDER BY total_spent;

-- Which account has spent the most with us?
SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY total_spent DESC
LIMIT 1;


-- Which account has spent the least with us?
SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY total_spent
LIMIT 1;

-- Which accounts used facebook as a channel to contact customers more than 6 times?
select a.name,a.id,count(*)
from accounts a
join web_events w
on a.id=w.account_id and w.channel = 'facebook'
group by 1,2
having count(*)>6;


-- Which account used facebook most as a channel?
select a.name,a.id,count(*)
from accounts a
join web_events w
on a.id=w.account_id and w.channel = 'facebook'
group by 1,2
order by 3 desc
limit 1;


-- Which channel was most frequently used by most accounts?
select a.name,a.id,w.channel,count(*)
from accounts a
join web_events w
on a.id=w.account_id
group by 1,2,3
order by 4 desc;