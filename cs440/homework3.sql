spool homework3.txt

/*
Jonathan Rile
CS 440
Assignment 3
February 3, 2013
*/

set echo on
-- 1
update emp set mgr = (select mgr from emp where ename = 'TURNER') 
	where ename = 'SCOTT';
rollback;

-- 2
insert into dept values(69, 'PR', 'Somewhere');
update emp set deptno = 69 
	where deptno = (select deptno from dept where lower(dname) = 'research');
rollback;


-- 3
select ename from emp minus (
	select ename from emp where mgr = (select mgr from emp where lower(ename) = 'martin'));

-- 4
break on sname
select distinct sname, pname from (sp right join p using(p#)) right join s using(s#) order by sname;

-- 5
select distinct pname from sp join p using(p#) where s# in 
	(select s# from s join sp using(s#) join p using(p#) where lower(pname) = 'stapler')
	and lower(pname) != 'stapler';


-- 6
select pname from p minus
	select pname from s join sp using(s#) join p using(p#) where lower(s.city) = 'bonn';
-- 7
select sname from s 
	where 3 <= ( select count(distinct city) from sp join p using (p#) where s.s# = s#); 

-- 8
select distinct dname, avg(sal) from dept left join emp using(deptno) group by dname;


-- 9
select dname from dept where dname not in(
	select dname from dept join emp using(deptno));

-- 10 added "or sal is null" to account for departments with 0 employees.
select dname, ename, sal from dept left join emp using(deptno) 
	where sal in (select max(sal) from emp group by deptno) or sal is null;

spool off; 