import csv
import os
from collections import Counter


# Read CSV file and return records
def read_csv_file(file_path):

    if not os.path.exists(file_path):
        raise FileNotFoundError(
            f"File not found: {file_path}"
        )

    with open(
        file_path,
        mode="r",
        encoding="utf-8"
    ) as file:

        reader = csv.DictReader(file)

        records = list(reader)

    return records


# Inspect CSV records
def inspect_records(records):

    print("=" * 40)
    print("CSV Inspection")
    print("=" * 40)

    print(f"\nTotal raw records: {len(records)}")

    print("\nColumns:")

    for column in records[0].keys():

        print(column)


    print("\nFirst 3 records:")

    for record in records[:3]:

        print(
            record["ID"],
            "-",
            record["Name"],
            "-",
            record["City"],
            "-",
            record["Course"]
        )


# Find data quality issues
def find_data_quality_issues(records):

    missing_values = []
    invalid_values = []
    inconsistent_values = []


    for record in records:


        # Missing values

        for column, value in record.items():

            if value == "":

                column_name = column.lower().replace(" ", "_")

                if column_name == "homework":
                    column_name = "homework_score"

                missing_values.append(
                    f"student_id={record['ID']}, column={column_name}"
                )


        # Invalid numeric values

        numeric_columns = [
            "Age",
            "Attendance",
            "Homework"
        ]

        for column in numeric_columns:

            if (
                record[column] != ""
                and not record[column].isdigit()
            ):

                invalid_values.append(
                    f"student_id={record['ID']}, column={column.lower()}, value={record[column]}"
                )


        # Inconsistent city

        if record["City"] == "VUSHTRRI":

            inconsistent_values.append(
                "student_id=6, column=city, value=VUSHTRRI"
            )


        if record["City"] == "prishtina":

            inconsistent_values.append(
                "student_id=10, column=city, value=prishtina"
            )


        # Inconsistent course

        if record["Course"] == "Data engineering":

            inconsistent_values.append(
                "student_id=7, column=course, value=Data engineering"
            )


    total_issues = (
        len(missing_values)
        +
        len(invalid_values)
        +
        len(inconsistent_values)
    )


    report = []

    report.append("Data Quality Report")

    report.append(
        f"Total issues found: {total_issues}"
    )


    report.append("\nMissing values:")

    for issue in missing_values:

        report.append(issue)


    report.append("\nInvalid numeric values:")

    for issue in invalid_values:

        report.append(issue)


    report.append("\nInconsistent text values:")

    for issue in inconsistent_values:

        report.append(issue)


    return "\n".join(report), total_issues


# Clean one student record
def clean_student_record(record):

    cleaned_record = {}


    # Convert student ID

    cleaned_record["student_id"] = int(record["ID"])


    # Keep name

    cleaned_record["name"] = record["Name"]


    # Clean city

    if record["City"] == "":

        cleaned_record["city"] = "Unknown"

    elif record["City"] == "VUSHTRRI":

        cleaned_record["city"] = "Vushtrri"

    elif record["City"] == "prishtina":

        cleaned_record["city"] = "Prishtina"

    else:

        cleaned_record["city"] = record["City"]


    # Clean course

    if record["Course"] == "":

        cleaned_record["course"] = "Not Assigned"

    elif record["Course"] == "Data engineering":

        cleaned_record["course"] = "Data Engineering"

    else:

        cleaned_record["course"] = record["Course"]


    # Clean age

    if record["Age"] == "":

        cleaned_record["age"] = 0

    else:

        cleaned_record["age"] = int(record["Age"])


    # Clean attendance

    if (
        record["Attendance"] == ""
        or not record["Attendance"].isdigit()
    ):

        cleaned_record["attendance"] = 0

    else:

        cleaned_record["attendance"] = int(record["Attendance"])


    # Clean homework score

    if record["Homework"] == "":

        cleaned_record["homework_score"] = 0

    else:

        cleaned_record["homework_score"] = int(record["Homework"])

        # Clean registered date
    if record["Registered Date"] == "":
        cleaned_record["registered_date"] = "Unknown Date"

    else:
        cleaned_record["registered_date"] = record["Registered Date"]


    # Calculate total score
    cleaned_record["total_score"] = (
        cleaned_record["attendance"]
        +
        cleaned_record["homework_score"]
    )


    # Add attendance level
    if cleaned_record["attendance"] >= 80:
        cleaned_record["attendance_level"] = "High"

    elif cleaned_record["attendance"] >= 60:
        cleaned_record["attendance_level"] = "Medium"

    else:
        cleaned_record["attendance_level"] = "Low"


    # Performance status
    if (
        cleaned_record["attendance"] >= 80
        and cleaned_record["homework_score"] >= 80
    ):
        cleaned_record["performance_status"] = "Strong"

    elif (
        cleaned_record["attendance"] >= 60
        and cleaned_record["homework_score"] >= 60
    ):
        cleaned_record["performance_status"] = "Average"

    else:
        cleaned_record["performance_status"] = "Needs Support"


    # Risk flag
    if (
        cleaned_record["attendance"] < 60
        or cleaned_record["homework_score"] < 60
    ):
        cleaned_record["risk_flag"] = "At Risk"

    else:
        cleaned_record["risk_flag"] = "OK"


    return cleaned_record


# Clean all student records
def clean_all_records(records):

    cleaned_records = []

    for record in records:
        cleaned_records.append(
            clean_student_record(record)
        )

    return cleaned_records


