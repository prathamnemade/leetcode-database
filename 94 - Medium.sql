Create table If Not Exists Accounts (id int, name varchar(10));
Create table If Not Exists Logins (id int, login_date date);
Truncate table Accounts;
insert into Accounts (id, name) values ('1', 'Winston');
insert into Accounts (id, name) values ('7', 'Jonathan');
Truncate table Logins;
insert into Logins (id, login_date) values ('7', '2020-05-30');
insert into Logins (id, login_date) values ('1', '2020-05-30');
insert into Logins (id, login_date) values ('7', '2020-05-31');
insert into Logins (id, login_date) values ('7', '2020-06-01');
insert into Logins (id, login_date) values ('7', '2020-06-02');
insert into Logins (id, login_date) values ('7', '2020-06-02');
insert into Logins (id, login_date) values ('7', '2020-06-03');
insert into Logins (id, login_date) values ('1', '2020-06-07');
insert into Logins (id, login_date) values ('7', '2020-06-10');

with t1 as (
select id,login_date,
lead(login_date,4) over(partition by id order by login_date) date_5
from (select distinct * from Logins) b
)
select * from t1;
select distinct a.id, a.name from t1
inner join accounts a 
on t1.id = a.id
where datediff(t1.date_5,login_date) = 4
order by id

