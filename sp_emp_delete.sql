CREATE PROCEDURE `sp_emp_delete` (_empid int, OUT _empcnt int)
BEGIN
	declare v_deptid tinyint ;
    select dept into v_deptid from Emp where id = _empid;
    
	delete from Emp where id= _empid;
    
    select empcnt into _empcnt from Dept where id = v_deptid;
END