
--Project Details
You’ve just joined Adventure Works Cycles, a company that makes and sells bikes, parts,
clothing and accessories around the world. On your first morning the Sales Director drops by
your desk with a list of questions. Nobody has had time to answer them, and the data is sitting
in the company database.
Your job is to be the Bike Shop Detective. You’ll write 32 SQL queries, each answering a real
business question, plus a final challenge that brings everything together.
-----------------------------------------------------------------

--Selecting the database

Use AdventureWorks2022
----------------------------------------------------------------
--- PART A - Product Exploration 

--Q1 What do we sell?

SELECT TOP 10 ProductID,Name, ProductNumber, Color, ListPrice 
FROM Production.Product

--Q2 Marketing is planning a red-themed campaign. Which red products cost
more than $1,000, most expensive first?

SELECT Name,Color,ListPrice 
FROM Production.Product
WHERE Color = 'Red' AND ListPrice > 1000
ORDER BY ListPrice DESC;

-------------------------------------------------------------------
---Part B - Aggregate functions
--Q3 How many products do we have?

SELECT COUNT(*) AS TotalProducts
From Production.Product;

--Q4 How many products have a colour, and how many different colours do we use?

SELECT
    COUNT(*) AS TotalProducts,
    COUNT(Color) AS ProductsWithColour,
    COUNT(DISTINCT Color) AS DifferentColours
FROM Production.Product;

--Q5 Of the products we actually sell, what are the cheapest, most expensive and average list prices?

SELECT 
MIN(ListPrice) AS CheapestListPrice,
MAX(ListPrice) AS MostExpensiveListPrice,
AVG(ListPrice) AS AverageListPrice
FROM Production.Product
WHERE ListPrice > 0

--Q6 “Show the average list price rounded in different ways so we can see what ROUND does.

SELECT 
AVG(ListPrice) As AveragePrice,
ROUND(AVG(ListPrice),0) AS AverageListPrice0,
ROUND(AVG(ListPrice),1) AS AverageListPrice1,
ROUND(AVG(ListPrice),2) AS AverageListPrice2,
ROUND(AVG(ListPrice),3) AS AverageListPrice3
FROM Production.Product
WHERE ListPrice > 0

--Q7 How many orders have we taken in total, and how much did they bring in, split into sales, tax and freight?

SELECT COUNT(*) AS SalesOrderID,
ROUND(SUM(SubTotal),2) AS SumSubtotal,
ROUND(SUM(TaxAmt),2) AS SumTaxAmt,
ROUND(SUM(Freight),2) AS SumFreight,
ROUND(SUM(TotalDue),2) AS SumTotalDue
FROM Sales.SalesOrderHeader

--Q8 When did we take our first and last orders, and how many different customers have ordered?

SELECT 
MIN(OrderDate) AS FirstOrder,
MAX(OrderDate) AS RecentOrder,
COUNT(DISTINCT CustomerID) AS CustomersOrdered
FROM Sales.SalesOrderHeader;

--Q9 For each colour, how many products do we have and what is their average price?

SELECT Color,
COUNT(*) AS ProductNumber,
AVG(ListPrice) AS AvgPrice
FROM Production.Product
GROUP BY Color;

--Q10 How many orders did we take each year, and how much revenue did they bring in?

SELECT 
YEAR(OrderDate) AS OrderYear,
COUNT(*) AS SalesOrderID,
SUM(TotalDue) AS Revenue
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate)
ORDER BY OrderYear;

--Q11 Which colours have more than 30 products for sale?

SELECT Color,
Count(*) AS ProductNumber
From Production.Product
GROUP BY Color
HAVING COUNT(*) > 30;

----------------------------------------------------------------------------------
---Part C - Date and Time Analysis

--Q12 For our first few orders, show the year, quarter, month, day and the name of the weekday

SELECT TOP 10
OrderDate,
YEAR(OrderDate) AS Year,
MONTH(OrderDate) AS Month,
DAY(OrderDate) AS Day,
DATEPART(quarter,OrderDate) AS DatePart,
DATENAME(Month,OrderDate) AS DateNameMonth,
DATENAME(Weekday,OrderDate) AS DateNameWeekday,
DATEPART(Weekday,OrderDate) AS DatePartWeekday
FROM Sales.SalesOrderHeader;

