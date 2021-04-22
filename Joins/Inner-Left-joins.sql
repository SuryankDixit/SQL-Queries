
-- I recommend testing your queries with the environment below, and then saving them to a file. Then compare your file to my solutions on the next concept!

-- If you have two or more columns in your SELECT that have the same name after the table name such as accounts.name and sales_reps.name you will need to alias them. Otherwise it will only show one of the columns. You can alias them like accounts.name AS AcountName, sales_rep.name AS SalesRepName

-- Questions



--1. Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.
select r.name region_name, s.name sales_rep_name, a.name accounts_name
from sales_reps s
join region r
on s.region_id = r.id and r.name = 'Midwest'
join accounts a
on a.sales_rep_id = s.id
order by a.name;

SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
WHERE r.name = 'Midwest'
ORDER BY a.name;


--2. Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for accounts where the sales rep has a first name starting with S and in the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.
select r.name region,a.name account,s.name sales
from sales_reps s
join region r
on s.region_id = r.id and r.name = 'Midwest' and s.name like 'S%'
join accounts a
on a.sales_rep_id = s.id and s.name like 'S%'
order by account;

SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
WHERE r.name = 'Midwest' AND s.name LIKE 'S%'
ORDER BY a.name;


--3. Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for accounts where the sales rep has a last name starting with K and in the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.
select r.name region,a.name account,s.name sales
from sales_reps s
join region r
on s.region_id = r.id and r.name = 'Midwest' and s.name like '% K%'
join accounts a
on a.sales_rep_id = s.id and s.name like '% K%'
order by account;


SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
WHERE r.name = 'Midwest' AND s.name LIKE '% K%'
ORDER BY a.name;


--4. Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100. Your final table should have 3 columns: region name, account name, and unit price. In order to avoid a division by zero error, adding .01 to the denominator here is helpful total_amt_usd/(total+0.01).
select r.name region, a.name account_name, (o.total_amt_usd/(o.total +.01)) as unit_price
from orders o
join accounts a
on a.id = o.account_id and o.standard_qty>100
join sales_reps s
on s.id = a.sales_rep_id
join region r
on s.region_id = r.id;


SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100;


--5. Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, account name, and unit price. Sort for the smallest unit price first. In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01).
select r.name region, a.name account_name, (o.total_amt_usd/(o.total +.01)) as unit_price
from orders o
join accounts a
on a.id = o.account_id and o.standard_qty>100 and o.poster_qty>50
join sales_reps s
on s.id = a.sales_rep_id
join region r
on s.region_id = r.id;

SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price;


--6.  Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, account name, and unit price. Sort for the largest unit price first. In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01).
select r.name region, a.name account_name, (o.total_amt_usd/(o.total +.01)) as unit_price
from orders o
join accounts a
on a.id = o.account_id and o.standard_qty>100 and o.poster_qty>50
join sales_reps s
on s.id = a.sales_rep_id
join region r
on s.region_id = r.id
order by unit_price desc;


--7. What are the different channels used by account id 1001? Your final table should have only 2 columns: account name and the different channels. You can try SELECT DISTINCT to narrow down the results to only the unique values.
select distinct a.name,w.channel
from accounts a
join web_events w
on a.id = w.account_id and a.id = 1001;


--8. Find all the orders that occurred in 2015. Your final table should have 4 columns: occurred_at, account name, order total, and order total_amt_usd.
SELECT o.occurred_at, a.name, o.total, o.total_amt_usd
FROM accounts a
JOIN orders o
ON o.account_id = a.id
WHERE o.occurred_at BETWEEN '01-01-2015' AND '01-01-2016'
ORDER BY o.occurred_at DESC;