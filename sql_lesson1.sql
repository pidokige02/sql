show databases;
create Database testdb;
use testdb;
show tables;
desc Dept;
desc Emp;
show create table Emp;   /* table 만든 방법을 보여준다, constraint foreign key를 볼때 편하다  */
show index from Emp;     /* key 값을 조회할 때 사용한다 */

show grants for pidokige@'%'; /* 권한을 보여준다 */

select current_user();  /* 접속된 user 를 보여준다 */

create table Dept2 like Dept; /* 같은 구조의 table 을 만든다 */

create table Dept3 AS select * from Dept; /* 같은 구조 같은 date 의 table 을 만든다 */
/* data 는 오지만 index 는 오지 않는다 별도로 작업을 해 주어야 한다*/

select * from Dept3;

show create table Dept3;
 
create table Emp2 AS select * from Emp;

select * from Emp2;
show create table Emp2;

CREATE TABLE `Emp2` (
   `id` int unsigned NOT NULL DEFAULT '0',
   `ename` varchar(31) NOT NULL,
   `dept` tinyint unsigned NOT NULL,
   `salary` int NOT NULL DEFAULT '0'
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/* 
CREATE TABLE `Emp2` (
   `id` int unsigned NOT NULL DEFAULT '0',
   `ename` varchar(31) NOT NULL,
   `dept` tinyint unsigned NOT NULL,
   `salary` int NOT NULL DEFAULT '0'
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
*/

 drop table Dept2;
 drop table Dept3;
 drop table Emp2;
 
 select @@time_zone;  /* @@는 전역변수임 */
 show variables like '%time_zone%';
 
 alter table Dept add column workdate timestamp not null default current_timestamp
    on update current_timestamp;
/* workdate 라는 column을 timestampe type으로 만들고, 초기값이 null 은 아니고 detault 값은 현재 시간임, 추후 update 시에도 current time 값으로 update 한다 */ 
 
 select * from Dept;
 
 update Dept set dname='클라팀' where id = 7; /* data 를 변경하면 다른 time stampt 가 변경되는 것이 확인 가능함 */

 select * from Dept;
 
 -- 실무에서 사용하는 방법 실수하지 않기 위해 selec 를 미리 걸고 data를 확인한다
 select * from Dept
 -- update Dept set dname='클라팀'
 where id = 7;
 
 create table Test(
  id int unsigned not null auto_increment,
  ttt varchar(31) not null,
  primary key(id)
  );

select * from Test;
insert into Test(ttt) values ('aaa1'), ('aaa2'), ('aaa3'), ('aaa4'), ('aaa5'); 
-- 이후에 table manipulation tool 을 이용하여 dept field 를 nn unsigned 로 작성함
-- dept 를 만들고 위의 insert 를 돌리면 error 가 발생했음
update Test set dept = f_rand1('34567');

-- 이후에 UI tool 을 이용하여 foreign key 를 걸었다. 23 min 부터 참고 가능함

-- tip: write 에 관련된 command 는 사용한 이후 주석처리를 하는게 좋다.

show create table Test;
/*
CREATE TABLE `Test` (
   `id` int unsigned NOT NULL AUTO_INCREMENT,
   `ttt` varchar(31) NOT NULL,
   `dept` tinyint unsigned NOT NULL,
   PRIMARY KEY (`id`),
   KEY `ref_test_dept_idx` (`dept`),
   CONSTRAINT `ref_test_dept` FOREIGN KEY (`dept`) REFERENCES `Dept` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
 ) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
*/

truncate table Test;   -- data 및 구조를 모두 지우는 명령어. (drop and delete)
select * from Test;
insert into Test(ttt) values ('aaa1'), ('aaa2'), ('aaa3'), ('aaa4'), ('aaa5');  -- error 가 남
insert into Test(ttt, dept) values ('aaa1',3), ('aaa2',4), ('aaa3',5), ('aaa4',6), ('aaa5',7);  -- error 가 나지 않음
select * from Test;    -- id 가 1 부터 증가하는 것을 볼수 있다. 


delete from Test where id > 0; -- data 만 지우는 명령어
select * from Test;
insert into Test(ttt, dept) values ('aaa1',3), ('aaa2',4), ('aaa3',5), ('aaa4',6), ('aaa5',7);  -- error 가 나지 않음
select * from Test;    -- id 가 6 부터 증가하는 것을 볼수 있다. table 조작 tool 의 option 에서 시작점을 조절할 수 있다


update Test set ttt='한글입니다😊'  where id=6;
select * from Test;
