use pracDB;

CREATE TABLE ClubMember (
  id int unsigned not null PRIMARY KEY auto_increment COMMENT 'id',
  club_id int unsigned COMMENT 'club_id',
  FOREIGN KEY(club_id) REFERENCES Club(club_id) ON DELETE SET NULL,
  level int unsigned COMMENT '레벨'
);

CREATE TABLE Club (
  club_id int unsigned not null PRIMARY KEY auto_increment COMMENT 'club_id',
  club_name varchar(32) not null COMMENT '동아리'
);
