
--Premiere Products Pg 191
DROP TABLE NONAPPLIANCE;
CREATE TABLE NONAPPLIANCE
(PART_NUM CHAR(4) PRIMARY KEY NOT NULL,
DESCRIPTION CHAR(15),
ON_HAND DECIMAL(4,0),
CLASS CHAR(2),
PRICE DECIMAL(6,2)
);
EXEC SP_COLUMNS NONAPPLIANCE;
 
INSERT INTO NONAPPLIANCE
SELECT PART_NUM, DESCRIPTION, ON_HAND, CLASS, PRICE
FROM PART
WHERE CLASS <> 'AP';

UPDATE NONAPPLIANCE
SET DESCRIPTION = 'Steam Iron'
WHERE PART_NUM = 'AT94';

UPDATE NONAPPLIANCE
SET PRICE = (PRICE * 1.03)
WHERE CLASS = 'SG';

INSERT INTO NONAPPLIANCE
VALUES ('TL92','Edge Trimmer',11,'HW', 29.95);

DELETE FROM NONAPPLIANCE 
WHERE CLASS = 'SG';

UPDATE NONAPPLIANCE
SET CLASS = NULL
WHERE PART_NUM = 'FD21';

ALTER TABLE NONAPPLIANCE
ADD ON_HAND_VALUE DECIMAL (7,2);

UPDATE NONAPPLIANCE
SET ON_HAND_VALUE = ON_HAND * PRICE;

ALTER TABLE NONAPPLIANCE
ALTER COLUMN DESCRIPTION CHAR(30);

EXEC SP_COLUMNS NONAPPLIANCE

DROP TABLE NONAPPLIANCE;
--228
--1(a)
CREATE VIEW MAJOR_CUSTOMER AS 
SELECT CUSTOMER_NUM, CUSTOMER_NAME, BALANCE, CREDIT_LIMIT, REP_NUM
FROM CUSTOMER;

--1(b)
SELECT CUSTOMER_NUM,CUSTOMER_NAME
FROM MAJOR_CUSTOMER
WHERE BALANCE > CREDIT_LIMIT;

--1(c)
SELECT CUSTOMER_NUM, CUSTOMER_NAME
FROM CUSTOMER
WHERE CUSTOMER.BALANCE > CUSTOMER.CREDIT_LIMIT;

--2(a)
CREATE VIEW PART_ORDER AS
SELECT ORDER_LINE.PART_NUM, DESCRIPTION, PRICE, ORDER_LINE.ORDER_NUM, ORDER_DATE, NUM_ORDERED,  QUOTED_PRICE
FROM PART, ORDERS, ORDER_LINE
WHERE ORDER_LINE.ORDER_NUM = ORDERS.ORDER_NUM AND
ORDER_LINE.PART_NUM = PART.PART_NUM;

--2(b)
SELECT PART_NUM, DESCRIPTION, ORDER_NUM, QUOTED_PRICE
FROM PART_ORDER
WHERE QUOTED_PRICE > 100;

--2(c)
SELECT ORDER_LINE.PART_NUM, DESCRIPTION, ORDER_NUM, QUOTED_PRICE
FROM PART, ORDER_LINE
WHERE ORDER_LINE.PART_NUM = PART.PART_NUM AND
QUOTED_PRICE > 100; 

--3(a)
CREATE VIEW ORDER_TOTAL AS
SELECT ORDER_NUM, SUM(NUM_ORDERED * QUOTED_PRICE) AS TOTAL_AMOUNT
FROM ORDER_LINE
GROUP BY ORDER_NUM;

--3(b)
SELECT ORDER_NUM, TOTAL_AMOUNT
FROM ORDER_TOTAL 
WHERE TOTAL_AMOUNT > 1000;

--3(c)
SELECT ORDER_NUM, SUM(NUM_ORDERED * QUOTED_PRICE) AS TOTAL_AMOUNT
FROM ORDER_LINE
WHERE TOTAL_AMOUNT > 1000;

--6(a)
CREATE INDEX PART_INDEX1 ON ORDER_LINE(PART_NUM);

--6(b)
CREATE INDEX PART_INDEX2  ON PART(CLASS);

--6(c)
CREATE INDEX PART_INDEX3 ON PART(CLASS, WAREHOUSE);

--6(d)
CREATE INDEX PART_INDEX4 ON PART(CLASS DESC, WAREHOUSE)

--7
DROP INDEX PART_INDEX3 ON PART;

--10
SELECT CUSTOMER_NUM, CUSTOMER_NAME, CREDIT_LIMIT
FROM CUSTOMER
WHERE CREDIT_LIMIT IN (5000,7500,10000,15000)
ORDER BY CREDIT_LIMIT;