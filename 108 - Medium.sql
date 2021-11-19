CREATE TABLE IF NOT EXISTS Salary1 (
    id INT,
    Employee1_id INT,
    amount INT,
    pay_date DATE
);
CREATE TABLE IF NOT EXISTS Employee1 (
    Employee1_id INT,
    department_id INT
);
Truncate table Salary1;
insert into Salary1 (id, Employee1_id, amount, pay_date) values ('1', '1', '9000', '2017/03/31');
insert into Salary1 (id, Employee1_id, amount, pay_date) values ('2', '2', '6000', '2017/03/31');
insert into Salary1 (id, Employee1_id, amount, pay_date) values ('3', '3', '10000', '2017/03/31');
insert into Salary1 (id, Employee1_id, amount, pay_date) values ('4', '1', '7000', '2017/02/28');
insert into Salary1 (id, Employee1_id, amount, pay_date) values ('5', '2', '6000', '2017/02/28');
insert into Salary1 (id, Employee1_id, amount, pay_date) values ('6', '3', '8000', '2017/02/28');
Truncate table Employee1;
insert into Employee1 (Employee1_id, department_id) values ('1', '1');
insert into Employee1 (Employee1_id, department_id) values ('2', '2');
insert into Employee1 (Employee1_id, department_id) values ('3', '2');


with t1 as (select avg(amount) as company_average, month(pay_date) as company_pay_month from Salary1 group by month(pay_date)),
t2 as (select  e.department_id,month(s.pay_date) as pay_month,avg(s.amount) as to_comapre from Salary1 as s inner join Employee1 as e on s.employee1_id = e.employee1_id group by month(s.pay_date),e.department_id)
select 
(select date_format(pay_date,'%Y-%m') from Salary1 where month(pay_date) = a.company_pay_month limit 1)
as pay_month,b.department_id as department_id, case when a.company_average > b.to_comapre then 'lower'
when a.company_average < b.to_comapre then 'higher'
else 'same' end as comparison from t1 as a inner join t2 as b on a.company_pay_month = b.pay_month;

