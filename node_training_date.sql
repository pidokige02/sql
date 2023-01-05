create table User(
    uid varchar(31) not null primary key,
    upw varchar(128) not null,
    uname varchar(31) not null,
    sessionkey varchar(128),
    sessionlimit timestamp,
    naverid varchar(255),
    googleid varchar(255),
    lastlogin timestamp
);

select password("NodeJS", SHA2("NodeJS", 256),  SHA2(concat("NodeJS", "nodevue")), 256);

update User set lastlogin=now() where uid='user1';
update User set lastlogin=now() where uid='user2';