CREATE DEFINER=`pidokige`@`%` PROCEDURE `sp_count`(_table varchar(31))
BEGIN  -- string 을 가지고 query 를 만드는 방법.
	SET @sql = CONCAT('select count(*) cnt from ', _table);
    
    PREPARE myQuery from @sql;
    EXECUTE myQuery;
    DEALLOCATE PREPARE myQuery;
    
END