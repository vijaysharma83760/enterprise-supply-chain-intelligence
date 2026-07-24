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
--------------------------------------------------------
-- Query 5
-- Supplier Order Frequency Ranking
-- Business Purpose:
-- Rank suppliers by purchase order frequency to
-- identify strategic procurement partners.
--------------------------------------------------------

SELECT
	s.supplier_name,
	COUNT(*) AS total_purchase_orders
FROM suppliers s
JOIN purchase_orders po
ON s.supplier_id = po.supplier_id
GROUP BY
	s.supplier_name
ORDER BY
	total_purchase_orders DESC;

--------------------------------------------------------
-- Query 6
-- Top 5 Suppliers by Procurement Spend
-- Business Purpose:
-- Identify the top five suppliers receiving the highest
-- procurement spend for strategic sourcing analysis.
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
	total_procurement_spend DESC
LIMIT 5;

--------------------------------------------------------
-- Query 7
-- High-Value Suppliers
-- Business Purpose:
-- Display suppliers whose total procurement spend
-- exceeds ₹100,000 for procurement analysis.
--------------------------------------------------------

SELECT
	s.supplier_name,
	SUM(po.total_cost) AS total_procurement_spend
FROM suppliers s
JOIN purchase_orders po
ON s.supplier_id = po.supplier_id
GROUP BY
	s.supplier_name
HAVING
	SUM(po.total_cost) > 100000
ORDER BY
	total_procurement_spend DESC;

--------------------------------------------------------
-- Query 8
-- Supplier Performance Summary
-- Business Purpose:
-- Generate a supplier performance report showing
-- purchase order count, total procurement spend,
-- and average purchase order value.
--------------------------------------------------------

SELECT
	s.supplier_name,
	COUNT(*) AS total_orders,
	SUM(po.total_cost) AS total_spend,
	ROUND(AVG(po.total_cost), 2) AS average_order_value
FROM suppliers s
JOIN purchase_orders po
ON s.supplier_id = po.supplier_id
GROUP BY
	s.supplier_name
ORDER BY
	total_spend DESC;

--------------------------------------------------------
-- Query 9
-- Overall Average Purchase Order Value
-- Business Purpose:
-- Calculate the average purchase order value across
-- all purchase orders for benchmarking purposes.
--------------------------------------------------------

SELECT
	AVG(total_cost) AS overall_average_purchase_order_value
FROM purchase_orders;

--------------------------------------------------------
-- Query 10
-- Purchase Orders Above Company Average Value
-- Business Purpose:
-- Identify purchase orders whose total cost is higher
-- than the overall average purchase order value.
-- Helps procurement managers detect high-value
-- purchase orders for approval and analysis.
--------------------------------------------------------

SELECT
	product_id,
	total_cost
FROM purchase_orders
WHERE total_cost >
(
	SELECT
		ROUND(AVG(total_cost), 2)
	FROM purchase_orders
)
ORDER BY
	total_cost DESC;

--------------------------------------------------------
-- Query 11
-- Total Procurement Spend by Supplier
-- Business Purpose:
-- Calculate the total procurement spend for each
-- supplier to identify strategic suppliers and
-- measure supplier contribution to overall procurement.
--------------------------------------------------------

SELECT
	s.supplier_name,
	SUM(po.total_cost) AS total_suppliers_spend
FROM suppliers s
INNER JOIN purchase_orders po
	ON s.supplier_id = po.supplier_id
GROUP BY
	s.supplier_name
ORDER BY
	total_suppliers_spend DESC;

--------------------------------------------------------
-- Query 12
-- Suppliers with Above-Average Procurement Spend
-- Business Purpose:
-- Identify suppliers whose total procurement spend
-- is greater than the average procurement spend of
-- all suppliers. Useful for strategic sourcing and
-- supplier performance evaluation.
--------------------------------------------------------

SELECT
	s.supplier_name,
	SUM(po.total_cost) AS total_suppliers_spend
FROM suppliers s
INNER JOIN purchase_orders po
	ON s.supplier_id = po.supplier_id
GROUP BY
	s.supplier_name
HAVING
	SUM(po.total_cost) >
(
	SELECT
		AVG(total_supplier_spend)
	FROM
	(
		SELECT
			supplier_id,
			SUM(total_cost) AS total_supplier_spend
		FROM purchase_orders
		GROUP BY
			supplier_id
	) AS supplier_spend
)
ORDER BY
	total_suppliers_spend DESC;

--------------------------------------------------------
-- Query 13
-- Purchase Orders Above Supplier Average Value
-- Business Purpose:
-- Identify purchase orders whose total cost is greater
-- than the average purchase order value for the same
-- supplier. Helps detect unusually large purchase
-- orders relative to each supplier's normal pattern.
--------------------------------------------------------

SELECT
    po.purchase_order_id,
    s.supplier_name,
    po.total_cost
FROM purchase_orders po
INNER JOIN suppliers s
    ON po.supplier_id = s.supplier_id
WHERE po.total_cost >
(
    SELECT
        AVG(po2.total_cost)
    FROM purchase_orders po2
    WHERE po2.supplier_id = po.supplier_id
)
ORDER BY
    po.total_cost DESC;

--------------------------------------------------------
-- Query 14
-- Products Above Category Average Cost
-- Business Purpose:
-- Identify products whose unit cost is greater than
-- the average unit cost of products in the same
-- category.
--------------------------------------------------------

SELECT
    p1.product_id,
    p1.product_name,
    p1.category,
    p1.unit_cost
FROM products p1
WHERE p1.unit_cost >
(
    SELECT
        AVG(p2.unit_cost)
    FROM products p2
    WHERE p2.category = p1.category
)
ORDER BY
    p1.unit_cost DESC;



