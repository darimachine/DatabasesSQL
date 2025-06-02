use ships;

--������ 8. ��������� �������, ��������� ������� �� �������, ����� �� ��-������� �� ������� ���
--Guadalcanal. ��� ��-������� ����� �� �������:
--a) ����� � ������ ��������� ������;
--b) ����� � ������ ��������� ������.
--���� ���������� ���������, �������� ������, ����� �������� ����������� �����
--a)
CREATE VIEW biggerBattleThanGuadalcanal
as
SELECT BATTLE FROM OUTCOMES
GROUP by BATTLE
HAVING COUNT(SHIP) > (SELECT COUNT(SHIP) as shipContains FROM OUTCOMES
WHERE BATTLE = 'Guadalcanal'
GROUP by BATTLE);

SELECT * FROM biggerBattleThanGuadalcanal;
--b)
CREATE VIEW biggerBattleThanGuadalcanalCountry
as
SELECT BATTLE FROM CLASSES
JOIN SHIPS ON CLASSES.CLASS=SHIPS.CLASS
JOIN OUTCOMES ON SHIPS.NAME = OUTCOMES.SHIP
GROUP BY BATTLE
HAVING COUNT(COUNTRY) > (SELECT COUNT(COUNTRY) as country FROM CLASSES
JOIN SHIPS ON CLASSES.CLASS=SHIPS.CLASS
JOIN OUTCOMES ON SHIPS.NAME = OUTCOMES.SHIP
WHERE BATTLE='Guadalcanal'
GROUP BY BATTLE);

SELECT * FROM biggerBattleThanGuadalcanalCountry;

--������ 9. �������� �� ��������� Outcomes ������ �����, � ����� � �������� ���� ��������� �����.

DELETE FROM OUTCOMES
WHERE OUTCOMES.SHIP IN
(SELECT SHIP FROM OUTCOMES
GROUP BY SHIP
HAVING COUNT(BATTLE)=1);

SELECT * FROM OUTCOMES;

--������ 10. �������� �� ��������� Outcomes ������ ������, � ����� ������� �����, ������� ���� ���
--���� � ���������� �� ����������� ����� � 'sunk'.
--���������: ����� ���� ���� �� �������� �������� �������, �� �� ��������� ��-����� ��� ������
--���������� ������.
DELETE FROM OUTCOMES
WHERE SHIP IN (SELECT ship FROM OUTCOMES
WHERE result = 'sunk'
GROUP BY OUTCOMES.SHIP
HAVING COUNT(result) >= 2);

--������ 11. �������� ������ �����, � ����� �� ��������� ������ ������, ���� �������� � ������� ���
--Guadalcanal.
--�������� ������� �� ��������: �������� ������, �������� ������ ����� � ����������� � ���
--������. ���� ���� �������� ������, ���� ���������� � �������.

create view countriesInGuadalCanal as
(SELECT DISTINCT COUNTRY
FROM OUTCOMES JOIN SHIPS as s ON OUTCOMES.SHIP=s.NAME
JOIN CLASSES as c ON c.CLASS=s.CLASS
WHERE BATTLE = 'Guadalcanal');

SELECT DISTINCT BATTLE
FROM OUTCOMES JOIN SHIPS as s ON OUTCOMES.SHIP=s.NAME
JOIN CLASSES as c ON c.CLASS=s.CLASS
WHERE COUNTRY IN (SELECT COUNTRY FROM countriesInGuadalCanal);

--������ 12. �������� ����� ������ � ����� ����� � ���������.
--���������: ��� �������� �� � ��������� � ���� ���� ����� (������ (�) ���� ������ ��� (�) ���
--������, �� �� �� �� ��������� � �����), �� ������ �� �� ������ � ��������� � ���� ������ 0.

SELECT COUNTRY,COUNT(BATTLE) as num_battles
FROM CLASSES as c LEFT JOIN SHIPS as s  ON c.CLASS = s.CLASS 
LEFT JOIN OUTCOMES as o ON s.NAME=o.SHIP
GROUP BY COUNTRY;

