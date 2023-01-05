CREATE DATABASE pracDB;
SHOW DATABASES;
USE pracDB;

CREATE TABLE Student (
  id int unsigned not null PRIMARY KEY auto_increment COMMENT '학번',
  stud_name varchar(32) not null COMMENT '학생명',
  createdate timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
  address varchar(128) not null COMMENT '주소',
  birthday DATE NOT NULL COMMENT '생년월일',
  tel varchar(15) not null COMMENT '전화번호',
  email varchar(31) not null COMMENT '전자메일'
);

ALTER TABLE Student MODIFY COLUMN address varchar(128);
ALTER TABLE Student RENAME COLUMN name to stud_name;

insert into Student (stud_name, address, birthday, tel, email ) values( '권소현', '경기도 용인시 기흥구 중동 어정마을 삼정아파트 103동 203호', '1970-05-22', '010-2558-4761','sohsunshine@naver.com');
insert into Student (stud_name, address, birthday, tel, email ) values( '황규성', '경기도 용인시 기흥구 중동 어정마을 삼정아파트 103동 204호', '2002-11-11', '010-9248-4761','sohsunshine@naver.com');
insert into Student (stud_name, address, birthday, tel, email ) values( '황규영', '경기도 용인시 기흥구 중동 어정마을 삼정아파트 103동 205호', '2004-08-28', '010-9249-4761','sohsunshine@naver.com');

SELECT * FROM Student;

CREATE TABLE Subject (
  subject_id int unsigned not null PRIMARY KEY auto_increment COMMENT '과목',
  subjectname varchar(12) not null COMMENT '과목명'
);

use pracDB;

-- Exam #6 
DROP TABLE Grades;
DROP TABLE Subject;
DROP TABLE Students;

CREATE TABLE Subject (
  subject_id int unsigned not null PRIMARY KEY auto_increment COMMENT '과목',
  subjectname varchar(12) not null COMMENT '과목명'
);

CREATE TABLE Students (
  student_id int unsigned not null PRIMARY KEY auto_increment COMMENT '학생ID',
  name varchar(12) not null COMMENT '학생이름'
);

CREATE TABLE Grades (
  midterm_score smallint unsigned not null COMMENT '중간성적',
  finalterm_score smallint unsigned not null COMMENT '기말성적',
  sub_id int unsigned,
  stud_id int unsigned,
  FOREIGN KEY(sub_id) REFERENCES Subject(subject_id) ON DELETE SET NULL,
  FOREIGN KEY(stud_id) REFERENCES Students(student_id) ON DELETE SET NULL
);


insert into Subject (subjectname ) values ('국어'),('영어'),('수학');

SELECT * FROM Subject;

insert into Students (name) values ('권소현'), ('황규성'), ('황규영');

SELECT * FROM Students;

-- 국어 권소현 
insert into Grades (midterm_score, finalterm_score, sub_id, stud_id) values (70, 70, 1, 1);

-- 영어 권소현
insert into Grades (midterm_score, finalterm_score, sub_id, stud_id) values (70, 70, 2, 1);

-- 수학 권소현
insert into Grades (midterm_score, finalterm_score, sub_id, stud_id) values (70, 70, 3, 1);

SELECT * FROM Grades;

-- 국어 영어 수학 황규성 
insert into Grades (midterm_score, finalterm_score, sub_id, stud_id) values (80, 80, 1, 2), (80, 80, 2, 2), (80, 80, 3, 2);

-- 국어 영어 수학 황규영 
insert into Grades (midterm_score, finalterm_score, sub_id, stud_id) values (90, 90, 1, 3), (90, 90, 2, 3), (90, 90, 3, 3);


SELECT  Subject.subjectname AS '과목명', Students.name AS '학생명', Grades.midterm_score AS '중간', Grades.finalterm_score AS '기말' 
  FROM ((Grades 
	INNER JOIN Students ON Students.student_id = Grades.stud_id)
	INNER JOIN Subject ON Subject.subject_id = Grades.sub_id);

