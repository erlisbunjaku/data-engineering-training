PRAGMA foreign_keys = ON;

-- Students
INSERT INTO students (full_name, city, email, created_at) VALUES
('Arta Krasniqi', 'Prishtina', 'arta@gmail.com', '2026-07-01'),
('Blend Hoxha', 'Peja', 'blend@gmail.com', '2026-07-02'),
('Dren Gashi', 'Prizren', 'dren@gmail.com', '2026-07-03'),
('Era Berisha', 'Gjilan', 'era@gmail.com', '2026-07-04'),
('Luan Mustafa', 'Ferizaj', 'luan@gmail.com', '2026-07-05'),
('Sara Aliu', 'Prishtina', 'sara@gmail.com', '2026-07-06'),
('Klea Rexha', 'Mitrovica', 'klea@gmail.com', '2026-07-07'),
('Endrit Shala', 'Vushtrri', 'endrit@gmail.com', '2026-07-08');

SELECT * FROM students;


-- Instructors
INSERT INTO instructors (full_name, specialization) VALUES
('Arben Gashi', 'Database Engineering'),
('Mira Krasniqi', 'Python Development'),
('Leon Berisha', 'Data Engineering');

SELECT * FROM instructors;


-- Courses
INSERT INTO courses (course_name, level, instructor_id) VALUES
('SQL Fundamentals', 'Beginner', 1),
('Python Programming', 'Intermediate', 2),
('Databricks Fundamentals', 'Advanced', 3),
('PySpark Data Processing', 'Advanced', 3),
('Data Modeling', 'Intermediate', 1);

SELECT * FROM courses;


-- Enrollments
INSERT INTO enrollments (student_id, course_id, enrollment_date, status) VALUES
(1, 1, '2026-07-01', 'active'),
(1, 2, '2026-07-02', 'active'),
(2, 1, '2026-07-01', 'completed'),
(2, 5, '2026-07-03', 'active'),
(3, 3, '2026-07-04', 'active'),
(3, 4, '2026-07-05', 'active'),
(4, 2, '2026-07-06', 'completed'),
(5, 5, '2026-07-06', 'active'),
(5, 3, '2026-07-07', 'active'),
(6, 1, '2026-07-08', 'dropped'),
(7, 4, '2026-07-08', 'active'),
(8, 2, '2026-07-09', 'active');

SELECT * FROM enrollments;


-- Attendance
INSERT INTO attendance 
(enrollment_id, session_date, attended, minutes_attended) VALUES
(1, '2026-07-10', 1, 120),
(1, '2026-07-11', 1, 110),
(2, '2026-07-10', 1, 100),
(3, '2026-07-10', 0, 0),
(4, '2026-07-11', 1, 90),
(5, '2026-07-12', 1, 130),
(6, '2026-07-12', 0, 0),
(7, '2026-07-13', 1, 120),
(8, '2026-07-13', 1, 95),
(9, '2026-07-14', 1, 115),
(10, '2026-07-14', 0, 0),
(11, '2026-07-15', 1, 140),
(12, '2026-07-15', 1, 100),
(3, '2026-07-16', 1, 80),
(5, '2026-07-16', 1, 125),
(7, '2026-07-17', 0, 0),
(9, '2026-07-17', 1, 105),
(12, '2026-07-18', 1, 120);

SELECT * FROM attendance;


-- Assignments
INSERT INTO assignments 
(course_id, title, max_score, due_date) VALUES
(1, 'SQL Queries Practice', 100, '2026-07-20'),
(2, 'Python Functions Project', 100, '2026-07-21'),
(3, 'Databricks Pipeline Task', 100, '2026-07-22'),
(4, 'PySpark Transformation Task', 100, '2026-07-23'),
(5, 'Database ER Diagram', 100, '2026-07-24'),
(1, 'Advanced SQL Reporting', 100, '2026-07-25');

SELECT * FROM assignments;


-- Submissions
INSERT INTO submissions
(assignment_id, student_id, submitted_at, score, status) VALUES
(1, 1, '2026-07-19', 90, 'submitted'),
(1, 2, '2026-07-19', 85, 'submitted'),
(2, 1, '2026-07-20', 95, 'submitted'),
(2, 4, '2026-07-22', 70, 'late'),
(3, 3, '2026-07-21', 88, 'submitted'),
(3, 5, NULL, 0, 'missing'),
(4, 3, '2026-07-24', 75, 'late'),
(4, 7, NULL, 0, 'missing'),
(5, 2, '2026-07-23', 92, 'submitted'),
(5, 5, '2026-07-24', 80, 'submitted'),
(6, 1, '2026-07-25', 100, 'submitted'),
(6, 6, NULL, 0, 'missing');

SELECT * FROM submissions;