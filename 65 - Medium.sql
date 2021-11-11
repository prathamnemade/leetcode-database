-- Question 65
Create table If Not Exists Events (business_id int, event_type varchar(10), occurences int);
Truncate table Events;
insert into Events (business_id, event_type, occurences) values ('1', 'reviews', '7');
insert into Events (business_id, event_type, occurences) values ('3', 'reviews', '3');
insert into Events (business_id, event_type, occurences) values ('1', 'ads', '11');
insert into Events (business_id, event_type, occurences) values ('2', 'ads', '7');
insert into Events (business_id, event_type, occurences) values ('3', 'ads', '6');
insert into Events (business_id, event_type, occurences) values ('1', 'page views', '3');
insert into Events (business_id, event_type, occurences) values ('2', 'page views', '12');

with allAverages as (
  select 
    event_type, 
    avg(occurences) as average 
  from 
    Events 
  group by 
    event_type
), 
modified_table as (
  select 
    *, 
    count(*) over(partition by ee.business_id) as count1 
  from 
    Events as ee 
  where 
    ee.occurences > (
      select 
        aa.average 
      from 
        allAverages aa 
      where 
        aa.event_type = ee.event_type
    )
) 
select 
  distinct business_id 
from 
  modified_table 
where 
  count1 = (
    select 
      max(count1) 
    from 
      modified_table
  );
