

-------question 1----------

CREATE VIEW SALES_INFO1 
AS
SELECT  pp.product_id,pp.product_name,pp.list_price,sot.item_id,sot.quantity,so.order_id,so.staff_id
FROM    sales.order_items  sot 
INNER JOIN sales.orders so
ON sot.order_id = so.order_id 
INNER JOIN production.products pp 
ON sot.product_id = pp.product_id

-------calling view------
select * from SALES_INFO1

---------question 2---------

CREATE VIEW staff_sales 
as 
select SOI.list_price,SOI.quantity,SOI.item_id,SO.customer_id,SO.order_id,SS.staff_id,SUM(QUANTITY * list_price) 'ORDER VALUE'     
from   sales.order_items soi 
INNER JOIN sales.orders SO
ON soi.order_id = SO.order_id
INNER JOIN sales.staffs SS
ON SO.staff_id = SS.staff_id 
GROUP BY SOI.list_price,SOI.quantity,SOI.item_id,SO.customer_id,SO.order_id,SS.staff_id

------CALLING VIEW-----
SELECT * FROM staff_sales


---------QUESTION 3--------

CREATE PROCEDURE USP_ADD_STORE 
@STORENAME VARCHAR (255),
@CITYNAME VARCHAR (255),
@COUNTSTORE INT OUTPUT
AS 
BEGIN 

INSERT INTO SALES.stores (store_name,city) VALUES (@STORENAME,@CITYNAME) 
SELECT @COUNTSTORE = COUNT(store_name)  FROM sales.stores
RETURN @COUNTSTORE
END


-------CALLING STORED PROCEDURE--------

DECLARE @COUNT INT ;
EXEC USP_ADD_STORE
@STORENAME ='NEW STORE',
@CITYNAME ='BERLIN',
@COUNTSTORE = @COUNT OUTPUT
SELECT @COUNT AS 'STORE COUNT'

------DESCRIPTION : SELECT SATEMENT TO CHECK VALUE STORED IN TABLE OR NOT-----

SELECT * FROM SALES.stores
WHERE city='BERLIN'


----------------QUESTION 4-----------


CREATE PROCEDURE USP_STORE_WISE_SALES
AS
BEGIN 

SELECT SS.store_id,SS.store_name,SS.city,COUNT (SO.order_id)
FROM sales.stores SS
INNER JOIN SALES.orders SO
ON SS.store_id=SO.store_id
GROUP BY SS.store_id,SS.store_name,SS.city
ORDER BY SS.store_id


END

--------CALLING SP------

USP_STORE_WISE_SALES


--------QUESTION 5------=--

CREATE FUNCTION UDF_AVG_QTY(

@COUNTYEAR DATETIME OUTPUT
)
AS
BEGIN

SELECT DISTINCT(COUNT (DATENAME(YEAR,SO.order_date)))
FROM SALES.ORDER_ITEMS SOI
INNER JOIN PRODUCTION.PRODUCTS PP
ON SOI.PRODUCT_ID = PP.PRODUCT_ID
INNER JOIN SALES.ORDERS SO
ON SOI.ORDER_ID=SO.order_id
GROUP BY SO.order_date


















