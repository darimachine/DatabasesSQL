--1. Напишете заявка, която извежда производителите на персонални
--компютри с честота над 500.
SELECT *
FROM product
WHERE model IN (SELECT model FROM pc WHERE speed>500);

--2. Напишете заявка, която извежда код, модел 
--и цена на принтерите с най-висока цена.

SELECT code,model,price
FROM printer
WHERE price >= ALL(SELECT price FROM printer);
-- ИЛИ
SELECT code,model,price
FROM printer
WHERE price = ALL(SELECT MAX(price) FROM printer);

--3. Напишете заявка, която извежда лаптопите, чиято честота е по-ниска от
--честотата на всички персонални компютри.
SELECT *
FROM laptop
WHERE speed < ALL(SELECT speed From pc);

-- ИЛИ ТОВА С MIN()
SELECT *
FROM laptop
WHERE speed < (SELECT MIN(speed) From pc);

--4. Напишете заявка, която извежда модела и цената на продукта (PC,
--лаптоп или принтер) с най-висока цена.
SELECT model,price
FROM (SELECT model,price FROM pc 
UNION SELECT model,price FROM laptop
UNION SELECT model,price FROM printer) as allTable
WHERE price >= ALL(SELECT price FROM pc 
UNION SELECT price FROM laptop
UNION SELECT price FROM printer);

--5. Напишете заявка, която извежда производителя на цветния принтер с
--най-ниска цена.
SELECT maker
FROM product JOIN printer ON product.model = printer.model
WHERE color ='y' AND price <= ALL(SELECT price FROM printer WHERE color='y');

--6. Напишете заявка, която извежда производителите на тези персонални
--компютри с най-малко RAM памет, които имат най-бързи процесори.
SELECT *
FROM product JOIN (SELECT * FROM pc WHERE ram <= ALL(SELECT ram FROM pc)) as pc1 
ON product.model = pc1.model
WHERE speed >= ALL(SELECT speed FROM pc WHERE ram <= ALL(SELECT ram FROM pc));

