
--1. Напишете заявка, която извежда
--средната честота на персоналните компютри
SELECT Convert(DECIMAL(16,2),AVG(speed)) as AvgSpeed
FROM pc;

--2. Напишете заявка, която извежда средния размер на екраните на лаптопите за
--всеки производител.SELECT maker,AVG(screen) as AvgScreenFROM product JOIN laptop ON product.model=laptop.modelGROUP BY maker;--3. Напишете заявка, която извежда средната честота на лаптопите с цена над 1000.SELECT AVG(speed) as AvgSpeedFROM laptopWHERE price>1000;--4. Напишете заявка, която извежда средната цена на персоналните компютри,
--произведени от производител ‘A’.SELECT maker,CONVERT(DECIMAL(16,2),AVG(price)) as AvgPriceFROM product join pc ON product.model = pc.modelWHERE maker='A'GROUP BY maker;--5. Напишете заявка, която извежда средната цена на персоналните компютри и
--лаптопите за производител ‘B’.SELECT maker,AVG(price) as AvgPriceFROM (SELECT model,price	  FROM pc      UNION ALL      SELECT model,price      FROM laptop) as priceTable JOIN 	  product ON product.model=priceTable.modelWHERE maker='B'GROUP By maker;--6. Напишете заявка, която извежда средната цена на персоналните компютри
--според различните им честоти.SELECT speed, AVG(price) as AvgPriceFROM pcGROUP BY speed;--7. Напишете заявка, която извежда производителите, които са произвели поне 3
--различни персонални компютъра (с различен код).
SELECT maker,COUNT(code) as number_of_pc
FROM product join pc ON product.model = pc.model
GROUP BY maker
HAVING COUNT(DISTINCT code) >=3;
--8. Напишете заявка, която извежда производителите с най-висока цена на
--персонален компютър
SELECT maker, price
FROM product join pc ON pc.model=product.model
WHERE price = (SELECT MAX(price) FROM pc);

--9. Напишете заявка, която извежда средната цена на персоналните компютри за
--всяка честота по-голяма от 800.SELECT speed, AVG(price) as AvgPriceFROM pcGROUP by speedHAVING speed>800;--10.Напишете заявка, която извежда средния размер на диска на тези персонални
--компютри, произведени от производители, които произвеждат и принтери.
--Резултатът да се изведе за всеки отделен производител.


SELECT maker, CONVERT(DECIMAL(8,2) ,AVG(hd)) as AvgHDD
FROM product JOIN pc ON product.model=pc.model
WHERE maker in (SELECT maker
FROM product
WHERE type ='printer'
INTERSECT
SELECT maker
FROM product
WHERE type = 'pc')
GROUP BY maker;
