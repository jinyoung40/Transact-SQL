-- 1. Retrieve products whose list price is higher than the average unit price
SELECT ProductID, Name, ListPrice
FROM SalesLT.Product
WHERE ListPrice >
(SELECT AVG(UnitPrice) FROM SalesLT.SalesOrderDetail);

-- 2. Retrieve products with a list price of $100 or more that have been sold less than $100
SELECT ProductID, Name, ListPrice
FROM SalesLT.Product
WHERE ProductID IN (SELECT ProductID FROM SalesLT.SalesOrderDetail WHERE UnitPrice <100)
AND ListPrice >=100;

-- 3. Retrieve the cost, list price, and average selling price for each product
SELECT ProductID, Name, ListPrice,
	(SELECT AVG(UnitPrice) FROM SalesLT.SalesOrderDetail od WHERE p.ProductID = od.ProductID) AS AvgSellingPrice
FROM SalesLT.Product p

-- 4. Retrieve products that have an average selling price that is lower than the cost
SELECT ProductID, Name, ListPrice,
	(SELECT AVG(UnitPrice) FROM SalesLT.SalesOrderDetail od WHERE p.ProductID = od.ProductID) AS AvgSellingPrice
FROM SalesLT.Product p
WHERE StandardCost > (SELECT AVG(UnitPrice) FROM SalesLT.SalesOrderDetail od WHERE p.ProductID = od.ProductID) 

-- 5. Retrieve all customer information for all sales order
SELECT oh.SalesOrderID, oh.CustomerID, c.FirstName, c.LastName, oh.TotalDue
FROM SalesLT.SalesOrderHeader oh
INNER JOIN SalesLT.Customer c
ON oh.CustomerID = c.CustomerID
CROSS APPLY dbo.ufnGetCustomerInformation(oh.CustomerID)
