CREATE FUNCTION `f_randname` ()
RETURNS varchar(31)
BEGIN
	declare v_ret varchar(31);
    declare v_lasts varchar(255) default '김이박최조정방천기지류배원';
    declare v_firsts varchar(255) default '순신세정성호가나다라마바사아차';
    
    set v_ret = concat(f_rand1(v_lasts), f_rand1(v_firsts), f_rand1(v_firsts)); 
       
RETURN v_ret;
END