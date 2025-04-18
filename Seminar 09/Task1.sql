
--Задача 1
--а) Дефинирайте следните релации:
--Product (maker, model, type), където:
-- модел е низ от точно 4 символа,
-- производител е низ от точно 1 символ,
-- тип е низ до 7 символа;
--Printer (code, model, price), където:
-- код е цяло число,
-- модел е низ от точно 4 символа,
-- цена с точност до два знака след десетичната запетая;
--б) Добавете кортежи с примерни данни към новосъздадените релации.
--в) Добавете към релацията Printer атрибути:
-- type - низ до 6 символа (забележка: type може да приема
--стойност 'laser', 'matrix' или 'jet'),
-- color - низ от точно 1 символ, стойност по подразбиране 'n'
--(забележка: color може да приема стойност 'y' или 'n').
--г) Напишете заявка, която премахва атрибута price от релацията Printer.
--д) Изтрийте релациите, които сте създали в Задача 1.
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