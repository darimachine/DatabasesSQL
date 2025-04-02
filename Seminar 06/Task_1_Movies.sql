--1. Напишете заявка, която извежда заглавие и година на всички филми, които са
--по-дълги от 120 минути и са снимани преди 2000 г. Ако дължината на филма е
--неизвестна, заглавието и годината на този филм също да се изведат.

SELECT TITLE, year,LENGTH
FROM MOVIE
WHERE (LENGTH>120  OR LENGTH is null) AND YEAR<2000;

--2. Напишете заявка, която извежда име и пол на всички актьори (мъже и жени),
--чието име започва с 'J' и са родени след 1948 година. Резултатът да бъде
--подреден по име в намаляващ ред.

SELECT NAME,GENDER
FROM MOVIESTAR
WHERE NAME LIKE 'J%' AND BIRTHDATE > 1948
ORDER BY NAME DESC;

--3. Напишете заявка, която извежда име на студио и брой на актьорите,
--участвали във филми, които са създадени от това студио

SELECT STUDIONAME, COUNT(DISTINCT STARSIN.STARNAME) as num_actors
FROM MOVIE JOIN STARSIN ON TITLE = MOVIETITLE
GROUP BY STUDIONAME;

--4. Напишете заявка, която за всеки актьор извежда име на актьора и броя на
--филмите, в които актьорът е участвал.
SELECT MOVIESTAR.NAME, COUNT(DISTINCT MOVIETITLE) as num_movies
FROM MOVIESTAR LEFT JOIN STARSIN ON STARNAME = MOVIESTAR.NAME
GROUP By MOVIESTAR.NAME;

--5. Напишете заявка, която за всяко студио извежда име на студиото и заглавие
--на филма, излязъл последно на екран за това студио.


SELECT MOVIE.STUDIONAME,TITLE, MOVIE.YEAR
FROM MOVIE JOIN
(SELECT STUDIONAME, MAX(YEAR) as year
FROM MOVIE
GROUP BY STUDIONAME) as mv ON MOVIE.STUDIONAME = mv.STUDIONAME
AND mv.year = MOVIE.YEAR;

--5. Напишете заявка, която за всяко студио извежда име на студиото и заглавие
--на филма, излязъл последно на екран за това студио
SELECT STUDIONAME,TITLE,YEAR
FROM MOVIE as m
WHERE YEAR >= ALL(SELECT YEAR FROM MOVIE WHERE m.STUDIONAME = MOVIE.STUDIONAME)
ORDER BY STUDIONAME DESC;

--6. Напишете заявка, която извежда името на най-младия актьор (мъж)

SELECT TOP 1 NAME
FROM MOVIESTAR
WHERE GENDER='m' AND
BIRTHDATE = (SELECT MAX(BIRTHDATE) FROM MOVIESTAR WHERE GENDER='m');

--7. Напишете заявка, която извежда име на актьор и име на студио за тези
--актьори, участвали в най-много филми на това студио.
SELECT STUDIONAME,STARNAME,COUNT(MOVIETITLE) as num_movies
FROM STARSIN JOIN MOVIE ON TITLE=MOVIETITLE
GROUP BY STUDIONAME,STARNAME
HAVING COUNT(MOVIETITLE) >=ALL(SELECT COUNT(MOVIETITLE) as num_movies
FROM STARSIN JOIN MOVIE ON TITLE=MOVIETITLE
GROUP BY STUDIONAME,STARNAME);

--8. Напишете заявка, която извежда заглавие и година на филма, и брой на
--актьорите, участвали в този филм за тези филми с повече от двама актьори.
SELECT MOVIETITLE,YEAR,COUNT(*) as num_movies
FROM STARSIN JOIN MOVIE ON TITLE=MOVIETITLE
GROUP BY MOVIETITLE,YEAR
HAVING COUNT(*) > 2;