--1. Да се вмъкне информация за актрисата Nicole Kidman. За нея знаем само, че е родена на
--20.06.1967.
--2. Да се изтрият всички продуценти с нетни активи под 30 милиона.
--3. Да се изтрие информацията за всички филмови звезди, за които не се знае адреса.

SELECT * FROM MOVIESTAR;
INSERT INTO MOVIESTAR(NAME,GENDER,BIRTHDATE)
VALUES('Nicole Kidman','F','1967-06-20')
SELECT * FROM MOVIEEXEC;

DELETE FROM MOVIEEXEC
WHERE NETWORTH < 30000000;

DELETE FROM MOVIESTAR
WHERE ADDRESS is NULL;