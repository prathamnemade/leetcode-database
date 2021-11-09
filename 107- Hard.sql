-- Question 107
-- The Numbers table keeps the value of number and its frequency.

CREATE TABLE IF NOT EXISTS Numbers (
    num INT,
    frequency INT
);
Truncate table Numbers;
insert into Numbers (num, frequency) values ('0', '7');
insert into Numbers (num, frequency) values ('1', '1');
insert into Numbers (num, frequency) values ('2', '3');
insert into Numbers (num, frequency) values ('3', '1');
insert into Numbers (num, frequency) values ('4', '7');



with modified_tab as (
  select 
    *, 
    sum(frequency) over(
      ROWS BETWEEN UNBOUNDED PRECEDING 
      AND CURRENT ROW
    ) as total_till 
  from 
    Numbers
), 
modified_table as (
  select 
    *, 
    (
      select 
        max(total_till) 
      from 
        modified_tab
    ) as total_records 
  from 
    modified_tab
) 
select 
  distinct case when total_records / 2 % 2 = 0 then (
    (
      select 
        num 
      from 
        modified_table 
      where 
        total_till >= total_records / 2 
      limit 
        1
    ) + (
      select 
        num 
      from 
        modified_table 
      where 
        total_till >= (total_records / 2)+ 1 
      limit 
        1
    )
  )/ 2 else (
    select 
      num 
    from 
      modified_table 
    where 
      total_till >= ceil(total_records / 2) 
    limit 
      1
  ) end as median 
from 
  modified_table;
