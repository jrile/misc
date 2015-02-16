/*
Jonathan Rile
CS 440
Assignment 2
January 28, 2013
*/

-- 1

alter table dept
/* 1A*/	modify deptno 	constraint dept_pk primary key deferrable initially immediate
/* 1B*/	modify dname	constraint dname_uq unique deferrable initially immediate
			constraint dname_nn not null deferrable initially immediate;

-- 2

alter table emp
/* 2A*/	modify empno	constraint emp_pk primary key deferrable initially immediate
/* 2B*/	modify ename	constraint ename_uq unique deferrable initially immediate
			constraint ename_nn not null deferrable initially immediate
/* 2C*/	modify mgr 	constraint mgr_ref references emp(empno) deferrable initially immediate
/* 2D*/	modify deptno	constraint deptno_ref references dept(deptno) deferrable initially immediate
/* 2E*/	modify sal	constraint sal_chk check(sal between 500 and 10000) deferrable initially immediate;

-- 3

alter table s 
/* 3A*/	modify s# 	constraint s_pk primary key deferrable initially immediate
/* 3B*/	modify sname	constraint sname_uq unique deferrable initially immediate
			constraint sname_nn not null deferrable initially immediate;
-- 4

alter table p
/* 4A*/	modify p# 	constraint p_pk primary key deferrable initially immediate
/* 4B*/	modify pname	constraint pname_uq unique deferrable initially immediate
			constraint pname_nn not null deferrable initially immediate;

-- 5

alter table sp
/* 5A*/	add constraint sp_pk primary key (s#, p#) deferrable initially immediate
/* 5B*/	modify qty	constraint qty_nneg check(qty>0) deferrable initially immediate
/* 5C*/	modify s#	constraint s_ref references s(s#) deferrable initially immediate
	modify p#	constraint p_ref references p(p#) deferrable initially immediate;



-- 6

create index emp_deptno on emp(deptno);

-- 7

update emp set hiredate=(add_months(hiredate, -12)) where extract(YEAR from hiredate) > 2012;
commit;

-- 8

select table_name, index_name from all_indexes;

-- 9

select table_name, constraint_name from all_constraints;
