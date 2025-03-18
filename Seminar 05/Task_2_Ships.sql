--1. �������� ������, ����� ������� ���� �� ��������� ����� ������.
SELECT COUNT(*) as NO_Classes
FROM CLASSES
WHERE type ='bb';

--2. �������� ������, ����� ������� ������� ���� ������ �� ����� ���� ���� �����.
SELECT class, AVG(NUMGUNS) as avgGuns
FROM CLASSES
WHERE type='bb'
GROUP BY class;

--3. �������� ������, ����� ������� ������� ���� ������ �� ������ ����� ������.
SELECT AVG(NUMGUNS) as avgGuns
FROM CLASSES;

--4. �������� ������, ����� ������� �� ����� ���� ������� � ���������� ������, �
--����� ����� �� ���������� ���� � ������ �� ����.
SELECT CLASSES.CLASS, MIN(LAUNCHED) as FirstYear, MAX(LAUNCHED) as LastYear
FROM CLASSES join SHIPS ON CLASSES.CLASS=SHIPS.CLASS
GROUP BY CLASSES.CLASS;
--5. �������� ������, ����� ������� ���� �� ��������, �������� � ����� ������
--�����.
SELECT CLASS, COUNT(RESULT) as No_Sunk
FROM SHIPS JOIN OUTCOMES ON SHIPS.NAME=OUTCOMES.SHIP
WHERE RESULT='sunk'
GROUP BY CLASS;
--6. �������� ������, ����� ������� ���� �� ��������, �������� � ����� ������
--�����, �� ���� ������� � ������ �� 2 ������

SELECT CLASS, COUNT(RESULT) as No_Sunk
FROM SHIPS JOIN OUTCOMES ON SHIPS.NAME=OUTCOMES.SHIP
WHERE RESULT='sunk' AND CLASS IN (SELECT CLASS
FROM SHIPS
GROUP BY CLASS
HAVING COUNT(NAME) > 2)
Group BY CLASS;

--7. �������� ������, ����� ������� ������� ������� �� �������� �� �������� ��
--����� ������
SELECT COUNTRY,CONVERT(DECIMAL(8,2), AVG(BORE)) as avg_bore
FROM CLASSES JOIN SHIPS ON CLASSES.CLASS=SHIPS.CLASS
GROUP BY COUNTRY;
