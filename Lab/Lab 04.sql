-- 1. Retrieve Billing Address
SELECT c.CompanyName, a.AddressLine1, a.City, 'Billing' AS AddressType
FROM SalesLT.Customer c
INNER JOIN SalesLT.CustomerAddress ca
ON c.CustomerID = ca.CustomerID
INNER JOIN SalesLT.Address a
ON ca.AddressID = a.AddressID
WHERE ca.AddressType = 'Main Office';

--2. Retrieve Shipping Address
SELECT c.CompanyName, a.AddressLine1, a.City, 'Shipping' AS AddressType
FROM SalesLT.Customer c
INNER JOIN SalesLT.CustomerAddress ca
ON c.CustomerID = ca.CustomerID
INNER JOIN SalesLT.Address a
ON ca.AddressID = a.AddressID
WHERE ca.AddressType = 'Shipping';

--3. Combine billing and shipping address
SELECT c.CompanyName, a.AddressLine1, a.City, 'Billing' AS AddressType
FROM SalesLT.Customer c
INNER JOIN SalesLT.CustomerAddress ca
ON c.CustomerID = ca.CustomerID
INNER JOIN SalesLT.Address a
ON ca.AddressID = a.AddressID
WHERE ca.AddressType = 'Main Office'
UNION ALL
SELECT c.CompanyName, a.AddressLine1, a.City, 'Shipping' AS AddressType
FROM SalesLT.Customer c
INNER JOIN SalesLT.CustomerAddress ca
ON c.CustomerID = ca.CustomerID
INNER JOIN SalesLT.Address a
ON ca.AddressID = a.AddressID
WHERE ca.AddressType = 'Shipping';

-- 4. Retrieve customer with only a main office address
SELECT c.CompanyName, a.AddressLine1, a.City, 'Billing' AS AddressType
FROM SalesLT.Customer c
INNER JOIN SalesLT.CustomerAddress ca
ON c.CustomerID = ca.CustomerID
INNER JOIN SalesLT.Address a
ON ca.AddressID = a.AddressID
WHERE ca.AddressType = 'Main Office'
EXCEPT
SELECT c.CompanyName, a.AddressLine1, a.City, 'Shipping' AS AddressType
FROM SalesLT.Customer c
INNER JOIN SalesLT.CustomerAddress ca
ON c.CustomerID = ca.CustomerID
INNER JOIN SalesLT.Address a
ON ca.AddressID = a.AddressID
WHERE ca.AddressType = 'Shipping';

-- 5. Retrieve customer with both a main office and shipping address
SELECT c.CompanyName, a.AddressLine1, a.City, 'Billing' AS AddressType
FROM SalesLT.Customer c
INNER JOIN SalesLT.CustomerAddress ca
ON c.CustomerID = ca.CustomerID
INNER JOIN SalesLT.Address a
ON ca.AddressID = a.AddressID
WHERE ca.AddressType = 'Main Office'
INTERSECT
SELECT c.CompanyName, a.AddressLine1, a.City, 'Shipping' AS AddressType
FROM SalesLT.Customer c
INNER JOIN SalesLT.CustomerAddress ca
ON c.CustomerID = ca.CustomerID
INNER JOIN SalesLT.Address a
ON ca.AddressID = a.AddressID
WHERE ca.AddressType = 'Shipping';