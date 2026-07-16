import csv
import os


#-------------------------
# File Paths
#-------------------------

DATA_FOLDER = "data"

orders_file = os.path.join(DATA_FOLDER, "orders_raw.csv")
customers_file = os.path.join(DATA_FOLDER, "customers_raw.csv")
products_file = os.path.join(DATA_FOLDER, "products_raw.csv")

OUTPUT_FOLDER = "output"

os.makedirs(OUTPUT_FOLDER, exist_ok=True)


#-------------------------
# Generic CSV Loader
#-------------------------

def load_csv(file_path):
    """
    Used for loading a CSV file using DictReader
    and returns a list of dictionaries
    """

    with open(file_path, mode="r", newline="", encoding="utf-8") as file:
        reader = csv.DictReader(file)
        return list(reader)



#-------------------------
# Load Orders
#-------------------------

def load_orders():
    orders = load_csv(orders_file)
    print(f"Loaded {len(orders)} raw orders.")
    return orders



#-------------------------
# Load Customers
#-------------------------

def load_customers():
    customers = load_csv(customers_file)
    print(f"Loaded {len(customers)} raw customers.")
    return customers



#-------------------------
# Load Products
#-------------------------

def load_products():
    products = load_csv(products_file)
    print(f"Loaded {len(products)} raw products.")
    return products



#-----------------------------
# Part 3 - Build lookup tables
#-----------------------------

def build_lookup_table(rows, key_field):
    """
    Creates a dictionary for fast lookups.
    """

    lookup = {}

    for row in rows:
        lookup[row[key_field]] = row

    return lookup



#---------------------------------
# Part 4 - Normalize messy values
#---------------------------------

def normalize_status(status):

    status = status.strip().lower()

    if status in ["completed", "complete", "done"]:
        return "completed"

    elif status == "pending":
        return "pending"

    elif status in ["cancelled", "canceled"]:
        return "cancelled"

    else:
        return "unknown"



def normalize_city(city):

    return city.strip().title()



def normalize_channel(channel):

    channel = channel.strip().lower()

    if channel in ["online", "web"]:
        return "online"

    elif channel == "store":
        return "store"

    else:
        return "unknown"



#---------------------------------
# Part 5 - Validate orders
#---------------------------------

def is_positive_integer(value):

    if value is None or value == "":
        return False

    try:
        return int(value) > 0

    except ValueError:
        return False



def validate_order(order, customers_lookup, products_lookup):

    if order["order_id"].strip() == "":
        return False, "missing_order_id"


    if order["customer_id"].strip() == "":
        return False, "missing_customer_id"


    if order["customer_id"] not in customers_lookup:
        return False, "invalid_customer_id"


    if order["product_id"].strip() == "":
        return False, "missing_product_id"


    if order["product_id"] not in products_lookup:
        return False, "invalid_product_id"


    if order["order_date"].strip() == "":
        return False, "missing_order_date"


    quantity = order["quantity"].strip()


    if quantity == "":
        return False, "missing_quantity"


    try:
        quantity_number = int(quantity)

    except ValueError:
        return False, "invalid_quantity"


    if quantity_number <= 0:
        return False, "negative_quantity"


    if order["status"].strip() == "":
        return False, "missing_status"


    status = normalize_status(order["status"])


    if status == "unknown":
        return False, "invalid_status"


    channel = normalize_channel(order["channel"])


    if channel not in ["online", "store", "unknown"]:
        return False, "invalid_channel"


    return True, "valid"



#---------------------------------
# Part 6 - Enrich valid orders
#---------------------------------

def calculate_total_amount(order):

    quantity = int(order["quantity"])

    price = float(order["price"])

    return quantity * price



def enrich_order(order, customers_lookup, products_lookup):

    customer = customers_lookup[order["customer_id"]]

    product = products_lookup[order["product_id"]]


    enriched_order = {

        "order_id": order["order_id"],

        "customer_id": order["customer_id"],

        "customer_name": customer["customer_name"],

        "city": normalize_city(customer["city"]),

        "product_id": order["product_id"],

        "product_name": product["product_name"],

        "category": product["category"],

        "quantity": int(order["quantity"]),

        "price": float(product["price"]),

        "status": normalize_status(order["status"]),

        "channel": normalize_channel(order["channel"]),

        "order_date": order["order_date"]
    }


    enriched_order["total_amount"] = calculate_total_amount(enriched_order)

    return enriched_order

#---------------------------------
# Part 7 - Write output files
#---------------------------------

def write_csv(file_path, rows, fieldnames):

    with open(
        file_path,
        mode="w",
        newline="",
        encoding="utf-8"
    ) as file:

        writer = csv.DictWriter(
            file,
            fieldnames=fieldnames
        )

        writer.writeheader()
        writer.writerows(rows)