SELECT  Subject.subjectname AS '과목명', Students.name AS '학생명', 
	Grades.midterm_score AS '중간', 
	Grades.finalterm_score AS '기말', 
	Grades.midterm_score + Grades.finalterm_score AS '총점',
    ROUND((Grades.midterm_score + Grades.finalterm_score)/2) AS'평균'
  FROM ((Grades 
	INNER JOIN Students ON Students.student_id = Grades.stud_id)
	INNER JOIN Subject ON Subject.subject_id = Grades.sub_id);

/* 
function 에서 아래의 error 를 없애기 위해 필요하다.
NO SQL, or READS SQL DATA in its declaration and binary logging is enabled
*/
SET GLOBAL log_bin_trust_function_creators = 1; 

SELECT  Subject.subjectname AS '과목명', Students.name AS '학생명', 
	Grades.midterm_score AS '중간', 
	Grades.finalterm_score AS '기말', 
	Grades.midterm_score + Grades.finalterm_score AS '총점',
    ROUND((Grades.midterm_score + Grades.finalterm_score)/2) AS'평균',
    GET_CREDIT(ROUND((Grades.midterm_score + Grades.finalterm_score)/2)) AS '학점'
  FROM ((Grades 
	INNER JOIN Students ON Students.student_id = Grades.stud_id)
	INNER JOIN Subject ON Subject.subject_id = Grades.sub_id);

/* data 를 학점이 골고루 나올 수 있도록 아래와 같이 변경한다 */
-- UPDATE Grades
-- SET midterm_score = 90, finalterm_score = 90
-- WHERE subject_id = 1 AND stud_id = 1;

-- UPDATE Grades
-- SET midterm_score = 80, finalterm_score = 80
-- WHERE subject_id = 1 AND stud_id = 2;

-- UPDATE Grades
-- SET midterm_score = 70, finalterm_score = 70
-- WHERE subject_id = 1 AND stud_id = 3;

-- UPDATE Grades
-- SET midterm_score = 90, finalterm_score = 90
-- WHERE subject_id = 3 AND stud_id = 1;

-- UPDATE Grades
-- SET midterm_score = 80, finalterm_score = 80
-- WHERE subject_id = 2 AND stud_id = 2;

-- UPDATE Grades
-- SET midterm_score = 70, finalterm_score = 70
-- WHERE subject_id = 1 AND stud_id = 3;

SELECT  Subject.subjectname AS '과목명', 
	ROUND(AVG((Grades.midterm_score + Grades.finalterm_score)/2)) AS '평균'
  FROM ((Grades 
	INNER JOIN Students ON Students.student_id = Grades.stud_id)
	INNER JOIN Subject ON Subject.subject_id = Grades.sub_id)
    GROUP BY Subject.subjectname;

SET GLOBAL log_bin_trust_function_creators = 1; 

SELECT  Subject.subjectname AS '과목명', Students.name AS '학생명', 
	Grades.midterm_score AS '중간', 
	Grades.finalterm_score AS '기말', 
	Grades.midterm_score + Grades.finalterm_score AS '총점',
    ROUND((Grades.midterm_score + Grades.finalterm_score)/2) AS'평균',
    GET_CREDIT(ROUND((Grades.midterm_score + Grades.finalterm_score)/2)) AS '학점'
  FROM ((Grades 
	INNER JOIN Students ON Students.student_id = Grades.stud_id)
	INNER JOIN Subject ON Subject.subject_id = Grades.sub_id);


--  
SELECT DISTINCT A.subjectname AS '과목명', 
	ROUND((g.midterm_score + g.finalterm_score)/2) AS'평균',
    Students.name AS '최고득점자'
    FROM (Grades g 
    INNER JOIN (  -- 어래는 table 을 return 해준다. 
			SELECT *, max(g.midterm_score + g.finalterm_score)
				over (partition by Subject.subjectname) as MAX_SCORE
				FROM (Grades g
					INNER JOIN Subject ON Subject.subject_id = g.sub_id	)) A 
			INNER JOIN Students ON Students.student_id = g.stud_id AND A.MAX_SCORE = (g.midterm_score + g.finalterm_score));
 -- MAX_SCORE 와 같은 것만 추려서 return 해준다. A.MAX_SCORE = (g.midterm_score + g.finalterm_score))
 -- DISTINCT : 반복되면 하나만 표시한다.


SELECT *, max(g.midterm_score + g.finalterm_score)
		over (partition by Subject.subjectname) as MAX_SCORE
	FROM (Grades g
	INNER JOIN Subject ON Subject.subject_id = g.sub_id );


