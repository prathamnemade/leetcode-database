-- Question 105

Create table If Not Exists Employee (id int, company varchar(255), salary int);
Truncate table Employee;
insert into Employee (id, company, salary) values ('1', 'A', '2341');
insert into Employee (id, company, salary) values ('2', 'A', '341');
insert into Employee (id, company, salary) values ('3', 'A', '15');
insert into Employee (id, company, salary) values ('4', 'A', '15314');
insert into Employee (id, company, salary) values ('5', 'A', '451');
insert into Employee (id, company, salary) values ('6', 'A', '513');
insert into Employee (id, company, salary) values ('7', 'B', '15');
insert into Employee (id, company, salary) values ('8', 'B', '13');
insert into Employee (id, company, salary) values ('9', 'B', '1154');
insert into Employee (id, company, salary) values ('10', 'B', '1345');
insert into Employee (id, company, salary) values ('11', 'B', '1221');
insert into Employee (id, company, salary) values ('12', 'B', '234');
insert into Employee (id, company, salary) values ('13', 'C', '2345');
insert into Employee (id, company, salary) values ('14', 'C', '2645');
insert into Employee (id, company, salary) values ('15', 'C', '2645');
insert into Employee (id, company, salary) values ('16', 'C', '2652');
insert into Employee (id, company, salary) values ('17', 'C', '65');

with modified_table as (
  select 
    *, 
    count(*) over(partition by company) as count, 
    row_number() over(
      partition by company 
      order by 
        company, 
        salary
    ) as row_num 
  from 
    Employee
) 
select 
  m1.id, 
  m1.company, 
  m1.salary 
from 
  modified_table m1 
where 
  m1.row_num = (
    select 
      case when m1.count % 2 = 0 then m1.count / 2 else ceil(m1.count / 2) end
  ) 
  or m1.row_num = (
    select 
      case when m1.count % 2 = 0 then (m1.count / 2)+ 1 else ceil(m1.count / 2) end
  );

