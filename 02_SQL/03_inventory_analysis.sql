/*
======================================================
Enterprise Supply Chain Intelligence
Phase 2 - Inventory Analysis

Author : Vijay Sharma
Database : SupplyChainDB

Description:
Inventory analysis queries for monitoring stock,
reorder levels, inventory value and warehouse performance.
======================================================
*/

--------------------------------------------------------
-- Query 1
-- View Current Inventory
--------------------------------------------------------

SELECT *
FROM inventory;

--------------------------------------------------------
-- Query 2
-- Products Below Reorder Point
--------------------------------------------------------

SELECT
    p.product_name,
    i.current_stock,
    i.reorder_level
FROM inventory i
JOIN products p
ON i.product_id = p.product_id
WHERE i.current_stock <= i.reorder_level;

--------------------------------------------------------
-- Query 3
-- Inventory Value
--------------------------------------------------------

SELECT
    p.product_name,
    i.current_stock,
    p.cost_price,
    (i.current_stock * p.cost_price) AS inventory_value
FROM inventory i
JOIN products p
ON i.product_id = p.product_id;