SELECT COUNT(*) FROM Students;
SELECT COUNT(student_id) FROM Students;

-- 각과목별 전체 수강 학생수를 구하는 SCRIPT 
SELECT COUNT(*) FROM Grades WHERE sub_id = 2; 


SELECT DISTINCT A.subjectname AS '과목명', 
	ROUND((g.midterm_score + g.finalterm_score)/2) AS'평균',
    Students.name AS '최고득점자',
    get_stud_count_byID(g.stud_id) AS '총학생'
    FROM (Grades g 
    INNER JOIN (  -- 어래는 table 을 return 해준다. 
			SELECT *, max(g.midterm_score + g.finalterm_score)
				over (partition by Subject.subjectname) as MAX_SCORE
				FROM (Grades g
					INNER JOIN Subject ON Subject.subject_id = g.sub_id	)) A 
			INNER JOIN Students ON Students.student_id = g.stud_id AND A.MAX_SCORE = (g.midterm_score + g.finalterm_score));


SELECT DISTINCT Students.name AS '학생명',
	get_subject() AS '과목수',
	get_total_score(Students.student_id) AS '총점',
	get_average_score(Students.student_id) AS '평균',	
	GET_CREDIT(get_average_score(Students.student_id)) AS '평점'
  FROM ((Grades 
	INNER JOIN Students ON Students.student_id = Grades.stud_id)
	INNER JOIN Subject ON Subject.subject_id = Grades.sub_id);

SELECT COUNT(*) FROM Subject;	

SELECT * FROM Grades WHERE sub_id = 1 AND stud_id = 1;

SELECT SUM((g.midterm_score + g.finalterm_score)/2) AS '총점' from Grades g WHERE stud_id = 1;

SELECT AVG((g.midterm_score + g.finalterm_score)/2) AS '평균' from Grades g WHERE stud_id = 1;


-- start sample table for practice. 
create table employee
( emp_ID int primary key
, emp_NAME varchar(50) not null
, DEPT_NAME varchar(50)
, SALARY int);

insert into employee values(101, 'Mohan', 'Admin', 4000);
insert into employee values(102, 'Rajkumar', 'HR', 3000);
insert into employee values(103, 'Akbar', 'IT', 4000);
insert into employee values(104, 'Dorvin', 'Finance', 6500);
insert into employee values(105, 'Rohit', 'HR', 3000);
insert into employee values(106, 'Rajesh',  'Finance', 5000);
insert into employee values(107, 'Preet', 'HR', 7000);
insert into employee values(108, 'Maryam', 'Admin', 4000);
insert into employee values(109, 'Sanjay', 'IT', 6500);
insert into employee values(110, 'Vasudha', 'IT', 7000);
insert into employee values(111, 'Melinda', 'IT', 8000);
insert into employee values(112, 'Komal', 'IT', 10000);
insert into employee values(113, 'Gautham', 'Admin', 2000);
insert into employee values(114, 'Manisha', 'HR', 3000);
insert into employee values(115, 'Chandni', 'IT', 4500);
insert into employee values(116, 'Satya', 'Finance', 6500);
insert into employee values(117, 'Adarsh', 'HR', 3500);
insert into employee values(118, 'Tejaswi', 'Finance', 5500);
insert into employee values(119, 'Cory', 'HR', 8000);
insert into employee values(120, 'Monica', 'Admin', 5000);
insert into employee values(121, 'Rosalin', 'IT', 6000);
insert into employee values(122, 'Ibrahim', 'IT', 8000);
insert into employee values(123, 'Vikram', 'IT', 8000);
insert into employee values(124, 'Dheeraj', 'IT', 11000);

select * from employee;

select x.*
from employee e
join (select *,
max(salary) over (partition by dept_name) as max_salary,
min(salary) over (partition by dept_name) as min_salary
from employee) x
on e.emp_id = x.emp_id
and (e.salary = x.max_salary or e.salary = x.min_salary)
order by x.dept_name, x.salary;

select *,
max(salary) over (partition by dept_name) as max_salary,
min(salary) over (partition by dept_name) as min_salary
from employee;
-- end sample table for practice. 

        
 