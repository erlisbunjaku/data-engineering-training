from order_data import orders


# =====================================================
# PART 1 - RAW DATA INSPECTION
# =====================================================

def print_raw_count(records):
    print(f"Raw records: {len(records)}")


def print_first_three_records(records):
    print("\nFIRST THREE RAW RECORDS")
    print("=" * 50)

    for order in records[:3]:
        for key, value in order.items():
            print(f"{key}: {value}")
        print("-" * 50)


def print_unique_raw_values(records):
    statuses = set()
    cities = set()
    categories = set()
    channels = set()

    for order in records:
        statuses.add(order["status"])
        cities.add(order["city"])
        categories.add(order["category"])
        channels.add(order["channel"])

    print("\nRAW VALUES BEFORE CLEANING")
    print("=" * 50)

    print("Statuses:")
    for value in sorted(statuses):
        print("-", value)

    print("\nCities:")
    for value in sorted(cities):
        print("-", value)

    print("\nCategories:")
    for value in sorted(categories):
        print("-", value)

    print("\nChannels:")
    for value in sorted(channels):
        print("-", value)


# =====================================================
# PART 2 - VALIDATION FUNCTIONS
# =====================================================

def validate_order(order):
    reasons = []

    # Customer validation
    if not order.get("customer_name") or order["customer_name"].strip() == "":
        reasons.append("Missing customer name")

    # Quantity validation
    if order.get("quantity") is None or order["quantity"] <= 0:
        reasons.append("Quantity must be greater than 0")

    # Price validation
    if order.get("price") is None or order["price"] <= 0:
        reasons.append("Price must be greater than 0")

    # Status validation
    allowed_statuses = [
        "completed",
        "Completed",
        "complete",
        "pending",
        "cancelled",
        "returned"
    ]

    if order.get("status") not in allowed_statuses:
        reasons.append("Invalid status value")

    return reasons



def split_valid_and_invalid_orders(records):
    valid_orders = []
    invalid_orders = []

    for order in records:

        errors = validate_order(order)

        if errors:
            invalid_order = order.copy()
            invalid_order["reasons"] = errors
            invalid_orders.append(invalid_order)

        else:
            valid_orders.append(order)

    return valid_orders, invalid_orders



def write_invalid_records(invalid_orders):

    with open(
        "output/invalid_records.txt",
        "w",
        encoding="utf-8"
    ) as file:

        file.write("INVALID RECORDS REPORT\n")
        file.write("=" * 60 + "\n\n")

        for order in invalid_orders:

            file.write(f"Order ID: {order['order_id']}\n")
            file.write(
                f"Customer: {order.get('customer_name', 'Missing')}\n"
            )
            file.write(
                f"Status: {order.get('status', 'Missing')}\n"
            )
            file.write(
                f"Quantity: {order.get('quantity')}\n"
            )
            file.write(
                f"Price: {order.get('price')}\n"
            )

            file.write("Reasons:\n")

            for reason in order["reasons"]:
                file.write(f"- {reason}\n")

            file.write("\n")
            file.write("-" * 60)
            file.write("\n\n")



def write_validation_report(
        raw_records,
        valid_orders,
        invalid_orders
):

    with open(
        "output/validation_report.txt",
        "w",
        encoding="utf-8"
    ) as file:

        file.write("DATA VALIDATION REPORT\n")
        file.write("=" * 60 + "\n\n")

        file.write(
            f"Raw records: {len(raw_records)}\n"
        )

        file.write(
            f"Valid records: {len(valid_orders)}\n"
        )

        file.write(
            f"Invalid records: {len(invalid_orders)}\n\n"
        )


        file.write("INVALID RECORD SUMMARY\n")
        file.write("-" * 60 + "\n")

        for order in invalid_orders:

            file.write(
                f"Order {order['order_id']}: "
            )

            file.write(
                ", ".join(order["reasons"])
            )

            file.write("\n")


            # =====================================================
# PART 3 - CLEANING AND NORMALIZATION
# =====================================================


def normalize_status(status):

    value = status.strip().lower()

    if value in ["completed", "complete"]:
        return "completed"

    return value



def normalize_city(city):

    value = city.strip().lower()

    if value in ["prishtine", "prishtina"]:
        return "Prishtina"

    return value.title()



def normalize_category(category):

    return category.strip().title()



def normalize_channel(channel):

    return channel.strip().lower()



