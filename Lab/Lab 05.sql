-- 1. Retrieve the name and approximate weight of each product
SELECT ProductID, UPPER(Name), CAST(ROUND(Weight,0) AS int) AS ApproxWeight
FROM SalesLT.Product;

-- 2. Retrieve the year and month in which products were first sold
SELECT ProductID, UPPER(Name), CAST(ROUND(Weight,0) AS int) AS ApproxWeight, 
		YEAR(SellStartDate) AS SellStartYear, DATENAME(m, SellStartDate) AS SellStartMonth
FROM SalesLT.Product;

-- 3. Extract product type from product number
SELECT ProductID, UPPER(Name), CAST(ROUND(Weight,0) AS int) AS ApproxWeight, YEAR(SellStartDate) AS SellStartYear, 
		DATENAME(m, SellStartDate) AS SellStartMonth, LEFT(ProductNumber, 2) AS ProductType
FROM SalesLT.Product;

-- 4. Retrieve only products with a numeric size
SELECT ProductID, UPPER(Name), CAST(ROUND(Weight,0) AS int) AS ApproxWeight, YEAR(SellStartDate) AS SellStartYear, 
		DATENAME(m, SellStartDate) AS SellStartMonth, LEFT(ProductNumber, 2) AS ProductType, Size
FROM SalesLT.Product
WHERE ISNUMERIC(Size) = 1;

-- 5. Retrieve companies ranked by sales totals
SELECT c.CompanyName, oh.TotalDue AS Rev,
RANK() OVER (ORDER BY oh.TotalDue DESC) AS RankByRev
FROM SalesLT.Customer c
INNER JOIN SalesLT.SalesOrderHeader oh
ON c.CustomerID = oh.CustomerID

-- 6. Retrieve total sales by product
SELECT p.Name, CAST(SUM(od.LineTotal) AS INT) AS TotalRev
FROM SalesLT.Product p
INNER JOIN SalesLT.SalesOrderDetail od
ON p.ProductID = od.ProductID
GROUP BY p.Name
ORDER BY TotalRev DESC

-- 7. Filter the product sales list to include only products that cost over $1,000
SELECT p.Name, SUM(od.LineTotal) AS TotalRev
FROM SalesLT.Product p
INNER JOIN SalesLT.SalesOrderDetail od
ON p.ProductID = od.ProductID
WHERE p.ListPrice > 1000
GROUP BY p.Name
ORDER BY TotalRev DESC

-- 8. Filter the product sales group to include only total sales over $20,000
SELECT p.Name, SUM(od.LineTotal) AS TotalRev
FROM SalesLT.Product p
INNER JOIN SalesLT.SalesOrderDetail od
ON p.ProductID = od.ProductID
WHERE p.ListPrice > 1000
GROUP BY p.Name
HAVING SUM(od.LineTotal) > 20000
ORDER BY TotalRev DESC