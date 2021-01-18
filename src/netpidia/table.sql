

----영화 리스트 테이블--------
CREATE TABLE tblMovie (
	num             int(11) NOT NULL  auto_increment,
	name            varchar(100),
	title				 VARCHAR(300),
	story           varchar(2048),
	nation			varchar(20),
	genre			varchar(20),
	grade			varchar(20),
	direc			varchar(20),
	actor			varchar(20),
	regdate 		date,
	rdate			varchar(20),
	runtime			varchar(20),
	poster           varchar(20)  NULL,
	pos                smallint(7) unsigned,
	ref               smallint(7),
	depth             smallint(7) unsigned,
	
	
	
	viewCount             smallint(7) unsigned,
	likeCount int, 
	hateCount int,
	
	
	PRIMARY KEY (num)
)COLLATE='euckr_korean_ci';

--영화 review 댓글 및 평가 테이블--
CREATE TABLE tblMovieComment (
	cnum INT(11) NOT NULL AUTO_INCREMENT,
	num INT(11) NULL DEFAULT NULL,
	id VARCHAR(20),
	opinion VARCHAR(300),
	comment  varchar(2048), 
	rateScore int,
	regdate DATE NULL DEFAULT NULL,
	PRIMARY KEY (cnum)
)COLLATE='euckr_korean_ci';

-- 영화 평점 테이블--
CREATE TABLE tblRate (
  id varchar(20) ,
  num int,
  ip varchar(50),
  rateScore int,
  PRIMARY KEY (id,num)
)COLLATE='euckr_korean_ci';







-----영화 찜 테이블(장바구니 같은 테이블, 저장시키기)----
---영화 좋아요 테이블--
CREATE TABLE tblMovieLike (
  id varchar(20) ,
  num int,
  ip varchar(50),
  PRIMARY KEY (id,num)
)COLLATE='euckr_korean_ci';

-- 영화 싫어요 테이블--
CREATE TABLE tblMovieHate (
  id varchar(20) ,
  num int,
  ip varchar(50),
  PRIMARY KEY (id,num)
)COLLATE='euckr_korean_ci';



-----shop 평가파트에 필요한 테이블-----
CREATE TABLE tbleva (
  productNo int auto_increment,
  id varchar(20),
  title varchar(50),
  content varchar(2048),
  totalScore varchar(5),
  totalRate varchar(10),
  month varchar(12),
  likeCount int, 
  PRIMARY KEY (productNo)
)COLLATE='euckr_korean_ci';

-----shop 평가파트에 들어가는 좋아요 테이블-----

CREATE TABLE tbllikey (
  id varchar(20) ,
  productNo int,
  ip varchar(50),
  PRIMARY KEY (id,productNo)
)COLLATE='euckr_korean_ci';


--------회원가입---------
CREATE TABLE tblMember (
  id char(20) NOT NULL,
  pwd char(20) NOT NULL,
  name char(20) NOT NULL,
  gender char(1) NOT NULL,
  birthday char(6) NOT NULL,
  email char(30) NOT NULL,
  taste char(10) NOT NULL,
  grade char(2) default '0',
  PRIMARY KEY (id)
)COLLATE='euckr_korean_ci';




-----------------투표------------------------
create table tblPollList(
 num int primary key auto_increment,
 question varchar(200) not null,
 sdate date,
 edate date,
 wdate date,
 type smallint default 1,
 active smallint default 1
)COLLATE='euckr_korean_ci';




create table tblPollItem(
 listnum int not null,
 itemnum smallint default 0,
 item varchar(50) not null,
 count int,
 primary key(listnum, itemnum)
)COLLATE='euckr_korean_ci';




--------------------투표파트 게시판----------------------------

CREATE TABLE `tblBoard` (
	num               int(11)              NOT NULL  auto_increment  ,
	name             varchar(20)                    ,
	subject           varchar(50)                    ,
	content           text                                ,
	pos                smallint(7) unsigned           ,
	ref               smallint(7)                    ,
	depth             smallint(7) unsigned           ,
	regdate          date                           ,
	pass              varchar(15)                    ,
	ip                  varchar(15)                    ,
	count             smallint(7) unsigned           ,
	filename         varchar(30)                    ,
	filesize           int(11)                        ,
	PRIMARY KEY (num)
)COLLATE='euckr_korean_ci';



CREATE TABLE tblBcomment (
	cnum INT(11) NOT NULL AUTO_INCREMENT,
	num INT(11) NULL DEFAULT NULL,
	name VARCHAR(20) NULL DEFAULT NULL,
	comment VARCHAR(200) NULL DEFAULT NULL,
	regdate DATE NULL DEFAULT NULL,
	PRIMARY KEY (cnum)
)COLLATE='euckr_korean_ci';