def calculate_total_amount(order):

    return order["quantity"] * order["price"]



def clean_order(order):

    cleaned = order.copy()

    cleaned["status"] = normalize_status(
        order["status"]
    )

    cleaned["city"] = normalize_city(
        order["city"]
    )

    cleaned["category"] = normalize_category(
        order["category"]
    )

    cleaned["channel"] = normalize_channel(
        order["channel"]
    )

    cleaned["total_amount"] = calculate_total_amount(
        order
    )

    return cleaned



# =====================================================
# PART 4 - BUSINESS METRIC FUNCTIONS
# =====================================================


def get_completed_orders(clean_orders):

    return [
        order
        for order in clean_orders
        if order["status"] == "completed"
    ]



def calculate_completed_revenue(clean_orders):

    completed_orders = get_completed_orders(
        clean_orders
    )

    return sum(
        order["total_amount"]
        for order in completed_orders
    )



def count_by_field(records, field_name):

    result = {}

    for record in records:

        value = record[field_name]

        if value not in result:
            result[value] = 0

        result[value] += 1

    return result



def sum_revenue_by_field(records, field_name):

    result = {}

    for record in records:

        if record["status"] == "completed":

            value = record[field_name]

            if value not in result:
                result[value] = 0

            result[value] += record["total_amount"]

    return result



def get_customers_with_multiple_orders(records):

    customer_counts = count_by_field(
        records,
        "customer_name"
    )

    return [
        customer
        for customer, count in customer_counts.items()
        if count > 1
    ]



def get_products_with_multiple_orders(records):

    product_counts = count_by_field(
        records,
        "product"
    )

    return [
        product
        for product, count in product_counts.items()
        if count > 1
    ]



# =====================================================
# PART 5 - SORTING HELPERS
# =====================================================


def sort_dictionary_value(item):

    return item[1]



def sort_total_amount(order):

    return order["total_amount"]



def get_top_orders_by_total_amount(
        records,
        limit=5
):

    completed = get_completed_orders(records)

    return sorted(
        completed,
        key=sort_total_amount,
        reverse=True
    )[:limit]



def get_top_elements_from_dict(
        dictionary,
        limit=3
):

    return sorted(
        dictionary.items(),
        key=sort_dictionary_value,
        reverse=True
    )[:limit]



# =====================================================
# PART 6 - BUSINESS REPORT GENERATION
# =====================================================


def write_business_report(
        cleaned_orders,
        invalid_orders
):

    completed_orders = get_completed_orders(
        cleaned_orders
    )

    completed_revenue = calculate_completed_revenue(
        cleaned_orders
    )


    average_value = (
        completed_revenue / len(completed_orders)
        if completed_orders
        else 0
    )


    highest_order = max(
        [
            order["total_amount"]
            for order in completed_orders
        ],
        default=0
    )


    lowest_order = min(
        [
            order["total_amount"]
            for order in completed_orders
        ],
        default=0
    )


    revenue_city = sum_revenue_by_field(
        cleaned_orders,
        "city"
    )

    revenue_category = sum_revenue_by_field(
        cleaned_orders,
        "category"
    )

    revenue_channel = sum_revenue_by_field(
        cleaned_orders,
        "channel"
    )

    revenue_customer = sum_revenue_by_field(
        cleaned_orders,
        "customer_name"
    )

    revenue_product = sum_revenue_by_field(
        cleaned_orders,
        "product"
    )


    with open(
        "output/business_report.txt",
        "w",
        encoding="utf-8"
    ) as file:


        file.write(
            "EXECUTIVE BUSINESS REPORT\n"
        )

        file.write(
            "=" * 60 + "\n\n"
        )


        file.write(
            "KEY METRICS\n"
        )

        file.write(
            "-" * 60 + "\n"
        )

        file.write(
            f"Completed Revenue: EUR {completed_revenue:.2f}\n"
        )

        file.write(
            f"Completed Orders: {len(completed_orders)}\n"
        )

        file.write(
            f"Average Order Value: EUR {average_value:.2f}\n"
        )

        file.write(
            f"Highest Order: EUR {highest_order:.2f}\n"
        )

        file.write(
            f"Lowest Order: EUR {lowest_order:.2f}\n\n"
        )


        file.write(
            "REVENUE BY CITY\n"
        )

        for key, value in get_top_elements_from_dict(
            revenue_city
        ):

            file.write(
                f"- {key}: EUR {value:.2f}\n"
            )


        file.write(
            "\nREVENUE BY CATEGORY\n"
        )

        for key, value in get_top_elements_from_dict(
            revenue_category
        ):

            file.write(
                f"- {key}: EUR {value:.2f}\n"
            )


        file.write(
            "\nREVENUE BY CHANNEL\n"
        )

        for key, value in get_top_elements_from_dict(
            revenue_channel
        ):

            file.write(
                f"- {key}: EUR {value:.2f}\n"
            )


        file.write(
            "\nTOP CUSTOMERS\n"
        )

        for key, value in get_top_elements_from_dict(
            revenue_customer
        ):

            file.write(
                f"- {key}: EUR {value:.2f}\n"
            )


        file.write(
            "\nTOP PRODUCTS\n"
        )

        for key, value in get_top_elements_from_dict(
            revenue_product
        ):

            file.write(
                f"- {key}: EUR {value:.2f}\n"
            )


        file.write(
            "\nRECOMMENDATION\n"
        )

        file.write(
            "Focus on high-performing electronics products "
            "and improve data validation before reporting."
        )

        # --- Part 6 Helper Functions for Sorting ---

