# AdventureWorks 2022 – SQL Mini-Project: The Bike Shop

## Project overview
This portfolio project contains 41 SQL queries based on the *AdventureWorks SQL Mini-Project: The Bike Shop* task sheet. The exercises use business questions about a fictional bicycle business to practise querying relational sales, product, customer and territory data.

The project includes the 33 numbered tasks and the 8 extra-practice questions (numbered 34–41 here).

## Database and tools
- Database: Microsoft AdventureWorks sample database (user's working environment: AdventureWorks 2022)
- SQL dialect: T-SQL (Microsoft SQL Server)
- Query tool: SQL Server Management Studio (SSMS)

## Topics covered
- SELECT, TOP, WHERE, ORDER BY and DISTINCT
- Aggregate functions: COUNT, SUM, AVG, MIN and MAX
- GROUP BY and HAVING
- ROUND and handling NULL values
- Date functions: YEAR, MONTH, DAY, DATEPART, DATENAME, FORMAT, DATEDIFF, DATEADD, EOMONTH and GETDATE
- INNER JOIN and LEFT JOIN
- Multi-table joins across Sales, Production and Person schemas
- CASE expressions and CONCAT
- Subqueries/CTEs and transaction concepts are not part of the 41 task-sheet questions unless added separately

## Repository structure
- `01_Warm_Up/` – Tasks 1–2
- `02_Aggregates/` – Tasks 3–11
- `03_Date_Functions/` – Tasks 12–21
- `04_Joins/` – Tasks 22–25
- `05_Joins_and_Aggregates/` – Tasks 26–29
- `06_Combined_Analysis/` – Tasks 30–33, including the five-table final challenge
- `07_Extra_Practice/` – Extra practice questions 1–8, numbered 34–41

Each `.sql` file includes the business question, SQL concepts and query.

## How to run
1. Restore the AdventureWorks sample database in SQL Server.
2. Open SQL Server Management Studio and connect to your SQL Server instance.
3. Select the AdventureWorks database in the database dropdown.
4. Open a `.sql` file and execute it.

## Important date-range note
The task sheet says its worked example uses orders from May 2022 to June 2025. It also warns that some older restored copies contain 2011–2014 order dates; for those copies, subtract 11 from the years specified in the date-based exercises. Check your actual data before running tasks that filter for 2024:

```sql
SELECT
    MIN(OrderDate) AS FirstOrderDate,
    MAX(OrderDate) AS LastOrderDate
FROM Sales.SalesOrderHeader;
```

If the result shows 2011–2014 rather than 2022–2025, use the corresponding adjusted year (for example, 2013 instead of 2024) in the date-filtered exercises.

## Notes on interpretation
- Revenue is measured using the field specified by each exercise. Where a task asks for order-level revenue, the query uses `TotalDue`; the final challenge uses `SalesOrderDetail.LineTotal`, as instructed.
- The Europe extra-practice query uses `TotalDue` as order revenue (including tax and freight).
- Results can differ if the restored database version or its date range differs from the task sheet's example.

## Learning outcome
Practised translating business questions into T-SQL queries, joining related tables, aggregating sales data and analysing customer, product, territory and order information.

---
*This repository contains independently written practice solutions based on the supplied task sheet. It does not include the original task-sheet PDF or the AdventureWorks database.*
