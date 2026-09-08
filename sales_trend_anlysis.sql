-- =====================================================
-- TASK 6: SALES TREND ANALYSIS USING AGGREGATIONS
-- Database: SQLite
-- Table: orders
-- Dataset: Online Sales Data
-- =====================================================


-- 1. View sample data
SELECT *
FROM orders
LIMIT 10;


-- 2. Count total records
SELECT
    COUNT(*) AS total_records
FROM orders;


-- 3. Check date range
SELECT
    MIN("Date") AS first_order_date,
    MAX("Date") AS last_order_date
FROM orders;


-- 4. Check duplicate transactions
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT "Transaction ID") AS unique_transactions
FROM orders;


-- 5. Check NULL values
SELECT
    COUNT(*) AS total_rows,
    COUNT("Transaction ID") AS transaction_id_count,
    COUNT("Date") AS date_count,
    COUNT("Total Revenue") AS revenue_count,
    COUNT("Product Category") AS category_count,
    COUNT("Product Name") AS product_name_count,
    COUNT("Units Sold") AS units_sold_count,
    COUNT("Unit Price") AS unit_price_count,
    COUNT("Region") AS region_count,
    COUNT("Payment Method") AS payment_method_count
FROM orders;


-- 6. Monthly revenue
SELECT
    strftime('%Y-%m', "Date") AS sales_month,
    SUM("Total Revenue") AS monthly_revenue
FROM orders
GROUP BY
    strftime('%Y-%m', "Date")
ORDER BY
    sales_month;


-- 7. Monthly order volume
SELECT
    strftime('%Y-%m', "Date") AS sales_month,
    COUNT(DISTINCT "Transaction ID") AS order_volume
FROM orders
GROUP BY
    strftime('%Y-%m', "Date")
ORDER BY
    sales_month;


-- 8. MAIN ANALYSIS
-- Monthly revenue and order volume
SELECT
    strftime('%Y-%m', "Date") AS sales_month,
    SUM("Total Revenue") AS monthly_revenue,
    COUNT(DISTINCT "Transaction ID") AS order_volume
FROM orders
GROUP BY
    strftime('%Y-%m', "Date")
ORDER BY
    sales_month;


-- 9. TOP 3 MONTHS BY REVENUE
SELECT
    strftime('%Y-%m', "Date") AS sales_month,
    SUM("Total Revenue") AS monthly_revenue
FROM orders
GROUP BY
    strftime('%Y-%m', "Date")
ORDER BY
    monthly_revenue DESC
LIMIT 3;


-- 10. Highest order-volume month
SELECT
    strftime('%Y-%m', "Date") AS sales_month,
    COUNT(DISTINCT "Transaction ID") AS order_volume
FROM orders
GROUP BY
    strftime('%Y-%m', "Date")
ORDER BY
    order_volume DESC,
    sales_month ASC
LIMIT 1;


-- 11. All months with the highest order volume
WITH monthly_orders AS (
    SELECT
        strftime('%Y-%m', "Date") AS sales_month,
        COUNT(DISTINCT "Transaction ID") AS order_volume
    FROM orders
    GROUP BY
        strftime('%Y-%m', "Date")
)
SELECT *
FROM monthly_orders
WHERE order_volume = (
    SELECT MAX(order_volume)
    FROM monthly_orders
)
ORDER BY sales_month;


-- 12. Total revenue
SELECT
    SUM("Total Revenue") AS total_revenue
FROM orders;


-- 13. Total unique orders
SELECT
    COUNT(DISTINCT "Transaction ID") AS total_orders
FROM orders;


-- 14. Monthly units sold
SELECT
    strftime('%Y-%m', "Date") AS sales_month,
    SUM("Units Sold") AS total_units_sold
FROM orders
GROUP BY
    strftime('%Y-%m', "Date")
ORDER BY
    sales_month;


-- 15. Average order value by month
SELECT
    strftime('%Y-%m', "Date") AS sales_month,
    SUM("Total Revenue") AS monthly_revenue,
    COUNT(DISTINCT "Transaction ID") AS order_volume,
    ROUND(
        SUM("Total Revenue") /
        NULLIF(COUNT(DISTINCT "Transaction ID"), 0),
        2
    ) AS average_order_value
FROM orders
GROUP BY
    strftime('%Y-%m', "Date")
ORDER BY
    sales_month;