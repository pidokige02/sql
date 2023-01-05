select * from Dept limit 3;   -- 3개만 나온다.

select workdate from Dept;    -- workdate 만 보여준다.

select distinct workdate from Dept;  -- unique한 workdate 만 보여준다.

select workdate from Dept group by workdate; -- distinct 와 동일함 결과임

select workdate, count(*) from Dept group by workdate; -- group by 로 하면 갯수도 표시가 가능함.

select * from Dept order by id desc; -- id 역순으로 표시함

select * from Dept order by rand(); -- id 불규칙하게 나타남.

select * from Dept limit 3, 2;  -- 3번째부터 2개만 표시.

select workdate, count(*) from Dept 
  group by workdate
  having count(*) > 1;  --  1 보다 큰것만 표시함.

select workdate, count(*) as cnt from Dept 
  group by workdate
  having cnt > 1;  --  위의 것과 동일하지만 column name 이 cnt 임.
  
select * from Dept where id in (select dept from Emp where id in (1,2));
-- Emp 에서 id 가 1,2 인것의 dept 를 가지고 와서 Dept에서 matching 이되는 id의 모든 field 를 보여준다. 
  
select sub.*
    from (select id as empid, dept from Emp where id < 3) sub;
-- sub는 alias 임.
-- id < 3인 Emp 에서 id 와 dept 를 가져온다. id 는 empid 로 alias 함. 이것을 sub로 alias 로 하고 모든 것을 가져온다.
  
select *, pid as ppid from Dept; -- ppid column이 추가로 뒤에 보여짐.  column 은 다르게 구분하도록 한다
  
select *, (case when pid = 0 then '최상위부서' else '부서' end) as ppid from Dept;
-- pid 값에 따라 치환하여 표시한다.
  
insert into Dept(pid, dname) values (2, '서버팀');  
-- tool 을 이용하여 unique 한 이름만 update 되게 하였음 (7min 에 강의) . 해서 error 가 발생함.
-- 아래의 명령어를 사용하면 error free 함 
  
insert into Dept(pid, dname) values (2, '서버팀')
    on duplicate key update dname='서버팀2';  -- 

insert into Dept(pid, dname) values (2, '서버팀2')
    on duplicate key update dname=concat(dname,'222');   
  
select * from Dept;

update Dept set dname='서버팀1' where id=6;

select * from Emp;
  
select e.*, d.dname
    from Dept d inner join Emp e on d.id = e.dept;
  
desc Emp;  -- table 의 속성을 보여줌
  
insert into Dept(pid, dname) values (2, 'DB팀');  -- DB팀을 새로 추가함

select * from Dept;  -- new id  가 생김

select * from Emp;   -- table 에서 직접 19 김마가를 dept 를 15 로 변경함
  
  select * from Emp where id=19;

  select e.*, d.dname
    from Dept d inner join Emp e on d.id = e.dept
   where e.id=19;  -- 김마가 data 가 join 되어서 보여짐
   
   delete from Dept where id=15;  -- DB 부서를 DELETE 하면 김마가 dept column data 가 자동으로 NULL 이 됨
   
   select * from Emp where id=19;  -- dept 가 null 이됨
   
 select e.*, d.dname  -- 직원과 부서명을 같이 보여준다.
    from Dept d inner join Emp e on d.id = e.dept -- 김마가는 보이지 않는다 dept 가 null 이므로 이경우에 outer join 을 쓰면 보인다.
   order by e.id;
  
select e.*, d.dname  -- 직원과 부서명을 같이 보여준다.
    from Dept d left outer join Emp e on d.id = e.dept -- 이경우도 김마가는 보이지 않는다 부서명을 기준으로 모두 보여준다.
  order by e.id;
  
select e.*, d.dname  -- 동적하지 않았음 이유는 모름 마마도 값이 없는 row 가 있어어 인것 같음)
    from Dept outer join Emp e on d.id = e.dept 
  order by e.id;

alter table Dept add column captain int unsigned;  -- 부서장 추가
select * from Dept d inner join Emp e on d.id = e.dept;
select * from Dept;

update Dept d  -- capain 값을 넣는다.
  set captain = (select id from Emp where dept = d.id order by rand() limit 1); 
select * from Dept;

select *, (select dept from Emp where id=d.captain) as eee from Dept d;  -- 잘 들어깠는제 확인함.

select *, (select ename from Emp where id=d.captain) as '부서장명' from Dept d;  -- 부서장 이름까지 표시함

select *
  from Dept d inner join Emp e on d.captain = e.id;

-- 3번 문제.
select *
  from Dept d left outer join Emp e on d.captain = e.id;  -- 모든 부서가 다 표시가 돰.

select *
  from Dept d right outer join Emp e on d.captain = e.id;  -- 모든 직원이 다 표시가 되지만 부서장은 해당 부서 표시가 됨

-- 4 번 문제.
select * from Emp where dept is null;

-- 5 번문제 : full outer join
select *  from Dept d left outer join Emp e on d.captain = e.id  -- 모든 부서가 다 표시가 돰.
UNION
select *  from Dept d right outer join Emp e on d.captain = e.id;  -- 모든 직원이 다 표시가 되지만 부서장은 해당 부서 표시가 됨


-- cross join
select * from Dept, Emp;


-- 2강 30 mins 내장함수.
select @@autocommit;
start transaction;

select * from Dept where id in (1,2);

update Dept set dname='영업부서' where id=1;  -- 다른 session 에서는 반영이 않되어 보인다.

commit;
rollback; -- 앞의 작업에 실수가 있으면 rollbakc 하여 원복할 수 있다.

start transaction;

select * from Dept where id in (1,2);

savepoint sp1;
update Dept set dname='영업222' where id=1;  

savepoint sp2;
update Dept set dname='개발222' where id=2;  

rollback to savepoint sp2;  -- 개발222 이 개발부로 rollback 이 됨.
commit;  -- 영업222 만 적용이됨.