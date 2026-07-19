from students_data import students


# Determine the student's performance level
def get_performance_status(student):
    attendance = student.get("attendance", 0)  # Default value
    homework = student.get("homework_score", 0)

    if attendance >= 80 and homework >= 80:
        return "Strong"
    elif attendance >= 60 and homework >= 60:
        return "Average"
    else:
        return "Needs Support"


# Calculate average attendance
def calculate_average_attendance(student_list):
    if not student_list:
        return 0.0

    total = 0

    for student in student_list:
        total += student.get("attendance", 0)

    return total / len(student_list)


# Calculate average homework score
def calculate_average_homework(student_list):
    if not student_list:
        return 0.0

    total = 0

    for student in student_list:
        total += student.get("homework_score", 0)

    return total / len(student_list)


# Count students by city
def count_by_city(student_list):
    counts = {}

    for student in student_list:
        city = student.get("city")

        if city:
            counts[city] = counts.get(city, 0) + 1

    return counts


# Count students by course
def count_by_course(student_list):
    counts = {}

    for student in student_list:
        course = student.get("course")

        if course:
            counts[course] = counts.get(course, 0) + 1

    return counts


# Return students with attendance below 70%
def get_low_attendance(student_list):
    names = []

    for student in student_list:
        if student.get("attendance", 0) < 70:
            names.append(student.get("name"))

    return names


# Return students with Strong performance
def get_strong_students(student_list):
    names = []

    for student in student_list:
        if get_performance_status(student) == "Strong":
            names.append(student.get("name"))

    return names


# Return students that need support
def get_needs_support(student_list):
    names = []

    for student in student_list:
        if get_performance_status(student) == "Needs Support":
            names.append(student.get("name"))

    return names


# Generate the complete report
def generate_report(student_list):
    print("Student Report")

    if not student_list:
        print("No student data available.")
        return

    print(f"\nTotal students: {len(student_list)}")
    print(f"Average attendance: {calculate_average_attendance(student_list):.2f}")
    print(f"Average homework score: {calculate_average_homework(student_list):.2f}")

    print("\nStudents by city:")
    cities = count_by_city(student_list)

    for city, count in cities.items():
        print(f"{city}: {count}")

    print("\nStudents by course:")
    courses = count_by_course(student_list)

    for course, count in courses.items():
        print(f"{course}: {count}")

    print("\nStudents with low attendance:")

    for name in get_low_attendance(student_list):
        print(name)

    print("\nStrong students:")

    for name in get_strong_students(student_list):
        print(name)

    print("\nStudents that need support:")

    for name in get_needs_support(student_list):
        print(name)


# Add a new student
def add_student(student_list, student):
    student_list.append(student)


# Sort students by homework score
def sort_students_by_homework(student_list):
    if not student_list:
        return []

    return sorted(
        student_list,
        key=lambda student: student.get("homework_score", 0),
        reverse=True
    )


# Return the top three students by combined score
def get_top_three_students(student_list):
    if not student_list:
        return []

    return sorted(
        student_list,
        key=lambda student: (
            student.get("attendance", 0)
            + student.get("homework_score", 0)
        ),
        reverse=True
    )[:3]


if __name__ == "__main__":

    generate_report(students)

    print("\nStudents sorted by homework score:")

    sorted_students = sort_students_by_homework(students)

    for student in sorted_students:
        print(f"{student['name']}: {student['homework_score']}")

    print("\nTop 3 students by combined score:")

    top_three = get_top_three_students(students)

    for student in top_three:
        total_score = student["attendance"] + student["homework_score"]
        print(f"{student['name']}: {total_score}")

    new_student = {
        "student_id": 7,
        "name": "Erion",
        "city": "Prishtina",
        "course": "React",
        "age": 23,
        "attendance": 99,
        "homework_score": 85
    }

    add_student(students, new_student)

    print("\nUpdated student report after adding Erion:")
    generate_report(students)

    print("\nReport with empty student list:")
    generate_report([])