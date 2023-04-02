create Database prac2db;
use prac2db;
-- playground for the view and trigger test

CREATE TABLE Subject (
  subject_id int unsigned not null PRIMARY KEY auto_increment COMMENT '과목',
  subjectname varchar(12) not null COMMENT '과목명'
);

insert into Subject (subjectname ) values ('국어'),('영어'),('수학'),('물리'),('화학'),('생물');
insert into Subject (subjectname ) values ('역사');

SELECT * FROM Subject;

CREATE TABLE Students (
  student_id int unsigned not null PRIMARY KEY auto_increment COMMENT '학생ID',
  name varchar(12) not null COMMENT '학생이름'
);

insert into Students (name) values ('권소현'), ('황규성'), ('황규영'), ('황인수'), ('장민자');

SELECT * FROM Students;

CREATE TABLE Grades (
	midterm_score smallint unsigned not null COMMENT '중간성적',
	finalterm_score smallint unsigned not null COMMENT '기말성적',
	sub_id int unsigned,
	stud_id int unsigned,
	FOREIGN KEY(sub_id) REFERENCES Subject(subject_id) ON DELETE SET NULL,
	FOREIGN KEY(stud_id) REFERENCES Students(student_id) ON DELETE SET NULL
);

-- 국어 권소현 (1,1)
insert into Grades (midterm_score, finalterm_score, sub_id, stud_id) values (70, 70, 1, 1);

-- 영어 권소현 (2,1)
insert into Grades (midterm_score, finalterm_score, sub_id, stud_id) values (70, 70, 2, 1);

-- 수학 권소현 (3,1)
insert into Grades (midterm_score, finalterm_score, sub_id, stud_id) values (80, 80, 3, 1);

-- 물리 권소현 (4,1)
insert into Grades (midterm_score, finalterm_score, sub_id, stud_id) values (90, 90, 4, 1);

-- 화학 권소현 (5,1)
insert into Grades (midterm_score, finalterm_score, sub_id, stud_id) values (90, 90, 5, 1);

-- 생물 권소현 (6,1)
insert into Grades (midterm_score, finalterm_score, sub_id, stud_id) values (90, 95, 6, 1);

-- 역사 권소현 (7,1)
insert into Grades (midterm_score, finalterm_score, sub_id, stud_id) values (90, 95, 7, 1);

-- 국어 영어 수학 물리 화학 생물 역사 황규성 
insert into Grades (midterm_score, finalterm_score, sub_id, stud_id) values (80, 80, 1, 2), (80, 80, 2, 2), (80, 80, 3, 2), (85, 85, 4, 2), (85, 85, 5, 2), (90, 90, 6, 2), (90, 90, 7, 2);

-- 국어 영어 수학 물리 화학 생물 역사 황규영 
insert into Grades (midterm_score, finalterm_score, sub_id, stud_id) values (90, 90, 1, 3), (90, 90, 2, 3), (90, 90, 3, 3),(80, 80, 4, 3), (85, 85, 5, 3), (90, 90, 6, 3), (95, 95, 7, 3) ;

-- 국어 영어 수학 물리 화학 생물 역사 황인수 
insert into Grades (midterm_score, finalterm_score, sub_id, stud_id) values (90, 90, 1, 4), (90, 90, 2, 4), (90, 90, 3, 4),(80, 80, 4, 4), (80, 80, 5, 4), (90, 90, 6, 4), (80, 80, 7, 4) ;

-- 국어 영어 수학 물리 화학 생물 역사 장민자 
insert into Grades (midterm_score, finalterm_score, sub_id, stud_id) values (90, 90, 1, 5), (90, 90, 2, 5), (90, 90, 3, 5),(80, 80, 4, 5), (70, 70, 5, 5), (70, 70, 6, 5), (70, 70, 7, 5) ;

SELECT * FROM Grades;

CREATE TABLE Enrolls (
	stud_id int unsigned COMMENT '학생ID',  
	sub_id int unsigned COMMENT '과목ID',	
	FOREIGN KEY(sub_id) REFERENCES Subject(subject_id) ON DELETE SET NULL,
	FOREIGN KEY(stud_id) REFERENCES Students(student_id) ON DELETE SET NULL
);  

insert into Enrolls (stud_id, sub_id) values (1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (1, 7);

insert into Enrolls (stud_id, sub_id) values (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (2, 6), (2, 7);

insert into Enrolls (stud_id, sub_id) values (3, 1), (3, 2), (3, 3), (3, 4), (3, 5), (3, 6), (3, 7);

insert into Enrolls (stud_id, sub_id) values (4, 1), (4, 2), (4, 3), (4, 4), (4, 5), (4, 6), (4, 7);

insert into Enrolls (stud_id, sub_id) values (5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6), (5, 7);

SELECT * FROM Enrolls;

select sub_id as SubjectID, count(stud_id) as NumOfStudent from Enrolls GROUP BY sub_id;


SELECT  Subject.subjectname AS '과목명', Students.name AS '학생명', Grades.midterm_score AS '중간', Grades.finalterm_score AS '기말' 
  FROM ((Grades 
	INNER JOIN Students ON Students.student_id = Grades.stud_id)
	INNER JOIN Subject ON Subject.subject_id = Grades.sub_id);
