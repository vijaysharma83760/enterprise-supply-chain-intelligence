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

--------------------------------------------------------
-- Query 50
-- Classify Inventory by Stock Status
-- Business Purpose:
-- Classify products based on their current stock level
-- compared with the reorder point and safety stock.
-- This helps warehouse and procurement teams quickly
-- identify products requiring replenishment, products
-- with low inventory buffers, and products with adequate
-- stock levels.
--------------------------------------------------------

SELECT 
    product_id,
    product_name,
    category,
    current_stock,
    reorder_point,
    safety_stock,
    CASE
        WHEN current_stock < reorder_point THEN 'Reorder'
        WHEN current_stock >= reorder_point 
             AND current_stock < safety_stock THEN 'Low Buffer'
        ELSE 'Adequate'
    END AS inventory_status
FROM vw_inventory_summary
ORDER BY current_stock ASC;

--------------------------------------------------------
-- Query 51
-- Identify Products with High Inventory Value at Risk
--
-- Business Purpose:
-- Identify products whose current stock is below the
-- defined reorder point and calculate the current
-- inventory value at risk. This helps procurement and
-- warehouse teams prioritize replenishment for products
-- with higher financial exposure.
--------------------------------------------------------

SELECT 
	product_id,
    product_name,
    category,
    current_stock,
    reorder_point,
    safety_stock,
	current_stock * unit_cost AS inventory_value_at_risk
FROM vw_inventory_summary
WHERE current_stock < reorder_point
ORDER BY inventory_value_at_risk DESC;

--------------------------------------------------------
-- Query 52
-- Calculate Inventory Coverage Ratio
--
-- Business Purpose:
-- Calculate the inventory coverage ratio for each
-- product by comparing its current inventory level
-- with the defined reorder point. This helps inventory
-- planners identify products with relatively low
-- inventory coverage and prioritize inventory review.
--------------------------------------------------------

SELECT 
	product_id,
    product_name,
    category,
    current_stock,
    reorder_point,
    safety_stock,
	unit_cost,
	(current_stock * unit_cost) / (reorder_point * unit_cost) AS inventory_coverage_ratio
FROM vw_inventory_summary
ORDER BY inventory_coverage_ratio ASC;

--------------------------------------------------------
-- Query 53
-- Identify Products with Low Inventory Coverage
--
-- Business Purpose:
-- Identify products whose inventory coverage ratio is
-- below 1. This helps inventory and procurement teams
-- identify products whose current inventory level is
-- below the defined reorder-point level and prioritize
-- them for further inventory review.
--------------------------------------------------------

SELECT 
	product_id,
    product_name,
    category,
    current_stock,
    reorder_point,
    safety_stock,
	unit_cost,
	(current_stock * unit_cost) / (reorder_point * unit_cost) AS inventory_coverage_ratio
FROM vw_inventory_summary
WHERE (current_stock * unit_cost) / (reorder_point * unit_cost) < 1
ORDER BY inventory_coverage_ratio ASC;

--------------------------------------------------------
-- Query 54
-- Classify Products by Inventory Coverage Risk
--
-- Business Purpose:
-- Classify products based on their inventory coverage
-- ratio to identify critical, high-risk, moderate-risk,
-- and adequate inventory positions. This helps inventory
-- and procurement teams prioritize products requiring
-- closer monitoring and replenishment attention.
--------------------------------------------------------

SELECT 
	product_id,
    product_name,
    category,
    current_stock,
    reorder_point,
    safety_stock,
	unit_cost,
	(current_stock * unit_cost) / (reorder_point * unit_cost) AS inventory_coverage_ratio,
	CASE
	WHEN (current_stock * unit_cost) / (reorder_point * unit_cost) < .50 THEN 'Critical'
	WHEN (current_stock * unit_cost) / (reorder_point * unit_cost) >=0.50 
		AND (current_stock * unit_cost) / (reorder_point * unit_cost) <0.75 THEN 'High Risk'
	WHEN (current_stock * unit_cost) / (reorder_point * unit_cost) >=.75 
		AND (current_stock * unit_cost) / (reorder_point * unit_cost) <1.00 THEN 'Moderate Risk'
	ELSE 'Adequate'
	END AS inventory_coverage_ratio_status
