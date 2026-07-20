import csv
import os

# -------------------------
# Part 2 - Python Pipeline
# -------------------------

# load_csv / write_csv

def load_csv(filepath):
    with open(filepath, "r", newline="", encoding="utf-8") as file:
        return list(csv.DictReader(file))


def write_csv(filepath, data):
    if not data:
        return
    
    os.makedirs(os.path.dirname(filepath), exist_ok=True)

    with open(filepath, "w", newline="", encoding="utf-8") as file:
        writer = csv.DictWriter(file, fieldnames=data[0].keys())
        writer.writeheader()
        writer.writerows(data)



# normalization functions

def normalize_status(status):

    if not status:
        return "unknown"

    status = status.strip().lower()

    if status in ["completed", "done"]:
        return "completed"

    elif status in ["cancelled", "canceled"]:
        return "cancelled"

    elif status == "pending":
        return "pending"

    return None    


def normalize_city(city):
    if not city:
        return "uknown"

    return city.strip().title()


def normalize_channel(channel):

    if not channel:
        return "unknown"

    channel = channel.strip().lower()

    if channel in ["online", "store", "web", "bank"]:
        return channel

    return "unknown"

# validation functions

def validate_order(order, customers, products, order_ids):
    reasons = []

    if order["order_id"] in order_ids:
        reasons.append("Duplicate order_id")

    if not order["quantity"].isdigit():
        reasons.append("Invalid quantity")

    else:
        if int(order["quantity"]) <= 0:
            reasons.append("Quantity must be greater than 0")

    
    normalized_status = normalize_status(order["status"])
    if normalized_status is None:
      reasons.append("Invalid status")

    if normalize_status(order["status"]) is None:
        reasons.append("Invalid status")

    if not order["order_date"]:
        reasons.append("Missing order_date")

    if order["customer_id"] not in customers:
        reasons.append("Invalid customer_id")

    if order["product_id"] not in products:
        reasons.append("Invalid product_id")

    return reasons


# lookup functions

def get_customer(customer_id, customers):
    """
    Lookup customer details using customer_id
    """
    return customers.get(customer_id)


def get_product(product_id, products):
    """
    Lookup product details using product_id
    """
    return products.get(product_id)

    
# create_silver_orders

def create_silver_orders(orders, customers, products):

    clean_orders = []
    invalid_orders = []

    order_ids = set()

    for order in orders:
        reasons = validate_order(
            order,
            customers,
            products,
            order_ids
        )

        order_ids.add(order["order_id"])

        if reasons:
            order["invalid_reasons"] = ", ".join(reasons)
            invalid_orders.append(order)
            continue


        customer = get_customer(
        order["customer_id"],
        customers
        )

        product = get_product(
        order["product_id"],
        products
        )
        

        clean_orders.append({
            "order_id": order["order_id"],
            "customer_id": order["customer_id"],
            "customer_name": customer["customer_name"],
            "city": normalize_city(customer["city"]),
            "segment": customer["segment"],
            "product_id" : order["product_id"],
            "product_name": product["product_name"],
            "category": product["category"],
            "quantity": int(order["quantity"]),
            "price": float(product["price"]),
            "status": normalize_status(order["status"]),
            "order_date": order["order_date"],
            "channel": normalize_channel(order["channel"]),
            "total_amount": int(order["quantity"]) * float(product["price"])
        })

    return clean_orders, invalid_orders
    
        
# Gold Reports
def create_gold_reports(clean_orders):
    completed = [
        order for order in clean_orders
        if order["status"] == "completed"
    ]


    city_report = {}
        
    
    for order in completed:
        city = order["city"]
        city_report[city] = city_report.get(city,0) + order["total_amount"]

    write_csv(
      "data/gold/revenue_by_city.csv",
    [
        {"city": k, "revenue": v}
        for k,v in city_report.items()
    ]
)
        
    category_report = {}

    for order in completed:
        category = order["category"]
        category_report[category] = category_report.get(category,0) + order["total_amount"]


    write_csv(
        "data/gold/revenue_by_category.csv",
        [
            {"category": k, "revenue": v}
            for k,v in category_report.items()
        ]
    )

    customers = {}

    for order in completed:
        name = order["customer_name"]

        customers[name] = customers.get(name,0) + order["total_amount"]
    top = sorted(
        customers.items(),
        key=lambda x:x[1],
        reverse=True
    )

    write_csv(
        "data/gold/top_customers.csv",
        [
            {
                "customer_name": name,
                "revenue": revenue
            }
            for name,revenue in top[:5]
        ]
    )


    with open(
        "data/gold/executive_summary.txt",
        "w",
        encoding="utf-8"
    ) as file:

        file.write(
            f"""
Executive Summary
Completed Orders: {len(completed)}
Total Revenue: {sum(o['total_amount'] for o in completed)}
"""
        )
# -------------------------
# Main Pipeline
# -------------------------
def main():
    orders = load_csv(
        "data/bronze/orders_raw.csv"
    )
    customers_list = load_csv(
        "data/bronze/customers_raw.csv"
    )
    products_list = load_csv(
        "data/bronze/products_raw.csv"
    )
    customers = {
        c["customer_id"]: c
        for c in customers_list
    }
    products = {
        p["product_id"]: p
        for p in products_list
    }
    clean, invalid = create_silver_orders(
        orders,
        customers,
        products
    )
    write_csv(
        "data/silver/orders_clean.csv",
        clean
    )
    write_csv(
        "data/silver/invalid_orders.csv",
        invalid
    )

    create_gold_reports(clean)

    print("Pipeline completed successfully!")
if __name__ == "__main__":
    main()

