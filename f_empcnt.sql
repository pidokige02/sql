CREATE DEFINER=`pidokige`@`%` FUNCTION `f_empcnt`(_dept tinyint) RETURNS int
BEGIN
  declare v_ret int;
  select count(*) into v_ret from Emp where dept = _dept;
  
RETURN v_ret;
END