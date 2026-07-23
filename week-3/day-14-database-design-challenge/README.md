# Day 14 - Database Design Challenge

## Project Goal

The goal of this project was to design a relational database for a training center management system. The database manages students, programs, instructors, enrollments, attendance, and payments while supporting business reports and data quality checks.

---

## Business Requirements

Unity Tech Hub needed a system to track:

- Students and their information
- Available training programs
- Instructors
- Student enrollments
- Attendance records
- Payments and financial status
- Reports for management decisions

---

## Database Design

The database contains 6 main tables:

### Students

Stores student information such as name, email, phone, and city.

### Programs

Stores available training programs and their prices.

### Instructors

Stores instructor information and specialization.

### Enrollments

Connects students with programs and instructors. It also tracks enrollment status and enrollment dates.

### Attendance

Stores attendance history for each enrollment. This allows attendance rates to be calculated from real records.

### Payments

Stores payment records, amounts, and payment status for each enrollment.

---

## Relationships

The main relationships are:

- One student can have many enrollments.
- One program can have many enrollments.
- One instructor can manage many enrollments.
- One enrollment can have many attendance records.
- One enrollment can have many payment records.

The Enrollments table solves the many-to-many relationship between students and programs because one student can join multiple programs and one program can have many students.

---

## Primary Keys and Foreign Keys

Each table has a primary key to uniquely identify records.

Examples:

- Students → `student_id`
- Programs → `program_id`
- Instructors → `instructor_id`
- Enrollments → `enrollment_id`
- Attendance → `attendance_id`
- Payments → `payment_id`

Foreign keys connect tables together:

- `enrollments.student_id` → `students.student_id`
- `enrollments.program_id` → `programs.program_id`
- `enrollments.instructor_id` → `instructors.instructor_id`
- `attendance.enrollment_id` → `enrollments.enrollment_id`
- `payments.enrollment_id` → `enrollments.enrollment_id`

---

## Constraints

The database uses constraints to protect data quality:

- **PRIMARY KEY** prevents duplicate IDs and identifies each record.
- **FOREIGN KEY** prevents invalid relationships between tables.
- **NOT NULL** ensures important information cannot be missing.
- **UNIQUE** prevents duplicate values such as student and instructor emails.
- **CHECK** controls allowed values like enrollment status, payment status, and payment amounts.

---

## How to Run

Run the SQL files in this order:

1. `database_schema.sql`
2. `insert_data.sql`
3. `relationship_tests.sql`
4. `join_reports.sql`
5. `aggregation_reports.sql`
6. `having_reports.sql`
7. `data_quality_checks.sql`

The schema must be created first because the other files depend on the tables and relationships.

---

## Most Important Reports

Important reports created include:

- Students with their programs and instructors.
- Active, completed, and dropped enrollments.
- Revenue by program and city.
- Attendance rate reports.
- Payment risk reports.
- Program performance reports.
- Instructor workload reports.

---

## Data Quality Checks Discovered

The database checks for:

- Students without enrollments.
- Programs without students.
- Missing payment records.
- Missing attendance records.
- Students with low attendance.
- Students with unpaid or partial payments.
- Risky or incomplete records.

These checks help confirm that the data is complete and reliable.

---

## Business Insights

The reports help management understand:

- Which programs have the highest number of active students.
- Which programs generate the most revenue.
- Which students may need financial or academic support.
- Which instructors have higher workloads.
- Where data quality problems exist.

These insights help management make better decisions using trusted database information.

---

## What I Can Explain Live

I can explain:

- How primary keys and foreign keys connect tables.
- Why the Enrollments table is needed.
- How JOIN queries combine information from multiple tables.
- How attendance rate is calculated from attendance records.
- How constraints protect data quality.
- How SQL reports help answer business questions.

I am still improving my database design and SQL reporting skills, but this project helped me understand how real business systems are structured and how relational databases support decision making.