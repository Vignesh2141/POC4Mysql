CREATE DATABASE POC4;
USE POC4;
create table author (
id int primary key,
name varchar(100)
);

create table post(
id int primary key,
name varchar(100),
authorid int,
createdts datetime,
foreign key(authorid) references author(id) on delete cascade
);



create table user (
id int primary key,
name varchar(100)
);

create table comment (
id int primary key,
content varchar(1000),
postid int ,
createdts datetime,
userid int ,
foreign key(postid) references post(id) on delete cascade,
foreign key(userid) references user(id) on delete cascade
);

insert into author(id,name) values(1,"James Bond"),(2,"Sherlock Holmes"),(3,"Alen Turing");

select * from author;

insert into user(id,name) values (1,"Vignesh"),(2,"Rakshith"),(3,"Yaswanth");

select * from User;

delete from post where id=2;

insert into post(id,name,authorid,createdts) values (1,"FirstPost",1,"2020-12-19 11:22:33"),(2,"SecondPost",2,"2021-01-21 12:33:44"),(3,"ThirdPost",2,"2022-01-11 16:02:55");
insert into post(id,name,authorid,createdts) values(2,"SecondPost",1,"2021-01-21 12:33:44");
select * from post;

insert into comment(id,content,postid,createdts,userid) values (1,"comment1",1,"2020-12-20 13:32:43",1),
(2,"comment2",1,"2021-01-19 09:21:22",1),(3,"comment3",1,"2021-02-12 09:54:32",2),
(4,"comment4",1,"2021-03-10 14:32:44",3),(5,"comment5",1,"2021-04-12 08:32:43",2),
(6,"comment6",1,"2021-04-21 19:10:43",2),(7,"comment7",1,"2021-05-20 12:32:43",1),
(8,"comment8",1,"2021-05-22 10:23:11",2),(9,"comment9",1,"2021-08-22 18:20:43",2),
(10,"comment10",1,"2021-02-11 21:32:43",1);

select * from comment;
insert into comment(id,content,postid,createdts,userid) values (11,"comment11",2,"2021-03-20 13:32:43",1),
(12,"comment11",2,"2021-01-11 11:21:22",2),(13,"comment11",2,"2021-01-21 21:54:32",2);



select * from (select p.id as pid,p.name,p.createdts as pdates,p.authorid,c.id as cid,c.content,c.createdts as cdates,c.userid,row_number() OVER (PARTITION BY p.id Order by p.createdts DESC) AS Sno  from post p left join comment c on c.postid=p.id 
where c.postid in 
(select p.id from post p left join author a on a.id=p.authorid 
where a.name="James Bond") 
order by c.postid,c.createdts desc)aliasname where Sno<=10;