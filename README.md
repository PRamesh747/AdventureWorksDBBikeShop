# Project Title: AdventureWorks 2022 – SQL Business Analysis

**Project Type:** Data Analytics – SQL Project  
**Database:** Microsoft AdventureWorks 2022  
**SQL Environment:** SQL Server Management Studio (SSMS)  
**SQL Language:** T-SQL  
**Number of SQL Queries:** 41

## 1. Project Introduction

This project focuses on analysing business data using the Microsoft AdventureWorks 2022 sample database.

Adventure Works Cycles is a company involved in manufacturing and selling bicycles, components, clothing and accessories. The database contains information relating to products, customers, sales orders, sales territories and order fulfilment.

The objective of this project was to investigate business questions using SQL and extract meaningful information from different areas of the business.

I used SQL queries to analyse product pricing, sales performance, customer purchasing activity, sales channels, geographical performance and shipping operations.

The project demonstrates how SQL can be used to retrieve, combine, filter and summarise data from multiple related tables to support business reporting and decision-making.

## 2. Project Objectives

The main objectives of this project were:

1. Explore the AdventureWorks database and understand its structure.
2. Analyse the product portfolio, pricing and product categories.
3. Examine sales performance and revenue across different periods.
4. Identify high-value customers and understand customer activity.
5. Compare online and sales-representative sales channels.
6. Analyse sales performance across different territories.
7. Investigate monthly, quarterly and annual sales trends.
8. Examine order processing and shipping durations.
9. Apply SQL joins and aggregate functions to combine data from multiple tables.
10. Translate business questions into SQL queries and meaningful analysis.

## 3. Database Overview

This project uses the Microsoft AdventureWorks 2022 sample database.

The analysis uses tables from the following schemas:

- **Production:** Product details, product categories and subcategories.
- **Sales:** Customers, sales orders, sales order details and territories.
- **Person:** Individual customer names and contact information.

### Main Tables Used

| Table | Description |
|---|---|
| `Production.Product` | Product details, colours and list prices |
| `Production.ProductSubcategory` | Product subcategory information |
| `Production.ProductCategory` | Product category information |
| `Sales.SalesOrderHeader` | Sales order dates, customer IDs and order values |
| `Sales.SalesOrderDetail` | Products and quantities within sales orders |
| `Sales.Customer` | Customer records and territory information |
| `Sales.SalesTerritory` | Sales territory and regional information |
| `Person.Person` | Individual customer names and contact details |

### Selecting the Database

```sql
USE AdventureWorks2022;
GO
```

## 4. Data Exploration

Before conducting the analysis, I explored the database to understand the available information and identify relevant tables and columns.

The initial exploration included:

- Retrieving product records.
- Reviewing sales order information.
- Identifying product categories and subcategories.
- Examining customer information.
- Checking the available order-date range.
- Understanding relationships between tables.

### Example: Retrieve Product Records

```sql
SELECT TOP 10
    ProductID,
    Name,
    ProductNumber,
    Color,
    ListPrice
FROM Production.Product;
```

### Example: Check the Sales Order Date Range

```sql
SELECT
    MIN(OrderDate) AS FirstOrderDate,
    MAX(OrderDate) AS LastOrderDate
FROM Sales.SalesOrderHeader;
```

## 5. Business Analysis and SQL Queries

I developed 41 SQL queries to investigate business questions across different areas of Adventure Works Cycles.

### Part A – Product Exploration

**Q1. What do we sell?**

Retrieve the first 10 products, including product ID, name, product number, colour and list price.

**Business purpose:** Understand the products available in the company's product catalogue.

**SQL concepts:** SELECT, TOP.

**Q2. Which red products cost more than $1,000, with the most expensive listed first?**

Filter the product catalogue to identify red products with a list price above $1,000 and sort them by price in descending order.

**Business purpose:** Identify higher-priced products for a potential red-themed marketing campaign.

**SQL concepts:** WHERE, AND, ORDER BY, DESC.

