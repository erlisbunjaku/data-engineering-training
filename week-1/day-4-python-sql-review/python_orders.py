orders = [
    {
        "order_id": 1,
        "customer_name": "Arta",
        "city": "Vushtrri",
        "product": "Laptop",
        "category": "Electronics",
        "quantity": 1,
        "price": 700,
        "status": "completed",
        "order_date": "2026-07-01"
    },
    {
        "order_id": 2,
        "customer_name": "Blend",
        "city": "Prishtina",
        "product": "Mouse",
        "category": "Accessories",
        "quantity": 2,
        "price": 15,
        "status": "completed",
        "order_date": "2026-07-01"
    },
    {
        "order_id": 3,
        "customer_name": "Arta",
        "city": "Vushtrri",
        "product": "Keyboard",
        "category": "Accessories",
        "quantity": 1,
        "price": 40,
        "status": "cancelled",
        "order_date": "2026-07-02"
    },
    {
        "order_id": 4,
        "customer_name": "Dren",
        "city": "Mitrovica",
        "product": "Monitor",
        "category": "Electronics",
        "quantity": 1,
        "price": 180,
        "status": "completed",
        "order_date": "2026-07-02"
    },
    {
        "order_id": 5,
        "customer_name": "Elira",
        "city": "Prishtina",
        "product": "Mouse",
        "category": "Accessories",
        "quantity": 1,
        "price": 15,
        "status": "completed",
        "order_date": "2026-07-03"
    },
    {
        "order_id": 6,
        "customer_name": "Dren",
        "city": "Mitrovica",
        "product": "Laptop",
        "category": "Electronics",
        "quantity": 1,
        "price": 700,
        "status": "pending",
        "order_date": "2026-07-03"
    },
    {
        "order_id": 7,
        "customer_name": "Nora",
        "city": "Vushtrri",
        "product": "Headphones",
        "category": "Accessories",
        "quantity": 1,
        "price": 50,
        "status": "completed",
        "order_date": "2026-07-04"
    },
    {
        "order_id": 8,
        "customer_name": "Leart",
        "city": "Peja",
        "product": "Monitor",
        "category": "Electronics",
        "quantity": 2,
        "price": 180,
        "status": "completed",
        "order_date": "2026-07-04"
    },
    {
        "order_id": 9,
        "customer_name": "Faton",
        "city": "Prizren",
        "product": "Desk Chair",
        "category": "Office",
        "quantity": 1,
        "price": 120,
        "status": "completed",
        "order_date": "2026-07-05"
    },
    {
        "order_id": 10,
        "customer_name": "Gresa",
        "city": "Prishtina",
        "product": "USB Cable",
        "category": "Accessories",
        "quantity": 3,
        "price": 8,
        "status": "completed",
        "order_date": "2026-07-05"
    },
    {
        "order_id": 11,
        "customer_name": "Rina",
        "city": "Vushtrri",
        "product": "Laptop",
        "category": "Electronics",
        "quantity": 1,
        "price": 650,
        "status": "cancelled",
        "order_date": "2026-07-06"
    },
    {
        "order_id": 12,
        "customer_name": "Arben",
        "city": "Ferizaj",
        "product": "Desk",
        "category": "Office",
        "quantity": 1,
        "price": 220,
        "status": "pending",
        "order_date": "2026-07-06"
    },
    {
    "order_id": 13,
    "customer_name": "Besa",
    "city": "Prishtina",
    "product": "Tablet",
    "category": "Electronics",
    "quantity": 1,
    "price": 300,
    "status": "completed",
    "order_date": "2026-07-07"
},
{
    "order_id": 14,
    "customer_name": "Luan",
    "city": "Vushtrri",
    "product": "Keyboard",
    "category": "Accessories",
    "quantity": 2,
    "price": 40,
    "status": "pending",
    "order_date": "2026-07-07"
}

    
]

# Task 1

def total_orders(orders):
    total_orders = len(orders)
    print(total_orders)


def print_customer_names(orders):
    for order in orders:
        print(order["customer_name"])


def print_order_sentences(orders):
    for order in orders:
        print(
            f"{order['customer_name']} ordered {order['product']} "
            f"from {order['city']} and the status is {order['status']}."
        )


# Call Task 1 functions
print("\nTotal Number of Orders")
total_orders(orders)
print("\nAll Customer Names")
print_customer_names(orders)
print("\nReadable Sentence for Each Order")
print_order_sentences(orders)


# Task 2

def print_completed_orders(orders):
    for order in orders:
        if order["status"] == "completed":
            print(order["customer_name"])


def print_pending_orders(orders):
    for order in orders:
        if order["status"] == "pending":
            print(order["customer_name"])

def print_cancelled_orders(orders):
    for order in orders:
        if order["status"] == "cancelled":
            print(f"{order["customer_name"]}")

def print_order_greater_than_100(orders):
    for order in orders:
        if order["price"] > 100:
            print(order["customer_name"])

def print_order_category_accessories(orders):
    for order in orders:
        if order["category"] == "Accessories":
            print(order["customer_name"])


