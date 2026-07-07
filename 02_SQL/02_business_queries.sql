/*
=========================================================
Enterprise Supply Chain Intelligence
Phase 2 - Business Queries

Author  : Vijay Sharma
Database: SupplyChainDB

Description:
This script contains the fundamental business queries used
to explore and validate the Supply Chain database.

Topics Covered:
- Product Information
- Supplier Information
- Customer Information
- Inventory Information
- Purchase Orders
- Sales Orders
- Shipment Information

=========================================================
*/
-- ==========================================
-- Business Query 1
-- View All Products
-- ==========================================

SELECT *
FROM products;
-- ==========================================
-- Business Query 2
-- Product Catalog
-- ==========================================

SELECT
    product_id,
    product_name,
    category,
    selling_price
FROM products;
