CREATE DEFINER=`pidokige`@`%` TRIGGER `Emp_AFTER_DELETE` AFTER DELETE ON `Emp` FOR EACH ROW BEGIN
	update Dept set empcnt = empcnt - 1
		where id = OLD.dept;
END