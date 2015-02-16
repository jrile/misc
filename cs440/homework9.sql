/* Jonathan Rile
CS440 Assignment 9
Due Monday April 10th */
rollback;
drop table classes_ot;
drop table classes_ref_ty;
drop table student_plus;
drop type classes_ty;

-- Question 1
create or replace type classes_ty as object (
	CRN varchar2(5),
	Department varchar2(8),
	CourseTitle varchar2(25) );
/
-- Question 2
create table classes_ot of classes_ty;
/

-- Question 3
insert into classes_ot select * from wu.classes;
/

-- Question 4
create type classes_ref_ty as table of ref classes_ty;
/

-- 5
create table student_plus (
	student# varchar2(11),
	student_name varchar(10),
	major varchar2(8),
	advisor varchar(10),
	enrolled classes_ref_ty )
	nested table enrolled store as enrolled_tab;
/

-- 6
insert into student_plus (student#, student_name, major, advisor, enrolled) 
  select student_id, name, dept, advisor, classes_ref_ty() from wu.students;

begin
  for student in (select * from wu.students) loop
    for class in (select column_value from 
    table(select classes from wu.students where student_id = student.student_id)) loop
      insert into table(select enrolled from student_plus where student# = student.student_id) 
        select ref(x) from classes_ot x where crn = class.column_value;
    end loop;
        
      
  end loop;
end;