### Part B – Aggregate Functions

**Q3. How many products do we have?**

Calculate the total number of products in the product catalogue.

**Business purpose:** Understand the size of the product portfolio.

**SQL concepts:** COUNT().

**Q4. How many products have a colour, and how many different colours do we use?**

Calculate the total product count, the number of products with a recorded colour and the number of distinct colours.

**Business purpose:** Understand product catalogue completeness and colour variety.

**SQL concepts:** COUNT(), COUNT(DISTINCT).

**Q5. What are the cheapest, most expensive and average list prices of products with a selling price?**

Calculate the minimum, maximum and average list prices for products where the list price is greater than zero.

**Business purpose:** Understand the product pricing range.

**SQL concepts:** MIN(), MAX(), AVG(), WHERE.

**Q6. How does rounding affect the average product list price?**

Calculate the average list price and display the result rounded to zero, one, two and three decimal places.

**Business purpose:** Understand numerical precision and presentation when reporting average prices.

**SQL concepts:** AVG(), ROUND().

**Q7. How many orders have we taken, and how much did they bring in, split into sales, tax and freight?**

Calculate the total number of sales orders and aggregate subtotal, tax, freight and total due.

**Business purpose:** Understand overall order activity and the different components of order value.

**SQL concepts:** COUNT(), SUM(), ROUND().

**Q8. When did we take our first and last orders, and how many different customers have ordered?**

Identify the earliest and most recent order dates and count the distinct customers who placed orders.

**Business purpose:** Understand the historical sales period and customer reach.

**SQL concepts:** MIN(), MAX(), COUNT(DISTINCT).

**Q9. For each colour, how many products do we have and what is their average price?**

Group products by colour and calculate the product count and average list price for each group.

**Business purpose:** Compare product availability and average pricing across colours.

**SQL concepts:** GROUP BY, COUNT(), AVG().

**Q10. How many orders did we take each year, and how much revenue did they bring in?**

Calculate annual sales order volumes and total due by order year.

**Business purpose:** Monitor sales activity and order value over time.

**SQL concepts:** YEAR(), COUNT(), SUM(), GROUP BY, ORDER BY.

**Q11. Which colours have more than 30 products for sale?**

Group products by colour and filter the results to show colours with more than 30 products.

**Business purpose:** Identify colours with larger product ranges.

**SQL concepts:** GROUP BY, HAVING, COUNT().

### Part C – Date and Time Analysis

**Q12. For the first 10 orders, what are the year, quarter, month, day and weekday?**

Extract different date components from the order date, including year, month, day, quarter and weekday.

**Business purpose:** Understand how date fields can be used to support time-based sales reporting.

**SQL concepts:** YEAR(), MONTH(), DAY(), DATEPART(), DATENAME(), TOP.

**Q13. How can order dates be displayed in a format a UK manager would recognise?**

Convert order dates into a date format and display them using the UK-style `dd/MM/yyyy` format.

**Business purpose:** Present dates in a familiar reporting format.

**SQL concepts:** CAST(), FORMAT().

**Q14. How many orders did we take in the first quarter of 2014, and what were they worth?**

Calculate the total number of orders and total due between 1 January and 31 March 2014.

**Business purpose:** Review first-quarter order activity and sales value.

**SQL concepts:** WHERE, date filtering, COUNT(), SUM().

**Q15. How many orders did we take and how much revenue did they generate in each month of 2014?**

Calculate monthly order volumes and total due for each month of 2014.

**Business purpose:** Compare monthly sales activity within a reporting year.

**SQL concepts:** YEAR(), MONTH(), DATENAME(), COUNT(), SUM(), GROUP BY, ORDER BY.

**Q16. On which day of the week do we receive the most orders?**

Group sales orders by weekday and sort the results by order count.

**Business purpose:** Understand the distribution of order activity across weekdays.

**SQL concepts:** DATENAME(), COUNT(), GROUP BY, ORDER BY.

