-- Question 106
Create table If Not Exists Student1 (student_id int, student_name varchar(30));
Create table If Not Exists Exam1 (exam_id int, student_id int, score int);
Truncate table Student;
insert into Student1 (student_id, student_name) values ('1', 'Daniel');
insert into Student1 (student_id, student_name) values ('2', 'Jade');
insert into Student1 (student_id, student_name) values ('3', 'Stella');
insert into Student1 (student_id, student_name) values ('4', 'Jonathan');
insert into Student1 (student_id, student_name) values ('5', 'Will');
Truncate table Exam;
insert into Exam1 (exam_id, student_id, score) values ('10', '1', '70');
insert into Exam1 (exam_id, student_id, score) values ('10', '2', '80');
insert into Exam1 (exam_id, student_id, score) values ('10', '3', '90');
insert into Exam1 (exam_id, student_id, score) values ('20', '1', '80');
insert into Exam1 (exam_id, student_id, score) values ('30', '1', '70');
insert into Exam1 (exam_id, student_id, score) values ('30', '3', '80');
insert into Exam1 (exam_id, student_id, score) values ('30', '4', '90');
insert into Exam1 (exam_id, student_id, score) values ('40', '1', '60');
insert into Exam1 (exam_id, student_id, score) values ('40', '2', '70');
insert into Exam1 (exam_id, student_id, score) values ('40', '4', '80');


with banned_id as (
  select 
    e1.student_id 
  from 
    (
      select 
        *, 
        min(score) over(partition by exam_id) as least, 
        max(score) over(partition by exam_id) as most 
      from 
        exam1
    ) as e1 
  where 
    e1.score = least 
    or e1.score = most
) 
select 
  distinct s1.student_id, 
  s1.student_name 
from 
  student1 as s1 
  join exam1 as e1 on s1.student_id = e1.student_id 
where 
  s1.student_id != all(
    select 
      * 
    from 
      banned_id
  );
