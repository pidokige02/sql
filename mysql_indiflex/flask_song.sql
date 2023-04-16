show databases;

create Database flaskdb;

use flaskdb;


create table User(
id int unsigned not null auto_increment primary key,
email varchar(255) not null UNIQUE,
passwd varchar(255),
nickname varchar(255)
);


create table Album(
albumid varchar(31) not null primary key,
createdt varchar(31) not null,
title varchar(31) not null,
company varchar(31) not null,
genre varchar(31) not null,
likecnt int unsigned,
rate float,
crawldt varchar(31) not null
);


create table Artist(
artistid varchar(31) not null primary key,
name varchar(31) not null,
atype smallint unsigned not null
);


create table Song(
songno varchar(10) not null primary key,
title varchar(255),
genre varchar(31),
likecnt int unsigned unsigned not null,
albumid varchar(10),
FOREIGN KEY(albumid) REFERENCES Album(albumid) ON DELETE SET NULL
);

ALTER TABLE Song modify COLUMN likecnt int unsigned;
desc Song;

create table SongRank(
id int unsigned not null primary key,
rankdt varchar(31) not null,
songno varchar(10) not null,
srank smallint unsigned not null,
FOREIGN KEY(songno) REFERENCES Song(songno)
);

create table SongArtist(
songno varchar(10),
artistid varchar(31),
atype smallint unsigned not null,
FOREIGN KEY(songno) REFERENCES Song(songno),
FOREIGN KEY(artistid) REFERENCES Artist(artistid) ON DELETE SET NULL
);

desc Song;
create table Myalbum(
id int unsigned not null auto_increment primary key,
userid int unsigned not null,
songno varchar(10) not null,
upfile varchar(128) not null,
FOREIGN KEY(songno) REFERENCES Song(songno)
);

desc Myalbum;
ALTER TABLE Myalbum MODIFY COLUMN upfile varchar(128);
-- remove "not null" property from upfile
 
select * from Myalbum;

create table Mycom(
id int auto_increment primary key,
myalbumid int,
writer int unsigned,
content varchar(1023),
writedate timestamp default current_timestamp,
FOREIGN KEY(writer) REFERENCES User(id)
);
ALTER TABLE Mycom MODIFY COLUMN myalbumid int;
ALTER TABLE Mycom MODIFY COLUMN content varchar(1023);
ALTER TABLE Mycom MODIFY COLUMN writedate timestamp default current_timestamp;
desc User;
desc Mycom;
insert into Mycom(myalbumid, writer, content) values (1, 5, "첫번째");
insert into Mycom(myalbumid, writer, content) values (1, 5, "두번째");

select * from Mycom;

-- view 를 통하여 만들어질 table 다른 방법으로 만들었다 'v_sa_grp'
create table SongInfo(
id varchar(31) not null primary key,
songno varchar(10),
names varchar(31),
atype smallint unsigned not null
);


create table Ttt(
id int unsigned not null auto_increment primary key,
myalbum int unsigned,
writer int unsigned,
content varchar(255),
writedate DATETIME not null,
FOREIGN KEY(myalbum) REFERENCES Myalbum(id) ON DELETE SET NULL,
FOREIGN KEY(writer) REFERENCES User(id) ON DELETE SET NULL
);


select * from Album where crawldt < date_format(now(), "%Y-%m-%d"); 

drop table User;

select * from Album;

show processlist;

-- data update is done in python codes
-- ALTER TABLE Album ADD COLUMN likecnt int unsigned;

-- insert into Album(albumid, createdt, title, company, genre, likecnt, rate, crawldt )
--     value ("0000001", "2018-8-28", "Ditto", "신나라", "발라드", 1200, 3.5, "2018-8-28" );

-- insert into Album(albumid, createdt, title, company, genre, likecnt, rate, crawldt )
--     values ("0000002", "2018-8-28", "OMG", "신나라", "Jazz", 1500, 4.0, "2022-8-28" ),
--      ("0000003", "2019-9-28", "OMG2", "신나라2", "Dance", 1100, 4.5, "2022-9-28" );

-- insert into Song(songno, title, genre, likecnt, albumid  )
--     values ('0000001', '피어나도록 (love you twice)', '발라드', 3206, '0000001'),
--     ('0000002', '피어나도록2 (love you twice)2', '발라드', 3208, '0000001'),
--     ('0000003', '피어나도록3 (love you twice)3', '발라드', 3200, '0000001'),
--     ('0000004', 'Hype boy', 'Jazz', 3208, '0000002'),
--     ('0000005', 'Teddy Bear', 'Jazz', 3200, '0000002'),
--     ('0000006', 'Hype boy', 'OMG2', 4208, '0000003'),
--     ('0000007', 'Teddy Bear', 'OMG2', 4200, '0000003'); 

select * from Song;
select * from Artist;
select * from SongArtist;
select * from SongRank;
select * from User;
select * from SongInfo;

select * from Song where likecnt < 10000;
select * from Song where title like '%12%';

select sa.*, a.* 
from SongArtist sa inner join Artist a 
	on sa.artistid=a.artistid  
	where sa.songno='0000001' and a.atype > 0;

-- not working below command 
select sa.*, a.* 
from SongArtist sa inner join Artist a 
	on sa.artistid=a.artistid  
	where sa.songno='0000001' and a.atype > 0
	group by sa.atype;

-- below command is converted to view w/ v_sa_grp   
select sa.atype, group_concat(a.name) names
	from SongArtist sa inner join Artist a 
		on sa.artistid = a.artistid and sa.atype = a.atype 
    where sa.songno='0000002' and a.atype > 0
    group by sa.atype;

select * from v_sa_grp where songno = '0000001';
select * from v_sa_grp;

select concat(sa.songno, sa.atype) id, sa.atype, group_concat(a.name) names
	from SongArtist sa inner join Artist a 
		on sa.artistid = a.artistid and sa.atype = a.atype 
    where sa.songno='0000002' and a.atype > 0
    group by sa.atype;

select atype, group_concat(name) from v_sa 
  where songno = '0000001' and atype > 0 group by atype;  -- call view

select sa.songno, sa.atype, group_concat(a.name) names
	from SongArtist sa inner join Artist a 
		on sa.artistid = a.artistid and sa.atype = a.atype 
    where  a.atype > 0
    group by sa.songno, sa.atype;

select * from v_sa where songno='0000001';
select * from v_sa;

select * from Myalbum;

select s.songno, s.genre, r.srank
	from Song s inner join SongRank r on s.songno = r.songno
    where r.rankdt = "2022-10-28" order by genre;
    
select 'abc', password('abc');
select 'abc', sha2('abc', 256);



--