#---------------------------------
# Part 8 - Create data quality report
#---------------------------------

def create_data_quality_report(raw_orders, clean_orders, invalid_orders):

    report_file = os.path.join(
        OUTPUT_FOLDER,
        "data_quality_report.txt"
    )


    invalid_reasons = {}

    for order in invalid_orders:

        reason = order["reason"]

        if reason in invalid_reasons:
            invalid_reasons[reason] += 1

        else:
            invalid_reasons[reason] = 1



    statuses = set()

    channels = set()

    cities = set()


    for order in clean_orders:

        statuses.add(order["status"])

        channels.add(order["channel"])

        cities.add(order["city"])



    with open(report_file, mode="w", encoding="utf-8") as file:

        file.write("Data Quality Report - Day 9\n")
        file.write("============================\n\n")


        file.write(
            f"Total raw orders: {len(raw_orders)}\n"
        )

        file.write(
            f"Valid orders: {len(clean_orders)}\n"
        )

        file.write(
            f"Invalid orders: {len(invalid_orders)}\n\n"
        )


        file.write("Invalid records by reason:\n")

        for reason, count in invalid_reasons.items():

            file.write(
                f"- {reason}: {count}\n"
            )



        file.write("\nStatus values after cleaning:\n")

        for status in sorted(statuses):

            file.write(
                f"- {status}\n"
            )



        file.write("\nChannel values after cleaning:\n")

        for channel in sorted(channels):

            file.write(
                f"- {channel}\n"
            )



        file.write("\nCity values after cleaning:\n")

        for city in sorted(cities):

            file.write(
                f"- {city}\n"
            )



        file.write("\nBronze input files checked:\n")

        file.write("- orders_raw.csv\n")
        file.write("- customers_raw.csv\n")
        file.write("- products_raw.csv\n")



        file.write("\nSilver output files created:\n")

        file.write("- orders_clean.csv\n")
        file.write("- invalid_orders.csv\n")



        file.write("\nMain data quality problems found:\n")


        if invalid_orders:

            file.write("- Invalid customer IDs\n")
            file.write("- Invalid product IDs\n")
            file.write("- Missing or invalid quantities\n")
            file.write("- Missing dates or statuses\n")

        else:

            file.write("- No data quality problems found\n")


    print("Data quality report created successfully!")



#---------------------------------
# Part 9 - Create business summary
#---------------------------------

def count_by_field(rows, field_name):

    counts = {}

    for row in rows:

        value = row[field_name]

        counts[value] = counts.get(value, 0) + 1

    return counts



def sum_by_field(rows, group_field, amount_field):

    totals = {}

    for row in rows:

        key = row[group_field]

        totals[key] = totals.get(key, 0) + float(row[amount_field])

    return totals



def get_completed_orders(rows):

    completed = []

    for row in rows:

        if row["status"] == "completed":

            completed.append(row)

    return completed



def get_top_n_by_field(rows, field_name, n):

    totals = {}

    for row in rows:

        key = row[field_name]

        totals[key] = totals.get(key, 0) + row["total_amount"]

    sorted_totals = sorted(
        totals.items(),
        key=lambda x: x[1],
        reverse=True
    )

    return sorted_totals[:n]



def create_business_summary(clean_orders):

    report_file = os.path.join(
        OUTPUT_FOLDER,
        "business_summary.txt"
    )

    completed_orders = get_completed_orders(clean_orders)

    completed_revenue = sum(
        order["total_amount"]
        for order in completed_orders
    )

    orders_by_status = count_by_field(
        clean_orders,
        "status"
    )

    orders_by_city = count_by_field(
        clean_orders,
        "city"
    )

    revenue_by_category = sum_by_field(
        completed_orders,
        "category",
        "total_amount"
    )

    revenue_by_channel = sum_by_field(
        completed_orders,
        "channel",
        "total_amount"
    )

    top_customers = get_top_n_by_field(
        completed_orders,
        "customer_name",
        3
    )

    top_products = get_top_n_by_field(
        completed_orders,
        "product_name",
        3
    )

    highest_order = max(
        completed_orders,
        key=lambda order: order["total_amount"]
    )

    non_revenue_orders = len(clean_orders) - len(completed_orders)

    with open(report_file, "w", encoding="utf-8") as file:

        file.write("Business Summary - Day 9\n")
        file.write("==========================\n\n")

        file.write(f"Completed revenue: {completed_revenue:.2f}\n\n")

        file.write("Orders by status:\n")
        for status, count in orders_by_status.items():
            file.write(f"- {status}: {count}\n")

        file.write("\nOrders by city:\n")
        for city, count in orders_by_city.items():
            file.write(f"- {city}: {count}\n")

        file.write("\nRevenue by category:\n")
        for category, total in revenue_by_category.items():
            file.write(f"- {category}: {total:.2f}\n")

        file.write("\nRevenue by channel:\n")
        for channel, total in revenue_by_channel.items():
            file.write(f"- {channel}: {total:.2f}\n")

        file.write("\nTop 3 customers by completed revenue:\n")
        for customer, total in top_customers:
            file.write(f"- {customer}: {total:.2f}\n")

        file.write("\nTop 3 products by completed revenue:\n")
        for product, total in top_products:
            file.write(f"- {product}: {total:.2f}\n")

        file.write("\nMost valuable completed order:\n")
        file.write(
            f"- Order {highest_order['order_id']} ({highest_order['customer_name']}): {highest_order['total_amount']:.2f}\n"
        )

        file.write("\nOrders that should not count as revenue:\n")
        file.write(f"- {non_revenue_orders}\n")

        file.write("\nBusiness recommendation:\n")
        file.write("- Focus on completed orders and reduce cancelled or pending orders.\n")

        file.write("\nWhy this Gold output can be trusted:\n")
        file.write("- Only validated, cleaned, completed orders were used for revenue calculations.\n")

    print("Business summary created successfully!")