--Q13 Show order dates in formats a UK manager would recognise

SELECT CAST(OrderDate AS DATE) AS Date,
FORMAT(OrderDate, 'dd/MM/yyyy' ) AS BritishDateFormat
FROM Sales.SalesOrderHeader;

--Q14 How many orders did we take in the first quarter of 2014 (January to March), and what were they worth?

SELECT 
COUNT(*) AS TotalOrders,
SUM(TotalDue) AS Revenue
FROM Sales.SalesOrderHeader
WHERE OrderDate >= '2014-01-01' 
    AND OrderDate < '2014-04-01'

--Q15 Show the number of orders and the revenue for each month of 2014.

SELECT 
  Month(OrderDate) AS MonthNum,
  DATENAME(MONTH,OrderDate) AS MonthName,
  COUNT(*) AS NumOrders,
  SUM(TotalDue) AS Revenue
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = 2014
GROUP BY
  Month(OrderDate),
  DATENAME(MONTH,OrderDate)
ORDER BY MonthNum;

--Q16 On which day of the week do we receive the most orders?

SELECT 
COUNT(*) AS TotalOrders,
DATENAME(WEEKDAY, OrderDate) AS DayName
FROM Sales.SalesOrderHeader
GROUP BY DATENAME(Weekday, OrderDate)
ORDER BY TotalOrders DESC;

--Q17 How long did each order take to ship? For our first 10 orders, how many days passed between ordering and shipping, and how many days were left before the due date?”

SELECT TOP 10
SalesOrderID,
OrderDate,
ShipDate,
DueDate,
DATEDIFF(Day,OrderDate,ShipDate) AS ShippingDuration,
DATEDIFF(Day,ShipDate,DueDate) AS DueDateDuration
FROM Sales.SalesOrderHeader

--Q18 Shipping performance summary.Across all orders, what were the fastest, slowest and average shipping times?

SELECT
MAX(DATEDIFF(Day,OrderDate,ShipDate)) AS FastestShipping,
MIN(DATEDIFF(Day,OrderDate,ShipDate)) AS SlowestShipping,
AVG(DATEDIFF(Day,OrderDate,ShipDate)) AS AvgWholedays,
AVG(DATEDIFF(Day,OrderDate,ShipDate)*1.0) AS AvgExact
FROM Sales.SalesOrderHeader

--Q19 Find the slow shipments-Which orders took more than 7 days to ship?

SELECT 
SalesOrderNumber,
OrderDate,
ShipDate,
DATEDIFF(Day, OrderDate,ShipDate)  AS  DaysToShip
FROM Sales.SalesOrderHeader
WHERE DATEDIFF(Day, OrderDate,ShipDate) > 7

--Q20  Payment and reminder dates. For each order, work out a payment due date 30 days later, a service reminder 6 months later, and the last day of the order’s month

SELECT TOP 5
SalesOrderID,
DueDate,
DATEADD(DAY,30,DueDate)     AS     PaymentDueDate,
DATEADD(MONTH, 6, DueDate)  AS     ServiceReminder,
EOMONTH(DueDate)            AS     MonthEndDate
FROM Sales.SalesOrderHeader

--Q21 Our longest-standing customers.Which customers have the longest gap between their first and last order?

SELECT TOP 10
CustomerID,
COUNT(*) AS NumOrders,
MIN(OrderDate) AS FirstOrder,
MAX(OrderDate) AS LastOrder,
DATEDIFF(Day,MIN(OrderDate),MAX(OrderDate)) AS DaysAsCustomer
FROM Sales.SalesOrderHeader
GROUP BY CustomerID

--------------------------------------------------------------------------------------------
---Part D - Simple Joins

--Q22 Each product with its subcategory. Show our 10 most expensive products with the name of their subcategory.

SELECT TOP 10
p.Name AS Product,
s.Name AS Subcategory,
p.ListPrice 
FROM Production.Product AS p
LEFT JOIN Production.ProductSubcategory AS s ON
p.ProductSubcategoryID = s.ProductSubcategoryID
WHERE s.Name IS NOT NULL

--Q23  Every subcategory with its category. List every subcategory with the category it belongs to, sorted by category