FROM vw_inventory_summary
ORDER BY inventory_coverage_ratio ASC;

--------------------------------------------------------
-- Query 55
-- Identify Critical Inventory Products
--
-- Business Purpose:
-- Identify products with an inventory coverage ratio
-- below 0.50. This helps procurement and warehouse teams
-- identify critically understocked products and prioritize
-- urgent replenishment activities.
--------------------------------------------------------

SELECT 
	product_id,
    product_name,
    category,
    current_stock,
    reorder_point,
    safety_stock,
	unit_cost,
	(current_stock * unit_cost) / (reorder_point * unit_cost) AS inventory_coverage_ratio
FROM vw_inventory_summary
WHERE (current_stock * unit_cost) / (reorder_point * unit_cost) < .50
ORDER BY inventory_coverage_ratio ASC;

--------------------------------------------------------
-- Query 56
-- Identify High-Risk Inventory Products
--
-- Business Purpose:
-- Identify products with an inventory coverage ratio
-- between 0.50 and below 0.75. This helps inventory
-- and procurement teams identify products with high
-- inventory risk and prioritize them for monitoring
-- and potential replenishment.
--------------------------------------------------------

SELECT 
	product_id,
    product_name,
    category,
    current_stock,
    reorder_point,
    safety_stock,
	unit_cost,
	(current_stock * unit_cost) / (reorder_point * unit_cost) AS inventory_coverage_ratio
FROM vw_inventory_summary
WHERE (current_stock * unit_cost) / (reorder_point * unit_cost) >= .50 
	AND (current_stock * unit_cost) / (reorder_point * unit_cost) < .75
ORDER BY inventory_coverage_ratio ASC;

--------------------------------------------------------
-- Query 57
-- Identify Moderate-Risk Inventory Products
--
-- Business Purpose:
-- Identify products with an inventory coverage ratio
-- between 0.75 and below 1.00. This helps inventory
-- and procurement teams identify products with moderate
-- inventory risk and prioritize them for monitoring before
-- they reach higher-risk inventory levels.
--------------------------------------------------------

SELECT 
	product_id,
    product_name,
    category,
    current_stock,
    reorder_point,
    safety_stock,
	unit_cost,
	(current_stock * unit_cost) / (reorder_point * unit_cost) AS inventory_coverage_ratio
FROM vw_inventory_summary
WHERE (current_stock * unit_cost) / (reorder_point * unit_cost) >= .75 
	AND (current_stock * unit_cost) / (reorder_point * unit_cost) < 1.00
ORDER BY inventory_coverage_ratio ASC;

--------------------------------------------------------
-- Query 58
-- Identify Adequate Inventory Products
--
-- Business Purpose:
-- Identify products with an inventory coverage ratio
-- of 1.00 or higher. This helps inventory and procurement
-- teams identify products with sufficient inventory coverage
-- relative to the defined reorder-point level and distinguish
-- them from products requiring closer inventory monitoring.
--------------------------------------------------------

SELECT 
	product_id,
    product_name,
    category,
    current_stock,
    reorder_point,
    safety_stock,
	unit_cost,
	(current_stock * unit_cost) / (reorder_point * unit_cost) AS inventory_coverage_ratio
FROM vw_inventory_summary
WHERE (current_stock * unit_cost) / (reorder_point * unit_cost) >= 1.00
ORDER BY inventory_coverage_ratio DESC;

--------------------------------------------------------
-- Query 59
-- Calculate Inventory Value by Coverage Risk
--
-- Business Purpose:
-- Calculate the total inventory value associated with
-- each inventory coverage risk category. This helps
-- supply chain, inventory, and procurement teams understand
-- the financial exposure across critical, high-risk,
-- moderate-risk, and adequate inventory positions.
--------------------------------------------------------

SELECT
    CASE
        WHEN (current_stock * unit_cost) / (reorder_point * unit_cost) < 0.50
            THEN 'Critical'
        WHEN (current_stock * unit_cost) / (reorder_point * unit_cost) >= 0.50
             AND (current_stock * unit_cost) / (reorder_point * unit_cost) < 0.75
            THEN 'High Risk'
        WHEN (current_stock * unit_cost) / (reorder_point * unit_cost) >= 0.75
             AND (current_stock * unit_cost) / (reorder_point * unit_cost) < 1.00
            THEN 'Moderate Risk'
        ELSE 'Adequate'
    END AS inventory_coverage_risk,
    SUM(inventory_value) AS total_inventory_value
