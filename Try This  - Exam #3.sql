use pracDB;
Drop Table ClubMember;

--  Try This  - Exam 3
CREATE TABLE ClubMember (
  id int unsigned not null PRIMARY KEY auto_increment COMMENT 'id',
  name varchar(32) not null COMMENT '이름',
  club_id int unsigned COMMENT 'club_id',
  FOREIGN KEY(club_id) REFERENCES Club(club_id) ON DELETE SET NULL,
  level int unsigned COMMENT '레벨'
);

CREATE TABLE Club (
  club_id int unsigned not null PRIMARY KEY auto_increment COMMENT 'club_id',
  club_name varchar(32) not null COMMENT '동아리'
);

insert into Club (club_name ) values ('사진'), ('자전거'), ('등산'), ('낚시');

SELECT * FROM Club;

insert into ClubMember (name, club_id, level  ) values ('황진하', 1, 2);
insert into ClubMember (name, club_id, level  ) values ('권소현', 2, 1);
insert into ClubMember (name, club_id, level  ) values ('황규영', 3, 0);
insert into ClubMember (name, club_id, level  ) values ('황규성', 1, 1);

insert into ClubMember (name, club_id, level  ) values ('김기동', 1, 2);
insert into ClubMember (name, club_id, level  ) values ('김기민', 2, 1);
insert into ClubMember (name, club_id, level  ) values ('김기성', 3, 0);
insert into ClubMember (name, club_id, level  ) values ('김기명', 1, 1);


SELECT * FROM ClubMember;

SELECT * FROM employee;

--  Try This  - Exam 4
CREATE TABLE Dept (
  id int unsigned not null PRIMARY KEY auto_increment COMMENT 'id',
  name varchar(32) not null COMMENT '학과명',
  prof varchar(64) not null COMMENT '지도교수',
  student varchar(64) not null COMMENT '과대표'
);

insert into Dept (name, prof, student ) values ('컴푸터공', '김교수', '김학생' ), ('제어계측공', '이교수', '이학생'), ('전자공', '박교수', '박학생'), ('전기공', '강교수', '강학생'), ('건축공', '최교수', '최학생');

SELECT * FROM Dept;

drop table Stud;

CREATE TABLE Stud (
  id int unsigned not null PRIMARY KEY auto_increment COMMENT 'id',
  name varchar(32) not null COMMENT '학생이름',
  dep_id int unsigned COMMENT 'dep_id',
  FOREIGN KEY(dep_id) REFERENCES Dept(id)
);

SET GLOBAL log_bin_trust_function_creators = 1; 

select name FROM Dept where id = 1;
SELECT CEIL(RAND()*(6-1)); -- return number is from 1 to 5 

SET @var = CEIL(RAND()*(6-1)); -- vairable can be used w/ @ccc
select name FROM Dept where id = @var;

select f_randselect();

select f_randname();

select f_rand_depid_select();

insert into Stud (name, dep_id ) values ('황진하', 1 );

call sp_make_stud(250);

select * from Stud;

select Stud.name, Dept.name from Stud left JOIN Dept ON Stud.dep_id = Dept.id;

select Stud.name, Dept.name from Stud left JOIN Dept ON Stud.dep_id = Dept.id where Dept.name = '컴푸터공';
select Stud.name, Dept.name from Stud left JOIN Dept ON Stud.dep_id = Dept.id where Dept.name = '제어계측공';
select Stud.name, Dept.name from Stud left JOIN Dept ON Stud.dep_id = Dept.id where Dept.name = '전자공';
select Stud.name, Dept.name from Stud left JOIN Dept ON Stud.dep_id = Dept.id where Dept.name = '전기공';
select Stud.name, Dept.name from Stud left JOIN Dept ON Stud.dep_id = Dept.id where Dept.name = '건축공';


update Dept set student = '황진하' where name = '컴푸터공'; 
update Dept set student = '방정사' where name = '제어계측공'; 
update Dept set student = '박가나' where name = '전자공'; 
update Dept set student = '배정마' where name = '전기공'; 
update Dept set student = '조차차' where name = '건축공'; 

SELECT * FROM Dept;

-- practice 
-- https://docs.google.com/presentation/d/1GbYGn73VH4hZg99bHYamMZqR846kE2r4sHbM3_o0WlY/edit#slide=id.g487e8ed6e8_1_22
show tables;

select now(), sysdate(), curdate(), curtime();
select year(now());

show variables like '%time_zone%';
select @@time_zone;

-- not working below commands
-- set time_zone = 'Asia/Seoul';
-- set global time_zone = 'UTC';

show create table Stud;  -- table 정보를 알려준다
show create table Student;

select CAST('2018-12-25 11:22:22.123' AS DATETIME);
SELECT FIND_IN_SET('b','a,b,c,d');
SELECT find_in_set('s1', 's0,s1,s2');
SELECT format(123456789,0);
SELECT format(789.012356, 4);
SELECT truncate(789.012356, 4);

SELECT left('abc', 2);
SELECT upper('abc');
SELECT lower('ABC');
SELECT lpad('5', 2, '0'); -- 2자리로 5 를 표시하면서 왼쪽을 0으로 채운다
SELECT rpad('15', 3, '0');

SELECT replace('abcdefg', 'cde', 'xxx');

SELECT substring_index('a,b,c', ',', 2);  -- a,b (,를 기준으로 두번째까지)
SELECT substring_index('a,b,c', ',', -1); -- c  (-1은 ,로 잘라낸 마지막 값)
SELECT substring_index( substring_index('a,b,c', ',', 2), ',', -1);