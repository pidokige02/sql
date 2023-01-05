CREATE DEFINER=`pidokige`@`%` TRIGGER `Emp_AFTER_UPDATE` AFTER UPDATE ON `Emp` FOR EACH ROW BEGIN
IF OLD.dept != NEW.dept		THEN	
  update Dept set empcnt = empcnt + 1
		where id = NEW.dept;
    
	update Dept set empcnt = empcnt - 1
		where id = OLD.dept;
END IF;
END