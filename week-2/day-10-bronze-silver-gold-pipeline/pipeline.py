import csv
import os

def ensure_output_folders():
    folders = [
        "data/silver",
        "data/gold"
    ]

    for folder in folders:
        os.makedirs(folder, exist_ok=True)
#-------------------------------
# Bronze Data
#-------------------------------
ORDERS_FILE = "data/bronze/orders_raw.csv"
CUSTOMERS_FILE = "data/bronze/customers_raw.csv"
PRODUCTS_FILE = "data/bronze/products_raw.csv"


#-------------------------------
# Silver Data
#-------------------------------
SILVER_CUSTOMERS = "data/silver/customers_clean.csv"
SILVER_PRODUCTS = "data/silver/products_clean.csv"
SILVER_ORDERS = "data/silver/orders_clean.csv"
INVALID_ORDERS = "data/silver/invalid_orders.csv"


#-------------------------------
# Gold Data
#-------------------------------
GOLD_CATEGORY = "data/gold/revenue_by_category.csv"
GOLD_CITY = "data/gold/revenue_by_city.csv"
GOLD_CUSTOMER = "data/gold/revenue_by_customer.csv"
GOLD_PRODUCTS = "data/gold/top_products.csv"
EXECUTIVE_SUMMARY = "data/gold/executive_summary.txt"
DATA_QUALITY_REPORT = "data_quality_report.txt"
# -------------------------------------------
# Helper Functions
#---------------------------------------------

def is_positive_integer(value):
    try:
        number = int(value)

        if number > 0:
            return True

        return False

    except ValueError:
        return False
    


def is_positive_number(value):
    try:
        number = float(value)

        if number > 0:
            return True

        return False

    except ValueError:
        return False
    

def build_lookup(rows, key_field):
    lookup = {}

    for row in rows:
        lookup[row[key_field]] = row

    return lookup


PIPELINE_LOG = "pipeline_log.txt"

def write_pipeline_log(file_path):
    with open(file_path, "w", encoding="utf-8") as file:
        file.write("Pipeline Log - Day 10\n")
        file.write("---------------------\n")
        file.write("Step 1: Loaded Bronze files.\n")
        file.write("Step 2: Cleaned customers.\n")
        file.write("Step 3: Cleaned products.\n")
        file.write("Step 4: Validated orders.\n")
        file.write("Step 5: Created Silver clean orders.\n")
        file.write("Step 6: Created invalid orders file.\n")
        file.write("Step 7: Created Gold revenue reports.\n")
        file.write("Step 8: Created executive summary.\n")
        file.write("Pipeline completed successfully.\n")

# -------------------------------------------
# Part 1 - Bronze layer: raw data as received
#---------------------------------------------
def count_records(file_path):
    with open(file_path, "r", newline="", encoding="utf-8") as file:
        reader = csv.DictReader(file)
        return list(reader)


# --------------------------------------------------------
# Part 2 - Silver layer: cleaned, validated, enriched data
#---------------------------------------------------------
def normalize_city(city):
    city = city.strip()

    if city == "":
        return "Unknown"

    city_lower = city.lower()

    if city_lower == "prishtina":
        return "Prishtina"

    if city_lower == "vushtrri":
        return "Vushtrri"

    return city.title()


def normalize_status(status):
    status = status.strip().lower()

    if status in ["completed", "complete", "done"]:
        return "completed"

    if status in ["cancelled", "canceled"]:
        return "cancelled"

    if status == "pending":
        return "pending"

    return "unknown"


def normalize_channel(channel):
    channel = channel.strip().lower()

    if channel in ["online", "web", "mobile"]:
        return "online"

    if channel == "store":
        return "store"

    return "unknown"


def clean_customers(customers):
    cleaned_customers = []
    seen_ids = set()

    for customer in customers:
        customer_id = customer["customer_id"]

        # Skip duplicate customer IDs
        if customer_id in seen_ids:
            continue

        seen_ids.add(customer_id)

        cleaned_customers.append({
            "customer_id": customer_id,
            "customer_name": customer["customer_name"].strip(),
            "city": normalize_city(customer["city"])
        })

    return cleaned_customers


def clean_products(products):
    cleaned_products = []

    for product in products:
        if not is_positive_number(product["price"]):
            continue

        price = float(product["price"])

        category = product["category"].strip()

        if category == "":
            category = "Unknown"

        cleaned_products.append({
            "product_id": product["product_id"],
            "product_name": product["product_name"],
            "category": category,
            "price": price
        })

    return cleaned_products


