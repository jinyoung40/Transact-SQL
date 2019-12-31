-- 1. Retrieve Customer Details
SELECT *
FROM SalesLT.Customer;

-- 2. Retrieve Customer Name
SELECT Title, FirstName, MiddleName, LastName, Suffix
FROM SalesLT.Customer;

-- 3. Retrieve Customer names and Phone numbers
SELECT SalesPerson, Title +'. '+ LastName AS CustomerName, Phone
FROM SalesLT.Customer;

-- 4. Retrieve a list of customer companies
SELECT CAST(CustomerID AS varchar(10)) + ': ' + CompanyName
FROM SalesLT.Customer;

-- 5. Retrieve a list of sales order revisions
SELECT SalesOrderNumber +' ('+STR(RevisionNumber,1)+')' AS OrderRevision,
		CONVERT(nvarchar(40), OrderDate, 102) AS OrderDate
FROM SalesLT.SalesOrderHeader;

-- 6. Retrieve customer contact names with middle names if known
SELECT FirstName + ' ' + ISNULL(MiddleName, '') + ' ' + LastName AS CustomerName
FROM SalesLT.Customer;

-- 7. Retrieve primary contact details
UPDATE SalesLT.Customer
SET EmailAddress = NULL
WHERE CustomerID %7 = 1;

SELECT CustomerID, COALESCE(EmailAddress, Phone) AS PrimaryContact
FROM SalesLT.Customer;

-- 8. Retrieve Shipping Status
UPDATE SalesLT.SalesOrderHeader
SET ShipDate = NULL
WHERE SalesOrderID > 71899;

SELECT SalesOrderID, OrderDate, 
	CASE
	WHEN ShipDate IS NULL THEN 'Awaiting Shipment'
	ELSE 'Shipped'
	END AS ShippingStatus
FROM SalesLT.SalesOrderHeader;