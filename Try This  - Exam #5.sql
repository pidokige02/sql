-- Try This  - Exam #5

CREATE TABLE Classroom (
  id int unsigned not null PRIMARY KEY auto_increment COMMENT 'id',
  name varchar(32) not null COMMENT '강의실이름'
);

CREATE TABLE Subject_Exam5 (
  id int unsigned not null PRIMARY KEY auto_increment COMMENT 'id',
  name varchar(32) not null COMMENT '과목이름',
  class_id int unsigned COMMENT 'class_id',
  FOREIGN KEY(class_id) REFERENCES Classroom(id)
);

insert into Classroom (name ) values ('1 강의실'), ('2 강의실'), ('3 강의실'), ('4 강의실'), ('5 강의실'), ('6 강의실'), ('7 강의실'), ('8 강의실'), ('9 강의실'), ('10 강의실');

select * from Classroom;

insert into Subject_Exam5 (name, class_id ) values ('국어', 1), ('영어', 2), ('수학', 3), ('물리', 4), ('화학', 5), ('생물', 6), ('국사', 7), ('지학', 8), ('한문', 9), ('음악', 10);

select * from Subject_Exam5;

select S.name, C.name from Subject_Exam5 S left JOIN Classroom C ON S.class_id = C.id;

CREATE VIEW Subject_Exam5_VIEW AS
	select * from Subject_Exam5;

select * from information_schema.views where table_schema='pracDB';
show tables;  -- view 를 위한 table 이 만들어진 것을 볼 수 있음
show create view Subject_Exam5_VIEW; -- Subject_Exam5_VIEW 에 대한 정보를 봏 수 있다.

desc Subject_Exam5_VIEW;

select * from Subject_Exam5_VIEW;

