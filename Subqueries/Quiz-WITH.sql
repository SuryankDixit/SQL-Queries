--1. Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.
With t1 As (
    select r.name region_name, s.name sales_name ,sum(total_amt_usd) largest_amt
    from sales_reps s
    join region r
    on s.region_id = r.id
    join accounts a
    on a.sales_rep_id = s.id
    join orders o
    on a.id = o.account_id
    group by 1,2  
),
t2 As(
    select region_name, max(largest_amt) large_amt
    from t1
    group by 1
)

select t1.sales_name, t1.region_name, t2.large_amt
from t1
join t2
on t1.region_name = t2.region_name and t1.largest_amt = t2.large_amt;




--2. For the region with the largest sales total_amt_usd, how many total orders were placed?


--3. How many accounts had more total purchases than the account name which has bought the most standard_qty paper throughout their lifetime as a customer?


--4. For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events did they have for each channel?


--5. What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?


--6. What is the lifetime average amount spent in terms of total_amt_usd, including only the companies that spent more per order, on average, than the average of all orders.