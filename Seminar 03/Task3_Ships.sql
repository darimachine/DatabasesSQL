--1. Напишете заявка, която извежда страните, чиито кораби са с най-голям
--брой оръдия.
SELECT DISTINCT COUNTRY 
FROM CLASSES
WHERE NUMGUNS >= (SELECT MAX(NUMGUNS) FROM CLASSES);

--2. Напишете заявка, която извежда класовете, за които поне един от
--корабите е потънал в битка
SELECT DISTINCT SHIPS.CLASS
FROM SHIPS JOIN OUTCOMES ON SHIPS.NAME=OUTCOMES.SHIP
WHERE OUTCOMES.RESULT='sunk';

--3. Напишете заявка, която извежда името и класа на корабите с 16 инчови
--оръдия.
SELECT NAME, CLASS
FROM SHIPS
WHERE CLASS IN (SELECT CLASS FROM CLASSES WHERE BORE=16);

--4. Напишете заявка, която извежда имената на битките, в които са
--участвали кораби от клас ‘Kongo’.
SELECT BATTLE
FROM OUTCOMES JOIN SHIPS ON OUTCOMES.SHIP=SHIPS.NAME
WHERE CLASS = 'Kongo';
-- OR
SELECT BATTLE
FROM OUTCOMES
WHERE SHIP IN (SELECT NAME FROM SHIPS WHERE CLASS='Kongo');

--5. Напишете заявка, която извежда класа и името на корабите, чиито брой
--оръдия е по-голям или равен на този на корабите със същия калибър
--оръдия
SELECT s.CLASS,s.NAME
FROM SHIPS as s 
JOIN CLASSES as c 
ON s.CLASS = c.CLASS
WHERE c.NUMGUNS >= ALL(SELECT NUMGUNS FROM CLASSES as c1 WHERE c.BORE = c1.BORE)
ORDER BY s.CLASS;