SELECT
c.Name    AS    Category,
s.Name    AS    SubCategory
FROM Production.ProductCategory  AS c
LEFT JOIN Production.ProductSubCategory  AS s ON
c.ProductCategoryID = s.ProductCategoryID

--Q24  Our 10 biggest orders and where they came from.Show our 10 biggest orders with their order number, date and the name of the sales territory

SELECT TOP 10
o.SalesOrderNumber,
o.OrderDate,
o.TotalDue,
t.Name  AS TerritoryName
FROM Sales.SalesOrderHeader     AS  o
LEFT JOIN Sales.SalesTerritory  AS  t
ON o.TerritoryID = t.TerritoryID
ORDER BY o.TotalDue DESC;

--Q25 Names of our individual customers. Show the names of 10 individual (non-store) customers, sorted by surname.

SELECT TOP 10
c.CustomerID,
p.FirstName,
p.LastName
FROM Sales.Customer       AS  c
INNER JOIN Person.Person  AS  p
ON p.BusinessEntityID = c.PersonID
WHERE c.StoreID IS NULL
ORDER BY p.LastName ASC;
---------------------------------------------------------------------------------------

---Part E - Joins + aggregates

--Q26  How many orders came from each Sales territory?

SELECT 
COUNT(*)                  AS   TotalOrders,
c.TerritoryID             AS   Territory
FROM Sales.Customer       AS   c
INNER JOIN Person.Person  AS   p
ON p.BusinessEntityID = c.PersonID
GROUP BY c.TerritoryID;

--Q27  Which 10 subcategories have the most products, and what is the price range in each?

SELECT TOP 10
s.Name                                   AS   Subcategory,
COUNT(*)                                 AS   NumProducts,
MIN(ListPrice)                           AS   LowestPrice,
MAX(ListPrice)                           AS   HighestPrice
FROM Production.Product                  AS   p
LEFT JOIN Production.ProductSubcategory  AS   s ON
p.ProductSubcategoryID = s.ProductSubcategoryID
WHERE s.Name IS NOT NULL
GROUP BY s.Name

--Q28  What are our top 10 products by revenue, and how many units of each did we sell?

SELECT TOP 10
p.Name                            AS  Product,
SUM(s.OrderQty)                   AS  UnitsSold,
SUM(LineTotal)                    AS  Revenue
FROM Production.Product           AS   p
LEFT JOIN Sales.SalesOrderDetail  AS   s ON
p.ProductID = s.ProductID
GROUP BY p.Name
ORDER BY Revenue DESC

--Q29  Which sales territories brought in more than $10 million in total?

SELECT 
t.Name                          AS  TerritoryName,
t.[Group]                       AS  Region,
SUM(o.TotalDue)                 AS  Revenue,
Count(o.SalesOrderID)           AS  NumOrders
FROM Sales.SalesOrderHeader     AS  o
LEFT JOIN Sales.SalesTerritory  AS  t
ON o.TerritoryID = t.TerritoryID
GROUP BY t.Name,
         t.[Group]
HAVING SUM(o.TotalDue)  >  10000000;

-----------------------------------------------------------------------------------------
--- Part F - Advanced Business Analysis

--Q30 How many products do we have in each category, and what is the average list price?

SELECT 
pc.Name   AS  Category,
COUNT(p.ProductID)  AS NumOrders,
AVG(p.ListPrice)    AS AvgPrice
FROM Production.Product AS p
INNER JOIN Production.ProductSubcategory AS ps
    ON p.ProductSubcategoryID = ps.ProductSubcategoryID
INNER JOIN Production.ProductCategory AS pc 
ON ps.ProductCategoryID = pc.ProductCategoryID
GROUP BY pc.Name

--Q31  Do we make more money from online orders or from orders taken by our sales reps?

SELECT
    CASE
        WHEN OnlineOrderFlag = 1 THEN 'Online'
        ELSE 'Sales Rep'
    END AS Channel,
    COUNT(*) AS NumOrders,
    AVG(TotalDue) AS AvgOrderValue,
    SUM(TotalDue) AS Revenue
FROM Sales.SalesOrderHeader
GROUP BY
    CASE
        WHEN OnlineOrderFlag = 1 THEN 'Online'
        ELSE 'Sales Rep'
    END;