**Q17. How long did each order take to ship, and how many days were left before the due date?**

For the first 10 orders, calculate the number of days between order date and ship date, and between ship date and due date.

**Business purpose:** Examine order processing and shipping timelines.

**SQL concepts:** DATEDIFF(), TOP.

**Q18. What were the fastest, slowest and average shipping times across all orders?**

Calculate the minimum, maximum and average number of days between order date and ship date.

**Business purpose:** Summarise shipping duration across the order dataset.

**SQL concepts:** DATEDIFF(), MIN(), MAX(), AVG(), decimal arithmetic.

**Q19. Which orders took more than seven days to ship?**

Identify sales orders where the difference between order date and ship date exceeded seven days.

**Business purpose:** Identify longer shipping durations for further operational investigation.

**SQL concepts:** DATEDIFF(), WHERE, comparison operators.

**Q20. What are the payment due date, service reminder date and month-end date for each order?**

Calculate a date 30 days after the due date, a date six months later and the final day of the due-date month.

**Business purpose:** Explore how SQL date functions can support payment scheduling and reminder planning.

**SQL concepts:** DATEADD(), EOMONTH(), TOP.

**Q21. Which customers have the longest gap between their first and last order?**

Calculate the number of orders, first order date, last order date and elapsed days between the first and last order for each customer. Return the top 10 records.

**Business purpose:** Understand the recorded duration of customer relationships and identify customers with longer purchasing histories.

**SQL concepts:** GROUP BY, COUNT(), MIN(), MAX(), DATEDIFF(), TOP.

### Part D – Simple Joins

**Q22. Which are the 10 most expensive products, and what is their subcategory?**

Combine product information with product subcategory information to retrieve product names, subcategories and list prices.

**Business purpose:** Connect product pricing information with the product hierarchy.

**SQL concepts:** LEFT JOIN, table aliases, WHERE.

**Q23. Which category does each product subcategory belong to?**

Combine product category and subcategory tables to display their relationship.

**Business purpose:** Understand the structure of the product category hierarchy.

**SQL concepts:** LEFT JOIN, table aliases, join conditions.

**Q24. What are our 10 biggest orders, and which sales territories did they come from?**

Combine sales order information with sales territory details and retrieve the highest-value orders.

**Business purpose:** Identify high-value orders and their geographical territories.

**SQL concepts:** LEFT JOIN, ORDER BY, DESC, TOP.

**Q25. What are the names of 10 individual customers who are not store customers?**

Join customer records with individual person details and retrieve customer names sorted by surname.

**Business purpose:** Identify individual customers separately from store customers.

**SQL concepts:** INNER JOIN, WHERE, IS NULL, ORDER BY.

### Part E – Joins and Aggregate Analysis

**Q26. How many orders came from each sales territory?**

Join customer records with individual person records and group the returned records by territory ID.

**Business purpose:** Explore the distribution of joined customer/person records across territories.

**SQL concepts:** INNER JOIN, COUNT(), GROUP BY.

**Note:** The current query counts joined customer/person records, not sales orders. To calculate actual orders by territory, the query would need to use sales order records.

**Q27. Which 10 subcategories have the most products, and what is the price range in each?**

Join products with their subcategories and calculate the number of products, lowest list price and highest list price for each subcategory.

**Business purpose:** Compare product range size and pricing across subcategories.

**SQL concepts:** LEFT JOIN, COUNT(), MIN(), MAX(), GROUP BY, TOP.

**Q28. What are our top 10 products by revenue, and how many units of each did we sell?**

Join product information with sales order details and calculate total units sold and product-line revenue.

**Business purpose:** Identify products with the highest recorded sales revenue and their sales volumes.

**SQL concepts:** LEFT JOIN, SUM(), GROUP BY, ORDER BY, TOP.

**Q29. Which sales territories brought in more than $10 million in total?**

Join sales order information with sales territory information and calculate total due and order count by territory. Filter territories with total due above $10 million.

**Business purpose:** Identify territories exceeding a defined sales value threshold.

