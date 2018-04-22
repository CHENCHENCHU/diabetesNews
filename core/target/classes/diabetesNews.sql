-- 一、删除数据库
DROP DATABASE IF EXISTS diabetesNews;
-- 二、创建数据库
create database diabetesNews character set utf8;
-- 三、使用数据库
use diabetesNews;
-- 四、创建数据表
-- 1、用户数据表
drop table if exists user;
/*=============================================================*/
/* Table: user  status --0（激活状态）1（锁定状态）  */
/*==============================================================*/
create table  user
(
   user_id              int auto_increment,
   name                 varchar(255) unique,
   real_name            varchar(255),
   phone                varchar(255),
   email                varchar(255),
   role                 varchar(255),
   status               bit,
   created_date         date,
   modified_date        date,
   deleted_date         date,
   is_deleted           bit DEFAULT 0,
   primary key (user_id)
)engine = innodb;
-- 2、角色表
drop table if exists role;
/*==============================================================*/
/* Table: role                                                  */
/*==============================================================*/
create table role
(
   role_id              int,
   title                varchar(255),
   code                 varchar(255),
   primary key (role_id)
)type = innodb;
-- 3、权限表
drop table if exists permission;
/*==============================================================*/
/* Table: permission                                            */
/*==============================================================*/
create table permission
(
   per_id               int,
   title                varchar(255),
   code                 varchar(255),
   primary key (per_id)
)type = innodb;
-- 4、角色权限关系表
drop table if exists role_permission;
/*==============================================================*/
/* Table: role_permission                                       */
/*==============================================================*/
create table role_permission
(
   id                   int auto_increment,
   rid                  int,
   pid                  int,
   primary key (id)
)type = innodb;
-- 5、资讯表
drop table if exists news;
/*==============================================================*/
/* Table: news                                                  */
/*==============================================================*/
create table news
(
   news_id              int auto_increment,
   title                varchar(255),
   abstract             varchar(255),
   type                 varchar(255),
   picture              varchar(255),
   content              varchar(255),
   create_id            int,
   created_date         date,
   modified_id          int,
   modified_date        date,
   deleted_date         date,
   is_deleted           bit DEFAULT 0,
   is_hidden            bit DEFAULT 0,
   version              long ,
   primary key (news_id)
)type = innodb;
-- 6、留言表
drop table if exists bespeak;
/*==============================================================*/
/* Table: bespeak status --0（未处理）1（已处理）*/
/*==============================================================*/
create table bespeak
(
   bespeak_id           int auto_increment,
   user_id              int,
   bespeak_date         datetime,
   bespeak              varchar(255),
   status               int DEFAULT 0,
   reponser_id          int,
   response             varchar(255),
   is_deleted           bit DEFAULT 0,
   primary key (bespeak_id)
)type = innodb;
-- 五、建立外键
alter table role_permission add constraint FK_rid foreign key (rid)
      references role (role_id) on delete restrict on update restrict;
alter table role_permission add constraint FK_pid foreign key (pid)
      references permission (per_id) on delete restrict on update restrict;
alter table news add constraint FK_create_id foreign key (create_id)
      references user (user_id) on delete restrict on update restrict;
alter table news add constraint FK_modified_id foreign key (modified_id)
      references user (user_id) on delete restrict on update restrict;
alter table bespeak add constraint FK_user_id foreign key (user_id)
      references user (user_id) on delete restrict on update restrict;
alter table bespeak add constraint FK_reponser_id foreign key (reponser_id)
      references user (user_id) on delete restrict on update restrict;
-- 六、创建基础数据
-- 1、角色表
-- doctor查看、回复留言、创建、更新、删除资讯
-- admin查看留言、创建、更新、删除资讯、锁定用户
insert into role(role_id,title,code) values(1,"普通用户","user");
insert into role(role_id,title,code) values(2,"医生","doctor");
insert into role(role_id,title,code) values(3,"普通管理员","admin");
insert into role(role_id,title,code) values(4,"超级管理员","super");
-- 2、权限表
insert into permission(per_id,title,code) values(1,"创建用户","user:add");
insert into permission(per_id,title,code) values(2,"更新用户","user:edit");
insert into permission(per_id,title,code) values(3,"锁定用户","user:lock");
insert into permission(per_id,title,code) values(4,"激活用户","user:unlock");
insert into permission(per_id,title,code) values(5,"创建资讯","news:add");
insert into permission(per_id,title,code) values(6,"更新资讯","news:edit");
insert into permission(per_id,title,code) values(7,"删除资讯","news:delete");
insert into permission(per_id,title,code) values(8,"查看留言","bespeak:list");
insert into permission(per_id,title,code) values(9,"回复留言","bespeak:response");
-- 3、角色权限表
insert into role_permission(rid,pid) values(2,8);
insert into role_permission(rid,pid) values(2,9);
insert into role_permission(rid,pid) values(2,5);
insert into role_permission(rid,pid) values(2,6);
insert into role_permission(rid,pid) values(2,7);
insert into role_permission(rid,pid) values(3,3);
insert into role_permission(rid,pid) values(3,5);
insert into role_permission(rid,pid) values(3,6);
insert into role_permission(rid,pid) values(3,7);
insert into role_permission(rid,pid) values(3,8);
insert into role_permission(rid,pid) values(3,8);
insert into role_permission(rid,pid) values(4,1);
insert into role_permission(rid,pid) values(4,2);
insert into role_permission(rid,pid) values(4,3);
insert into role_permission(rid,pid) values(4,4);
insert into role_permission(rid,pid) values(4,5);
insert into role_permission(rid,pid) values(4,6);
insert into role_permission(rid,pid) values(4,7);
insert into role_permission(rid,pid) values(4,8);
insert into role_permission(rid,pid) values(4,9);
-- 4、用户表
insert into user(name,real_name,phone,email,role,status,created_date,is_deleted) values("ccc","楚琛琛","18856042341","ccc@163.com","admin",0,"2018-01-01",0);
insert into user(name,real_name,phone,email,role,status,created_date,is_deleted) values("zs","张三","18342343241","zs@163.com","admin",0,"2018-01-01",0);
insert into user(name,real_name,phone,email,role,status,created_date,is_deleted) values("ls","李四","13456042341","ls@163.com","user",0,"2018-01-01",0);
insert into user(name,real_name,phone,email,role,status,created_date,is_deleted) values("ww","王五","13256042341","ww@163.com","user",0,"2018-01-01",0);
insert into user(name,real_name,phone,email,role,status,created_date,is_deleted) values("zq","战前",null,null,"user",0,"2018-01-01",0);
insert into user(name,real_name,phone,email,role,status,created_date,is_deleted) values("zys","张医生","12578342341","zys@163.com","doctor",0,"2018-01-01",0);
insert into user(name,real_name,phone,email,role,status,created_date,is_deleted) values("lys","李医生","1876432341","lys@163.com","doctor",0,"2018-01-01",0);