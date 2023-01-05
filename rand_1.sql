CREATE DEFINER=`pidokige`@`%` FUNCTION `f_rand1`(_str varchar(255)) RETURNS varchar(31) CHARSET utf8mb4
BEGIN
    declare v_ret varchar(31);
    declare v_len tinyint;
    
    set v_len = char_length(_str);
    set v_ret = substring(_str, CEIL(rand() * v_len), 1);

RETURN v_ret;
END