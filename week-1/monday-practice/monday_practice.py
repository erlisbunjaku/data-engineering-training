from students_data import students

# -----------------------
# Task 1 - Basic Reporting
# -----------------------

print("\nTask 1")

print("\nTotal Students:")
total_students = len(students)
print(total_students)

print("\nStudent Names:")
for student in students:
    print(student["name"])

print("\nStudent Details:")
for student in students:
    print(
        f"{student['name']} lives in {student['city']} "
        f"and attends the {student['course']} course."
    )


# -----------------------
# Task 2 - Filtering
# -----------------------

print("\nTask 2")

print("\nStudents from Vushtrri:")
for student in students:
    if student["city"] == "Vushtrri":
        print(student["name"])

print("\nStudents with low attendance:")
for student in students:
    if student["attendance"] < 70:
        print(student["name"])

print("\nStudents with homework score above 85:")
for student in students:
    if student["homework_score"] > 85:
        print(student["name"])


# -----------------------
# Task 3 - Statistics
# -----------------------

print("\nTask 3")

total_attendance = 0
total_homework = 0

city_count = {}
course_count = {}

for student in students:
    total_attendance += student["attendance"]
    total_homework += student["homework_score"]

    # Count students by city
    city = student["city"]
    city_count[city] = city_count.get(city, 0) + 1

    # Count students by course
    course = student["course"]
    course_count[course] = course_count.get(course, 0) + 1

avg_attendance = total_attendance / len(students)
avg_homework = total_homework / len(students)

print(f"\nAverage attendance: {avg_attendance:.2f}")
print(f"Average homework score: {avg_homework:.2f}")

print("\nStudents by city:")
for city, count in city_count.items():
    print(f"{city}: {count}")

print("\nStudents by course:")
for course, count in course_count.items():
    print(f"{course}: {count}")


# -----------------------
# Task 4 - Performance Evaluation
# -----------------------

print("\nTask 4")

print("\nPerformance Status:")

for student in students:

    if student["attendance"] >= 80 and student["homework_score"] >= 80:
        performance_status = "Strong"

    elif student["attendance"] >= 60 and student["homework_score"] >= 60:
        performance_status = "Average"

    else:
        performance_status = "Needs Support"

    student["performance_status"] = performance_status

    print(f"{student['name']}: {performance_status}")


# -----------------------
# Task 5 - Clean Report
# -----------------------

print("\nTask 5")

clean_report = []

for student in students:

    clean_student = {
        "student_id": student["student_id"],
        "name": student["name"],
        "course": student["course"],
        "performance_status": student["performance_status"]
    }

    clean_report.append(clean_student)

print("\nClean Report Records:")

for student in clean_report:
    print(
        f"{student['student_id']} - "
        f"{student['name']} - "
        f"{student['course']} - "
        f"{student['performance_status']}"
    )