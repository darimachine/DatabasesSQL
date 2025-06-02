CREATE database FurnitureCompany;
use FurnitureCompany;

create table product(
Product_ID int PRIMARY KEY,
Product_Description varchar(200),
Product_Finish varchar(50) CHECK(Product_Finish IN ('череша', 'естествен ясен','бял ясен','червен дъб','естествен дъб','орех')),
Standard_Price DECIMAL(10,2),
Product_Line_ID INT NOT NULL
)
drop table product;

create table Customer(
Customer_ID int PRIMARY KEY IDENTITY(1,1),
Customer_Name varchar(200),
Customer_address varchar(200),
Customer_City varchar(200),
City_Code varchar(10)
)
--drop table Customer;
create table Order_T(
Order_ID int primary key,
Order_Date date not null,
Customer_ID int,
Constraint fk_ime FOREIGN KEY(Customer_ID) References Customer(Customer_ID) 
ON DELEtE CASCADE
ON UPDATE CASCADE
)
--drop table Order_T;
create table ORDER_LINE(
Order_ID int,
Product_ID int,
Ordered_Quantity int CHECK(Ordered_Quantity>0),
FOREIGN KEY(Order_ID) REFERENCES Order_T(Order_ID) 
ON DELEtE CASCADE
ON UPDATE CASCADE,
FOREIGN KEY(Product_ID) REFERENCES Product(Product_ID)
ON DELEtE CASCADE
ON UPDATE CASCADE
)
--drop table ORDER_LINE;

insert into CUSTOMER values
('Иван Петров', 'ул. Лавеле 8', 'София', '1000'),
('Камелия Янева', 'ул. Иван Шишман 3', 'Бургас', '8000'),
('Васил Димитров', 'ул. Абаджийска 87', 'Пловдив', '4000'),
('Ани Милева', 'бул. Владислав Варненчик 56', 'Варна','9000');

insert into PRODUCT values
(1000, 'офис бюро', 'череша', 195, 10),
(1001, 'директорско бюро', 'червен дъб', 250, 10),
(2000, 'офис стол', 'череша', 75, 20),
(2001, 'директорски стол', 'естествен дъб', 129, 20),
(3000, 'етажерка за книги', 'естествен ясен', 85, 30),
(4000, 'настолна лампа', 'естествен ясен', 35, 40);

insert into ORDER_T values
(100, '2013-01-05', 1),
(101, '2013-12-07', 2),
(102, '2014-10-03', 3),
(103, '2014-10-08', 2),
(104, '2015-10-05', 1),
(105, '2015-10-05', 4),
(106, '2015-10-06', 2),
(107, '2016-01-06', 1);

insert into ORDER_LINE values
(100, 4000, 1),
(101, 1000, 2),
(101, 2000, 2),
(102, 3000, 1),
(102, 2000, 1),
(106, 4000, 1),
(103, 4000, 1),
(104, 4000, 1),
(105, 4000, 1),
(107, 4000, 1);

--Задача 2. Напишете заявка, която извежда id и описание на продукт, както и колко пъти е бил поръчан,
--само за тези продукти, които са били поръчвани.
SELECT p.Product_id,p.Product_description, COUNT(p.Product_ID) as Times_Ordered
FROM product as p JOIN ORDER_LINE as ol ON p.Product_ID = ol.Product_ID
JOIN ORDER_T as ot ON ot.ORDER_ID = ol.ORDER_ID
GROUP BY p.pRODUCT_id,p.Product_description;

--Задача 3. Напишете заявка, която извежда id и описание на продукт, както и поръчано количество, за
--всички продукти
SELECT p.Product_id,p.Product_description, IsNULL(SUM(ol.Ordered_Quantity),0) as Total_Ordered
FROM product as p LEFT JOIN ORDER_LINE as ol ON p.Product_ID = ol.Product_ID
LEFT JOIN ORDER_T as ot ON ot.ORDER_ID = ol.ORDER_ID
GROUP BY p.pRODUCT_id,p.Product_description;

--Задача 4. Напишете заявка, която извежда име на клиента и обща стойност на направените от него
--поръчки, само за клиентите с поръчки.

SELECT c.Customer_Name, SUM(p.Standard_Price)
FROM Customer as c JOIN Order_T as ot ON c.Customer_ID = ot.Customer_id
JOIN ORDER_LINE as ol on ol.Order_ID = ot.ORDER_ID
JOIN Product as p ON p.Product_id = ol.Product_ID
GROUP BY c.Customer_Name;