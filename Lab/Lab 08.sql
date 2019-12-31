-- 1. Retrieve totals for country/region and state/province
SELECT a.CountryRegion, a.StateProvince, SUM(soh.TotalDue) AS Revenue
FROM SalesLT.Address AS a
JOIN SalesLT.CustomerAddress AS ca ON a.AddressID = ca.AddressID
JOIN SalesLT.Customer AS c ON ca.CustomerID = c.CustomerID
JOIN SalesLT.SalesOrderHeader as soh ON c.CustomerID = soh.CustomerID
GROUP BY ROLLUP (a.CountryRegion, a.StateProvince)
ORDER BY a.CountryRegion, a.StateProvince;

-- 2. Indicating Group Level in the results
SELECT a.CountryRegion, a.StateProvince,
IIF(GROUPING_ID(CountryRegion) = 1 AND GROUPING_ID(a.StateProvince) = 1, 'Total', IIF(GROUPING_ID(StateProvince) = 1, a.CountryRegion + ' Subtotal', a.StateProvince + ' Subtotal')) AS Level, 
SUM(soh.TotalDue) AS Revenue
FROM SalesLT.Address AS a
JOIN SalesLT.CustomerAddress AS ca ON a.AddressID = ca.AddressID
JOIN SalesLT.Customer AS c ON ca.CustomerID = c.CustomerID
JOIN SalesLT.SalesOrderHeader as soh ON c.CustomerID = soh.CustomerID
GROUP BY ROLLUP (a.CountryRegion, a.StateProvince)
ORDER BY a.CountryRegion, a.StateProvince;

-- 3. Adding Grouping level to all cities
SELECT a.CountryRegion, a.StateProvince, a.City,
CHOOSE (1 + GROUPING_ID(CountryRegion) + GROUPING_ID(StateProvince) + GROUPING_ID(City),
        a.City + ' Subtotal', a.StateProvince + ' Subtotal',
        a.CountryRegion + ' Subtotal', 'Total') AS Level,
SUM(soh.TotalDue) AS Revenue
FROM SalesLT.Address AS a
JOIN SalesLT.CustomerAddress AS ca
ON a.AddressID = ca.AddressID
JOIN SalesLT.Customer AS c
ON ca.CustomerID = c.CustomerID
JOIN SalesLT.SalesOrderHeader as soh
ON c.CustomerID = soh.CustomerID
GROUP BY ROLLUP(a.CountryRegion, a.StateProvince, a.City)
ORDER BY a.CountryRegion, a.StateProvince, a.City;

-- 3. Retrieve customer sales revenue for each parent category
SELECT * 
FROM
	(SELECT cat.ParentProductCategoryName, cust.CompanyName, sod.LineTotal
	 FROM SalesLT.SalesOrderDetail sod
	 JOIN SalesLT.SalesOrderHeader soh 
	 ON sod.SalesOrderID = soh.SalesOrderID
	 JOIN SalesLT.Customer cust 
	 ON soh.CustomerID = cust.CustomerID
	 JOIN SalesLT.Product prod 
	 ON sod.ProductID = prod.ProductID
	 JOIN SalesLT.vGetAllCategories cat 
	 ON prod.ProductcategoryID = cat.ProductCategoryID) AS sales
PIVOT (SUM(LineTotal) FOR ParentProductCategoryName
IN ([Accessories], [Bikes], [Clothing], [Components])) AS pivotedsales
ORDER BY CompanyName;