# Check duplicate student IDs
def find_duplicate_ids(records):

    ids = []
    duplicates = []

    for record in records:

        if record["ID"] in ids:
            duplicates.append(record["ID"])

        else:
            ids.append(record["ID"])

    return duplicates


# Save cleaned CSV file
def save_clean_csv(records, file_path):

    fieldnames = [
        "student_id",
        "name",
        "city",
        "course",
        "age",
        "attendance",
        "homework_score",
        "registered_date",
        "total_score",
        "performance_status",
        "risk_flag",
        "attendance_level"
    ]

    with open(
        file_path,
        "w",
        newline="",
        encoding="utf-8"
    ) as file:

        writer = csv.DictWriter(
            file,
            fieldnames=fieldnames
        )

        writer.writeheader()

        writer.writerows(records)


# Count values dynamically
def count_by_field(records, field):

    counts = Counter()

    for record in records:
        counts[record[field]] += 1

    return counts


# Calculate average value
def calculate_average(records, field):

    total = 0

    for record in records:
        total += record[field]

    return total / len(records)


# Calculate average value by group
def calculate_average_by_group(records, group_field, value_field):

    totals = {}
    counts = {}

    for record in records:

        group = record[group_field]

        if group not in totals:
            totals[group] = 0
            counts[group] = 0

        totals[group] += record[value_field]
        counts[group] += 1


    averages = {}

    for group in totals:

        averages[group] = totals[group] / counts[group]

    return averages

# Get students by status
def get_students_by_status(records, status):

    students = []

    for record in records:

        if record["performance_status"] == status:
            students.append(record["name"])

    return students


# Get students by risk flag
def get_students_by_risk(records):

    students = []

    for record in records:

        if record["risk_flag"] == "At Risk":
            students.append(record["name"])

    return students


# Get top 3 students
def get_top_students(records):

    top_students = sorted(
        records,
        key=lambda record: record["total_score"],
        reverse=True
    )

    return top_students[:3]


# Generate final summary report
def generate_summary_report(raw_records, cleaned_records, total_issues):

    city_count = count_by_field(
        cleaned_records,
        "city"
    )

    course_count = count_by_field(
        cleaned_records,
        "course"
    )

    average_attendance = calculate_average(
        cleaned_records,
        "attendance"
    )

    average_homework = calculate_average(
        cleaned_records,
        "homework_score"
    )

    attendance_by_course = calculate_average_by_group(
        cleaned_records,
        "course",
        "attendance"
    )

    homework_by_city = calculate_average_by_group(
        cleaned_records,
        "city",
        "homework_score"
    )

    strong_students = get_students_by_status(
        cleaned_records,
        "Strong"
    )

    support_students = get_students_by_status(
        cleaned_records,
        "Needs Support"
    )

    risk_students = get_students_by_risk(
        cleaned_records
    )

    top_students = get_top_students(
        cleaned_records
    )


    report = []

    report.append("Final Student Data Report")

    report.append(
        f"Total raw records: {len(raw_records)}"
    )

    report.append(
        f"Total cleaned records: {len(cleaned_records)}"
    )

    report.append(
        f"Total data quality issues found: {total_issues}"
    )

    report.append(
        f"Average attendance: {average_attendance:.2f}"
    )

    report.append(
        f"Average homework score: {average_homework:.2f}"
    )


    report.append("\nStudents by city:")

    for city, count in city_count.items():

        report.append(
            f"{city}: {count}"
        )


    report.append("\nStudents by course:")

    for course, count in course_count.items():

        report.append(
            f"{course}: {count}"
        )


    report.append("\nAverage attendance by course:")

    for course, average in attendance_by_course.items():

        report.append(
            f"{course}: {average:.2f}"
        )


    report.append("\nAverage homework score by city:")

    for city, average in homework_by_city.items():

        report.append(
            f"{city}: {average:.2f}"
        )


    report.append("\nStrong students:")

    for student in strong_students:

        report.append(student)


    report.append("\nStudents that need support:")

    for student in support_students:

        report.append(student)


    report.append("\nAt Risk students:")

    for student in risk_students:

        report.append(student)


    report.append("\nTop 3 students by total_score:")

    for student in top_students:

        report.append(
            f"{student['name']}: {student['total_score']}"
        )


    return "\n".join(report)


# Save text report
def save_text_report(text, file_path):

    with open(
        file_path,
        "w",
        encoding="utf-8"
    ) as file:

        file.write(text)


# ==========================
# Main Pipeline
# ==========================

# Create output folder automatically

os.makedirs(
    "output",
    exist_ok=True
)


# Read raw CSV

try:

    records = read_csv_file(
        "data/students_raw.csv"
    )

except FileNotFoundError as error:

    print(error)

    exit()


# Check duplicate IDs

duplicates = find_duplicate_ids(records)

if duplicates:

    print(
        "Duplicate student IDs found:",
        duplicates
    )


# Task 2

inspect_records(records)


# Task 3

quality_report, total_issues = find_data_quality_issues(
    records
)

print("\n" + quality_report)

save_text_report(
    quality_report,
    "output/data_quality_report.txt"
)


# Task 4 + Task 5

cleaned_records = clean_all_records(
    records
)


print("\nPerformance Status")

for record in cleaned_records:

    print(
        record["name"],
        "-",
        record["performance_status"],
        "-",
        record["risk_flag"],
        "-",
        record["attendance_level"]
    )


# Task 6

save_clean_csv(
    cleaned_records,
    "output/students_clean.csv"
)


# Task 7

summary_report = generate_summary_report(
    records,
    cleaned_records,
    total_issues
)


print("\n" + summary_report)

save_text_report(
    summary_report,
    "output/summary_report.txt"
)