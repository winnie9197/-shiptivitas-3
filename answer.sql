-- TYPE YOUR SQL QUERY BELOW

-- PART 1: Create a SQL query that maps out the daily average users before and after the feature change

-- Union of a table for daily average users after & a table for daily average users before
-- built from sub-tables which show the daily user count since and after 2018-06-02
-- Format: Avg_count, Start_date, End_date

select round(avg(count)), min(dates), max(dates) 
from (select count(date(login_timestamp, "unixepoch")) as count, date(login_timestamp, "unixepoch") as dates
from login_history
where date(login_timestamp, "unixepoch")
between "2018-06-02" and date('now')
group by date(login_timestamp, "unixepoch")
union
select round(avg(count)),  min(dates), max(dates) 
from (select count(date(login_timestamp, "unixepoch")) as count, date(login_timestamp, "unixepoch") as dates
from login_history
where date(login_timestamp, "unixepoch") <
 "2018-06-02"
group by date(login_timestamp, "unixepoch"));

-- PART 2: Create a SQL query that indicates the number of status changes by card
-- Format: CardID, Number_of_status_changes
select card.id, count(card_change_history.timestamp), card.status as status
from card
left join card_change_history on 
card.id = card_change_history.cardID
group by card.id;

-- Investigation: another query for grouping status changes by date
-- Format: Date_of_change, New_status
select date(card_change_history.timestamp, "unixepoch") as dates, card_change_history.newStatus as newStatus
from card
left join card_change_history on 
card.id = card_change_history.cardID
group by dates;

