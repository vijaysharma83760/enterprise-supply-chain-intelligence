/*
===========================================================
Enterprise Supply Chain Intelligence
Phase 2 - Sales Analysis

Author      : Vijay Sharma
Database    : SupplyChainDB

Description:
This script contains sales analysis queries for monitoring
sales performance, revenue generation, customer demand,
product performance, and order status.

Topics Covered:
- Sales Overview
- Revenue Analysis
- Product Performance
- Customer Analysis
- Order Status Analysis
- Monthly Sales
===========================================================
*/

-----------------------------------------------------------
-- Query 1
-- View All Sales Orders
-----------------------------------------------------------

SELECT *
FROM sales_orders;

-----------------------------------------------------------
-- Query 2
-- Total Sales Revenue
-----------------------------------------------------------

SELECT
SUM(total_sales) AS total_sales_revenue
FROM sales_orders;

-----------------------------------------------------------
-- Query 3
-- Top 5 Selling Products by Quantity
-----------------------------------------------------------

SELECT
p.product_name,
SUM(s.quantity) AS total_quantity_sold
FROM sales_orders s
JOIN products p
ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 5;

-----------------------------------------------------------
-- Query 4
-- Top 5 Products by Revenue
-----------------------------------------------------------

SELECT
p.product_name,
SUM(s.total_sales) AS total_revenue
FROM sales_orders s
JOIN products p
ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC
LIMIT 5;

-----------------------------------------------------------
-- Query 5
-- Customer-wise Sales Revenue
-----------------------------------------------------------

SELECT
customer_id,
SUM(total_sales) AS customer_revenue
FROM sales_orders
GROUP BY customer_id
ORDER BY customer_revenue DESC;

-----------------------------------------------------------
-- Query 6
-- Average Order Value
-----------------------------------------------------------

SELECT
ROUND(AVG(total_sales),2) AS average_order_value
FROM sales_orders;

-----------------------------------------------------------
-- Query 7
-- Delivered Orders
-----------------------------------------------------------

SELECT
COUNT(*) AS delivered_orders
FROM sales_orders
WHERE order_status='Delivered';

-----------------------------------------------------------
-- Query 8
-- Pending Orders
-----------------------------------------------------------

SELECT
COUNT(*) AS pending_orders
FROM sales_orders
WHERE order_status='Pending';

-----------------------------------------------------------
-- Query 9
-- Sales Status Summary
-----------------------------------------------------------

SELECT
order_status,
COUNT(*) AS total_orders
FROM sales_orders
GROUP BY order_status
ORDER BY total_orders DESC;

-----------------------------------------------------------
-- Query 10
-- Monthly Sales Revenue
-----------------------------------------------------------

SELECT
DATE_TRUNC('month', order_date) AS sales_month,
SUM(total_sales) AS monthly_sales
FROM sales_orders
GROUP BY sales_month
ORDER BY sales_month;
