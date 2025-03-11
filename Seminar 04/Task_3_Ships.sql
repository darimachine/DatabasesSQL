--1. Напишете заявка, която извежда цялата налична информация за всеки
--кораб, включително и данните за неговия клас. В резултата не трябва да
--се включват тези класове, които нямат кораби.
SELECT *
FROM SHIPS JOIN CLASSES ON SHIPS.CLASS=CLASSES.CLASS;
--2. Повторете горната заявка, като този път включите в резултата и класовете,
--които нямат кораби, но съществуват кораби със същото име като тяхното.
SELECT *
FROM SHIPS FULL JOIN CLASSES ON SHIPS.CLASS=CLASSES.CLASS
WHERE CLASSES.CLASS IN (SELECT NAME FROM SHIPS) OR CLASSES.CLASS IS NOT NULL;

--3. За всяка страна изведете имената на корабите, които никога не са
--участвали в битка.
SELECT CLASSES.COUNTRY,NAME
FROM (ships LEFT JOIN OUTCOMES ON SHIPS.NAME=OUTCOMES.SHIP)
JOIN CLASSES ON CLASSES.CLASS = SHIPS.CLASS
WHERE OUTCOMES.SHIP is null
ORDER BY CLASSES.COUNTRY,NAME;

--4. Намерете имената на всички кораби с поне 7 оръдия, пуснати на вода
--през 1916, но наречете резултатната колона Ship Name
SELECT NAME AS 'Ship Name'
FROM SHIPS LEFT JOIN CLASSES ON SHIPS.CLASS=CLASSES.CLASS
WHERE NUMGUNS>=7 AND LAUNCHED = 1916;

--5. Изведете имената на всички потънали в битка кораби, името и дата на
--провеждане на битките, в които те са потънали. Подредете резултата по
--име на битката.

SELECT SHIP,NAME,DATE
FROM BATTLES JOIN OUTCOMES ON BATTLES.NAME=OUTCOMES.BATTLE
WHERE RESULT ='sunk'
ORDER BY NAME;

--6. Намерете името, водоизместимостта и годината на пускане на вода на
--всички кораби, които имат същото име като техния клас.
SELECT NAME,DISPLACEMENT,LAUNCHED
FROM SHIPS JOIN CLASSES ON SHIPS.CLASS = CLASSES.CLASS
WHERE NAME = SHIPS.CLASS;

--7. Намерете всички класове кораби, от които няма пуснат на вода нито един
--кораб.

SELECT *
FROM CLASSES LEFT JOIN SHIPS ON CLASSES.CLASS=SHIPS.CLASS
WHERE SHIPS.CLASS is null;

--8. Изведете името, водоизместимостта и броя оръдия на корабите,
--участвали в битката ‘North Atlantic’, а също и резултата от битката.
SELECT SHIPS.NAME,DISPLACEMENT,NUMGUNS,RESULT
FROM (CLASSES JOIN SHIPS ON CLASSES.CLASS = SHIPS.CLASS)
JOIN (SELECT *
	  FROM OUTCOMES
	  WHERE BATTLE ='North Atlantic') as m ON SHIPS.NAME = m.SHIP;
-- OR
SELECT SHIPS.NAME,DISPLACEMENT,NUMGUNS,RESULT
FROM (CLASSES JOIN SHIPS ON CLASSES.CLASS = SHIPS.CLASS)
	JOIN OUTCOMES ON OUTCOMES.SHIP=SHIPS.NAME
	WHERE BATTLE ='North Atlantic';