-- 1. Retrieve a list of cities
SELECT DISTINCT City, StateProvince
FROM SalesLT.Address;

-- 2. Retrieve the heaviest product [top 10 %]
SELECT TOP 10 PERCENT Name, Weight
FROM SalesLT.Product
ORDER BY Weight DESC;

-- 3. Retrieve the heaviest 100 products not including heavist ten
SELECT Name, Weight
FROM SalesLT.Product
ORDER BY Weight DESC
OFFSET 10 ROWS FETCH NEXT 100 ROWS ONLY;

-- 4. Retrieve product details for product model 1
SELECT Name, Color, Size
FROM SalesLT.Product
WHERE ProductModelID = 1;

-- 5. Filter products by color and size
SELECT ProductNumber, Name, Color, Size
FROM SalesLT.Product
WHERE Color IN ('black', 'red', 'white') AND Size IN ('S', 'M');

-- 6. Filter products by product number
SELECT ProductNumber, Name, ListPrice
FROM SalesLT.Product
WHERE ProductNumber LIKE 'BK%';

-- 7. Retrieve specific products by product number
SELECT ProductNumber, Name, ListPrice
FROM SalesLT.Product
WHERE ProductNumber LIKE 'BK%-[^R]%-[0-9][0-9]'