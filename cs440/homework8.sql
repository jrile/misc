spool homework8
/* Jonathan Rile - jrile
CS 440 Assignment 8
Due 4/8/13 */


-- Question 1
create or replace type likers_array as varray(100) of number;
/
create or replace function Likers (i_crn IN number) 
	return likers_array
as
	l_tab likers_array := likers_array();
begin
	for lover in (select name from Likes join WVU on Likes.CRN1 = WVU.CRN where Likes.CRN2 = i_crn) loop
		l_tab.extend;
		l_tab(l_tab.count) := lover.name;
	end loop;
	return l_tab;

end Likers;
/

-- Question 2
create or replace procedure Hermitify (crn IN number)
as
begin
	delete from Likes where CRN1 = crn or CRN2 = crn;
	delete from Friend where CRN1 = crn or CRN2 = crn;
end Hermitify;
/

-- Question 3 
create or replace trigger new_student_likes
after insert on WVU
for each row
begin
	for student in (select CRN from WVU where grade = :new.grade) loop
		insert into Likes values(:new.CRN, student.CRN);
	end loop;
end new_student_likes;
/

-- Question 4
create or replace trigger new_student_is_freshman
before insert on WVU 
for each row when (new.grade is null)
begin
	:new.grade := 'FR';
end new_student_is_freshman;
/

-- Queston 5
create or replace trigger friend_symmetry
after insert on Friend
begin
	insert into Friend (select CRN2, CRN1 from Friend a
			    where not exists(select 1 from Friend where CRN1 = a.CRN2 and CRN2 = a.CRN1);
end friend_symmetry; 
/



-- Question 6
create or replace trigger student_advance 
for update of grade on WVU
compound trigger
type advance_friends is table of number index by binary_integer;
adv_fr	advance_friends;
ctr binary_integer := 1;
	before each row is begin
		adv_fr(ctr) := :new.CRN;
		ctr := ctr + 1;
	end before each row;
	after statement is begin
			for i in 1 .. adv_fr.count loop
				update WVU set grade = (select abbrev from year where position = (
						(select position from year where abbrev = grade)+1 )) 
						where CRN in(select CRN1 from Friend where CRN2 = adv_fr(i));
			end loop;
	end after statement;		
end student_advance;
/

-- Question 7
create or replace trigger delete_grads
for update of grade on WVU
compound trigger

	after each row is
	begin
		if :new.grade = 'GR' then
			delete from Likes where CRN1 = :new.CRN or CRN2 = :new.CRN;
			delete from Friend where CRN1 = :new.CRN or CRN2 = :new.CRN;
		end if;
	end after each row;

	after statement is
	begin
		delete from WVU where grade = 'GR';
	end after statement;

end delete_grads;
/

-- Question 8

create or replace trigger friend_update
after update of CRN2 on Likes
for each row
declare
	friendExists number := 0;
begin
	select 1 into friendExists from Friend where CRN1 = :old.CRN2 and CRN2 = :new.CRN2; 
	if (friendExists > 0) then
		delete from Friend where CRN1 = :old.CRN2 and CRN2 = :new.CRN2;
		delete from Friend where CRN2 = :old.CRN2 and CRN1 = :new.CRN2;
	end if;

exception
when no_data_found then
	null; -- do nothing, they don't exist in Friend table.

end friend_update;
/
end spool;