Create table If Not Exists Friends (id int, name varchar(30), activity varchar(30));
Create table If Not Exists Activities (id int, name varchar(30));
Truncate table Friends;
insert into Friends (id, name, activity) values ('1', 'Jonathan D.', 'Eating');
insert into Friends (id, name, activity) values ('2', 'Jade W.', 'Singing');
insert into Friends (id, name, activity) values ('3', 'Victor J.', 'Singing');
insert into Friends (id, name, activity) values ('4', 'Elvis Q.', 'Eating');
insert into Friends (id, name, activity) values ('5', 'Daniel A.', 'Eating');
insert into Friends (id, name, activity) values ('6', 'Bob B.', 'Horse Riding');
Truncate table Activities;
insert into Activities (id, name) values ('1', 'Eating');
insert into Activities (id, name) values ('2', 'Singing');
insert into Activities (id, name) values ('3', 'Horse Riding');

with t2 as (select count(*) as cc, activity from Friends group by activity)
select activity from t2 where cc != (select max(cc) from t2) and cc != (select min(cc) from t2);