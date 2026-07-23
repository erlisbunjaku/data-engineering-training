PRAGMA foreign_keys = ON;

------------------
-- Students
-------------------

CREATE TABLE students(
    student_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    phone TEXT NOT NULL,
    city TEXT NOT NULL
);



-----------------
-- Programs
-----------------

CREATE TABLE programs(
    program_id INTEGER PRIMARY KEY AUTOINCREMENT,
    program_name TEXT UNIQUE NOT NULL,
    duration_months INTEGER NOT NULL CHECK(duration_months > 0),
    price REAL NOT NULL CHECK(price > 0)
);


----------------
-- Instructors
----------------

CREATE TABLE instructors(
    instructor_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    specialization TEXT NOT NULL
);


----------------
-- Enrollments
----------------

CREATE TABLE enrollments(
    enrollment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    student_id INTEGER NOT NULL,
    program_id INTEGER NOT NULL,
    instructor_id INTEGER NOT NULL,
    enrollment_date DATE NOT NULL,
    status TEXT NOT NULL
        CHECK(status IN ('active','completed','dropped')),

    FOREIGN KEY(student_id) REFERENCES students(student_id),
    FOREIGN KEY(program_id) REFERENCES programs(program_id),
    FOREIGN KEY(instructor_id) REFERENCES instructors(instructor_id)
);

---------------
-- Attendance
---------------

CREATE TABLE attendance(
    attendance_id INTEGER PRIMARY KEY AUTOINCREMENT,
    enrollment_id INTEGER NOT NULL,
    session_date DATE NOT NULL,
    attendance_status TEXT NOT NULL
       CHECK(attendance_status IN ('Present','Absent')),

    FOREIGN KEY(enrollment_id) REFERENCES enrollments(enrollment_id)
);


--------------
-- Payments
-------------

CREATE TABLE payments(
    payment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    enrollment_id INTEGER NOT NULL,
    payment_month TEXT NOT NULL,
    amount REAL NOT NULL CHECK (amount >= 0),
    payment_status TEXT NOT NULL 
      CHECK(payment_status IN ('Paid','Partial','Unpaid')),
    payment_date DATE,

    FOREIGN KEY(enrollment_id) REFERENCES enrollments(enrollment_id)
);

SELECT * FROM students;
SELECT * FROM programs;
SELECT * FROM instructors;
SELECT * FROM enrollments;
SELECT * FROM attendance;
SELECT * FROM payments;