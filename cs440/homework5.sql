spool hw5.txt
/* Jonathan Rile
CS 440 Assignment 5 Redo
Due February 20 */


-- 1a
select distinct pname from p join sp using(p#) where s# in('s1', 's2', 's4');

-- 1b
select distinct pname from p join sp using(p#) where s# = 's1' and
	pname in(select distinct pname from p join sp using(p#) where s# = 's2' and
	pname in(select distinct pname from p join sp using(p#) where s# = 's4'));

-- 2
select distinct sname from s join sp using(s#)  where
	(select count(*) from (
		(select p# from p where lower(color) = 'red')
		minus
		(select p# from sp where sp.s# = s#))) = 0;

-- 3
select sname from s where s#
	in(select s# from sp where p# = 'p4')
	and s# not in(select s# from sp where p# = 'p5');

-- 4
select sname from 
	sp join s using(s#) where qty = (select max(qty) from 
		(select qty from sp minus (select max(qty) from sp)));

-- 5
select sname from 
	(select sname, s#, count(distinct p#) pcnt from sp join s using(s#) group by s#, sname) 
	where pcnt > 1
	and s# not in
		(select s# from sp  where p# = 'p3');


-- 6
with x as(select sname, pname, rank() over(partition by sname order by qty desc) rank
	from s join sp using(s#) join p using(p#) order by s#, qty desc)
select j.sname, (select pname from x a where j.sname = a.sname and a.rank = 1) "One",
		(select pname from x b where j.sname = b.sname and b.rank = 2) "Two",
		(select pname from x c where j.sname = c.sname and c.rank = 3) "Three"
	from (select sname from s natural join sp 
		group by sname having count(*) >= 3) j; 

-- 7
select distinct sname, min(qty) over(partition by s#) "minqty" from s join sp using(s#) 
	where s# in
	(select s# from sp where qty > 
		(select max(qty) from sp where p# = 'p2'));

-- 8
select sname, pname, qty, max(qty) over (partition by s# order by s#) "maxqty", 
	max(qty) over (partition by p# order by p#) "Max qty overall"
	from s join sp using(s#) join p using(p#)
	order by sname;



-- 9
select ename, level-1 from emp
where lower(job) != 'analyst'
start with empno = (select mgr from emp where lower(ename) = 'adams')
connect by empno = prior mgr;
 
-- 10
col Name format a20
select  lpad(' ', 3*(level-1)) || ename Name, 
	(select ename from emp where empno = x.mgr) "Manager", level-1 from emp x
		where lower(job) != 'clerk'
		start with mgr is null
		connect by prior empno = mgr;

spool off;