def clean_orders(orders, clean_customers, cleaned_products):
    customer_lookup = {
        customer["customer_id"]: customer for customer in clean_customers
    }

    product_lookup = build_lookup(cleaned_products, "product_id")

    valid_orders = []
    invalid_orders = []
    seen_order_ids = set()

    for order in orders:
        reasons = []

        # Duplicate order validation
        if order["order_id"] in seen_order_ids:
            reasons.append("Duplicate order_id")

        seen_order_ids.add(order["order_id"])

        # Customer validation
        if order["customer_id"] not in customer_lookup:
            reasons.append("Invalid customer")

        # Product validation
        if order["product_id"] not in product_lookup:
            reasons.append("Invalid product")

        # Order date validation
        if order["order_date"].strip() == "":
            reasons.append("Missing order date")

        # Quantity validation
        if not is_positive_integer(order["quantity"]):
            reasons.append("Invalid quantity")
        else:
           quantity = int(order["quantity"])

        # Invalid order
        if reasons:
            invalid_order = {
                "order_id": order["order_id"],
                "customer_id": order["customer_id"],
                "product_id": order["product_id"],
                "order_date": order["order_date"],
                "quantity": order["quantity"],
                "status": order["status"],
                "channel": order["channel"],
                "reason": ", ".join(reasons)
            }

            invalid_orders.append(invalid_order)
            continue

        customer = customer_lookup[order["customer_id"]]
        product = product_lookup[order["product_id"]]

        valid_orders.append({
            "order_id": order["order_id"],
            "customer_id": order["customer_id"],
            "customer_name": customer["customer_name"],
            "city": customer["city"],
            "product_id": order["product_id"],
            "product_name": product["product_name"],
            "category": product["category"],
            "quantity": quantity,
            "price": product["price"],
            "total_amount": quantity * product["price"],
            "status": normalize_status(order["status"]),
            "channel": normalize_channel(order["channel"]),
            "order_date": order["order_date"]
        })

    return valid_orders, invalid_orders






def write_csv(file_path, data):
    if not data:
        return

    with open(file_path, "w", newline="", encoding="utf-8") as file:
        writer = csv.DictWriter(file, fieldnames=data[0].keys())
        writer.writeheader()
        writer.writerows(data)



# -------------------------------------------
# Part 3 - Gold layer: business-ready reports
#--------------------------------------------
def read_csv(file_path):
    with open(file_path, "r", newline="", encoding="utf-8") as file:
        reader = csv.DictReader(file)
        return list(reader)


def revenue_by_category(orders):
    report = {}

    for order in orders:
        if order["status"] == "completed":
            category = order["category"]

            if category not in report:
                report[category] = {
                    "completed_revenue": 0,
                    "total_completed_orders": 0
                }

            report[category]["completed_revenue"] += float(order["total_amount"])
            report[category]["total_completed_orders"] += 1

    result = []

    for category, values in report.items():
        result.append({
            "category": category,
            "completed_revenue": values["completed_revenue"],
            "total_completed_orders": values["total_completed_orders"]
        })

    return result


def revenue_by_city(orders):
    report = {}

    for order in orders:
        if order["status"] == "completed":
            city = order["city"]

            if city not in report:
                report[city] = {
                    "completed_revenue": 0,
                    "total_completed_orders": 0
                }

            report[city]["completed_revenue"] += float(order["total_amount"])
            report[city]["total_completed_orders"] += 1

    result = []

    for city, values in report.items():
        result.append({
            "city": city,
            "completed_revenue": values["completed_revenue"],
            "total_completed_orders": values["total_completed_orders"]
        })

    return result


def revenue_by_customer(orders):
    report = {}

    for order in orders:
        if order["status"] == "completed":

            customer = (
                order["customer_name"],
                order["city"]
            )

            if customer not in report:
                report[customer] = {
                    "completed_revenue": 0,
                    "total_completed_orders": 0
                }

            report[customer]["completed_revenue"] += float(order["total_amount"])
            report[customer]["total_completed_orders"] += 1

    result = []

    for customer, values in report.items():
        result.append({
            "customer_name": customer[0],
            "city": customer[1],
            "completed_revenue": values["completed_revenue"],
            "total_completed_orders": values["total_completed_orders"]
        })

    return result


