create table Reply(
  rno int unsigned not null auto_increment,
  bno int unsigned not null,
  replyer varchar(31) not null,
  replytext varchar(128) not null,
  regdate timestamp,
  updatedate timestamp,
  primary key(rno)
);

insert into Reply(bno, replyer, replytext) values ('265','User2','22222222'), ('265','User2','33333333'), ('265','User2','반가워요'), ('265','User2','88888888'), ('265','User2','999999');

select * from Reply where bno=265;

select * from Reply where bno=265 limit 10;


create table Survey (
  id int unsigned auto_increment not null,
  title varchar(127) not null comment '설문제목',
  state tinyint(1) unsigned default 0 comment '0:준비, 1: 오픈, 9: 종료',
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
  ismulti tinyint(1) unsigned not null comment '1:객관식',
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
