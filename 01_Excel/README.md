# Phase 1 — Excel

This folder contains the Excel-based analysis and business logic developed as the first analytical layer of the **Enterprise Supply Chain Intelligence** project.

Excel was used to transform the supply chain dataset into structured operational analysis, calculate key supply chain metrics, and establish the initial business logic later extended into PostgreSQL, Python, and Power BI.

## Current Status

**Completed**

## Objectives

The objectives of the Excel phase were to:

* Understand the supply chain dataset and its operational structure.
* Establish foundational supply chain KPIs.
* Analyze inventory, procurement, sales, and logistics performance.
* Identify products requiring inventory attention.
* Calculate key operational metrics.
* Build management-oriented summaries using Pivot Tables and Pivot Charts.
* Establish business logic that can be reproduced in later project phases.

## Analysis Covered

### Inventory Analysis

The Excel analysis includes:

* Current stock
* Inventory value
* Reorder requirements
* Products in stock
* Average current stock
* Reorder point analysis
* Inventory-related KPIs

### Procurement Analysis

The analysis includes:

* Total purchase cost
* Purchase order analysis
* Supplier-related metrics
* Supplier lead time
* Procurement performance

### Sales Analysis

The analysis includes:

* Total sales revenue
* Total sales orders
* Average order value
* Product-level sales analysis

### Logistics Analysis

The analysis includes:

* Total shipping cost
* Average transit days
* Shipment-related operational analysis

## Key KPIs

The Excel phase established the following core KPIs:

| KPI                        | Description                                    |
| -------------------------- | ---------------------------------------------- |
| Total Sales Revenue        | Total revenue generated from sales orders      |
| Average Order Value        | Average value of a sales order                 |
| Total Purchase Cost        | Total procurement expenditure                  |
| Total Inventory Value      | Financial value of current inventory           |
| Products Requiring Reorder | Number of products requiring replenishment     |
| Products In Stock          | Number of products currently holding inventory |
| Average Current Stock      | Average inventory quantity across products     |
| Total Shipping Cost        | Total logistics/shipping expenditure           |
| Average Transit Days       | Average shipment transit duration              |
| Average Supplier Lead Time | Average time associated with supplier delivery |
| Total Sales Orders         | Total number of sales orders                   |

## Business Logic

The Excel phase establishes foundational decision logic for supply chain operations.

Examples include:

**Inventory Reorder Decision**

Current Stock < Reorder Point

→ Replenishment Required

**Inventory Value**

Current Stock × Unit Cost

→ Inventory Value

These calculations provide the foundation for more advanced inventory and replenishment analysis in later phases of the project.

## Excel Features Used

The workbook uses Excel capabilities including:

* Formulas
* KPI calculations
* Pivot Tables
* Pivot Charts
* Interactive Slicers
* Data analysis
* Business-rule calculations
* Operational summaries

## Business Questions Addressed

The Excel phase helps answer questions such as:

1. What is the total sales revenue?
2. What is the average order value?
3. How much has been spent on procurement?
4. How much capital is currently tied up in inventory?
5. Which products require replenishment?
6. What is the average inventory level?
7. What is the average supplier lead time?
8. What is the average shipment transit time?
9. How much is being spent on shipping?
10. How many sales orders have been processed?

## Role in the End-to-End Project

Excel is the **first analytical layer** of the project.

The overall project progresses from:

**Supply Chain Data**

↓

**Excel Analysis**

↓

**PostgreSQL Database**

↓

**SQL Business Analytics**

↓

**Python Analytics & Forecasting**

↓

**Forecast → Inventory → Replenishment Decision**

↓

**Supply Chain Risk Analysis**

↓

**Power BI Executive Decision Dashboard**

↓

**Business Recommendations**

The business logic established in Excel is therefore carried forward into the subsequent analytical phases rather than being treated as an isolated Excel exercise.

## Project Outcome

The Excel phase successfully established the initial supply chain analytical framework, including operational KPIs, inventory logic, procurement analysis, sales analysis, and logistics metrics.

This provides the foundation for the subsequent PostgreSQL, Python, and Power BI phases of the **Enterprise Supply Chain Intelligence** project.

## Next Phase

**Phase 2 — PostgreSQL / SQL**

The next phase converts the operational supply chain data into a structured relational database and applies SQL-based business analysis for deeper supply chain insights.