def get_revenue(product):
    return product["completed_revenue"]


def top_products(orders):
    report = {}

    for order in orders:
        if order["status"] == "completed":

            product = (
                order["product_name"],
                order["category"]
            )

            if product not in report:
                report[product] = {
                    "total_quantity_sold": 0,
                    "completed_revenue": 0
                }

            report[product]["total_quantity_sold"] += int(order["quantity"])
            report[product]["completed_revenue"] += float(order["total_amount"])

    result = []

    for product, values in report.items():
        result.append({
            "product_name": product[0],
            "category": product[1],
            "total_quantity_sold": values["total_quantity_sold"],
            "completed_revenue": values["completed_revenue"]
        })

    return sorted(
        result,
        key=get_revenue,
        reverse=True
    )

def count_status(orders, status):
    count = 0

    for order in orders:
        if order["status"] == status:
            count += 1

    return count


def calculate_completed_revenue(orders):
    revenue = 0

    for order in orders:
        if order["status"] == "completed":
            revenue += float(order["total_amount"])

    return revenue


def get_top_item(data, key):
    if not data:
        return "None"

    return data[0][key]


def get_most_common_invalid_reason(invalid_orders):
    reasons = {}

    for order in invalid_orders:
        reason = order["reason"]

        if reason not in reasons:
            reasons[reason] = 0

        reasons[reason] += 1

    if not reasons:
        return "None"

    highest = None
    count = 0

    for reason, value in reasons.items():
        if value > count:
            count = value
            highest = reason

    return highest

def write_executive_summary(
    file_path,
    total_raw_orders,
    valid_orders,
    invalid_orders,
    completed_orders,
    pending_orders,
    cancelled_orders,
    completed_revenue,
    top_category,
    top_city,
    top_customer,
    top_product,
    invalid_reason
):
    with open(file_path, "w", encoding="utf-8") as file:
        file.write("Executive Summary - Day 10 Pipeline\n")
        file.write("---------------------------------\n\n")

        file.write(f"Total raw orders: {total_raw_orders}\n")
        file.write(f"Valid silver orders: {valid_orders}\n")
        file.write(f"Invalid orders: {invalid_orders}\n")
        file.write(f"Completed orders: {completed_orders}\n")
        file.write(f"Pending orders: {pending_orders}\n")
        file.write(f"Cancelled orders: {cancelled_orders}\n")
        file.write(f"Completed revenue: {completed_revenue}\n")
        file.write(f"Top category: {top_category}\n")
        file.write(f"Top city: {top_city}\n")
        file.write(f"Top customer: {top_customer}\n")
        file.write(f"Top product: {top_product}\n")
        file.write(f"Most common invalid reason: {invalid_reason}\n\n")

        file.write("Business recommendation:\n")
        file.write(
            "Focus on the highest-performing categories and cities, "
            "while improving data quality by fixing the most common validation issues."
        )

def create_data_quality_report(
    file_path,
    raw_orders,
    clean_orders,
    invalid_orders,
    customers,
    products
):
    duplicate_order_ids = 0
    missing_dates = 0
    invalid_quantities = 0
    invalid_statuses = 0
    invalid_products = 0
    invalid_customers = 0
    invalid_prices = 0
    missing_cities = 0

    reasons = {}

    seen_order_ids = set()

    for order in raw_orders:
        if order["order_id"] in seen_order_ids:
            duplicate_order_ids += 1

        seen_order_ids.add(order["order_id"])

        if order["order_date"].strip() == "":
            missing_dates += 1

        try:
            if int(order["quantity"]) <= 0:
                invalid_quantities += 1
        except ValueError:
            invalid_quantities += 1

    for order in invalid_orders:
        reason = order["reason"]

        if reason not in reasons:
            reasons[reason] = 0

        reasons[reason] += 1

    for customer in customers:
        if customer["city"].strip() == "":
            missing_cities += 1

    with open(file_path, "w", encoding="utf-8") as file:
        file.write("Validation Checks\n")
        file.write("-----------------\n\n")

        file.write(f"Raw orders count: {len(raw_orders)}\n")
        file.write(f"Silver clean orders count: {len(clean_orders)}\n")
        file.write(f"Invalid orders count: {len(invalid_orders)}\n")

        if len(raw_orders) == len(clean_orders) + len(invalid_orders):
            file.write("Raw = Silver + Invalid: YES\n\n")
        else:
            file.write("Raw = Silver + Invalid: NO\n\n")

        file.write(f"Customer IDs checked: {len(customers)}\n")
        file.write(f"Product IDs checked: {len(products)}\n")
        file.write(f"Duplicate order IDs found: {duplicate_order_ids}\n")
        file.write(f"Missing dates found: {missing_dates}\n")
        file.write(f"Invalid quantities found: {invalid_quantities}\n")
        file.write(f"Invalid statuses found: {invalid_statuses}\n")
        file.write(f"Invalid products found: {invalid_products}\n")
        file.write(f"Invalid customers found: {invalid_customers}\n")
        file.write(f"Invalid product prices found: {invalid_prices}\n")
        file.write(f"Missing customer cities found: {missing_cities}\n\n")

        file.write("Invalid records by reason:\n")

        for reason, count in reasons.items():
            file.write(f"- {reason}: {count}\n")

