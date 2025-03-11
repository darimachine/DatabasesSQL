--1. Напишете заявка, която извежда производител, модел и тип на продукт
--за тези производители, за които съответният продукт не се продава
--(няма го в таблиците PC, Laptop или Printer)
SELECT maker,product.model,product.type
FROM product LEFT JOIN 
(SELECT model
FROM pc
union
SELECT model
FROM laptop
UNION
SELECT model
FROM printer) as models ON product.model = models.model
WHERE models.model is null;

--2. Намерете всички производители, които правят както лаптопи, така и
--принтери.
SELECT maker
FROM product
WHERE type = 'laptop'
INTERSECT
SELECT maker
FROM product
WHERE type = 'printer';

--3. Намерете размерите на тези твърди дискове, които се появяват в два
--или повече модела лаптопи.
SELECT hd
FROM laptop
GROUP BY hd
HAVING COUNT(hd) >= 2;

--4. Намерете всички модели персонални компютри, които нямат регистриран
--производител.

SELECT *
FROM pc LEFT JOIN product ON product.model=pc.model
WHERE product.model is null;
