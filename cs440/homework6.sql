/* Jonathan Rile
CS 440 HW 6
Due 3/4/13 */


set serveroutput on format wrapped size 1000000
set line 140

create or replace procedure Salary_Report is
	v_total_sal	emp.sal%type;
	v_avg_sal	emp.sal%type;
	v_total_sal_overall	emp.sal%type;
	v_avg_sal_overall	emp.sal%type;

	procedure spaces(line in varchar) is
	numSpaces number;
	returnString varchar2(140);

	begin
		for i in 0..(140-length(line))/2 loop 
			-- this assumes line will always be <= 140
			returnString := returnString || ' ';
		end loop;
		returnString := returnString || line || chr(10) ;
	
	dbms_output.put_line(returnString);
	end spaces;

BEGIN

	spaces(initcap(to_char(sysdate, 'DAY, MON DD, YYYY')));
	spaces('Regal Lager');
	spaces(htf.italic('More than a Great Brew - a Palindrome'));
	spaces('Departmental Salary Report'); 
	dbms_output.put_line(chr(10) || chr(10));

	for dep in (select dname, deptno from dept) loop
		spaces('Department: ' || initcap(dep.dname));
		for empl in (select ename, sal from emp where emp.deptno = dep.deptno) loop
			spaces(empl.ename || ' $' || empl.sal);
		end loop;  
	
		select sum(sal) into v_total_sal from emp where emp.deptno = dep.deptno; 

		spaces('Total ' || initcap(dep.dname) || ' salary: $' || 
			v_total_sal);

		select avg(sal) into v_avg_sal from emp where emp.deptno = dep.deptno;
		
		spaces('Average ' || initcap(dep.dname) || ' salary: $' ||
                        v_avg_sal);

		dbms_output.put_line(chr(10));

	end loop;
	
	select sum(sal) into v_total_sal_overall from emp;
	select avg(sal) into v_avg_sal_overall from emp;

	spaces('Company Salaries:') ;
	spaces('Total Regal Lager salary: $' || v_total_sal_overall);
	spaces('Average Regal Lager salary: $' || v_avg_sal_overall);
	spaces('End of Report');
END Salary_Report;
/