--Q32 Who are our top 5 individual customers by total spend?

SELECT TOP 5
    CONCAT(p.FirstName, ' ', p.LastName) AS CustomerName,
    COUNT(o.SalesOrderID) AS NumOrders,
    SUM(o.TotalDue) AS TotalSpent
FROM Sales.Customer AS c
INNER JOIN Person.Person AS p
    ON c.PersonID = p.BusinessEntityID
INNER JOIN Sales.SalesOrderHeader AS o
    ON c.CustomerID = o.CustomerID
WHERE c.StoreID IS NULL
GROUP BY
    c.CustomerID,
    p.FirstName,
    p.LastName
ORDER BY TotalSpent DESC;

-- Q33 Revenue by category, by year.For each year, how much revenue did each product category bring in?”

SELECT
    YEAR(soh.OrderDate) AS OrderYear,
    pc.Name AS Category,
    SUM(sod.LineTotal) AS Revenue
FROM Sales.SalesOrderDetail sod
JOIN Sales.SalesOrderHeader soh
    ON sod.SalesOrderID = soh.SalesOrderID
JOIN Production.Product p
    ON sod.ProductID = p.ProductID
JOIN Production.ProductSubcategory psc
    ON p.ProductSubcategoryID = psc.ProductSubcategoryID
JOIN Production.ProductCategory pc
    ON psc.ProductCategoryID = pc.ProductCategoryID
GROUP BY
    YEAR(soh.OrderDate),
    pc.Name
ORDER BY
    OrderYear,
    Category;

--Q34 Average OrderQty per order line.What is the average quantity of products per sales order line?

-- Integer average
SELECT AVG(OrderQty) AS AverageOrderQty
FROM Sales.SalesOrderDetail;

-- Decimal average
SELECT AVG(OrderQty * 1.0) AS AverageOrderQty
FROM Sales.SalesOrderDetail;

--Q35 Which product colour sells the most units?

SELECT
    p.Color,
    SUM(o.OrderQty) AS TotalUnitsSold
FROM Sales.SalesOrderDetail o
JOIN Production.Product p
    ON o.ProductID = p.ProductID
GROUP BY p.Color
ORDER BY TotalUnitsSold DESC;

--Q36 How many orders and how much revenue did each European sales territory generate?

SELECT
    st.Name AS Territory,
    COUNT(soh.SalesOrderID) AS OrderCount,
    ROUND(SUM(soh.SubTotal), 0) AS TotalRevenue
FROM Sales.SalesTerritory st
JOIN Sales.SalesOrderHeader soh
    ON st.TerritoryID = soh.TerritoryID
WHERE st.[Group] = 'Europe'
GROUP BY st.Name
ORDER BY TotalRevenue DESC;

--Q37 How many orders did each customer place TOP 10?

SELECT TOP 10
    CustomerID,
    COUNT(SalesOrderID) AS TotalOrders
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
ORDER BY TotalOrders DESC;

--Q38 Find products that have never been sold.

SELECT
    p.ProductID,
    p.Name AS ProductName
FROM Production.Product p
LEFT JOIN Sales.SalesOrderDetail s
    ON p.ProductID = s.ProductID
WHERE s.ProductID IS NULL;

--Q39 How many years ago was our very first order?

SELECT
    DATEDIFF(
        YEAR,
        MIN(OrderDate),
        GETDATE()
    ) AS YearsSinceFirstOrder
FROM Sales.SalesOrderHeader;

--Q40 Which quarter of 2014 had the highest revenue?

SELECT
    DATEPART(QUARTER, OrderDate) AS OrderQuarter,
    ROUND(SUM(SubTotal), 0) AS TotalRevenue
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = 2014
GROUP BY DATEPART(QUARTER, OrderDate)
ORDER BY TotalRevenue DESC;

--Q41 On average, how many days were there between the shipping date and the due date for each order year?

SELECT
    YEAR(OrderDate) AS OrderYear,
    AVG(DATEDIFF(DAY, ShipDate, DueDate) * 1.0)
        AS AverageDays
FROM Sales.SalesOrderHeader
WHERE ShipDate IS NOT NULL
GROUP BY YEAR(OrderDate)
ORDER BY OrderYear;
