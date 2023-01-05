create view v_Emp AS 
 select e.*, d.dname from Emp e inner join Dept d on e.dept = d.id;
 
 show tables;  -- v_Emp 도 보인다. 
 
 select * from information_schema.views  -- view 의 definition 정보를 볼수 있다.
    where table_schema='testdb';
    
select * from v_Emp;  -- view 사용법. 



-- Trigger 사용법.
 select *, ( select count(*) from Emp where dept = d.id ) empcnt from Dept d; -- 각 부서별 직원수도 마지막 column 에 표시한다. sub query 를 이용함.
 
 select * from Emp where dept is null;
 
 -- dept 가 없는 경우가 있기 대문에 inner join 을 걸 수가 없다.  대신 outer join 을 건다.
 --  집계함수 max?? 
 -- count(e.id)  은 이해가 않됨 count(e.*)?, count(*)  
 select  d.id, max(d.dname) dname, count(e.id) empcnt  -- 
   from Emp e right outer join Dept d on e.dept = d.id
  group by d.id;
  
  
  alter table Dept add column empcnt int not null default 0;  -- 
  
  select * from Dept;
  update Dept d set empcnt =  ( select count(*) from Emp where dept = d.id ); -- 부서별 empcount를 setting 함.
  
  -- 직원이 삭제 추가될때마다 자동으로 부서별 empcot 가 update 돰. 강의 10min 19 에 tool 을 이용하여 함.
  insert into Emp(ename, dept, salary) values ('TTT', 5, 200);
  
  select * from Emp where ename='TTT';
  
  update Emp set dept=6 where id=253;  -- 자동으로 empcnt 가 변경이 됨.
  
  delete from Emp where id=253; -- 자동으로 empcnt 가 변경이 됨.
  
  
  -- @rownum
  select s.*, (@rownum := @rownum +1) rownum
    from Emp s, (select @rowf_rand1num := 0) rn;
  
  -- ERROR 1418: This function has none of DETERMINISTIC, NO SQL, or READS SQL DATA in its declaration and binary logging is enabled (you *might* want to use the less safe log_bin_trust_function_creators variable)
  -- SQL Statement: 함수 생성시 위 error 가  나올때 해결하였음
  SET GLOBAL log_bin_trust_function_creators = 1;
  
  
  select *, f_empcnt(id) empcnt2 from Dept;
  select * from Emp; 
  
  call sp_emp_delete(6, @empcnt);  -- called stored procedure and save result in @empcnt
  select @empcnt;   -- display the value of @empcnt
  
  -- sample for stored procedure
  -- call sp_xxx(@empcnt);
  -- select * from xxx from id=@empcnt;
  
  select * from Emp where id between 15 and 10;  -- 사이의 값을 조회한다. 값이 나오지 않는다.
  
  call sp_emp_range(1,5);
  call sp_emp_range(5,1);
  call sp_emp_range(-5,-1);  -- leave 로 빠져나오게 SP 가 program 되어 있음.
  
  --  make SQL by using string.
  call sp_count('Emp');
  call sp_count('Dept');
  
call sp_emp_range(5,1);

  
 
  
  
  
  
  
  