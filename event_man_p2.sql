create table Event2(
id int unsigned not null PRIMARY KEY auto_increment COMMENT 'primary Key',
event_id int unsigned not null ,
category varchar(64) not null,
organizer varchar(31) not null,
title varchar(31) not null,
description varchar(128) not null,
location varchar(64) not null,
date DATE NOT NULL DEFAULT '2022-05-11',
time TIME NOT NULL DEFAULT "23:59:59"
);

SHOW TABLE STATUS LIKE 'Event2';
SELECT * FROM   INFORMATION_SCHEMA.COLUMNS WHERE  TABLE_NAME = 'Event2';

create table Attendees(
person_id varchar(31) not null ,
name varchar(31) not null COMMENT 'attendee name', 
event_id int unsigned,
FOREIGN KEY(event_id) REFERENCES Event2(id) ON DELETE SET NULL
);

SELECT * FROM  INFORMATION_SCHEMA.COLUMNS WHERE  TABLE_NAME = 'Attendees';

insert into Event2(event_id, title, date, time, location, description, organizer, category)
values (1,'Beach Cleanup','2018-8-28','12:10:30','Daytona Beach','Let\'s clean up this beach','Adam Jahr','sustainability'),
(2,'Park Cleanup','2018-11-28','13:00:00','132 N Magnolia Street, Orlando, Florida','We\'re going to clean up this park.','Adam Jahr','sustainability' ),
(3,'Pet Adoption Day','2018-12-02','14:30:00','132 N Magnolia Street, Orlando, Florida','Help animals find new homes.','Gregg Pollack', 'animal welfare'),
(4,'Disco Party','2018-08-28','14:10:10','Daytona Beach','Let\'s clean up this beach','Adam Jahr','sustainability'),
(5,'Vue Users Group','2018-11-12','15:00:00','132 N Magnolia Street, Orlando, Florida','We\'re going to clean up this park','Adam Jahr','nature');

insert into Attendees(person_id, name, event_id)
values 	("abc123", "Adam Jahr", 1),
		("def456", "Gregg Pollack", 1),
        ("ghi789", "Beth Swanson", 1),
        ("jkl101", "Mary Gordon", 1),
		("ghi789", "Beth Swanson",2),
        ("jkl101", "Mary Gordon", 2),
        ("abc123", "Adam Jahr", 3),
        ("ghi789", "Beth Swanson", 3),
        ("jkl101", "Mary Gordon", 3),
		("abc123", "Adam Jahr", 4),
		("def456", "Gregg Pollack", 4),
		("ghi789", "Beth Swanson", 4),
		("jkl101", "Mary Gordon",4),
        ("ghi789", "Beth Swanson", 5 ),
        ("jkl101", "Mary Gordon", 5);
        
SELECT * FROM Event2;
SELECT * FROM Attendees;

DROP TABLE Attendees;
select COUNT(*) from Event2;


SELECT Attendees.person_id AS 'ID', Attendees.name AS '이름', Event2.id AS 'EventID' from Attendees  
  INNER JOIN Event2 ON Event2.id = Attendees.event_id;


SELECT Attendees.person_id AS 'ID', Attendees.name AS '이름', Event2.*  from Attendees  
  INNER JOIN Event2 ON Event2.id = Attendees.event_id;


SELECT Attendees.person_id AS 'ID', Attendees.name AS '이름', Event2.*  from Attendees  
  INNER JOIN Event2 ON Event2.id = Attendees.event_id WHERE Attendees.event_id = 1;

USE testdb;

SELECT person_id,  name FROM Attendees WHERE (event_id = 1) OR (event_id = 2) OR (event_id = 3); 