spool homework4.txt
/* Jonathan Rile
CS 440 Homework 4
Due Feb 11, 2013 */
set echo on
-- 1
select name from Company where ID in (
	select C1 from Collaborators where C2 in (select ID from Company where lower(ceo) = 'gabriel'));

-- 2 
select b.name, c.name, d.Field, e.Field from Suppliers a join Company b on(a.Supplier = b.ID) join Company c on(a.Purchaser = c.ID)
	join Complexity d on (b.field = d.Field) join Complexity e on(c.field = e.Field)
	where (d.rank - e.rank >= 2)
	order by b.name, c.name;

-- 3
select a.name A, b.name B, a.field "A Field", b.field "B Field" from Collaborators join Company a on(C1 = a.ID) join Company b on(C2 = b.ID) 
	where a.name < b.name order by a.name, b.name;


-- 4
select name, field from Company where ID not in
	(select Supplier from Suppliers union select Purchaser from Suppliers)
	order by field, name;
	

-- 5
select a.name, a.field, b.name, b.field 
	from Suppliers join Company a on(Suppliers.Supplier = a.ID)
	join Company b on(Suppliers.Purchaser = b.ID)
	where b.ID not in(select Supplier from Suppliers);



-- 6
select field, name from Company  minus
	(select a.field, a.name from Collaborators x join Company a on(C1 = a.ID) join Company b on(C2 = b.ID) 
		where a.field != b.field)
	order by field, name;


-- 7
with collab as(select * from Company join Collaborators on(ID = C1))
	select a.name, b.name, c.name from 
	Suppliers join collab a on(a.ID = Supplier)
	join collab b on(b.ID = Purchaser)
	join Company c on c.ID = a.C2 and C.ID = b.C2
	where((a.ID, b.ID) not in(select * from Collaborators));

-- 8
select count(distinct a.ID) - count(distinct b.ceo) from Company a, Company b;

-- 9
select name, field from Company a where 2 <= (select count(*) from Suppliers where Purchaser = a.ID);

-- 10
select name, field from Company join Collaborators on ID = C1
group by name, field
having count(*) >= all(select count(*) from Collaborators group by C1);

spool off;