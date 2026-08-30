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

# ============================================================
# 14. Conditional Statements
# ============================================================
#
# Business Objective
# ------------------
# Use business rules to make decisions from supply-chain data.
#
# Supply Chain Use Cases
# ----------------------
# 1. Inventory reorder decisions
# 2. Stock risk classification
# 3. Shipment status evaluation
# 4. Supplier performance classification
#
# Concepts Covered
# ----------------
# 1. if
# 2. else
# 3. Comparison operators
# 4. Business-rule evaluation
#
# ============================================================

if product["current_stock"] < product["reorder_point"]:
    print("Reorder Required")
elif product["current_stock"] == product["reorder_point"]:
    print("Reorder Required")
else:
    print("No Reorder Required")

# ------------------------------------------------------------
# 14.2 Stock Risk Classification
# ------------------------------------------------------------

if product["current_stock"] < 50:
    print("Critical Stock")

elif product["current_stock"] < product["reorder_point"]:
    print("Low Stock")

else:
    print("Healthy Stock")

# ------------------------------------------------------------
# 14.3 Inventory Value Classification
# ------------------------------------------------------------

if inventory_value < 100000:
    print("Low Value Inventory")

elif inventory_value < 500000:
    print("Medium Value Inventory")

else:
    print("High Value Inventory")

# ------------------------------------------------------------
# 14.4 Supplier Performance Classification
# ------------------------------------------------------------

on_time_delivery_rate = 92

if on_time_delivery_rate >= 95:
    print("Excellent Supplier")

elif on_time_delivery_rate >= 85:
    print("Good Supplier")

else:
    print("Needs Improvement")

# ------------------------------------------------------------
# 14.5 Shipment Delay Classification
# ------------------------------------------------------------

transit_days = 7

expected_transit_days = 11

if transit_days > expected_transit_days:
    print("Delayed Shipment")
elif transit_days == expected_transit_days:
    print("On-Time Shipment")
else:
    print("Early Shipment")

# ------------------------------------------------------------
# 14.6 Order Priority Classification
# ------------------------------------------------------------

order_value = float(input("Enter order value: "))

if order_value >= 100000:
    print("High Priority")

elif order_value >= 50000:
    print("Medium Priority")

else:
    print("Low Priority")

# ------------------------------------------------------------
# 14.7 Combined Inventory Risk Decision
# ------------------------------------------------------------

if product["current_stock"] < product["reorder_point"] and "inventory_value" < 200000:
    print("Critical Reorder")

else:
    print("Normal Inventory")

# ------------------------------------------------------------
# 14.8 Shipment Management Review
# ------------------------------------------------------------

if transit_days > 10 or order_value >= 100000:
    print("Management Review")
else:
    print("No Management Review")

# ------------------------------------------------------------
# 14.9 Integrated Supply Chain Risk Decision
# ------------------------------------------------------------

if product["current_stock"] < product["reorder_point"] or transit_days > expected_transit_days:
    print("High Risk")
else:
    print("Low Risk")

# ============================================================
# 15. Python Loops
# ============================================================
#
# Business Objective:
# Automate repetitive operations across supply-chain data.
#
# Concepts Covered:
# 1. for loops
# 2. range()
# 3. Iterating through lists
# 4. Conditional logic inside loops
# 5. while loops
#
# Supply Chain Applications:
# - Product processing
# - Inventory monitoring
# - Risk identification
# - Record-level analysis
#
# ============================================================

# ------------------------------------------------------------
# 15.1 Iterating Through Supply Chain Products
# ------------------------------------------------------------

for product in products:
    print(product)

# ------------------------------------------------------------
# 15.2 Using range() for Repeated Operations
# ------------------------------------------------------------

for records in range(1,6):
    print(records)

# ------------------------------------------------------------
# 15.3 Iterating Through Products Using List Indexes
# ------------------------------------------------------------

for index in range(len(products)):
    print(products[index])

# ------------------------------------------------------------
# 15.4 Inventory Reorder Check Using a Loop
# ------------------------------------------------------------

inventory_levels = (75, 150, 40, 120, 30)
reorder_point = 100

for inventory in inventory_levels:

    if inventory <= reorder_point:
        print("Reorder Required")

    else:
        print("Stock Sufficient")

# ------------------------------------------------------------
# 15.5 Identifying Low-Stock Inventory Levels
# ------------------------------------------------------------
for inventory in inventory_levels:

    if inventory <= reorder_point:
        print(f"Reorder Required - Current Inventory: {inventory}")

    else:
        print(f"Stock Sufficient - Current Inventory: {inventory}")

# ------------------------------------------------------------
# 15.6 Using a while Loop for Inventory Monitoring
# ------------------------------------------------------------

count = 1

while count <= 5:
    print("Inventory Check", count)
    count = count + 1

# ------------------------------------------------------------
# 15.7 Practical Inventory Monitoring Loop
# ------------------------------------------------------------

count = 1

while count <= 5:
    print("Inventory Check", count, "- Monitoring stock levels")
    count = count + 1

# ------------------------------------------------------------
# 15.8 Integrated Product Inventory Risk Check
# ------------------------------------------------------------

inventory_levels = (75, 150, 40, 120, 30, 110, 65, 200)

for index in range(len(products)):

    if inventory_levels[index] <= reorder_point:
        print(
            f"{products[index]} - "
            f"Reorder Required - "
            f"Inventory: {inventory_levels[index]}"
        )

    else:
        print(
            f"{products[index]} - "
            f"Stock Sufficient - "
            f"Inventory: {inventory_levels[index]}"
        )