# -----------------
# Main function
#------------------
def main():

    ensure_output_folders()
    # -------------------------------------------
    # Part 1 - Bronze layer: raw data as received
    #---------------------------------------------
    orders = count_records(ORDERS_FILE)
    customers = count_records(CUSTOMERS_FILE)
    products = count_records(PRODUCTS_FILE)

    print("=== Bronze Layer ===")
    print(f"Orders: {len(orders)}")
    print(f"Customers: {len(customers)}")
    print(f"Products: {len(products)}")

    # ---------------------------------------------------------
    # Part 2 - Silver layer: cleaned, validated, enriched data
    #----------------------------------------------------------
    clean_customers_data = clean_customers(customers)
    clean_products_data = clean_products(products)

    clean_orders_data, invalid_orders_data = clean_orders(
        orders,
        clean_customers_data,
        clean_products_data
    )

    write_csv(SILVER_CUSTOMERS, clean_customers_data)
    write_csv(SILVER_PRODUCTS, clean_products_data)
    write_csv(SILVER_ORDERS, clean_orders_data)
    write_csv(INVALID_ORDERS, invalid_orders_data)

    print("\n=== Silver Layer ===")
    print(f"Clean customers: {len(clean_customers_data)}")
    print(f"Clean products: {len(clean_products_data)}")
    print(f"Valid orders: {len(clean_orders_data)}")
    print(f"Invalid orders: {len(invalid_orders_data)}")


    
    # -------------------------------------------
    # Part 3 - Gold layer: business-ready reports
    #--------------------------------------------
    silver_orders = read_csv(SILVER_ORDERS)

    category_report = revenue_by_category(silver_orders)
    city_report = revenue_by_city(silver_orders)
    customer_report = revenue_by_customer(silver_orders)
    product_report = top_products(silver_orders)

    write_csv(GOLD_CATEGORY, category_report)
    write_csv(GOLD_CITY, city_report)
    write_csv(GOLD_CUSTOMER, customer_report)
    write_csv(GOLD_PRODUCTS, product_report)

    completed_orders = count_status(silver_orders, "completed")
    pending_orders = count_status(silver_orders, "pending")
    cancelled_orders = count_status(silver_orders, "cancelled")

    completed_revenue = calculate_completed_revenue(silver_orders)

    top_category = get_top_item(category_report, "category")
    top_city = get_top_item(city_report, "city")
    top_customer = get_top_item(customer_report, "customer_name")
    top_product = get_top_item(product_report, "product_name")

    invalid_reason = get_most_common_invalid_reason(invalid_orders_data)

    write_executive_summary(
        EXECUTIVE_SUMMARY,
        len(orders),
        len(clean_orders_data),
        len(invalid_orders_data),
        completed_orders,
        pending_orders,
        cancelled_orders,
        completed_revenue,
        top_category,
        top_city,
        top_customer,
        top_product,
        invalid_reason
    )

    #--------------------------------------------------
    #Part 5 - Data quality report and validation checks
    #--------------------------------------------------

    create_data_quality_report(
    DATA_QUALITY_REPORT,
    orders,
    clean_orders_data,
    invalid_orders_data,
    clean_customers_data,
    clean_products_data
)
    
write_pipeline_log(PIPELINE_LOG)


if __name__ == "__main__":
    main()  


