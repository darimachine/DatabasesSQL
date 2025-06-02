use pc;

--5. �� �� ������ ������, ����� ������� ��������������� ����� �� ��������, ���� � �� �������.
--���������: ���������� 2 �������� �� �������� �� �������� - � ��������� � ��� ����������.
SELECT maker
FROM product
WHERE type='laptop'
INTERSECT
SELECT maker
FROM product
WHERE type='printer';

--������ 6. �������� � 5% ������ �� ����� ���������� ��������, ����� ���� �������������,
--������ �� �������� ���� �� ����������� �� ��� �������� � ��� 800.

UPDATE pc
SET pc.price=pc.price*0.95
WHERE pc.model IN (SELECT p.model FROM pc as p 
JOIN product ON p.model=product.model
WHERE product.maker IN (SELECT product.maker
FROM printer JOIN Product ON printer.model = product.model
GROUP BY product.maker
HAVING AVG(price) > 300)
);

--������ 7. �������� �� ����� ������ �� ����� ���� �� ���������� �������� ����� 10 � 30 GB, ���������� ���� �� ���������� ������.
SELECT hd, MIN(pc.price) as min_price
FROM pc
WHERE hd>=10 and hd <=30
GROUP BY hd;