FROM vw_inventory_summary
GROUP BY
    CASE
        WHEN (current_stock * unit_cost) / (reorder_point * unit_cost) < 0.50
            THEN 'Critical'
        WHEN (current_stock * unit_cost) / (reorder_point * unit_cost) >= 0.50
             AND (current_stock * unit_cost) / (reorder_point * unit_cost) < 0.75
            THEN 'High Risk'
        WHEN (current_stock * unit_cost) / (reorder_point * unit_cost) >= 0.75
             AND (current_stock * unit_cost) / (reorder_point * unit_cost) < 1.00
            THEN 'Moderate Risk'
        ELSE 'Adequate'
    END
ORDER BY total_inventory_value DESC;

--------------------------------------------------------
-- Query 60
-- Suppliers with At Least One High-Value Purchase Order
--
-- Business Purpose:
-- Identify suppliers who have at least one purchase order
-- with a total cost of ₹200,000 or more. This helps
-- procurement teams identify suppliers involved in
-- financially significant purchase orders.
--
-- SQL Concepts:
-- EXISTS
-- Correlated Subquery
-- Supplier-Purchase Order Relationship
--------------------------------------------------------

SELECT 
	s.supplier_id,
	s.supplier_name
FROM suppliers s
WHERE EXISTS (
	SELECT 1 FROM purchase_orders po
	WHERE s.supplier_id = po.supplier_id
	AND po.total_cost >= 200000
)

--------------------------------------------------------
-- Query 61
-- Suppliers with No High-Value Purchase Orders
--
-- Business Purpose:
-- Identify suppliers who do not have any purchase order
-- with a total cost of ₹200,000 or more. This helps
-- procurement teams identify suppliers that have not
-- contributed to high-value procurement transactions.
--
-- SQL Concepts:
-- NOT EXISTS
-- Correlated Subquery
-- Supplier-Purchase Order Relationship
--------------------------------------------------------

SELECT 
	s.supplier_id,
	s.supplier_name
FROM suppliers s
WHERE NOT EXISTS (
	SELECT 1 FROM purchase_orders po
	WHERE s.supplier_id = po.supplier_id
	AND po.total_cost >= 200000
)

--------------------------------------------------------
-- Query 62
-- Supplier Order Status Summary
--
-- Business Purpose:
-- Summarize supplier purchase orders by total order
-- volume, high-value orders, pending orders, and
-- completed orders. This helps procurement teams
-- evaluate supplier order activity and financial exposure.
--
-- SQL Concepts:
-- Conditional Aggregation
-- SUM(CASE WHEN ...)
-- COUNT()
-- JOIN
-- GROUP BY
--------------------------------------------------------

SELECT
    s.supplier_id,
    s.supplier_name,
    COUNT(po.purchase_order_id) AS total_orders,
	
    SUM(
        CASE
            WHEN po.total_cost >= 200000 THEN 1
            ELSE 0
        END
    ) AS high_value_orders,
	
    SUM(
        CASE
            WHEN po.status = 'Pending' THEN 1
            ELSE 0
        END
    ) AS pending_orders,

    SUM(
        CASE
            WHEN po.status = 'Completed' THEN 1
            ELSE 0
        END
    ) AS completed_orders

FROM suppliers s
JOIN purchase_orders po
    ON s.supplier_id = po.supplier_id
GROUP BY
    s.supplier_id,
    s.supplier_name
ORDER BY
    total_orders DESC;

--------------------------------------------------------
-- Query 63
-- Inventory Risk KPI Dashboard
--
-- Business Purpose:
-- Create a consolidated inventory risk summary showing
-- the number of products in critical, high-risk,
-- moderate-risk, and adequate inventory positions.
-- This helps supply chain teams quickly assess overall
-- inventory exposure.
--
-- SQL Concepts:
-- Conditional Aggregation
-- SUM(CASE WHEN ...)
-- NULLIF()
--------------------------------------------------------

