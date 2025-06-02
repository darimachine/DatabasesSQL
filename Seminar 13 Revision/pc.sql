use pc;

--5. Да се напише заявка, която извежда производителите както на принтери, така и на лаптопи.
--Забележка: Предложете 2 варианта за решаване на задачата - с подзаявка и със съединение.
SELECT maker
FROM product
WHERE type='laptop'
INTERSECT
SELECT maker
FROM product
WHERE type='printer';

--Задача 6. Намалете с 5% цената на онези персонални компютри, които имат производители,
--такива че средната цена на продаваните от тях принтери е над 800.

UPDATE pc
SET pc.price=pc.price*0.95
WHERE pc.model IN (SELECT p.model FROM pc as p 
JOIN product ON p.model=product.model
WHERE product.maker IN (SELECT product.maker
FROM printer JOIN Product ON printer.model = product.model
GROUP BY product.maker
HAVING AVG(price) > 300)
);

--Задача 7. Намерете за всеки размер на твърд диск на персонален компютър между 10 и 30 GB, найниската цена за съответния размер.
SELECT hd, MIN(pc.price) as min_price
FROM pc
WHERE hd>=10 and hd <=30
GROUP BY hd;