def sort_key_total_amount(order):
    return order["total_amount"]


def sort_key_dictionary_value(item_tuple):
    return item_tuple[1]


def get_top_orders_by_total_amount(records, limit=5):
    completed_orders = get_completed_orders(records)
    return sorted(
        completed_orders,
        key=sort_key_total_amount,
        reverse=True
    )[:limit]


def get_top_elements_from_dict(summary_dict, limit=3):
    sorted_items = sorted(
        summary_dict.items(),
        key=sort_key_dictionary_value,
        reverse=True
    )
    return sorted_items[:limit]


# --- Part 8 Output Reports ---

def write_business_report(cleaned_valid_orders, invalid_orders):

    completed_orders = get_completed_orders(cleaned_valid_orders)

    completed_revenue = calculate_completed_revenue(
        cleaned_valid_orders
    )

    average_value = (
        completed_revenue / len(completed_orders)
        if completed_orders
        else 0
    )

    highest_order = max(
        (order["total_amount"] for order in completed_orders),
        default=0
    )

    lowest_order = min(
        (order["total_amount"] for order in completed_orders),
        default=0
    )


    revenue_by_city = sum_revenue_by_field(
        cleaned_valid_orders,
        "city"
    )

    revenue_by_category = sum_revenue_by_field(
        cleaned_valid_orders,
        "category"
    )

    revenue_by_channel = sum_revenue_by_field(
        cleaned_valid_orders,
        "channel"
    )

    revenue_by_customer = sum_revenue_by_field(
        cleaned_valid_orders,
        "customer_name"
    )

    revenue_by_product = sum_revenue_by_field(
        cleaned_valid_orders,
        "product"
    )


    with open(
        "output/business_report.txt",
        "w",
        encoding="utf-8"
    ) as file:


        file.write("DAY 8 BUSINESS PERFORMANCE REPORT\n")
        file.write("=" * 60 + "\n\n")


        file.write("KEY METRICS\n")
        file.write("-" * 60 + "\n")

        file.write(
            f"Valid orders: {len(cleaned_valid_orders)}\n"
        )

        file.write(
            f"Invalid orders removed: {len(invalid_orders)}\n"
        )

        file.write(
            f"Completed orders: {len(completed_orders)}\n"
        )

        file.write(
            f"Completed revenue: EUR {completed_revenue:.2f}\n"
        )

        file.write(
            f"Average completed order value: EUR {average_value:.2f}\n"
        )

        file.write(
            f"Highest completed order: EUR {highest_order:.2f}\n"
        )

        file.write(
            f"Lowest completed order: EUR {lowest_order:.2f}\n\n"
        )


        file.write("REVENUE BY CITY\n")
        file.write("-" * 60 + "\n")

        for city, revenue in sorted(
            revenue_by_city.items(),
            key=sort_key_dictionary_value,
            reverse=True
        ):
            file.write(
                f"{city}: EUR {revenue:.2f}\n"
            )


        file.write("\nREVENUE BY CATEGORY\n")
        file.write("-" * 60 + "\n")

        for category, revenue in sorted(
            revenue_by_category.items(),
            key=sort_key_dictionary_value,
            reverse=True
        ):
            file.write(
                f"{category}: EUR {revenue:.2f}\n"
            )


        file.write("\nREVENUE BY CHANNEL\n")
        file.write("-" * 60 + "\n")

        for channel, revenue in sorted(
            revenue_by_channel.items(),
            key=sort_key_dictionary_value,
            reverse=True
        ):
            file.write(
                f"{channel}: EUR {revenue:.2f}\n"
            )


        file.write("\nTOP CUSTOMERS\n")
        file.write("-" * 60 + "\n")

        for customer, revenue in get_top_elements_from_dict(
            revenue_by_customer,
            3
        ):
            file.write(
                f"{customer}: EUR {revenue:.2f}\n"
            )


        file.write("\nTOP PRODUCTS\n")
        file.write("-" * 60 + "\n")

        for product, revenue in get_top_elements_from_dict(
            revenue_by_product,
            3
        ):
            file.write(
                f"{product}: EUR {revenue:.2f}\n"
            )


        file.write("\nBUSINESS RECOMMENDATION\n")
        file.write("-" * 60 + "\n")

        file.write(
            "Focus on high performing products and cities because "
            "they generate the majority of completed revenue.\n"
        )

        file.write(
            "Improve data validation before reporting because "
            "invalid records can create incorrect business decisions.\n"
        )
        