SELECT
    COUNT(*) AS total_products,

    SUM(
        CASE
            WHEN current_stock::numeric / NULLIF(reorder_point, 0) < 0.50
            THEN 1
            ELSE 0
        END
    ) AS critical_products,

    SUM(
        CASE
            WHEN current_stock::numeric / NULLIF(reorder_point, 0) >= 0.50
             AND current_stock::numeric / NULLIF(reorder_point, 0) < 0.75
            THEN 1
            ELSE 0
        END
    ) AS high_risk_products,

    SUM(
        CASE
            WHEN current_stock::numeric / NULLIF(reorder_point, 0) >= 0.75
             AND current_stock::numeric / NULLIF(reorder_point, 0) < 1.00
            THEN 1
            ELSE 0
        END
    ) AS moderate_risk_products,

    SUM(
        CASE
            WHEN current_stock::numeric / NULLIF(reorder_point, 0) >= 1.00
            THEN 1
            ELSE 0
        END
    ) AS adequate_products

FROM vw_inventory_summary;

--------------------------------------------------------
-- Query 64
-- Supplier Procurement Spend Contribution
--
-- Business Purpose:
-- Calculate each supplier's contribution to total
-- procurement spend and identify whether company
-- procurement spending is concentrated among a small
-- number of suppliers.
--
-- SQL Concepts:
-- CTE
-- Aggregation
-- Window Functions
-- Percentage Contribution
-- Running Total
--------------------------------------------------------

WITH supplier_spend AS (
    SELECT
        s.supplier_id,
        s.supplier_name,
        SUM(po.total_cost) AS total_procurement_spend
    FROM suppliers s
    JOIN purchase_orders po
        ON s.supplier_id = po.supplier_id
    GROUP BY
        s.supplier_id,
        s.supplier_name
)

SELECT
    supplier_id,
    supplier_name,
    total_procurement_spend,

    ROUND(
        total_procurement_spend * 100.0
        / SUM(total_procurement_spend) OVER (),
        2
    ) AS spend_percentage,

    ROUND(
        SUM(total_procurement_spend) OVER (
            ORDER BY total_procurement_spend DESC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) * 100.0
        / SUM(total_procurement_spend) OVER (),
        2
    ) AS cumulative_spend_percentage

FROM supplier_spend
ORDER BY total_procurement_spend DESC;

--------------------------------------------------------
-- Query 65
-- Monthly Procurement Spend Growth
--
-- Business Purpose:
-- Analyze month-over-month changes in procurement
-- spending to identify increasing or decreasing
-- procurement trends.
--
-- SQL Concepts:
-- DATE_TRUNC()
-- CTE
-- LAG()
-- Window Functions
-- Percentage Change
--------------------------------------------------------

WITH monthly_spend AS (
    SELECT
        DATE_TRUNC('month', order_date) AS procurement_month,
        SUM(total_cost) AS current_month_spend
    FROM purchase_orders
    GROUP BY DATE_TRUNC('month', order_date)
),

spend_comparison AS (
    SELECT
        procurement_month,
        current_month_spend,
        LAG(current_month_spend) OVER (
            ORDER BY procurement_month
        ) AS previous_month_spend
    FROM monthly_spend
)

SELECT
    procurement_month,
    current_month_spend,
    previous_month_spend,

    current_month_spend - previous_month_spend
        AS absolute_change,

    ROUND(
        (
            current_month_spend - previous_month_spend
        ) * 100.0
        / NULLIF(previous_month_spend, 0),
        2
    ) AS percentage_change

FROM spend_comparison
ORDER BY procurement_month;

--------------------------------------------------------
-- Query 66
-- Top 3 Products by Procurement Spend Within Each Category
--
-- Business Purpose:
-- Identify the three products with the highest
-- procurement spend within each product category.
-- This helps identify financially significant products
-- across different categories.
--
-- SQL Concepts:
-- CTE
-- ROW_NUMBER()
-- PARTITION BY
-- Top-N Per Group
--------------------------------------------------------

WITH product_spend AS (
    SELECT
        p.product_id,
        p.product_name,
        p.category,
        SUM(po.total_cost) AS total_procurement_spend
    FROM products p
    JOIN purchase_orders po
        ON p.product_id = po.product_id
    GROUP BY
        p.product_id,
        p.product_name,
        p.category
),

