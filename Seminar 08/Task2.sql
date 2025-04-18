--Задача 2
--а) Нека създадем мини вариант на Facebook. Искаме да имаме следните
--релации (може да предложите и друг вариант):
--Users: уникален номер (id), email, парола, дата на регистрация.
--Friends: двойки от номера на потребители, напр. ако 12 е приятел на 21, 25 и
--40, ще има кортежи (12,21), (12,25), (12,40).
--Walls: номер на потребител, номер на потребител написал съобщението,
--текст на съобщението, дата.
-- Groups: уникален номер, име, описание (по подразбиране - празен низ).
-- GroupMembers: двойки от вида номер на група - номер на потребител.
--б) Добавете кортежи с примерни данни към новосъздадените релации.

create database Facebook
use Facebook
create table users(
id  int not null identity(1,1) primary key,
email varchar(128),
password varchar(50),
date date
)
SELECT * FROM users

ALTER TABLE users
ADD CONSTRAINT DF DEFAULT getdate() FOR date;

create table Friend(
	friend1 int foreign key references users(id),
	friend2 int foreign key references users(id)
)
select * from Friend;

create table Walls(
userID int foreign key references users(id),
writerId int foreign key references users(id),
message varchar(512),
date datetime
)
SELECT * FROM Walls;
create table Groups(
 id int primary key identity(1,1),
 name varchar(128),
 description varchar(1024) DEFAULT ''
)
create Table GroupMembers(
	groupid int foreign key references Groups(id),
	userid int foreign key references users(id)
)
INSERT INTO Users
VALUES('email@gmail.com','12345parola','2024-04-17')
INSERT INTO Users
VALUES('email2@gmail.com','125parola','2025-04-17')

INSERT INTO Friend
VALUES(1,2)

drop database Facebook