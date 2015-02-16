/* Jonathan Rile
CS 440 Assignment 7
Due 3/15/13 */

create or replace trigger salary_reqs
for insert or update of sal, comm, job
on emp
compound trigger

-- global decs go here
type sal_table is table of binary_integer index by varchar2(15);
v_limit sal_table;

sal_diff number;
hour number;
emp_exists number;

before statement is
begin
        v_limit('ANALYST') := 4000;
	v_limit('CLERK') := 1500;
        v_limit('MANAGER') := 3500;
        v_limit('SALESMAN') := 2000;
        v_limit('PRESIDENT') := 1000000;
end before statement;

before each row is 
begin
	-- Question 2 Second Part
	if updating('job') then
		if v_limit(:new.job) > v_limit(:old.job) then
			raise_application_error(-20100, 'Job modification not permitted');
		end if;
	end if;
end before each row;

after each row is
begin
	-- Question 1
	if updating('comm') or inserting then
		-- get hour from timestamp
		select extract(hour from numtodsinterval(sysdate - trunc(sysdate), 'DAY')) into hour from dual; 
		-- check peculiar time constraint
		if hour between 7 and 16 then
			update bonus set comm = :new.comm where ename = :new.ename;
			if sql%notfound then
				insert into bonus(ename, job, sal, comm) values
					(:new.ename, :new.job, :new.sal, :new.comm);
			end if;
		end if;
	end if;

end after each row;

after statement is
begin	
	-- Question 2 First Part
	if updating('sal') then 
		for emp_rec in (select empno, sal, comm, job from emp) loop
			if emp_rec.sal > v_limit(emp_rec.job) then
				sal_diff := emp_rec.sal - v_limit(emp_rec.job);
				if emp_rec.comm is null then -- wasn't working proprerly when comm was initally null
					update emp set comm = sal_diff, sal = v_limit(emp_rec.job) where empno = emp_rec.empno;
				else
					update emp set comm = comm + sal_diff, sal = v_limit(emp_rec.job) where empno = emp_rec.empno;
				end if;
			end if;
		end loop;
	end if;	


end after statement;


end salary_reqs;
/



-- Question 3
create or replace trigger weight_red
before insert or update of weight
on p
for each row

begin
	if :new.weight > 10 then
		:new.color := 'RED';
	end if;
end weight_red;
/



-- Question 4
create or replace trigger weight_blue
for insert or update of weight
on p
compound trigger

type xx_tab is table of p.p#%type index by binary_integer;
xx	xx_tab;

after each row is
begin 
 	if :new.weight < 8 then
		xx(xx.count+1) := :new.p#;
	end if;

end after each row;

after statement is 
begin
	for i in 1..xx.count loop
		update p set color = 'BLUE' where p# = xx(i);
	end loop;

end after statement;

end weight_blue;
/