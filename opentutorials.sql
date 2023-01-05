create DATABASE opentutorials;
show DATABASES;
use opentutorials;
create table topic (
	id int(11) NOT NULL auto_increment,
  title varchar(45) NOT NULL,
  description text,
  created datetime NOT NULL,
  primary key(id)
  ) engine = InnoDB;
  show tables;
  desc topic;
  select * from topic;
  