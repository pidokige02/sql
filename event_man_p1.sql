show databases;
create Database testdb;
use testdb;

create table User(
id tinyint unsigned not null auto_increment,
uid varchar(31) not null,
upw varchar(31) not null,
uname varchar(31) not null,
PRIMARY KEY(id)
);

insert into User(uid, upw, uname) values ('go','0','황규성'), ('google','0','황규영'), ('gosang','0','황진하'), ('naver','0','권소현');

insert into User(uid, upw, uname) values ('user1','0','김일수'), ('user2','0','김이수');

update User set lastlogin=now() where uid='user1';

select * from User where uid='user2';

select * from User;

drop table User;

create table User(
id tinyint unsigned not null auto_increment,
uid varchar(31) not null,
upw varchar(31) not null,
uname varchar(31) not null,
PRIMARY KEY(id)
);

ALTER TABLE User ADD COLUMN lastlogin DATETIME;

insert into User(uid, upw, uname) values ('go','0','황규성'), ('google','0','황규영'), ('gosang','0','황진하'), ('naver','0','권소현');

insert into User(uid, upw, uname) values ('user1','0','김일수'), ('user2','0','김이수');

update User set lastlogin=now() where uid='user1';

select uid, lastlogin from User where uid in ('user1', 'user2');  -- js test\mysqltest2.js 의 유효성 검증에 사용한 code 임.

drop table User;

create table User(
id tinyint unsigned not null auto_increment,
lastlogin DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
uid varchar(31) not null,
upw varchar(31) not null,
uname varchar(31) not null,
PRIMARY KEY(id)
);

update User set lastlogin=now() where uid='user2';

select * from User where uid='user2';

create table Reply(
rno tinyint unsigned not null auto_increment,
bno tinyint unsigned not null,
replier varchar(31) not null,
replytext varchar(31) not null,
regdate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
updatedate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY(rno)
);

ALTER TABLE User ADD COLUMN replytext varchar(128);

insert into Reply(bno, replier, replytext ) values ('265','user2','5555555'), ('265','user2','반가워요'), ('265','user2','7777777777'), ('265','user2', '88888888');

ALTER TABLE Reply ADD COLUMN replytext varchar(128);

insert into Reply(bno, replier, replytext) values ('65','user2','5555555'), ('65','user2','반가워요'), ('65','user2','7777777777'), ('65','user2', '88888888');

select * from Reply;

create table Survey (
  id int unsigned auto_increment not null,
  title varchar(127) not null comment '설문제목',
  state tinyint(1) unsigned default 0 comment '0:준비, 1: 오픈, 9: 종료',
  primary key(id)
);
drop table Survey;

create table Survey (
  id int unsigned auto_increment not null,
  title varchar(127) not null comment '설문제목',
  state tinyint unsigned default 0 comment '0:준비, 1: 오픈, 9: 종료',
  primary key(id)
);

create table Surveyee (
  id int unsigned auto_increment not null,
  email varchar(255) not null,
  uname varchar(63) not null,
  primary key(id)
);

create table Question (
  id int unsigned auto_increment not null,
  survey int unsigned not null comment '설문ID',
  quest varchar(255) not null comment '질문',
  ismulti tinyint unsigned not null comment '1:객관식',
  item varchar(1023) null comment '객관식 문항',
  primary key(id)
);

create table Answer (
  id int unsigned auto_increment not null,
  question int unsigned not null comment '질문ID',
  surveyee int unsigned not null comment '설문자',
  answer varchar(1023) not null comment '답변',
  primary key(id)
);

insert Survey(title) value('test survey');

select * from Survey;

create table Event(
id tinyint unsigned not null auto_increment,
title varchar(31) not null,
date DATE NOT NULL DEFAULT '2022-05-11',
time TIME NOT NULL DEFAULT "23:59:59",
location varchar(64) not null,
description varchar(128) not null,
organizer varchar(31) not null,
category varchar(64) not null,
PRIMARY KEY(id)
);

insert into Event(title, location, description, organizer, category)
values ('Beach Cleanup','Daytona Beach','Let\'s clean up this beach','Adam Jahr','sustainability'),
('Park Cleanup','132 N Magnolia Street, Orlando, Florida','We\'re going to clean up this park.','Adam Jahr','sustainability' ),
('Pet Adoption Day','132 N Magnolia Street, Orlando, Florida','Help animals find new homes.','Gregg Pollack', 'animal welfare'),
('Disco Party','Daytona Beach','Let\'s clean up this beach','Adam Jahr','sustainability'),
('Vue Users Group','132 N Magnolia Street, Orlando, Florida','We\'re going to clean up this park','Adam Jahr','nature');

drop table Event;

select * from Event;

create table category(
id tinyint unsigned not null,
title varchar(31) not null
);

insert into category (id, title)
value ('0','sustainability'),
('1','nature'),
('2','animal welfare'),
('3','housing'),
('4','education'),
('5','food'),
('6','community');

select * from category; 

select * from Event where id='2';

select * from Event LIMIT 0, 3;

SELECT COUNT(*) FROM Event;

insert into Event(title, location, description, organizer, category) value( "Church Event1", "YongIn", "worship the God on Sunday", "Adam", "sustainability" );

delete from Event where id=10;

delete from Event where id=11;

delete from Event where id=12;

