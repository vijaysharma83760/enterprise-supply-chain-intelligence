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
products[2] = "Heavy Duty Bearing"

print("\nAfter Updating Products:")
print(products)


# ------------------------------------------------------------
# 7. Removing a Product
# ------------------------------------------------------------

products.remove("Steel Sheet")

print("\nAfter Removing a Product:")
print(products)


# ------------------------------------------------------------
# 8. Counting Products
# ------------------------------------------------------------

print("\nTotal Products:")
print(len(products))


# ------------------------------------------------------------
# 9. Checking Product Availability
# ------------------------------------------------------------

print("\nProduct Availability:")
print("Industrial Motor" in products)
print("Electric Generator" in products)


# ------------------------------------------------------------
# 10. Adding Multiple Products
# ------------------------------------------------------------

products.extend([
    "Gearbox",
    "Conveyor Belt",
    "Pressure Sensor"
])

print("\nAfter Adding Multiple Products:")
print(products)


# ------------------------------------------------------------
# 11. List Slicing
# ------------------------------------------------------------

print("\nFirst Three Products:")
print(products[0:3])

# ------------------------------------------------------------
# 12. Supplier Status Tuple
# ------------------------------------------------------------

supplier_status = (
    "Active", 
    "Inactive", 
    "Blocked"
)

print("Supplier Status: ")
print(supplier_status)

print(supplier_status[0])
print(supplier_status[2])

# ------------------------------------------------------------
# 13. Supply Chain Product Dictionary
# ------------------------------------------------------------

product = {
    "product_id": "P1001",
    "product_name": "Industrial Motor",
    "category":  "Machinery",
    "current_stock": 75,
    "reorder_point": 100,
    "unit_cost": 2500.50
}

print(product)


# ------------------------------------------------------------
# 13.2 Accessing Dictionary Values
# ------------------------------------------------------------

print("Product Name: ", product["product_name"])
print("Current Stock: ", product["current_stock"])
print("Unit Cost: ", product["unit_cost"])

# ------------------------------------------------------------
# 13.3 Adding a New Dictionary Key
# ------------------------------------------------------------

product["supplier_name"] = "ABC Engineering"

print(product)

# ------------------------------------------------------------
# 13.4 Updating a Dictionary Value
# ------------------------------------------------------------

product["current_stock"] = 125
print("Updated Current Stock: ", product["current_stock"])

# ------------------------------------------------------------
# 13.5 Removing a Dictionary Key
# ------------------------------------------------------------

del product["supplier_name"]
print(product)

# ------------------------------------------------------------
# 13.6 Checking Dictionary Keys
# ------------------------------------------------------------

print("supplier_name" in product)
print("product_id" in product)

# ------------------------------------------------------------
# 13.7 Accessing Dictionary Keys and Values
# ------------------------------------------------------------

print(product.keys())
print(product.values())

# ------------------------------------------------------------
# 13.8 Calculating Inventory Value
# ------------------------------------------------------------

inventory_value = product["current_stock"] * product["unit_cost"]

print("Inventory Value: ", inventory_value)

# ------------------------------------------------------------
# 13.9 Reorder Decision
# ------------------------------------------------------------

if product["current_stock"] < product["reorder_point"]:
    print("Reorder Required")
else:
    print("No Reorder Required")

# ------------------------------------------------------------
# 13.10 Supply Chain Product Summary
# ------------------------------------------------------------

print("Product Name:", product["product_name"])
print("Product ID:", product["product_id"])
print("Category:", product["category"])
print("Current Stock:", product["current_stock"])
print("Reorder Point:", product["reorder_point"])
print("Unit Cost:", product["unit_cost"])
print("Inventory Value:", inventory_value)
