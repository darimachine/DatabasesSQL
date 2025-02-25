--Example 1
SELECT maker,speed
FROM product JOIN laptop ON product.model=laptop.model
WHERE hd >9;



--. Напишете заявка, която извежда модел и цена на продуктите, произведени от
--производител с име B.
SELECT laptop.model, laptop.price
FROM laptop JOIN product ON laptop.model = product.model
WHERE maker='B'
UNION
SELECT pc.model,price
FROM pc JOIN product ON pc.model=product.model
WHERE product.maker='B'
UNION
SELECT printer.model,price
FROM printer JOIN product ON printer.model=product.model
WHERE product.maker='B';

--Напишете заявка, която извежда производителите, които произвеждат лаптопи,
--но не произвеждат персонални компютри.
SELECT maker
FROM product JOIN laptop ON laptop.model= product.model

EXCEPT

SELECT maker
FROM product JOIN pc ON product.model = pc.model;

SELECT *
FROM product;


SELECT hd
FROM PC
GROUP BY hd
HAVING COUNT(DISTINCT code)>=2;


SELECT pc1.model,pc2.model
FROM PC as pc1 JOIN pc as pc2 ON (pc1.speed = pc2.speed AND pc1.ram = pc2.ram)
WHERE pc1.model < pc2.model;

SELECT maker
FROM product JOIN pc ON product.model=pc.model
WHERE speed>400
GROUP By maker
HAVING COUNT(DISTINCT code) >=2;
