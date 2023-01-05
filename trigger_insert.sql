CREATE DEFINER=`pidokige`@`%` TRIGGER `Emp_AFTER_INSERT` AFTER INSERT ON `Emp` FOR EACH ROW BEGIN
	update Dept set empcnt = empcnt + 1
		where id = NEW.dept;
END