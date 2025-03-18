
--1. �������� ������, ����� �������
--�������� ������� �� ������������ ��������
SELECT Convert(DECIMAL(16,2),AVG(speed)) as AvgSpeed
FROM pc;

--2. �������� ������, ����� ������� ������� ������ �� �������� �� ��������� ��
--����� ������������.SELECT maker,AVG(screen) as AvgScreenFROM product JOIN laptop ON product.model=laptop.modelGROUP BY maker;--3. �������� ������, ����� ������� �������� ������� �� ��������� � ���� ��� 1000.SELECT AVG(speed) as AvgSpeedFROM laptopWHERE price>1000;--4. �������� ������, ����� ������� �������� ���� �� ������������ ��������,
--����������� �� ������������ �A�.SELECT maker,CONVERT(DECIMAL(16,2),AVG(price)) as AvgPriceFROM product join pc ON product.model = pc.modelWHERE maker='A'GROUP BY maker;--5. �������� ������, ����� ������� �������� ���� �� ������������ �������� �
--��������� �� ������������ �B�.SELECT maker,AVG(price) as AvgPriceFROM (SELECT model,price	  FROM pc      UNION ALL      SELECT model,price      FROM laptop) as priceTable JOIN 	  product ON product.model=priceTable.modelWHERE maker='B'GROUP By maker;--6. �������� ������, ����� ������� �������� ���� �� ������������ ��������
--������ ���������� �� �������.SELECT speed, AVG(price) as AvgPriceFROM pcGROUP BY speed;--7. �������� ������, ����� ������� ���������������, ����� �� ��������� ���� 3
--�������� ���������� ��������� (� �������� ���).
SELECT maker,COUNT(code) as number_of_pc
FROM product join pc ON product.model = pc.model
GROUP BY maker
HAVING COUNT(DISTINCT code) >=3;
--8. �������� ������, ����� ������� ��������������� � ���-������ ���� ��
--���������� ��������
SELECT maker, price
FROM product join pc ON pc.model=product.model
WHERE price = (SELECT MAX(price) FROM pc);

--9. �������� ������, ����� ������� �������� ���� �� ������������ �������� ��
--����� ������� ��-������ �� 800.SELECT speed, AVG(price) as AvgPriceFROM pcGROUP by speedHAVING speed>800;--10.�������� ������, ����� ������� ������� ������ �� ����� �� ���� ����������
--��������, ����������� �� �������������, ����� ����������� � ��������.
--���������� �� �� ������ �� ����� ������� ������������.


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
