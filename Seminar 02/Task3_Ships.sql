
--Напишете заявка, която извежда името на корабите с водоизместимост над
--50000.
SELECT *
FROM SHIPS INNER JOIN CLASSES ON SHIPS.CLASS=CLASSES.CLASS
WHERE DISPLACEMENT>50000;

SELECT *
FROM SHIPS,CLASSES
WHERE DISPLACEMENT>50000 AND SHIPS.CLASS=CLASSES.CLASS;

--Напишете заявка, която извежда имената, водоизместимостта и броя оръдия на
--всички кораби, участвали в битката при Guadalcanal.
SELECT NAME,DISPLACEMENT,NUMGUNS
FROM SHIPS INNER JOIN OUTCOMES ON SHIPS.NAME=OUTCOMES.SHIP
INNER JOIN CLASSES ON SHIPS.CLASS=CLASSES.CLASS
WHERE OUTCOMES.BATTLE='Guadalcanal';

--Напишете заявка, която извежда имената на тези държави, които имат както
--бойни кораби, така и бойни крайцери.
SELECT COUNTRY
FROM CLASSES
WHERE TYPE = 'bb'

INTERSECT

SELECT Country
FROM CLASSES
WHERE TYPE = 'bc';
-- Variant 2
SELECT COUNTRY
FROM CLASSES
WHERE Type IN('bb','bc')
GROUP BY COUNTRY
HAVING COUNT(DISTINCT TYPE) =2;
--Напишете заявка, която извежда имената на тези кораби, които са били
--повредени в една битка, но по-късно са участвали в друга битка.
SELECT o1.SHIP
FROM outcomes AS o1
JOIN outcomes AS o2 
ON o1.ship = o2.ship
WHERE o1.RESULT='damaged' AND o2.RESULT='ok'
AND o1.BATTLE !=o2.BATTLE;

SELECT *
FROM CLASSES;

SELECT *
FROM SHIPS;

SELECT *
FROM SHIPS INNER JOIN CLASSES ON SHIPS.CLASS = CLASSES.CLASS;