use FLIGHTS;


--1. Добавете нова колона num_pass към таблицата Flights, която ще съдържа броя на
--пътниците, потвърдили резервация за съответния полет.
ALTER TABLE Flights
ADD num_pass int DEFAULT 0 check(num_pass>=0) NOT NULL;

--2. Добавете нова колона num_book към таблицата Agencies, която ще съдържа броя на
--резервациите към съответната агенция.

ALTER TABLE Agencies
ADD num_book int DEFAULT 0 check(num_book>=0) NOT NULL;

SELECT * FROM Agencies;
SELECT * FROM BOOKINGS;
SELECT * FROM FLIGHTS;

--3. Създайте тригер за таблицата Bookings, който да се задейства при вмъкване на
--резервация в таблицата и да увеличава с единица броя на пътниците, потвърдили
--резервация за таблицата Flights, както и броя на резервациите към съответната агенция
CREATE TRIGGER BookingInsertTrig ON Bookings
AFTER INSERT AS
BEGIN
UPDATE Flights
SET num_pass = num_pass+1
WHERE Flights.FNUMBER IN (SELECT inserted.FLIGHT_NUMBER FROM inserted);
UPDATE AGENCIES
SET num_book = num_book +1
WHERE AGENCIES.NAME IN (SELECT inserted.AGENCY FROM inserted);
END;

-- 4. Създайте тригер за таблицата Bookings, който да се задейства при изтриване на
--резервация в таблицата и да намалява с единица броя на пътниците, потвърдили
--резервация за таблицата Flights, както и броя на резервациите към съответната агенция
CREATE TRIGGER delTRigger ON Bookings
AFTER DELETE AS
BEGIN
UPDATE FLIGHTS
SET num_pass = num_pass -1
WHERE FLIGHTS.FNUMBER IN (SELECT deleted.FLIGHT_NUMBER FROM deleted);

UPDATE AGENCIES
SET num_book = num_book-1
WHERE AGENCIES.NAME IN (SELECT deleted.AGENCY FROM deleted);
END;

SELECT * FROM FLIGHTS;
SELECT * FROM BOOKINGS;
--5. Създайте тригер за таблицата Bookings, който да се задейства при обновяване на
--резервация в таблицата и да увеличава или намалява с единица броя на пътниците,
--потвърдили резервация за таблицата Flights при промяна на статуса на резервацията.
create trigger UpdateBooking ON Bookings
AFTER UPDATE  AS
BEGIN
UPDATE FLIGHTS
SET num_pass = num_pass +1
WHERE FLIGHTS.FNUMBER IN (SELECT i.FLIGHT_NUMBER FROM 
inserted as i JOIN deleted as d ON i.FLIGHT_NUMBER = d.FLIGHT_NUMBER 
WHERE i.STATUS=1 and d.STATUS=0);

UPDATE FLIGHTS
SET num_pass = num_pass - 1
WHERE FLIGHTS.FNUMBER IN (SELECT i.FLIGHT_NUMBER FROM 
inserted as i JOIN deleted as d ON i.FLIGHT_NUMBER = d.FLIGHT_NUMBER 
WHERE i.STATUS=0 and d.STATUS=1);

END;