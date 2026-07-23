# Day 14 - Database Design Challenge

## Project Goal

The goal of this project is to design a relational database for a training center that manages students, programs, instructors, enrollments, attendance, and payments. The database is designed to keep data organized, reduce duplication, and support accurate business reporting.

---

## Tables

### Students

This table stores each student's personal information. Student data is stored once so the same information does not need to be repeated across the database.

### Programs

This table stores the training programs offered by the center. Keeping programs separate makes it easy to manage and report on different courses.

### Instructors

This table stores instructor information. One instructor can teach many students through different enrollments.

### Enrollments

This is the main relationship table. It connects students with programs and instructors while storing the enrollment date and status. It allows a student to join multiple programs.

### Attendance

Attendance is stored separately because one enrollment has many class sessions. This makes it possible to calculate attendance rates and identify students with low attendance.

### Payments

Payments are stored separately because each enrollment can have multiple monthly payments. This allows the system to track revenue and payment status over time.

---

## Primary Keys

Each table has its own primary key to uniquely identify every record:

* Students → `student_id`
* Programs → `program_id`
* Instructors → `instructor_id`
* Enrollments → `enrollment_id`
* Attendance → `attendance_id`
* Payments → `payment_id`

---

## Foreign Keys

Foreign keys connect related tables and prevent invalid data.

* `Enrollments.student_id` → Students
* `Enrollments.program_id` → Programs
* `Enrollments.instructor_id` → Instructors
* `Attendance.enrollment_id` → Enrollments
* `Payments.enrollment_id` → Enrollments

---

## Relationship Types

The database uses one-to-many relationships:

* One student can have many enrollments.
* One program can have many enrollments.
* One instructor can manage many enrollments.
* One enrollment can have many attendance records.
* One enrollment can have many payment records.

The many-to-many relationship between students and programs is handled through the **Enrollments** table.

---

## Constraints

The database uses constraints to protect data quality:

* **PRIMARY KEY** ensures every record is unique.
* **FOREIGN KEY** ensures relationships are valid.
* **NOT NULL** prevents missing required information.
* **UNIQUE** prevents duplicate student and instructor emails.
* **CHECK** limits status values and prevents negative payment amounts.

---

## Report Readiness

This design supports business reports such as:

* Student progress
* Program performance
* Attendance rates
* Revenue and payment reports
* Instructor workload
* Students at academic or financial risk

The structure keeps data organized and makes SQL reporting simple and reliable.