ranked_products AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY category
            ORDER BY total_procurement_spend DESC
        ) AS product_rank
    FROM product_spend
)

SELECT
    product_id,
    product_name,
    category,
    total_procurement_spend,
    product_rank

FROM ranked_products
WHERE product_rank <= 3

ORDER BY
    category,
    product_rank;

--------------------------------------------------------
-- Query 67
-- Latest Purchase Order for Each Supplier
--
-- Business Purpose:
-- Identify the most recent purchase order for every
-- supplier. This helps procurement teams monitor the
-- latest supplier activity.
--
-- SQL Concepts:
-- ROW_NUMBER()
-- PARTITION BY
-- Latest Record Per Entity
-- CTE
--------------------------------------------------------

WITH ranked_purchase_orders AS (
    SELECT
        po.purchase_order_id,
        po.supplier_id,
        po.product_id,
        po.order_date,
        po.total_cost,

        ROW_NUMBER() OVER (
            PARTITION BY po.supplier_id
            ORDER BY
                po.order_date DESC,
                po.purchase_order_id DESC
        ) AS rn

    FROM purchase_orders po
)

SELECT
    s.supplier_id,
    s.supplier_name,
    rpo.purchase_order_id,
    rpo.product_id,
    rpo.order_date,
    rpo.total_cost

FROM suppliers s
JOIN ranked_purchase_orders rpo
    ON s.supplier_id = rpo.supplier_id

WHERE rpo.rn = 1

ORDER BY s.supplier_id;

--------------------------------------------------------
-- Query 68
-- Purchase Order Data Quality Check
--
-- Business Purpose:
-- Identify potential data quality issues in purchase
-- order records before they are used for analytics
-- or business decision-making.
--
-- SQL Concepts:
-- CASE
-- IS NULL
-- COALESCE()
-- NULLIF()
-- Data Quality Validation
--------------------------------------------------------

SELECT
    purchase_order_id,
    supplier_id,
    product_id,
    order_date,
    quantity,
    unit_cost,
    total_cost,

    CASE
        WHEN supplier_id IS NULL
            THEN 'Missing Supplier'

        WHEN product_id IS NULL
            THEN 'Missing Product'

        WHEN quantity IS NULL OR quantity <= 0
            THEN 'Invalid Quantity'

        WHEN unit_cost IS NULL OR unit_cost <= 0
            THEN 'Invalid Unit Cost'

        WHEN total_cost IS NULL OR total_cost < 0
            THEN 'Invalid Total Cost'

        ELSE 'Valid Record'
    END AS data_quality_status

FROM purchase_orders

ORDER BY purchase_order_id;

--------------------------------------------------------
-- Query 69
-- Identify Potential Duplicate Purchase Orders
--
-- Business Purpose:
-- Identify purchase order records with identical
-- supplier, product, order date, quantity, and unit
-- cost combinations that may represent duplicate
-- transactions.
--
-- SQL Concepts:
-- GROUP BY
-- HAVING
-- COUNT()
-- Duplicate Detection
--------------------------------------------------------

SELECT
    supplier_id,
    product_id,
    order_date,
    quantity,
    unit_cost,
    COUNT(*) AS duplicate_count

FROM purchase_orders

GROUP BY
    supplier_id,
    product_id,
    order_date,
    quantity,
    unit_cost

HAVING COUNT(*) > 1

ORDER BY duplicate_count DESC;

--------------------------------------------------------
-- Query 70
-- Procurement Executive KPI Summary
--
-- Business Purpose:
-- Create a consolidated procurement KPI summary for
-- management reporting. The query provides a single
-- view of procurement spend, purchase order volume,
-- average order value, high-value orders, and supplier
-- activity.
--
-- SQL Concepts:
-- Aggregation
-- Conditional Aggregation
-- CASE
-- COUNT()
-- SUM()
-- AVG()
--------------------------------------------------------

