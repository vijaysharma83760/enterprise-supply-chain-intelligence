/*
===========================================================
Enterprise Supply Chain Intelligence
Phase 2 - Inventory Analysis

Author      : Vijay Sharma
Database    : SupplyChainDB

Description:
This script contains inventory analysis queries used for
monitoring stock levels, reorder requirements, inventory
value, warehouse performance, and inventory KPIs.

Topics Covered:
- Inventory Overview
- Reorder Analysis
- Inventory Valuation
- Overstock Analysis
- Average Stock Analysis
- Highest & Lowest Inventory
- Category-wise Inventory
===========================================================
*/

-----------------------------------------------------------
-- Query 1
-- View Current Inventory
-----------------------------------------------------------

SELECT *
FROM inventory;

-----------------------------------------------------------
-- Query 2
-- Products Below Reorder Level
-----------------------------------------------------------

SELECT
    p.product_id,
    p.product_name,
    i.current_stock,
    i.reorder_level
FROM inventory i
JOIN products p
ON i.product_id = p.product_id
WHERE i.current_stock <= i.reorder_level
ORDER BY i.current_stock;

-----------------------------------------------------------
-- Query 3
-- Inventory Value by Product
-----------------------------------------------------------

SELECT
    p.product_id,
    p.product_name,
    i.current_stock,
    p.cost_price,
    (i.current_stock * p.cost_price) AS inventory_value
FROM inventory i
JOIN products p
ON i.product_id = p.product_id
ORDER BY inventory_value DESC;

-----------------------------------------------------------
-- Query 4
-- Overstocked Products
-----------------------------------------------------------

SELECT
    p.product_id,
    p.product_name,
    i.current_stock,
    i.reorder_level
FROM inventory i
JOIN products p
ON i.product_id = p.product_id
WHERE i.current_stock > (i.reorder_level * 3)
ORDER BY i.current_stock DESC;

-----------------------------------------------------------
-- Query 5
-- Average Inventory Level
-----------------------------------------------------------

SELECT
    ROUND(AVG(current_stock),2) AS average_inventory
FROM inventory;

-----------------------------------------------------------
-- Query 6
-- Top 5 Products with Highest Stock
-----------------------------------------------------------

SELECT
    p.product_name,
    i.current_stock
FROM inventory i
JOIN products p
ON i.product_id = p.product_id
ORDER BY i.current_stock DESC
LIMIT 5;

-----------------------------------------------------------
-- Query 7
-- Top 5 Products with Lowest Stock
-----------------------------------------------------------

SELECT
    p.product_name,
    i.current_stock
FROM inventory i
JOIN products p
ON i.product_id = p.product_id
ORDER BY i.current_stock ASC
LIMIT 5;

-----------------------------------------------------------
-- Query 8
-- Total Inventory Value
-----------------------------------------------------------

SELECT
    SUM(i.current_stock * p.cost_price) AS total_inventory_value
FROM inventory i
JOIN products p
ON i.product_id = p.product_id;

-----------------------------------------------------------
-- Query 9
-- Inventory by Product Category
-----------------------------------------------------------

SELECT
    p.category,
    SUM(i.current_stock) AS total_stock
FROM inventory i
JOIN products p
ON i.product_id = p.product_id
GROUP BY p.category
ORDER BY total_stock DESC;

-----------------------------------------------------------
-- Query 10
-- Average Inventory by Product Category
-----------------------------------------------------------

SELECT
    p.category,
    ROUND(AVG(i.current_stock),2) AS average_stock
FROM inventory i
JOIN products p
ON i.product_id = p.product_id
GROUP BY p.category
ORDER BY average_stock DESC;
