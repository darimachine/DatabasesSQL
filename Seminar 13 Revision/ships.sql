use ships;

--Задача 8. Съставете изгледи, съдържащи имената на битките, които са по-мащабни от битката при
--Guadalcanal. Под по-мащабна битка се разбира:
--a) битка с повече участващи кораби;
--b) битка с повече участващи страни.
--Като използвате изгледите, напишете заявки, които извеждат съответните битки
--a)
CREATE VIEW biggerBattleThanGuadalcanal
as
SELECT BATTLE FROM OUTCOMES
GROUP by BATTLE
HAVING COUNT(SHIP) > (SELECT COUNT(SHIP) as shipContains FROM OUTCOMES
WHERE BATTLE = 'Guadalcanal'
GROUP by BATTLE);

SELECT * FROM biggerBattleThanGuadalcanal;
--b)
CREATE VIEW biggerBattleThanGuadalcanalCountry
as
SELECT BATTLE FROM CLASSES
JOIN SHIPS ON CLASSES.CLASS=SHIPS.CLASS
JOIN OUTCOMES ON SHIPS.NAME = OUTCOMES.SHIP
GROUP BY BATTLE
HAVING COUNT(COUNTRY) > (SELECT COUNT(COUNTRY) as country FROM CLASSES
JOIN SHIPS ON CLASSES.CLASS=SHIPS.CLASS
JOIN OUTCOMES ON SHIPS.NAME = OUTCOMES.SHIP
WHERE BATTLE='Guadalcanal'
GROUP BY BATTLE);

SELECT * FROM biggerBattleThanGuadalcanalCountry;

--Задача 9. Изтрийте от таблицата Outcomes всички битки, в които е участвал един единствен кораб.

DELETE FROM OUTCOMES
WHERE OUTCOMES.SHIP IN
(SELECT SHIP FROM OUTCOMES
GROUP BY SHIP
HAVING COUNT(BATTLE)=1);

SELECT * FROM OUTCOMES;

--Задача 10. Изтрийте от таблицата Outcomes всички записи, в които участва кораб, потапян поне два
--пъти и резултатът от съответната битка е 'sunk'.
--Забележка: Преди това може да вмъкнете следните кортежи, за да проверите по-лесно как работи
--написаната заявка.
DELETE FROM OUTCOMES
WHERE SHIP IN (SELECT ship FROM OUTCOMES
WHERE result = 'sunk'
GROUP BY OUTCOMES.SHIP
HAVING COUNT(result) >= 2);

--Задача 11. Изведете всички битки, в които са участвали същите страни, като страните в битката при
--Guadalcanal.
--Възможен вариант за решаване: Създайте изглед, съдържащ всички битки и участващите в тях
--страни. След това напишете заявка, като използвате и изгледа.

create view countriesInGuadalCanal as
(SELECT DISTINCT COUNTRY
FROM OUTCOMES JOIN SHIPS as s ON OUTCOMES.SHIP=s.NAME
JOIN CLASSES as c ON c.CLASS=s.CLASS
WHERE BATTLE = 'Guadalcanal');

SELECT DISTINCT BATTLE
FROM OUTCOMES JOIN SHIPS as s ON OUTCOMES.SHIP=s.NAME
JOIN CLASSES as c ON c.CLASS=s.CLASS
WHERE COUNTRY IN (SELECT COUNTRY FROM countriesInGuadalCanal);

--Задача 12. Намерете всяка страна в колко битки е участвала.
--Забележка: Ако страната не е участвала в нито една битка (защото (а) няма кораби или (б) има
--кораби, но те не са участвали в битка), то трябва да се покаже в резултата с брой кораби 0.

SELECT COUNTRY,COUNT(BATTLE) as num_battles
FROM CLASSES as c LEFT JOIN SHIPS as s  ON c.CLASS = s.CLASS 
LEFT JOIN OUTCOMES as o ON s.NAME=o.SHIP
GROUP BY COUNTRY;

