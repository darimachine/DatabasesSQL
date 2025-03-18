--1. Напишете заявка, която извежда броя на класовете бойни кораби.
SELECT COUNT(*) as NO_Classes
FROM CLASSES
WHERE type ='bb';

--2. Напишете заявка, която извежда средния брой оръдия за всеки клас боен кораб.
SELECT class, AVG(NUMGUNS) as avgGuns
FROM CLASSES
WHERE type='bb'
GROUP BY class;

--3. Напишете заявка, която извежда средния брой оръдия за всички бойни кораби.
SELECT AVG(NUMGUNS) as avgGuns
FROM CLASSES;

--4. Напишете заявка, която извежда за всеки клас първата и последната година, в
--която кораб от съответния клас е пуснат на вода.
SELECT CLASSES.CLASS, MIN(LAUNCHED) as FirstYear, MAX(LAUNCHED) as LastYear
FROM CLASSES join SHIPS ON CLASSES.CLASS=SHIPS.CLASS
GROUP BY CLASSES.CLASS;
--5. Напишете заявка, която извежда броя на корабите, потънали в битка според
--класа.
SELECT CLASS, COUNT(RESULT) as No_Sunk
FROM SHIPS JOIN OUTCOMES ON SHIPS.NAME=OUTCOMES.SHIP
WHERE RESULT='sunk'
GROUP BY CLASS;
--6. Напишете заявка, която извежда броя на корабите, потънали в битка според
--класа, за тези класове с повече от 2 кораба

SELECT CLASS, COUNT(RESULT) as No_Sunk
FROM SHIPS JOIN OUTCOMES ON SHIPS.NAME=OUTCOMES.SHIP
WHERE RESULT='sunk' AND CLASS IN (SELECT CLASS
FROM SHIPS
GROUP BY CLASS
HAVING COUNT(NAME) > 2)
Group BY CLASS;

--7. Напишете заявка, която извежда средния калибър на оръдията на корабите за
--всяка страна
SELECT COUNTRY,CONVERT(DECIMAL(8,2), AVG(BORE)) as avg_bore
FROM CLASSES JOIN SHIPS ON CLASSES.CLASS=SHIPS.CLASS
GROUP BY COUNTRY;
