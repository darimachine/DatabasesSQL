﻿use pc

--1. Напишете заявка, която извежда всички модели лаптопи, за които се
--предлагат както разновидности с 15" екран, така и с 11" екран.

SELECT model,code,screen
FROM laptop
WHERE screen = 11 OR screen = 15;
--2. Да се изведат различните модели компютри, 
--чиято цена е по-ниска от найевтиния лаптоп, произвеждан от същия производител.

SELECT DISTINCT pc.model
FROM pc JOIN product as p_pc ON pc.model = p_pc.model
WHERE pc.price < ( SELECT MIN(price) as min_price
				FROM laptop JOIN product as p ON laptop.model =p.model
				WHERE p_pc.maker = p.maker);
--3. Един модел компютри може да се предлага в няколко разновидности с
--различна цена. Да се изведат тези модели компютри, чиято средна цена (на
--различните му разновид

SELECT pc.model, AVG(price) as avgprice
FROM pc JOIN product as prod On pc.model=prod.model
GROUP BY pc.model,prod.maker
HAVING AVG(price) < (SELECT MIN(price) FROM laptop JOIN product as p ON
					laptop.model=p.model
					WHERE p.maker = prod.maker);
--4. Напишете заявка, която извежда за всеки компютър код на продукта,
--производител и брой компютри, които имат цена, по-голяма или равна на
--неговата.

SELECT code,maker, (SELECT COUNT(*) FROM pc as pc1 WHERE pc1.price >=pc.price) as num_pc_higher_price
FROM pc JOIN product as p1 ON pc.model=p1.model;