#---------------------------------
# Bonus - Detect duplicate orders
#---------------------------------

def find_duplicate_order_ids(orders):

    seen = set()
    duplicates = []

    for order in orders:

        order_id = order["order_id"]

        if order_id in seen:
            duplicates.append(order_id)

        else:
            seen.add(order_id)

    return duplicates

#---------------------------------
# Bonus - Completed orders file
#---------------------------------

def get_completed_orders(rows):

    completed_orders = []

    for order in rows:

        if order["status"] == "completed":

            completed_orders.append(order)

    return completed_orders


#---------------------------------
# Bonus - Revenue by city
#---------------------------------

def create_revenue_by_city(rows):

    revenue = {}


    for order in rows:

        if order["status"] == "completed":

            city = order["city"]

            amount = order["total_amount"]


            if city in revenue:

                revenue[city] += amount

            else:

                revenue[city] = amount



    sorted_revenue = sorted(
        revenue.items(),
        key=lambda x: x[1],
        reverse=True
    )


    with open(
        os.path.join(
            OUTPUT_FOLDER,
            "revenue_by_city.txt"
        ),
        "w",
        encoding="utf-8"
    ) as file:


        for city, amount in sorted_revenue:

            file.write(
                f"{city}: {amount}\n"
            )


# -----------------------------
# Main Program
# -----------------------------

def main():

    # 1. Load raw CSV files

    orders = load_orders()

    customers = load_customers()

    products = load_products()



    # 2. Build lookup tables

    customers_lookup = build_lookup_table(
        customers,
        "customer_id"
    )


    products_lookup = build_lookup_table(
        products,
        "product_id"
    )


    print(
        f"Customer lookup contains {len(customers_lookup)} customers."
    )

    print(
        f"Product lookup contains {len(products_lookup)} products."
    )



    valid_orders = []

    invalid_orders = []



    # 3. Validate and clean orders
    # 4. Enrich valid orders

    for order in orders:

        is_valid, reason = validate_order(
            order,
            customers_lookup,
            products_lookup
        )


        if is_valid:

            enriched_order = enrich_order(
                order,
                customers_lookup,
                products_lookup
            )

            valid_orders.append(enriched_order)

            print(
                f"Order {order['order_id']}: Valid"
            )


        else:

            invalid_order = order.copy()

            invalid_order["reason"] = reason

            invalid_orders.append(invalid_order)

            print(
                f"Order {order['order_id']}: Invalid ({reason})"
            )



    print()

    print(
        f"Total valid orders: {len(valid_orders)}"
    )

    print(
        f"Total invalid orders: {len(invalid_orders)}"
    )



    # 5. Write clean CSV file

    write_csv(

        os.path.join(
            OUTPUT_FOLDER,
            "orders_clean.csv"
        ),

        valid_orders,

        [
            "order_id",
            "customer_id",
            "customer_name",
            "city",
            "product_id",
            "product_name",
            "category",
            "quantity",
            "price",
            "total_amount",
            "status",
            "channel",
            "order_date"
        ]
    )



    # Write invalid CSV file

    write_csv(

        os.path.join(
            OUTPUT_FOLDER,
            "invalid_orders.csv"
        ),

        invalid_orders,

        [
            "order_id",
            "customer_id",
            "product_id",
            "order_date",
            "quantity",
            "status",
            "channel",
            "reason"
        ]
    )



    # 6. Create data quality report

    create_data_quality_report(
        orders,
        valid_orders,
        invalid_orders
    )

    create_business_summary(valid_orders)



    print()

    print(
        "CSV pipeline completed successfully!"
    )



if __name__ == "__main__":

    main()