# --- Main Application Flow ---
def main():
    print_raw_count(orders)
    print_first_three_records(orders)
    print_unique_raw_values(orders)
    # Validation
    valid_orders, invalid_orders = split_valid_and_invalid_orders(
        orders
    )

    write_invalid_records(
        invalid_orders
    )
    write_validation_report(
        orders,
        valid_orders,
        invalid_orders
    )

    print("\nVALIDATION SUMMARY")
    print("=" * 50)
    print(
        f"Raw records: {len(orders)}"
    )
    print(
        f"Valid records: {len(valid_orders)}"
    )
    print(
        f"Invalid records: {len(invalid_orders)}"
    )

    # Cleaning
    cleaned_orders = []
    for order in valid_orders:
        cleaned_orders.append(
            clean_order(order)
        )

    print("\nCLEANING COMPLETE")
    print(
        "Cleaned records:",
        len(cleaned_orders)
    )

    # Metrics
    completed_orders = get_completed_orders(
        cleaned_orders
    )
    completed_revenue = calculate_completed_revenue(
        cleaned_orders
    )
    non_revenue_orders = [
        order
        for order in cleaned_orders
        if order["status"]
        in [
            "pending",
            "cancelled",
            "returned"
        ]
    ]
    average_order_value = (
        completed_revenue / len(completed_orders)
        if completed_orders
        else 0
    )

    print("\nBUSINESS METRICS")
    print("=" * 50)
    print(
        f"Completed orders: {len(completed_orders)}"
    )
    print(
        f"Non revenue orders: {len(non_revenue_orders)}"
    )
    print(
        f"Completed revenue: EUR {completed_revenue:.2f}"
    )
    print(
        f"Average completed order value: EUR {average_order_value:.2f}"
    )


    # Dynamic reports
    revenue_by_city = sum_revenue_by_field(
        cleaned_orders,
        "city"
    )
    revenue_by_category = sum_revenue_by_field(
        cleaned_orders,
        "category"
    )
    revenue_by_channel = sum_revenue_by_field(
        cleaned_orders,
        "channel"
    )


    print("\nREVENUE BY CITY")
    for city, revenue in revenue_by_city.items():
        print(
            city,
            ":",
            revenue
        )

    print("\nREVENUE BY CATEGORY")
    for category, revenue in revenue_by_category.items():
        print(
            category,
            ":",
            revenue
        )

    print("\nREVENUE BY CHANNEL")
    for channel, revenue in revenue_by_channel.items():
        print(
            channel,
            ":",
            revenue
        )

    # Rankings
    top_orders = get_top_orders_by_total_amount(
        cleaned_orders,
        5
    )

    print("\nTOP 5 ORDERS")

    for order in top_orders:
        print(
            order["order_id"],
            order["product"],
            order["total_amount"]
        )

    # Final output
    write_business_report(
        cleaned_orders,
        invalid_orders
    )

    print(
        "\nReports generated successfully."
    )
if __name__ == "__main__":
    main()