# Call Task 2 functions
print("\nCompleted Orders")
print_completed_orders(orders)
print("\nPending Orders")
print_pending_orders(orders)
print("\nCancelled Orders")
print_cancelled_orders(orders)
print("\nOrders where price is greater than 100")
print_order_greater_than_100(orders)
print("\nOrders where category is Accessories")
print_order_category_accessories(orders)


# Task 3

def print_order_totals(orders):
    print("\nOrder Totals:")
    for order in orders:
        total_amount = order["quantity"] * order["price"]
        print(
            f"{order['customer_name']} - {order['product']} - "
            f"{order['quantity']} x {order['price']} = {total_amount}"
        )


# Call Task 3 function
print_order_totals(orders)


# Task 4

def sort_orders_by_price(orders):
    print("\nOrders Sorted by Price (Highest to Lowest)")
    sorted_orders =  sorted(orders, key=lambda order: order['price'], reverse=True)

    for order in sorted_orders:
        print(f"{order["customer_name"]} - {order["product"]} - {order["price"]}")

def sort_orders_by_toal_amount(orders):
    print("\nOrders Sorted by Total Amount (Highest to Lowest)")
    sorted_orders = sorted(
        orders,
        key= lambda order:order["quantity"] * order["price"],
        reverse=True
    )

    for order in sorted_orders:
        total_amount = order["quantity"] * order["price"]
        print(f"{order['customer_name']} - {order['product']} - {total_amount}")


def top_3_orders(orders):
    print("\nTop 3 Orders by Total Amount")
    sorted_orders = sorted(
        orders,
        key= lambda order:order["quantity"] * order["price"],
        reverse=True
    )

    for order in sorted_orders[:3]:
        total_amount = order["quantity"] * order["price"]
        print(f"{order['customer_name']} - {order['product']} - {total_amount}")


# Call Task 4 functions
sort_orders_by_price(orders)
sort_orders_by_toal_amount(orders)
top_3_orders(orders)


# Task 5
def order_summary(orders):
    completed = 0
    pending = 0
    cancelled = 0

    for order in orders:
        if order["status"] == "completed":
            completed += 1
            revenue = order["quantity"] * order["price"]
        
        elif order["status"] == "pending":
            pending += 1

        elif order["status"] == "cancelled":
            cancelled +=1

        
    print(f"completed: {completed}")
    print(f"pending: {pending}")
    print(f"cancelled: {cancelled}")

    print(f"\nCompleted Revenue: {revenue}")


def customers_with_multiple_orders(orders):
    print("\nCustomers with More Than One Order")

    customer_counts = {}

    for order in orders: 
        customer = order["customer_name"]

        if customer in customer_counts:
            customer_counts[customer] += 1

        else:
            customer_counts[customer] = 1

    for customer in customer_counts:
        if customer_counts[customer] > 1:
            print(f"{customer}: {customer_counts[customer]} orders")

# Call Task 5 functions
order_summary(orders)
customers_with_multiple_orders(orders)


# Part 4 - Mini Business Challenge


# Find the customer with the most expensive single order
def most_expensive_order(orders):
    print("\nCustomer with the most expensive single order:")

    highest_order = orders[0]

    for order in orders:
        if order["price"] > highest_order["price"]:
            highest_order = order

    print(
        f"{highest_order['customer_name']} - "
        f"{highest_order['product']} - "
        f"{highest_order['price']}"
    )


# Find the highest total_amount order
def highest_total_amount_order(orders):
    print("\nHighest total amount order:")

    highest_order = orders[0]

    for order in orders:
        total_amount = order["quantity"] * order["price"]
        highest_total = highest_order["quantity"] * highest_order["price"]

        if total_amount > highest_total:
            highest_order = order

    total_amount = highest_order["quantity"] * highest_order["price"]

    print(
        f"{highest_order['customer_name']} - "
        f"{highest_order['product']} - "
        f"{total_amount}"
    )


# Find orders that should NOT count as revenue
def invalid_revenue_orders(orders):
    print("\nOrders not counted as revenue:")

    for order in orders:
        if order["status"] == "pending" or order["status"] == "cancelled":
            print(
                f"{order['customer_name']} - "
                f"{order['product']} - "
                f"{order['status']}"
            )


# Calculate completed revenue only
def completed_revenue(orders):
    print("\nCompleted Revenue:")

    revenue = 0

    for order in orders:
        if order["status"] == "completed":
            revenue += order["quantity"] * order["price"]

    print(revenue)


# Call functions
most_expensive_order(orders)
highest_total_amount_order(orders)
invalid_revenue_orders(orders)
completed_revenue(orders)


# Bonus - Count orders by city

def count_orders_by_city(orders):
    print("\nOrders by City")

    city_count = {}

    for order in orders:
        city = order["city"]

        if city in city_count:
            city_count[city] += 1
        else:
            city_count[city] = 1

    for city, count in city_count.items():
        print(f"{city}: {count}")


count_orders_by_city(orders)

# Bonus - Count orders by category

def count_orders_by_category(orders):
    print("\nOrders by Category")

    category_count = {}

    for order in orders:
        category = order["category"]

        if category in category_count:
            category_count[category] += 1
        else:
            category_count[category] = 1

    for category, count in category_count.items():
        print(f"{category}: {count}")


count_orders_by_category(orders)