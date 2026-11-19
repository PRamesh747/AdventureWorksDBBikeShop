# AdventureWorks 2022 – SQL Data Analysis Project

## Project overview
This repository contains my SQL practice and analysis using the Microsoft AdventureWorks sample database. The queries are organised around business questions involving sales, customers, products and sales territories.

## Tools
- Microsoft SQL Server
- SQL Server Management Studio (SSMS)
- T-SQL
- AdventureWorks sample database

## Folder structure
| Folder | Topics |
|---|---|
| `01_Warm_Up` | Basic SELECT, TOP, WHERE and ORDER BY |
| `02_Aggregates` | COUNT, SUM, AVG, MIN, MAX and GROUP BY |
| `03_Date_Functions` | Date filtering and date functions |
| `04_Joins` | Joining related tables |
| `05_Joins_and_Aggregates` | Joins with grouping and aggregate calculations |
| `06_Combined_Analysis` | Multi-table analysis, CASE and CONCAT |
| `07_Extra_Practice` | Additional business questions |

## How to use
1. Connect to an AdventureWorks database in SQL Server.
2. Open a `.sql` file in SSMS.
3. Check that the database and table names match your installation.
4. Run the query and review the results.

## Check the database date range
Different AdventureWorks copies may contain different date ranges. Run `CHECK_DATABASE_DATE_RANGE.sql` before using year-specific filters. Only use years that exist in your database.

## Project skills
This project provides practice in translating business questions into SQL, filtering and sorting data, aggregating information, working with dates, and joining related tables.

**Note:** The SQL files added to this repository should be your own tested queries. Record only findings that you have confirmed from your query results.
