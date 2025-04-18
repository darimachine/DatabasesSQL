
--������ 1
--�) ����������� �������� �������:
--Product (maker, model, type), ������:
-- ����� � ��� �� ����� 4 �������,
-- ������������ � ��� �� ����� 1 ������,
-- ��� � ��� �� 7 �������;
--Printer (code, model, price), ������:
-- ��� � ���� �����,
-- ����� � ��� �� ����� 4 �������,
-- ���� � ������� �� ��� ����� ���� ����������� �������;
--�) �������� ������� � �������� ����� ��� ��������������� �������.
--�) �������� ��� ��������� Printer ��������:
-- type - ��� �� 6 ������� (���������: type ���� �� ������
--�������� 'laser', 'matrix' ��� 'jet'),
-- color - ��� �� ����� 1 ������, �������� �� ������������ 'n'
--(���������: color ���� �� ������ �������� 'y' ��� 'n').
--�) �������� ������, ����� �������� �������� price �� ��������� Printer.
--�) �������� ���������, ����� ��� ������� � ������ 1.
create database week08
use week08
create table Product(
maker char(1),
model char(4),
type varchar(7)
)
create table Printer(
code int,
model char(4),
price decimal(18,2)
)

INSERT INTO Product
VALUES('A','1234','printer');

INSERT INTO Printer
VALUES(2,'1234',300.21121);



ALTER TABLE Printer
ADD type varchar(6) CHECK (type in ('laser','matrix','jet'));

ALTER TABLE PRINTER
ADD color char(1) NOT NULL DEFAULT 'n' CHECK (color in ('n','y'));

ALTER TABLE PRINTER
DROP COLUMN price;

SELECT * FROM Printer;
SELECT * FROM Product;

drop database week08;