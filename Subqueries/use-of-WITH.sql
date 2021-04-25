
--  WITH SYNTAX

WITH table1 AS (
          SELECT *
          FROM web_events),

     table2 AS (
          SELECT *
          FROM accounts)


SELECT *
FROM table1
JOIN table2
ON table1.account_id = table2.id;





-- Avg number of Events per day in each marketting channel;
select channel,avg(events_) avg_events
from(
    select channel, date_trunc('day',occurred_at),count(*) events_
    from web_events
    group by 1,2
)q1
group by 1;



--   USE of With in Above Query
WITH events AS (
    select channel, date_trunc('day',occurred_at),count(*) events_
    from web_events
    group by 1,2
)

select channel,avg(events_) avg_events
from events
group by 1;