**SQL concepts:** LEFT JOIN, SUM(), COUNT(), GROUP BY, HAVING.

### Part F – Advanced Business Analysis

**Q30. How many products do we have in each category, and what is the average list price?**

Join product, product subcategory and product category tables to calculate product counts and average list prices by category.

**Business purpose:** Compare product portfolio size and pricing across categories.

**SQL concepts:** INNER JOIN, multiple table joins, COUNT(), AVG(), GROUP BY.

**Q31. Do we make more money from online orders or from orders taken by our sales representatives?**

Use the online order flag to categorise transactions into online and sales-representative channels. Calculate order counts, average order value and total due by channel.

**Business purpose:** Compare sales activity and order values across sales channels.

**SQL concepts:** CASE WHEN, COUNT(), AVG(), SUM(), GROUP BY.

**Q32. Who are our top five individual customers by total spend?**

Join customer, person and sales order tables to calculate order counts and total spend for individual customers. Rank the results by total spend.

**Business purpose:** Identify high-value individual customers based on recorded order value.

**SQL concepts:** INNER JOIN, CONCAT(), COUNT(), SUM(), GROUP BY, ORDER BY, TOP.

**Q33. For each year, how much revenue did each product category bring in?**

Join sales order details with sales order headers, products, product subcategories and product categories. Calculate product-line revenue by category and order year.

**Business purpose:** Understand how product categories contribute to sales revenue over time.

**SQL concepts:** Multiple table joins, YEAR(), SUM(), GROUP BY, ORDER BY.

**Q34. What is the average quantity of products per sales order line?**

Calculate the average order quantity using both integer and decimal calculations.

**Business purpose:** Understand average quantities recorded at sales order line level and the effect of integer versus decimal averages.

**SQL concepts:** AVG(), decimal arithmetic using `* 1.0`.

**Q35. Which product colour sells the most units?**

Join sales order details with product information and calculate total units sold by product colour.

**Business purpose:** Compare product sales volumes across colours.

**SQL concepts:** INNER JOIN, SUM(), GROUP BY, ORDER BY.

**Q36. How many orders and how much revenue did each European sales territory generate?**

Join sales territories with sales orders, filter the results to Europe and calculate order counts and subtotal by territory.

**Business purpose:** Compare order activity and subtotal values across European territories.

**SQL concepts:** INNER JOIN, WHERE, SUM(), COUNT(), ROUND(), GROUP BY, ORDER BY.

**Q37. How many orders did each customer place?**

Group sales orders by customer and identify the top 10 customers based on order count.

**Business purpose:** Identify customers with the highest recorded order frequency.

**SQL concepts:** COUNT(), GROUP BY, ORDER BY, TOP.

**Q38. Which products have never been sold?**

Use a LEFT JOIN between products and sales order details to identify products without matching sales records.

**Business purpose:** Identify products with no recorded sales-order detail for further investigation.

**SQL concepts:** LEFT JOIN, IS NULL.

**Q39. How many years ago was our very first order?**

Identify the earliest order date and calculate the difference in years between that date and the current date.

**Business purpose:** Understand the age of the recorded sales history.

**SQL concepts:** MIN(), DATEDIFF(), GETDATE().

**Q40. Which quarter of 2014 had the highest revenue?**

Group sales orders by quarter and calculate the subtotal for each quarter of 2014. Sort the results by revenue.

**Business purpose:** Compare quarterly sales performance and identify the highest-value quarter.

**SQL concepts:** DATEPART(), SUM(), ROUND(), WHERE, GROUP BY, ORDER BY.

**Q41. On average, how many days were there between the shipping date and the due date for each order year?**

Calculate the average number of days between ship date and due date, grouped by order year. Exclude orders without a ship date.

**Business purpose:** Examine the average gap between shipping and due dates across different years.

**SQL concepts:** YEAR(), DATEDIFF(), AVG(), decimal arithmetic, IS NOT NULL, GROUP BY, ORDER BY.

