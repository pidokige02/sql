CREATE DEFINER=`pidokige`@`%` PROCEDURE `sp_emp_range`(_sid int, _eid int)
prox:BEGIN
  declare v_sid int default _sid;
  declare v_eid int default _eid;
  
  -- cursor 임시 변수
  declare v_empid int;
  declare v_ename varchar(31);
  declare v_dname varchar(31);
  
  -- cursor 종료 flag
  Declare _done boolean default False;
  
  Declare _cur CURSOR FOR
    select id, ename, dname  from v_Emp where id between v_sid and v_eid;
    
  Declare Continue Handler
    For Not Found SET _done := True;
  
  
  IF _sid < 0 AND _eid < 0 THEN
    leave prox;
  END IF;
  
  IF _sid > _eid THEN
    set v_sid = _eid;
    set v_eid = _sid;
  END IF;
  
  drop temporary table IF Exists Tmp;
  
  create temporary table Tmp (
    empid int,
    edname varchar(63)
  );

  OPEN _cur; -- every row 마다 처리가 필요할 때 싸용함
  
    cur_loop: LOOP
      Fetch _cur into v_empid, v_ename, v_dname;
      IF _done THEN
        LEAVE cur_loop;
      END IF;
      
      insert into Tmp(empid, edname) values(v_empid, concat(v_ename, '-', ifnull(v_dname,'소속팀없음')));
      
    END LOOP cur_loop;
  
  CLOSE _cur;
  
  select * from Tmp;    
END