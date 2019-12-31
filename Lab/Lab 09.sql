-- 1. Insert a product
INSERT INTO SalesLT.Product (Name, ProductNumber, StandardCost, ListPrice, ProductCategoryID, SellStartDate)
VALUES
('LED Lights', 'LT-L123', 2.56, 12.99, 37, GETDATE());

SELECT *
FROM SalesLT.Product
WHERE ProductID = 1000;

-- 2. Insert a new category with two products
INSERT INTO SalesLT.ProductCategory (ParentProductCategoryID, Name)
VALUES
(4, 'Bells and Horns');

SELECT *
FROM SalesLT.ProductCategory
WHERE ParentProductCategoryID = 4;

INSERT INTO SalesLT.Product (Name, ProductNumber, StandardCost, ListPrice, ProductCategoryID, SellStartDate)
VALUES
('Bicycle Bell', 'BB-RING', 2.47, 4.99, 4, GETDATE()),
('Bicycle Horn', 'BB-PARP', 1.29, 3.75, 4, GETDATE());

SELECT *
FROM SalesLT.Product
WHERE ProductNumber = 'BB-RING' OR ProductNumber = 'BB-PARP';

-- 3. Update Product Prices
UPDATE SalesLT.Product
SET ListPrice = ListPrice * 1.1 
WHERE ProductCategoryID = 
(SELECT ParentProductCategoryID FROM SalesLT.ProductCategory WHERE Name = 'Bells and Horns');

SELECT *
FROM SalesLT.Product
WHERE ProductCategoryID = (SELECT ParentProductCategoryID FROM SalesLT.ProductCategory WHERE Name = 'Bells and Horns')

-- 4. Discontiue products
UPDATE SalesLT.Product
SET DiscontinuedDate = GETDATE()
WHERE ProductCategoryID = 37 AND ProductNumber != 'LT-L123'

SELECT *
FROM SalesLT.Product
WHERE ProductCategoryID = 37

-- 5. Deleting products
DELETE FROM SalesLT.Product
WHERE ProductCategoryID =
(SELECT ParentProductCategoryID FROM SalesLT.ProductCategory WHERE Name = 'Bells and Horns');

DELETE FROM SalesLT.ProductCategory
WHERE ProductCategoryID =
(SELECT ProductCategoryID FROM SalesLT.ProductCategory WHERE Name = 'Bells and Horns');