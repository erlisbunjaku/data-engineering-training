students = [
    {
        "student_id": 1,
        "name": "Arta",
        "city": "Vushtrri",
        "course": "Python",
        "age": 17,
        "attendance": 90,
        "homework_score": 85
    },
    {
        "student_id": 2,
        "name": "Blend",
        "city": "Prishtina",
        "course": "React",
        "age": 18,
        "attendance": 60,
        "homework_score": 70
    },
    {
        "student_id": 3,
        "name": "Dion",
        "city": "Vushtrri",
        "course": "Python",
        "age": 16,
        "attendance": 75,
        "homework_score": 95
    },
    {
        "student_id": 4,
        "name": "Elira",
        "city": "Mitrovica",
        "course": "React",
        "age": 17,
        "attendance": 80,
        "homework_score": 60
    },
    {
        "student_id": 5,
        "name": "Faton",
        "city": "Vushtrri",
        "course": "Data Engineering",
        "age": 19,
        "attendance": 100,
        "homework_score": 90
    },
    {
        "student_id": 6,
        "name": "Gresa",
        "city": "Prishtina",
        "course": "Python",
        "age": 18,
        "attendance": 55,
        "homework_score": 88
    }
]

#Task 1
print("\nTask 1: ")

print("\nTotal Students: ")
total_students = len(students)
print(total_students)

print("\nStudent Names: ")
for student in students:
    print(student["name"])

print("\nStudent Details: ")
for student in students:
    print(f"This student name is: {student['name']}, the student lives in {student['city']}. And they go to {student['course']} course.")


# #Task 2
print("\nTask 2: ")

print("\nStudents from Vushtrri: ")
for student in students:
    if student["city"] == "Vushtrri":
        print(student["name"])


print("\nStudents with low Attendance: ")
for student in students:
    if student["attendance"] < 70:
        print(student["name"])


print("\nStudents with homework score above 85 ")
for student in students:
    if student["homework_score"] > 85:
        print(student["name"])

    
#Task 3
print("\nTask 3: ")

total_attendace = 0
total_homework = 0

city_count = {}
course_count = {}

for student in students:
    total_attendace += student["attendance"]
    total_homework += student["homework_score"]


    #counting the cities
    city = student["city"]
    city_count[city] = city_count.get(city, 0) + 1

    #couting the courses
    course = student["course"]
    course_count[course] = course_count.get(course, 0) + 1


avg_attendance = total_attendace / len(students)
avg_homework = total_homework / len(students)

print("\nAverage attendance:", round(avg_attendance, 2))
print("Average homework score:", round(avg_homework, 2))


print("\nStudents by city:")
for city, count in city_count.items():
    print(f'{city}: {count}')

print("\nStudents by course:")
for course, count in course_count.items():
    print(f'{course}: {count}')


# Task 4
print("\nTask 4: ")

print("\nPerformance Status:")
for student in students:
    if student["attendance"] >= 80 and student["homework_score"] >= 80:
        performance_status = "Strong"
    
    elif student["attendance"] >=60 and student["homework_score"] >=60:
        performance_status = "Average"
    
    else:
        performance_status = "Needs Support"

    student["performance_status"] = performance_status

    print(f'{student["name"]}: {performance_status}')



#Task 5
print("\nTask 5: ")
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