SELECT
    SUM(total_cost) AS total_procurement_spend,

    COUNT(purchase_order_id) AS total_purchase_orders,

    ROUND(
        AVG(total_cost),
        2
    ) AS average_purchase_order_value,

    SUM(
        CASE
            WHEN total_cost >= 200000 THEN 1
            ELSE 0
        END
    ) AS high_value_orders,

    SUM(
        CASE
            WHEN status = 'Pending' THEN 1
            ELSE 0
        END
    ) AS pending_orders,

    SUM(
        CASE
            WHEN status = 'Completed' THEN 1
            ELSE 0
        END
    ) AS completed_orders,

    COUNT(DISTINCT supplier_id) AS active_suppliers

FROM purchase_orders;

--------------------------------------------------------
-- Query 71
-- High-Spend Suppliers with High Order Volume
--
-- Business Purpose:
-- Identify suppliers that have both high procurement
-- spend and high purchase order volume. These suppliers
-- represent financially and operationally significant
-- procurement dependencies.
--
-- SQL Concepts:
-- CTE
-- Aggregation
-- AVG()
-- Multi-Criteria Filtering
--------------------------------------------------------

WITH supplier_metrics AS (
    SELECT
        s.supplier_id,
        s.supplier_name,
        SUM(po.total_cost) AS total_procurement_spend,
        COUNT(po.purchase_order_id) AS total_orders

    FROM suppliers s
    JOIN purchase_orders po
        ON s.supplier_id = po.supplier_id

    GROUP BY
        s.supplier_id,
        s.supplier_name
)

SELECT
    supplier_id,
    supplier_name,
    total_procurement_spend,
    total_orders

FROM supplier_metrics

WHERE total_procurement_spend > (
    SELECT AVG(total_procurement_spend)
    FROM supplier_metrics
)

AND total_orders > (
    SELECT AVG(total_orders)
    FROM supplier_metrics
)

ORDER BY total_procurement_spend DESC;

--------------------------------------------------------
-- Query 72
-- Financially Significant Inventory Risk
--
-- Business Purpose:
-- Identify products that have both low inventory
-- coverage and significant inventory value. This helps
-- supply chain teams prioritize financially important
-- inventory risks instead of treating all stock risks
-- equally.
--
-- SQL Concepts:
-- CTE
-- CASE
-- Inventory Coverage Ratio
-- Multi-Criteria Filtering
-- NULLIF()
--------------------------------------------------------

WITH inventory_risk AS (
    SELECT
        product_id,
        product_name,
        category,
        current_stock,
        reorder_point,
        inventory_value,

        current_stock::numeric
        / NULLIF(reorder_point, 0)
        AS inventory_coverage_ratio

    FROM vw_inventory_summary
)

SELECT
    product_id,
    product_name,
    category,
    current_stock,
    reorder_point,
    inventory_value,

    ROUND(
        inventory_coverage_ratio,
        2
    ) AS inventory_coverage_ratio,

    CASE
        WHEN inventory_coverage_ratio < 0.50
            THEN 'Critical'

        WHEN inventory_coverage_ratio < 0.75
            THEN 'High Risk'

        ELSE 'Moderate Risk'
    END AS risk_level

FROM inventory_risk

WHERE inventory_coverage_ratio < 0.75
  AND inventory_value > (
      SELECT AVG(inventory_value)
      FROM vw_inventory_summary
  )

ORDER BY inventory_value DESC;

--------------------------------------------------------
-- Query 73
-- Top 3 Products by Procurement Spend Per Category
--
-- Business Purpose:
-- Solve the classic SQL interview problem of finding
-- the top three products within each category based
-- on procurement spend.
--
-- SQL Concepts:
-- DENSE_RANK()
-- PARTITION BY
-- CTE
-- Top-N Per Group
--------------------------------------------------------

WITH product_procurement AS (
    SELECT
        p.product_id,
        p.product_name,
        p.category,
        SUM(po.total_cost) AS total_procurement_spend

    FROM products p
    JOIN purchase_orders po
        ON p.product_id = po.product_id

    GROUP BY
        p.product_id,
        p.product_name,
        p.category
),

ranked_products AS (
    SELECT
        *,
        DENSE_RANK() OVER (
            PARTITION BY category
            ORDER BY total_procurement_spend DESC
        ) AS spend_rank

    FROM product_procurement
)

SELECT
    product_id,
    product_name,
    category,
    total_procurement_spend,
    spend_rank

FROM ranked_products

WHERE spend_rank <= 3

ORDER BY
    category,
    spend_rank;