## 6. SQL Skills Demonstrated

Through this project, I applied the following SQL concepts:

| SQL Skill | Application |
|---|---|
| SELECT and FROM | Retrieving data from database tables |
| TOP | Limiting query results |
| WHERE | Filtering records based on business conditions |
| AND | Applying multiple filtering conditions |
| DISTINCT | Identifying unique values |
| COUNT() | Counting records and orders |
| COUNT(DISTINCT) | Counting unique customers and values |
| SUM() | Calculating sales values and revenue |
| AVG() | Calculating average prices and sales values |
| MIN() and MAX() | Identifying minimum and maximum values |
| ROUND() | Rounding numerical results |
| GROUP BY | Aggregating data by categories, customers and periods |
| HAVING | Filtering grouped results |
| ORDER BY | Sorting query results |
| INNER JOIN | Combining matching records across related tables |
| LEFT JOIN | Identifying records without matching entries |
| Multiple Table Joins | Combining data across different database schemas |
| Table Aliases | Improving query readability |
| CASE WHEN | Categorising online and sales-representative orders |
| CONCAT() | Combining customer first and last names |
| YEAR(), MONTH(), DAY() | Extracting date components |
| DATEPART() | Extracting quarters and weekdays |
| DATENAME() | Retrieving month and weekday names |
| DATEDIFF() | Calculating differences between dates |
| DATEADD() | Adding intervals to dates |
| EOMONTH() | Identifying month-end dates |
| GETDATE() | Working with the current date |
| CAST() | Converting data types |
| FORMAT() | Formatting date values |
| Decimal Arithmetic | Using decimal calculations for more accurate averages |

## 7. Business Areas Explored

The 41 queries cover several important business analysis areas:

| Business Area | Analysis |
|---|---|
| Product portfolio | Product counts, colours and product availability |
| Product pricing | Average, minimum and maximum list prices |
| Sales performance | Order volumes and sales values |
| Revenue analysis | Revenue by year, product and category |
| Customer analysis | Customer spend, order frequency and purchasing history |
| Sales channels | Online versus sales-representative orders |
| Territory analysis | Regional order volumes and sales values |
| Time-based analysis | Monthly, quarterly, annual and weekday trends |
| Shipping analysis | Order-to-ship duration and due-date comparisons |
| Product performance | Units sold and products without recorded sales |

## 8. Tools and Technologies

- **Microsoft SQL Server:** Database management and query execution.
- **SQL Server Management Studio (SSMS):** Writing and executing T-SQL queries.
- **AdventureWorks 2022:** Relational sample database used for business analysis.
- **GitHub:** Project documentation and portfolio presentation.

## 9. Project Conclusion

This project provided practical experience in using SQL Server to analyse business data across multiple related database tables.

I applied querying, filtering, aggregation, joins, conditional logic and date functions to investigate product performance, sales revenue, customer activity, sales channels, geographical performance and order fulfilment.

The project strengthened my ability to translate business questions into SQL queries, work with relational data and produce structured information that can support business reporting and decision-making.

It also developed my understanding of how different areas of a business can be analysed using data from interconnected systems.

## 10. Further Development

Potential extensions to this project include:

- Developing Power BI dashboards to visualise sales and product performance.
- Conducting year-on-year and month-on-month revenue comparisons.
- Analysing product and category contribution to total sales.
- Investigating customer retention and repeat purchasing patterns.
- Comparing sales channel performance across different periods.
- Analysing regional sales performance using consistent revenue measures.
- Investigating the proportion of orders shipped later than defined targets.
- Extending the analysis using CTEs, subqueries and window functions.

## Author

**Poornisha Ramesh**

Qualified finance professional developing practical skills in data analytics, SQL, Excel and Power BI.

This project forms part of my data analytics learning and professional portfolio.

LinkedIn: https://www.linkedin.com/poornisha-ramesh

GitHub: [PRamesh747](https://github.com/PRamesh747)
