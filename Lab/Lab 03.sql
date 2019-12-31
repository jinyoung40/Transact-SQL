-- 1. Retrieve Customer Orders
SELECT c.CompanyName, so.SalesOrderID, so.TotalDue
FROM SalesLT.Customer c
INNER JOIN SalesLT.SalesOrderHeader so
ON c.CustomerID = so.CustomerID;

-- 2. Retrieve customer orders with address
SELECT c.CompanyName, so.SalesOrderID, so.TotalDue, a.AddressLine1, ISNULL(a.AddressLine2, '') AS AddressLine2, a.City, a.StateProvince, a.CountryRegion, a.PostalCode
FROM SalesLT.Customer c
INNER JOIN SalesLT.SalesOrderHeader so
ON c.CustomerID = so.CustomerID
INNER JOIN SalesLT.CustomerAddress ca
ON c.CustomerID = ca.CustomerID AND AddressType = 'Main Office'
INNER JOIN SalesLT.Address a
ON ca.AddressID = a.AddressID

-- 3. Retrieve a list of all customers and their orders
SELECT c.CompanyName, c.FirstName + ' ' + c.LastName AS FullName, oh.SalesOrderID, oh.TotalDue
FROM SalesLT.Customer c
LEFT JOIN SalesLT.SalesOrderHeader oh
ON c.CustomerID = oh.CustomerID
ORDER BY oh.TotalDue DESC

-- 4. Retrieve a list of customer with no address
SELECT c.CompanyName, c.FirstName + ' ' + c.LastName AS FullName
FROM SalesLT.Customer c
LEFT JOIN SalesLT.CustomerAddress ca
ON c.CustomerID = ca.CustomerID
WHERE ca.AddressID IS NULL

-- 5. Retrieve a list of customers and products with no order
SELECT c.CustomerID, p.ProductID
FROM SalesLT.Customer c
FULL OUTER JOIN SalesLT.SalesOrderHeader oh
ON c.CustomerID = oh.CustomerID
FULL OUTER JOIN SalesLT.SalesOrderDetail od
ON oh.SalesOrderID = od.SalesOrderID
FULL OUTER JOIN SalesLT.Product p
ON od.ProductID = p.ProductID
WHERE c.CustomerID IS NULL OR p.ProductID IS NULL