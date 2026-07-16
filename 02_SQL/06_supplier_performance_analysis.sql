/*
===========================================================
Enterprise Supply Chain Intelligence
Phase 2 - Supplier Performance Analysis

Author      : Vijay Sharma
Database    : SupplyChainDB

Description:
Supplier performance analysis queries for evaluating
supplier procurement spend, order volume, delivery
performance, and operational efficiency.
===========================================================
*/
--------------------------------------------------------
-- Query 1
-- View All Suppliers
-- Business Purpose:
-- Display all supplier records for initial data exploration.
--------------------------------------------------------
SELECT 
	* 
FROM suppliers;
--------------------------------------------------------
-- Query 2
-- Total Procurement Spend by Supplier
-- Business Purpose:
-- Calculate the total procurement spend for each supplier.
--------------------------------------------------------
SELECT 
	s.supplier_name,
	SUM (po.total_cost) AS total_procurement_spend
FROM suppliers s
JOIN purchase_orders po
ON s.supplier_id = po.supplier_id
GROUP BY 
	s.supplier_name
ORDER BY 
	 total_procurement_spend DESC;
--------------------------------------------------------
-- Query 3
-- Total Purchase Orders by Supplier
-- Business Purpose:
-- Count the total number of purchase orders for each supplier.
--------------------------------------------------------
SELECT 
	s.supplier_name,
	COUNT (po.purchase_order_id) AS total_purchase_orders
FROM suppliers s
JOIN purchase_orders po
ON s.supplier_id = po.supplier_id
GROUP BY 
	s.supplier_name
ORDER BY 
	total_purchase_orders DESC;

--------------------------------------------------------
-- Query 4
-- Average Purchase Order Value by Supplier
-- Business Purpose:
-- Calculate the average purchase order value for each
-- supplier to evaluate purchasing patterns.
--------------------------------------------------------

SELECT 
	s.supplier_name,
	ROUND (AVG(po.total_cost), 2) AS average_purchase_order_value
FROM suppliers s
JOIN purchase_orders po
ON s.supplier_id = po.supplier_id
GROUP BY 
	s.supplier_name
ORDER BY 
	average_purchase_order_value DESC;

