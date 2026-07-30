/*
===========================================================
Enterprise Supply Chain Intelligence
Phase 2 - SQL Views

Author      : Vijay Sharma
Database    : SupplyChainDB

Description:
This file contains reusable SQL Views developed for
Supply Chain Analytics. These views simplify complex
queries by creating reusable business datasets for
procurement, inventory, sales, warehouse, and logistics
analysis. The views can be directly consumed by analysts,
Power BI dashboards, and reporting applications.
===========================================================
*/

--------------------------------------------------------
-- View 1
-- Supplier Procurement Summary
-- Business Purpose:
-- Create a reusable supplier procurement summary
-- showing purchase order count, procurement spend,
-- and average purchase order value for each supplier.
-- This view can be used for procurement reporting,
-- supplier performance analysis, and Power BI dashboards.
--------------------------------------------------------
DROP view vw_supplier_procurement_summary;
CREATE VIEW vw_supplier_procurement_summary AS
SELECT
    s.supplier_name,
    s.city AS supplier_city,
    COUNT(po.purchase_order_id) AS total_purchase_orders,
    SUM(po.total_cost) AS total_procurement_spend,
    ROUND(AVG(po.total_cost),2) AS average_purchase_order_value
FROM suppliers s
INNER JOIN purchase_orders po
    ON s.supplier_id = po.supplier_id
GROUP BY
    s.supplier_name,
    s.city;

--------------------------------------------------------
-- Query 32
-- View All Supplier Procurement Summary Records
-- Business Purpose:
-- Retrieve all records from the supplier procurement
-- summary view to verify that the view has been created
-- successfully and returns the expected aggregated
-- procurement data. This query is commonly used for
-- validation, testing, and initial data exploration
-- before building reports and dashboards.
--------------------------------------------------------

SELECT 
	*
FROM vw_supplier_procurement_summary;

--------------------------------------------------------
-- Query 33
-- Retrieve Supplier Procurement KPIs
-- Business Purpose:
-- Retrieve key supplier procurement metrics from the
-- supplier procurement summary view. This query returns
-- supplier name, total purchase orders, and total
-- procurement spend for reporting, dashboarding, and
-- procurement performance analysis.
--------------------------------------------------------

SELECT 
	supplier_name,
	total_purchase_orders,
	total_procurement_spend
FROM vw_supplier_procurement_summary
ORDER BY total_procurement_spend DESC;

--------------------------------------------------------
-- Query 34
-- Retrieve High-Spend Suppliers
-- Business Purpose:
-- Identify suppliers whose total procurement spend
-- exceeds ₹500,000. This report helps procurement
-- managers focus on strategic suppliers for contract
-- negotiations, cost optimization, and supplier
-- performance reviews.
--------------------------------------------------------

SELECT 
	*
FROM vw_supplier_procurement_summary
WHERE total_procurement_spend > 500000
ORDER BY total_procurement_spend DESC
LIMIT 5;

--------------------------------------------------------
-- Query 35
-- Retrieve Top 5 Suppliers by Procurement Spend
-- Business Purpose:
-- Identify the top five suppliers based on total
-- procurement spend. This report helps management
-- recognize strategic suppliers, monitor procurement
-- concentration, and support contract negotiations.
--------------------------------------------------------

SELECT 
	supplier_name,
    total_procurement_spend
FROM vw_supplier_procurement_summary
ORDER BY total_procurement_spend DESC
LIMIT 5;

--------------------------------------------------------
-- Query 36
-- Retrieve Top 3 High-Value Suppliers by Average
-- Purchase Order Value
-- Business Purpose:
-- Identify the top three high-spend suppliers with the
-- highest average purchase order value. This report
-- helps procurement managers evaluate high-value
-- supplier relationships, support contract
-- negotiations, and optimize strategic sourcing
-- decisions.
--------------------------------------------------------

SELECT 
	supplier_name,
    total_procurement_spend,
	average_purchase_order_value
FROM vw_supplier_procurement_summary
WHERE total_procurement_spend > 500000
ORDER BY average_purchase_order_value DESC
LIMIT 3;

--------------------------------------------------------
-- Query 37
-- Retrieve Procurement Summary for Mumbai Suppliers
-- Business Purpose:
-- Retrieve procurement performance metrics for suppliers
-- located in Mumbai. This report supports regional
-- procurement analysis, supplier performance reviews,
-- and location-based procurement decision-making.
--------------------------------------------------------

SELECT 
	supplier_name,
    supplier_city,
    total_purchase_orders,
    total_procurement_spend,
    average_purchase_order_value
FROM vw_supplier_procurement_summary
WHERE supplier_city = 'Mumbai'
ORDER BY total_procurement_spend DESC;

--------------------------------------------------------
-- Query 38
-- Retrieve Suppliers with High Average Purchase
-- Order Value
-- Business Purpose:
-- Identify suppliers whose average purchase order
-- value exceeds ₹100,000. This report helps
-- procurement managers identify high-value supplier
-- relationships for strategic sourcing, contract
-- negotiations, and procurement planning.
--------------------------------------------------------

SELECT
	supplier_name,
	average_purchase_order_value,
	total_procurement_spend
FROM vw_supplier_procurement_summary
WHERE average_purchase_order_value > 100000
ORDER BY average_purchase_order_value DESC;
	
