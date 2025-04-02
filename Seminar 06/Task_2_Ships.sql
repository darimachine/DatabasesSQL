--1. �������� ������, ����� ������� ������� �� ������ ������ ��� ����������,
--����� �� ��������� � ���� ���� ����� � ����� ����� �������� � C ��� K.
SELECT DISTINCT SHIP
FROM OUTCOMES
WHERE SHIP LIKE 'C%' OR SHIP LIKE 'K%';

--2. �������� ������, ����� ������� ��� � ������� �� ������ ������, �����
--������ �� �� �������� � ����� (���� � �� �� �� ���������).
SELECT DISTINCT s.NAME, c.COUNTRY
FROM (SHIPS as s LEFT JOIN CLASSES as c ON s.CLASS = c.CLASS) LEFT JOIN OUTCOMES
ON OUTCOMES.SHIP=s.NAME
WHERE OUTCOMES.SHIP is NULL 
OR OUTCOMES.RESULT !='sunk';

--3. �������� ������, ����� ������� ��������� � ���� �� ���������� ������ ��
--���� �������. �������, ����� ����� ������ ��� ���� �����, �� ��� �� �
--�������� � �����, ���� �� ����� ��������.SELECT c1.COUNTRY,COUNT(o.SHIP)FROM (CLASSES as c1 LEFT JOIN SHIPS as s1 ON c1.CLASS=s1.CLASS) LEFT JOIN OUTCOMES as o ON o.SHIP=s1.NAMEWHERE o.RESULT='sunk' or o.RESULT is nullGROUP BY c1.COUNTRY;--4. �������� ������, ����� ������� ��� �� �������, ����� �� ��-������� (�
--������ ��������� ������) �� ������� ��� Guadalcanal.SELECT BATTLEFROM OUTCOMESGROUP BY BATTLEHAVING COUNT(*) > (SELECT COUNT(*)				   FROM OUTCOMES				   WHERE BATTLE = 'Guadalcanal');--5. �������� ������, ����� ������� ��� �� �������, ����� �� ��-������� (�
--������ ��������� ������) �� ������� ��� Surigao Strait.

SELECT BATTLEFROM OUTCOMESGROUP BY BATTLEHAVING COUNT(*) > (SELECT COUNT(*)				   FROM OUTCOMES				   WHERE BATTLE = 'Surigao Strait');--6. �������� ������, ����� ������� ������� �� ���-������ ������ � ���-�����
--������.

SELECT s.NAME,c.DISPLACEMENT,c.NUMGUNS
FROM SHIPS as s JOIN CLASSES as c ON s.CLASS=c.CLASS
WHERE DISPLACEMENT <= ALL(SELECT DISPLACEMENT FROM CLASSES)
AND NUMGUNS >= ALL(SELECT NUMGUNS
FROM SHIPS as s JOIN CLASSES as c ON s.CLASS=c.CLASS
WHERE DISPLACEMENT <= ALL(SELECT DISPLACEMENT FROM CLASSES));

--7. �������� ���� �� ��������, ����� �� ���� �������� � �����, �� �� ����
--��������� � ��-����� �� �������� � ����� �����.
SELECT COUNT(*)
FROM OUTCOMES as o1 JOIN BATTLES as b1 ON o1.BATTLE=b1.NAME
JOIN OUTCOMES as o2 ON o1.SHIP=o2.SHIP
JOIN BATTLES as b2 ON o2.BATTLE = b2.NAME
WHERE o1.RESULT = 'damaged'
AND o2.RESULT = 'ok'
AND b1.DATE < b2.DATE;

--8. �������� ��� �� ��������, ����� �� ���� �������� � �����, �� �� ����
--��������� � ��-����� �� �������� � ��-������� ����� (� ������ ������).

SELECT *
FROM OUTCOMES as o1 JOIN BATTLES as b1 ON o1.BATTLE=b1.NAME
JOIN OUTCOMES as o2 ON o1.SHIP=o2.SHIP
JOIN BATTLES as b2 ON o2.BATTLE = b2.NAME
WHERE o1.RESULT = 'damaged'
AND o2.RESULT = 'ok'
AND b1.DATE < b2.DATE;
	 


	  