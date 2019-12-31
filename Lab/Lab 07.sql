-- 1. Retrieve Product Model Description
SELECT p.ProductID, p.Name AS ProductName, vp.Name AS ModelName, vp.Summary
FROM SalesLT.Product p
INNER JOIN SalesLT.vProductModelCatalogDescription vp
ON p.ProductModelID = vp.ProductModelID;

-- 2. Create a table of distinct colors
DECLARE @Color AS TABLE (Color Varchar(20));

INSERT INTO @Color
SELECT DISTINCT Color
FROM SalesLT.Product

SELECT ProductID, Name, Color
FROM SalesLT.Product
WHERE Color in (SELECT * FROM @Color);

-- 3. Retrieve product parent categories
SELECT p.name, c.ProductCategoryName, c.ParentProductCategoryName
FROM SalesLT.Product p
INNER JOIN dbo.ufnGetAllCategories() c
ON p.ProductCategoryID = c.ProductCategoryID

-- 4. Retrieve sales revenue by customer and contact

SELECT CompanyContact, SUM(SalesAmount) AS Revenue
FROM	
(SELECT CONCAT(c.CompanyName, CONCAT(' (' + c.FirstName + ' ', c.LastName + ')')), SOH.TotalDue	 
FROM SalesLT.SalesOrderHeader AS SOH	 
JOIN SalesLT.Customer AS c	 
ON SOH.CustomerID = c.CustomerID) AS CustomerSales(CompanyContact, SalesAmount)
GROUP BY CompanyContact
ORDER BY CompanyContact;