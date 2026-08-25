# ============================================================
# Enterprise Supply Chain Intelligence
# Python Fundamentals — Variables, Data Types & Lists
# ============================================================
#
# Purpose:
# Demonstrate basic Python concepts using a supply-chain
# product example.
#
# Concepts Covered:
# 1. Variables
# 2. String, Integer, Float and Boolean data types
# 3. type()
# 4. Lists
# 5. List indexing
# 6. append()
# 7. Updating list items
#
# Project: Enterprise Supply Chain Intelligence
# Phase: 3 — Python Automation
# ============================================================


# ------------------------------------------------------------
# 1. Supply Chain Product Variables
# ------------------------------------------------------------

product_name = "industrial motor"
product_id = "P1001"
category = "machinery"
current_stock = 75
reorder_point = 100
unit_cost = 2500.50
reorder_required = True


# ------------------------------------------------------------
# 2. Checking Python Data Types
# ------------------------------------------------------------

print(type(product_name))
print(type(product_id))
print(type(category))
print(type(current_stock))
print(type(reorder_point))
print(type(unit_cost))
print(type(reorder_required))


# ------------------------------------------------------------
# 3. Supply Chain Product List
# ------------------------------------------------------------

products = [
    "Industrial Motor",
    "Hydraulic Pump",
    "Bearing",
    "Steel Sheet",
    "Control Panel"
]


# ------------------------------------------------------------
# 4. Accessing List Items Using Indexing
# ------------------------------------------------------------

print(products[0])  # First product
print(products[2])  # Third product
print(products[4])  # Fifth product


# ------------------------------------------------------------
# 5. Adding a New Product
# ------------------------------------------------------------

products.append("Industrial Valve")

print(products)


# ------------------------------------------------------------
# 6. Updating an Existing Product
# ------------------------------------------------------------

products[5] = "Industrial Control Valve"

print(products)
