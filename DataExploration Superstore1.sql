--Beginner

--1.	List the top 10 orders with the highest sales from the EachOrderBreakdown table.

SELECT top 10 * FROM EachOrder
ORDER BY Sales DESC


--2.	Show the number of orders for each product category in the EachOrderBreakdown table.

SELECT Category, COUNT(*) AS NumberofOrders
FROM EachOrder
GROUP BY Category


--3.	Find the total profit for each sub-category in the EachOrderBreakdown table.

SELECT SubCategory, SUM(Profit) AS TotalProfit
FROM EachOrder
GROUP BY SubCategory

SELECT * FROM EachOrder

-------Intermediate

--1.	Identify the customer with the highest total sales across all orders.

SELECT * FROM Orders

SELECT * FROM EachOrder

SELECT TOP 1 CustomerName, SUM(Sales) AS TotalSale
FROM Orders o
JOIN EachOrder e
ON o.OrderID = e.OrderID
GROUP BY CustomerName
ORDER BY TotalSale DESC


--2.	Find the month with the highest average sales in the OrdersList table.

SELECT TOP 1 Month(OrderDate) AS Month, AVG(Sales) AS AvgSale
FROM Orders o
JOIN EachOrder e
ON o.OrderID = e.OrderID
GROUP BY Month(OrderDate)
ORDER BY AvgSale DESC


--3.	Find out the average quantity ordered by customers whose first name starts with an alphabet 's'?

SELECT AVG(Quantity) AS AvgQuantity
FROM Orders o
JOIN EachOrder e
ON o.OrderID = e.OrderID
WHERE LEFT(CustomerName,1) = 'S'


-----Advanced

--1.	Find out how many new customers were acquired in the year 2014?

SELECT COUNT(*) AS NumberofCustomers FROM (
SELECT CustomerName,MIN(OrderDate) AS FirstOrderDate
FROM Orders
GROUP BY CustomerName
HAVING YEAR(MIN(OrderDate)) = '2014') AS NewCustomersIn2014

--2.	Calculate the percentage of total profit contributed by each sub-category to the overall profit.

SELECT SubCategory, SUM(Profit) AS SubCategoryProfit,
SUM(Profit) / (SELECT SUM(Profit) FROM EachOrder) * 100 AS PercentageofTotalContribution
FROM EachOrder
GROUP BY SubCategory

----SELECT SUM(Profit) AS totalprofit
----FROM EachOrder

--3.	Find the average sales per customer, considering only customers who have made more than one order.

WITH CustomerAvgSales AS(
SELECT CustomerName, COUNT(DISTINCT O.ORDERID) AS NumberofOrders, AVG(SALES) AS Avgsale
FROM Orders	o
JOIN EachOrder e
ON o.OrderID = e.OrderID
GROUP BY CustomerName
)
SELECT CustomerName, Avgsale,NumberofOrders
FROM CustomerAvgSales
WHERE NumberofOrders > 10


--4.Identify the top-performing subcategory in each category based on total sales. Include the sub- category name, total sales, and a ranking of sub-category within each category.
