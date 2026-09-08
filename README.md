# Task 6: Sales Trend Analysis Using Aggregations

## Objective

The objective of this task is to analyze monthly revenue and order volume using SQL aggregation functions.

## Tool Used

DB Browser for SQLite

## Database

SQLite

## Dataset

Online Sales Data

The dataset contains 240 transactions from January 2024 to August 2024.

## Table

orders

## Dataset Columns

- Transaction ID
- Date
- Product Category
- Product Name
- Units Sold
- Unit Price
- Total Revenue
- Region
- Payment Method

## Column Mapping

For this analysis:

- Transaction ID = Order ID
- Date = Order Date
- Total Revenue = Amount

## Analysis Performed

1. Checked total number of records.
2. Checked the date range.
3. Checked duplicate transactions.
4. Checked NULL values.
5. Calculated monthly revenue.
6. Calculated monthly order volume.
7. Combined monthly revenue and order volume.
8. Identified the top 3 months by revenue.
9. Identified months with the highest order volume.
10. Calculated total revenue and total orders.

## SQL Concepts Used

- SELECT
- SUM()
- COUNT()
- COUNT(DISTINCT)
- GROUP BY
- ORDER BY
- LIMIT
- MIN()
- MAX()
- COALESCE()
- strftime()

## Main Query

```sql
SELECT
    strftime('%Y-%m', "Date") AS sales_month,
    SUM("Total Revenue") AS monthly_revenue,
    COUNT(DISTINCT "Transaction ID") AS order_volume
FROM orders
GROUP BY
    strftime('%Y-%m', "Date")
ORDER BY
    sales_month;
