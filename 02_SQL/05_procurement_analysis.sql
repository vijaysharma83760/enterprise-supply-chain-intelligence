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
