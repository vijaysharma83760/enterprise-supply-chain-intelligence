/*
===========================================================
Enterprise Supply Chain Intelligence
Phase 2 - Procurement Analysis

Author      : Vijay Sharma
Database    : SupplyChainDB

Description:
Procurement analysis queries for monitoring purchase
orders, supplier performance and procurement costs.
===========================================================
*/

--------------------------------------------------------
-- Query 1
-- View All Purchase Orders
--------------------------------------------------------

SELECT *
FROM purchase_orders;

--------------------------------------------------------
-- Query 2
-- Purchase Orders by Total Cost (Highest to Lowest)
--------------------------------------------------------

SELECT
    purchase_order_id,
    quantity,
    unit_cost,
    total_cost
FROM purchase_orders
ORDER BY total_cost DESC;

--------------------------------------------------------
-- Query 3
-- Total Procurement Cost
--------------------------------------------------------

SELECT
    SUM(total_cost) AS total_procurement_cost
FROM purchase_orders;

--------------------------------------------------------
-- Query 4
-- Purchase Orders with Supplier Names
--------------------------------------------------------

SELECT
	po.purchase_order_id,
	s.supplier_name,
	po.quantity,
	po.unit_cost,
	po.total_cost,
	po.order_date
FROM purchase_orders po
JOIN suppliers s
ON po.supplier_id = s.supplier_id
ORDER BY po.total_cost DESC;

---------------------------------------------------------
-- Query 5
-- Top Products by Procurement Spend
-- Business Purpose:
-- Identify products with the highest procurement expenditure.
---------------------------------------------------------

SELECT
    pr.product_name,
    SUM(po.total_cost) AS total_procurement_spend
FROM products pr
JOIN purchase_orders po
ON pr.product_id = po.product_id
GROUP BY
    pr.product_name
ORDER BY
    total_procurement_spend DESC;

--------------------------------------------------------
-- Query 6
-- Procurement Spend by Supplier
-- Business Purpose:
-- Identify suppliers receiving the highest procurement spend.
--------------------------------------------------------

SELECT
    s.supplier_name,
    SUM(po.total_cost) AS total_procurement_spend
FROM suppliers s
JOIN purchase_orders po
ON s.supplier_id = po.supplier_id
GROUP BY
    s.supplier_name
ORDER BY
    total_procurement_spend DESC;

--------------------------------------------------------
-- Query 7
-- Average Purchase Order Value
-- Business Purpose:
-- Calculate the average value of all purchase orders.
--------------------------------------------------------

SELECT
    AVG(total_cost) AS average_purchase_order_value
FROM purchase_orders;

--------------------------------------------------------
-- Query 8
-- Total Purchase Orders by Supplier
-- Business Purpose:
-- Count the number of purchase orders for each supplier.
--------------------------------------------------------

SELECT
    s.supplier_name,
    COUNT(po.purchase_order_id) AS total_purchase_orders
FROM suppliers s
JOIN purchase_orders po
ON s.supplier_id = po.supplier_id
GROUP BY
    s.supplier_name
ORDER BY
    total_purchase_orders DESC;

--------------------------------------------------------
-- Query 9
-- High-Value Purchase Orders
-- Business Purpose:
-- Identify purchase orders with a total cost greater than
-- or equal to ₹200,000 for procurement monitoring.
--------------------------------------------------------

SELECT
    po.purchase_order_id,
    s.supplier_name,
    po.total_cost,
    po.order_date
FROM purchase_orders po
JOIN suppliers s
ON s.supplier_id = po.supplier_id
WHERE po.total_cost >= 200000
ORDER BY
    po.total_cost DESC;

--------------------------------------------------------
-- Query 10
-- Recent Purchase Orders
-- Business Purpose:
-- Display the latest purchase orders for procurement monitoring.
--------------------------------------------------------

SELECT
    po.purchase_order_id,
    s.supplier_name,
    po.order_date,
    po.total_cost
FROM purchase_orders po
JOIN suppliers s
ON po.supplier_id = s.supplier_id
ORDER BY
    po.order_date DESC
LIMIT 10;

--------------------------------------------------------
-- Query 11
-- Monthly Procurement Spend
-- Business Purpose:
-- Calculate monthly procurement spend for budgeting
-- and trend analysis.
--------------------------------------------------------

SELECT
    EXTRACT(MONTH FROM order_date) AS month,
    SUM(total_cost) AS monthly_procurement_spend
FROM purchase_orders
GROUP BY
    EXTRACT(MONTH FROM order_date)
ORDER BY
    month;

--------------------------------------------------------
-- Query 12
-- Pending Purchase Orders
-- Business Purpose:
-- Identify pending purchase orders requiring supplier
-- follow-up to ensure timely delivery and reduce delays.
--------------------------------------------------------

SELECT
    po.purchase_order_id,
    s.supplier_name,
    po.order_date,
    po.expected_delivery,
    po.total_cost,
    po.status
FROM purchase_orders po
JOIN suppliers s
ON po.supplier_id = s.supplier_id
WHERE po.status = 'Pending'
ORDER BY
    po.expected_delivery ASC;