------------------투표파트 방명록-----------------------------------


create table tblGuestBook(
	num int primary key auto_increment,
	id char(20) not null,
	contents text, ip char(15) not null,
	regdate date,
	regtime datetime,
	secret char(2) default '0'
)COLLATE='euckr_korean_ci';



create table tblComment(
 	cnum int primary key auto_increment,
 	num int not null,
 	cid char(20) not null,
 	comment text,
 	cip char(15) not null,
 	cregDate date
)COLLATE='euckr_korean_ci';

---------------------쇼핑-----------------------------------
CREATE TABLE tblProduct (
	productNo                  int(5)                      auto_increment  ,
	name            varchar(20)           NULL      ,
	price             int                           NULL      ,
	detail            text                          NULL      ,
	date              varchar(20)           NULL      ,
	stock            int                            NULL      ,
	image           varchar(20)           NULL      ,
	PRIMARY KEY ( productNo )
)COLLATE='euckr_korean_ci';



CREATE TABLE tblOrder (
	productNo                  int(5)                      auto_increment  ,
	quantity          int                           NULL      ,
	date                varchar(20)           NULL      ,
	state               varchar(10)           NULL      ,
	id                     varchar(10)           NULL      ,
	PRIMARY KEY ( productNo )
)COLLATE='euckr_korean_ci';


--------------------쇼핑몰 댓글----------------------------

create table tblshopguestbook(
	num int primary key auto_increment,
	id char(20) not null,
	contents text, ip char(15) not null,
	regdate date,
	regtime datetime,
	secret char(2) default '0'
)COLLATE='euckr_korean_ci';
	

create table tblshopcomment(
 	productNo int primary key auto_increment,
 	num int not null,
 	cid char(20) not null,
 	comment text,
 	cip char(15) not null,
 	cregDate date
)COLLATE='euckr_korean_ci';

----------------------쇼핑몰 결제------------------------------


CREATE TABLE tblPaid (
	apply_num      int(11)    NOT NULL  auto_increment  ,
	paid_amount  int    NULL ,
	PRIMARY KEY ( apply_num )
)COLLATE='euckr_korean_ci';

-----------------myprofile page ---------------------------

CREATE TABLE tblMyprofile (
  id char(20) NOT NULL,
  aboutme  text NOT NULL,
  phone  char(15) NOT NULL,
  live  char(10),
  speak  char(20),
  fhp char(40),
  ihp char(40),
  image  varchar(20)  NULL,
  name char(20) not null,
  zipcode char(5) NOT NULL,
  address char(50) NOT NULL
)COLLATE='euckr_korean_ci';



-------------------myprofile에 들어가는 zipcode---------------------

CREATE TABLE tblZipcode (
  zipcode char(5) NOT NULL,
  area1 char(10) DEFAULT NULL,
  area2 char(20) DEFAULT NULL,
  area3 char(30) DEFAULT NULL
)COLLATE='euckr_korean_ci';


-------------------blog 게시판-----------------------
CREATE TABLE `tblBlogBoard` (
	num               int(11)              NOT NULL  auto_increment  ,
	name             varchar(20)                    ,
	subject           varchar(50)                    ,
	content           text                                ,
	pos                smallint(7) unsigned           ,
	ref               smallint(7)                    ,
	depth             smallint(7) unsigned           ,
	
	regdate          date                           ,
	pass              varchar(15)                    ,
	ip                  varchar(15)                    ,
	count             smallint(7) unsigned           ,
	image  varchar(20)   NULL,
	filename         varchar(30)                    ,
	filesize           int(11)                        ,
	totalprice           varchar(10),
	price               varchar(10),
	cperson				varchar(10),
	email              char(30) ,
	id                char(20) ,
	netemail		 char(30) ,
	PRIMARY KEY (num)
)COLLATE='euckr_korean_ci';


-----------------블로그에 들어가는 댓글--------------------
CREATE TABLE tblBlogBcomment (
	cnum INT(11) NOT NULL AUTO_INCREMENT,
	num INT(11) NULL DEFAULT NULL,
	id   char(20),
	name VARCHAR(20) NULL DEFAULT NULL,
	comment VARCHAR(200) NULL DEFAULT NULL,
	regdate DATE NULL DEFAULT NULL,
	PRIMARY KEY (cnum)
)COLLATE='euckr_korean_ci';




