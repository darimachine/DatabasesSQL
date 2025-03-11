SELECT TITLE,NAME
FROM MOVIEEXEC JOIN MOVIE ON CERT#=PRODUCERC#
WHERE NAME = (
--1. Напишете заявка, която извежда името на продуцента и имената на
--филмите, продуцирани от продуцента на филма ‘Star Wars’.
SELECT MOVIEEXEC.NAME
FROM MOVIEEXEC JOIN MOVIE ON CERT#=PRODUCERC#
WHERE TITLE='Star Wars');

--2. Напишете заявка, която извежда имената на продуцентите на филмите, в
--които е участвал ‘Harrison Ford’
SELECT DISTINCT MOVIEEXEC.NAME
FROM MOVIEEXEC LEFT JOIN MOVIE ON MOVIEEXEC.CERT#=PRODUCERC#
WHERE MOVIE.TITLE IN (SELECT MOVIETITLE
FROM STARSIN
WHERE STARNAME = 'Harrison Ford');

--3. Напишете заявка, която извежда името на студиото и имената на
--актьорите, участвали във филми, произведени от това студио, подредени
--по име на студио.SELECT DISTINCT STUDIONAME, STARNAMEFROM MOVIE JOIN STARSIN ON MOVIE.TITLE = STARSIN.MOVIETITLEORDER BY STUDIONAME;--Напишете заявка, която извежда имената на актьорите, участвали във
--филми на продуценти с най-големи нетни активи.
SELECT STARNAME, pr.NETWORTH,STARSIN.MOVIETITLE
FROM STARSIN JOIN (MOVIE JOIN (SELECT * FROM MOVIEEXEC
WHERE NETWORTH >= ALL(SELECT NETWORTH FROM MOVIEEXEC)) as pr ON MOVIE.PRODUCERC#=pr.CERT#) 
ON STARSIN.MOVIETITLE = MOVIE.TITLE;

--5. Напишете заявка, която извежда имената на актьорите, които не са
--участвали в нито един филм.
SELECT NAME,MOVIETITLE
FROM MOVIESTAR LEFT JOIN STARSIN ON NAME=STARSIN.STARNAME
WHERE STARNAME is null;