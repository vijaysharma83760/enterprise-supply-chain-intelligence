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

/*
===========================================================
Enterprise Supply Chain Intelligence
Phase 2 - SQL Views

Author      : Vijay Sharma
Database    : SupplyChainDB

View 2      : Inventory Summary View

Description:
This view provides a consolidated inventory summary by
combining product master data with inventory records.
It enables inventory monitoring, stock valuation, and
reorder analysis through a reusable business dataset.

Business Use Cases:
- Monitor current inventory levels
- Analyze inventory value by product
- Support reorder planning
- Track safety stock compliance
- Build inventory management dashboards
===========================================================
*/

CREATE VIEW vw_inventory_summary AS 
SELECT 
	p.product_id,
	P.product_name,
	p.category,
	in_.current_stock,
	p.reorder_point,
	p.safety_stock,
	p.unit_cost,
	in_.inventory_value
FROM products p
INNER JOIN inventory in_
ON p.product_id = in_.product_id
ORDER BY p.product_id;

--------------------------------------------------------
-- Query 39
-- View Complete Inventory Summary
-- Business Purpose:
-- Display complete inventory information using the
-- inventory summary view for daily monitoring and
-- operational reporting.
--------------------------------------------------------

SELECT 
	* 
FROM vw_inventory_summary;

--------------------------------------------------------
-- Query 40
-- High-Value Inventory Items
-- Business Purpose:
-- Identify products with high inventory value to
-- support inventory investment analysis and working
-- capital management.
--------------------------------------------------------

SELECT 
	product_id,
	product_name,
	category,
	inventory_value
FROM vw_inventory_summary
WHERE inventory_value > 500000
ORDER BY inventory_value DESC;

--------------------------------------------------------
-- Query 41
-- Products Requiring Reorder
-- Business Purpose:
-- Identify products whose current stock has fallen
-- below the predefined reorder point. This report
-- helps inventory planners prioritize replenishment,
-- prevent stock shortages, and maintain optimal
-- inventory levels.
--------------------------------------------------------

SELECT 
	product_id,
	product_name,
	category,
	current_stock,
	reorder_point
FROM vw_inventory_summary
WHERE current_stock < reorder_point
ORDER BY current_stock ASC;

--------------------------------------------------------
-- Query 42
-- Overstocked Products
-- Business Purpose:
-- Identify products whose current stock exceeds the
-- defined safety stock level. This report helps
-- inventory managers monitor excess inventory,
-- optimize warehouse utilization, and reduce
-- inventory carrying costs.
--------------------------------------------------------

SELECT 
	product_id,
	product_name,
	category,
	current_stock,
	safety_stock
FROM vw_inventory_summary
WHERE current_stock > safety_stock
ORDER BY current_stock DESC;

--------------------------------------------------------
-- Query 43
-- Inventory Status Classification
-- Business Purpose:
-- Classify each product based on its current stock
-- relative to the reorder point. This report helps
-- inventory managers quickly identify products that
-- require replenishment, are optimally stocked, or
-- have excess inventory.
--------------------------------------------------------

SELECT 
	product_id,
	product_name,
	category,
	current_stock,
	reorder_point,
CASE
	WHEN current_stock < reorder_point THEN 'Reorder'
	WHEN current_stock > reorder_point THEN 'Overstocked'
	ELSE 'Optimal'
	END AS current_status
FROM vw_inventory_summary
ORDER BY current_stock ASC;

--------------------------------------------------------
-- Query 44
-- Inventory Status Summary
-- Business Purpose:
-- Summarize the number of products in each inventory
-- status category. This report helps inventory
-- managers monitor stock health and supports
-- inventory planning decisions.
--------------------------------------------------------

SELECT
    CASE
        WHEN current_stock < reorder_point THEN 'Reorder'
        WHEN current_stock > reorder_point THEN 'Overstocked'
        ELSE 'Optimal'
    END AS current_status,
    COUNT(*) AS total_products
FROM vw_inventory_summary
GROUP BY
    CASE
        WHEN current_stock < reorder_point THEN 'Reorder'
        WHEN current_stock > reorder_point THEN 'Overstocked'
        ELSE 'Optimal'
    END
ORDER BY total_products DESC;

--------------------------------------------------------
-- Query 45
-- Top 10 Products by Inventory Value
-- Business Purpose:
-- Identify the top 10 products with the highest
-- inventory value. This report helps management
-- prioritize inventory investment, optimize working
-- capital allocation, and focus on high-value
-- inventory items.
--------------------------------------------------------

SELECT 
	product_id,
	product_name,
	category,
	inventory_value
FROM vw_inventory_summary
ORDER BY inventory_value DESC
LIMIT 10;

--------------------------------------------------------
-- Query 46
-- Identify Products Below Safety Stock
-- Business Purpose:
-- Identify products whose current stock has fallen
-- below the defined safety stock level. This helps
-- warehouse and procurement teams identify inventory
-- risk and prioritize replenishment activities.
--------------------------------------------------------
SELECT 
	product_id,
	product_name,
	category,
	current_stock,
	safety_stock
FROM vw_inventory_summary
WHERE current_stock < safety_stock
ORDER BY current_stock ASC;

--------------------------------------------------------
-- Query 47
-- Identify Products Above Reorder Point
-- Business Purpose:
-- Identify products whose current stock is above the
-- defined reorder point. This helps warehouse managers
-- monitor inventory availability and prioritize products
-- with higher stock levels for inventory planning.
--------------------------------------------------------

SELECT 
	product_id,
	product_name,
	category,
	current_stock,
	reorder_point
FROM vw_inventory_summary
WHERE current_stock > reorder_point
ORDER BY current_stock DESC;

--------------------------------------------------------
-- Query 48
-- Identify Products at or Below Reorder Point
-- Business Purpose:
-- Identify products whose current stock has reached or
-- fallen below the defined reorder point. This helps
-- procurement and warehouse teams identify products
-- that may require replenishment.
--------------------------------------------------------

SELECT 
	product_id,
	product_name,
	category,
	current_stock,
	reorder_point
FROM vw_inventory_summary
WHERE current_stock <= reorder_point
ORDER BY current_stock ASC;

--------------------------------------------------------
-- Query 49
-- Identify Products with the Largest Replenishment Gap
-- Business Purpose:
-- Identify products whose current stock is below the
-- defined reorder point and calculate the inventory gap.
-- This helps procurement and warehouse teams prioritize
-- replenishment for products with the largest shortages.
--------------------------------------------------------

SELECT 
	product_id,
	product_name,
	category,
	current_stock,
	reorder_point,
	reorder_point - current_stock AS reorder_gap 
FROM vw_inventory_summary
WHERE current_stock < reorder_point
ORDER BY reorder_gap DESC;
