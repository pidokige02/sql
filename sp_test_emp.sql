CREATE DEFINER=`pidokige`@`%` PROCEDURE `sp_test_emp`(_cnt int)
BEGIN
	declare v_idx int default 0;
    
    while v_idx < _cnt
    do
		insert into Emp(ename, dept, salary) values (f_randname(), f_rand1('34567'), f_rand1('123456789') * 100);
        
        set v_idx = v_idx +1;
	end while;
END