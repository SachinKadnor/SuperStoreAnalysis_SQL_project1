CREATE DATABASE Superstore_db

USe Superstore_db

select * From Eachorder

-- Q1.	Establish the relationship between the tables as per the ER diagram.

ALTER TABLE Orders
ALTER COLUMN OrderID Nvarchar(255) NOT NULL

ALTER TABLE Orders
ADD CONSTRAINT pk_orderid PRIMARY KEY (OrderID)

ALTER TABLE EachOrder
ALTER COLUMN OrderID Nvarchar(255) NOT NULL

ALTER TABLE EachOrder
ADD CONSTRAINT fk_orderid FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)

-- Q2.	Split City State Country into 3 individual columns namely ‘City’, ‘State’, ‘Country’.

Select * from orders

ALTER TABLE Orders
ADD City Nvarchar(255),
	State Nvarchar(255),
	Country Nvarchar(255);

UPDATE Orders
SET City = PARSENAME(REPLACE([City State Country], ',' ,'.'), 3),
	State = PARSENAME(REPLACE([City State Country], ',' ,'.'), 2),
	Country = PARSENAME(REPLACE([City State Country], ',' ,'.'), 1);

ALTER TABLE Orders
DROP COLUMN [City State Country]

-- Q3.	Add a new Category Column using the following mapping as per the first 3 characters in the Product Name Column:
		--a.	TEC- Technology
		--b.	OFS – Office Supplies
		--c.	FUR - Furniture

SELECT * FROM EachOrder

ALTER TABLE EachOrder
ADD Category Nvarchar(255)

UPDATE EachOrder
SET Category = CASE WHEN LEFT(ProductName,3) = 'OFS' THEN 'Office Supplies'
					WHEN LEFT(ProductName,3) = 'TEC' THEN 'Technology'
					WHEN LEFT(ProductName,3) = 'FUR' THEN 'Furniture'
				END;


--Q4.	Delete the first 4 characters from the ProductName Column.

 UPDATE EachOrder
 SET ProductName = SUBSTRING(ProductName,5,LEN(ProductName)-4)


 --Q5.	Remove duplicate rows from EachOrderBreakdown table, if all column values are matching

 WITH CTE AS (
 SELECT *, ROW_NUMBER() OVER(PARTITION BY OrderID,ProductName,Discount,Sales,Profit,Quantity,SubCategory,Category
							ORDER BY OrderID) AS rn
FROM EachOrder
)
DELETE FROM CTE
WHERE rn > 1


-- Q6.	Replace blank with NA in OrderPriority Column in OrdersList table

SELECT * FROM Orders

UPDATE Orders
SET OrderPriority = 'NA'
WHERE OrderPriority = '';

----OR

UPDATE Orders
SET OrderPriority = CASE WHEN OrderPriority = '' THEN 'NA'
					END
