--1. Напишете заявка, която извежда имената на всички кораби без повторения,
--които са участвали в поне една битка и чиито имена започват с C или K.
SELECT DISTINCT SHIP
FROM OUTCOMES
WHERE SHIP LIKE 'C%' OR SHIP LIKE 'K%';

--2. Напишете заявка, която извежда име и държава на всички кораби, които
--никога не са потъвали в битка (може и да не са участвали).
SELECT DISTINCT s.NAME, c.COUNTRY
FROM (SHIPS as s LEFT JOIN CLASSES as c ON s.CLASS = c.CLASS) LEFT JOIN OUTCOMES
ON OUTCOMES.SHIP=s.NAME
WHERE OUTCOMES.SHIP is NULL 
OR OUTCOMES.RESULT !='sunk';

--3. Напишете заявка, която извежда държавата и броя на потъналите кораби за
--тази държава. Държави, които нямат кораби или имат кораб, но той не е
--участвал в битка, също да бъдат изведени.SELECT c1.COUNTRY,COUNT(o.SHIP)FROM (CLASSES as c1 LEFT JOIN SHIPS as s1 ON c1.CLASS=s1.CLASS) LEFT JOIN OUTCOMES as o ON o.SHIP=s1.NAMEWHERE o.RESULT='sunk' or o.RESULT is nullGROUP BY c1.COUNTRY;--4. Напишете заявка, която извежда име на битките, които са по-мащабни (с
--повече участващи кораби) от битката при Guadalcanal.SELECT BATTLEFROM OUTCOMESGROUP BY BATTLEHAVING COUNT(*) > (SELECT COUNT(*)				   FROM OUTCOMES				   WHERE BATTLE = 'Guadalcanal');--5. Напишете заявка, която извежда име на битките, които са по-мащабни (с
--повече участващи страни) от битката при Surigao Strait.

SELECT BATTLEFROM OUTCOMESGROUP BY BATTLEHAVING COUNT(*) > (SELECT COUNT(*)				   FROM OUTCOMES				   WHERE BATTLE = 'Surigao Strait');--6. Напишете заявка, която извежда имената на най-леките кораби с най-много
--оръдия.

SELECT s.NAME,c.DISPLACEMENT,c.NUMGUNS
FROM SHIPS as s JOIN CLASSES as c ON s.CLASS=c.CLASS
WHERE DISPLACEMENT <= ALL(SELECT DISPLACEMENT FROM CLASSES)
AND NUMGUNS >= ALL(SELECT NUMGUNS
FROM SHIPS as s JOIN CLASSES as c ON s.CLASS=c.CLASS
WHERE DISPLACEMENT <= ALL(SELECT DISPLACEMENT FROM CLASSES));

--7. Изведете броя на корабите, които са били увредени в битка, но са били
--поправени и по-късно са победили в друга битка.
SELECT COUNT(*)
FROM OUTCOMES as o1 JOIN BATTLES as b1 ON o1.BATTLE=b1.NAME
JOIN OUTCOMES as o2 ON o1.SHIP=o2.SHIP
JOIN BATTLES as b2 ON o2.BATTLE = b2.NAME
WHERE o1.RESULT = 'damaged'
AND o2.RESULT = 'ok'
AND b1.DATE < b2.DATE;

--8. Изведете име на корабите, които са били увредени в битка, но са били
--поправени и по-късно са победили в по-мащабна битка (с повече кораби).

SELECT *
FROM OUTCOMES as o1 JOIN BATTLES as b1 ON o1.BATTLE=b1.NAME
JOIN OUTCOMES as o2 ON o1.SHIP=o2.SHIP
JOIN BATTLES as b2 ON o2.BATTLE = b2.NAME
WHERE o1.RESULT = 'damaged'
AND o2.RESULT = 'ok'
AND b1.DATE < b2.DATE;
	 


	  