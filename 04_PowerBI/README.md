# Phase 4

# Power BI — Enterprise Supply Chain Intelligence

## Overview

This Power BI component transforms the enterprise supply chain dataset into an interactive executive dashboard for monitoring key supply chain performance indicators and identifying operational risks.

The dashboard integrates sales, procurement, inventory, supplier, customer, and shipment data to provide a consolidated view of supply chain performance.

## Business Objective

The objective is to help supply chain and operations teams:

- Monitor overall supply chain performance
- Track sales and procurement spend
- Monitor inventory value and inventory levels
- Identify SKUs below reorder point
- Identify potential stockout risk
- Evaluate supplier procurement concentration
- Monitor order fulfillment performance
- Analyze delivery performance
- Identify products and suppliers requiring management attention

## Dashboard

### Executive Supply Chain Overview

The dashboard provides a consolidated management view of:

- Total Sales
- Procurement Spend
- Inventory Value
- SKUs Below Reorder Point
- Orders Delivered
- Order Fill Rate
- Inventory Turnover
- Average Order Value
- On-Time Delivery
- SKUs at Stockout Risk

### Interactive Filters

The dashboard includes filters for:

- Year and Quarter
- Product Category
- Supplier

These filters allow users to analyze supply chain performance from different business perspectives.

## Key Analysis Areas

### 1. Sales Performance

Analyzes sales revenue trends and product-level sales performance to identify high-performing products and demand concentration.

### 2. Procurement Analysis

Analyzes procurement spend by supplier to identify major suppliers and potential supplier concentration or dependency.

### 3. Inventory Analysis

Monitors inventory value, current stock, reorder points, inventory turnover, and SKUs requiring replenishment.

### 4. Logistics and Order Performance

Tracks order status, delivered orders, order fill rate, and delivery performance to monitor service levels.

### 5. Management Insights

The dashboard translates analytical results into business-focused observations and potential actions, including:

- Replenishment priorities
- Supplier spend concentration
- High-performing products
- Potential inventory and service risks

## Key DAX Measures

The Power BI model uses DAX measures to calculate business KPIs, including:

- Total Sales
- Procurement Spend
- Inventory Value
- Average Order Value
- Inventory Turnover
- Reorder SKUs
- Stockout SKUs
- Orders Delivered
- Order Fill Rate
- On-Time Delivery

## Data Model

The Power BI model uses the following business tables:

- Products
- Suppliers
- Customers
- Purchase Orders
- Inventory
- Sales Orders
- Shipments

The model is designed to connect master data with transactional data so that supply chain KPIs can be analyzed consistently across products, suppliers, customers, inventory, sales, procurement, and logistics.

## Tools and Technologies

- Power BI Desktop
- Power Query
- DAX
- Data Modeling
- Interactive Dashboarding
- Supply Chain Analytics

## Business Value

The dashboard demonstrates how operational data can be transformed into actionable supply chain intelligence.

Instead of monitoring individual datasets separately, management can use the dashboard to identify:

- Where revenue is being generated
- Where procurement spending is concentrated
- Which SKUs require replenishment
- Where inventory risk may exist
- Which products contribute significantly to sales
- How effectively orders are being fulfilled
- Which areas require further operational investigation

## Project Integration

Power BI is one component of the broader Enterprise Supply Chain Intelligence project.

The same enterprise dataset is analyzed across multiple technologies:

Excel
→ Exploratory analysis and business reporting

PostgreSQL
→ Data querying and supply chain analysis

Power BI
→ Interactive business intelligence and KPI dashboard

Python
→ Programmatic data analysis and further analytical processing

## Project Status

Power BI Dashboard: Completed

The dashboard is designed as a single-page executive overview to provide a concise and performance-focused view of the enterprise supply chain.

## Portfolio Purpose

This project demonstrates practical application of:

- Supply Chain Analytics
- Business Intelligence
- Data Analysis
- KPI Development
- SQL
- Power BI
- DAX
- Data Modeling
- Business Problem Solving
- Management Reporting
