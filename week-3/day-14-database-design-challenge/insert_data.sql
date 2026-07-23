-- =========================
-- Students
-- =========================

INSERT INTO students (first_name, last_name, email, phone, city)
VALUES
('Arben', 'Krasniqi', 'arben@gmail.com', '044111111', 'Prishtina'),
('Luan', 'Berisha', 'luan@gmail.com', '044222222', 'Vushtrri'),
('Era', 'Hoxha', 'era@gmail.com', '044333333', 'Peja'),
('Diona', 'Gashi', 'diona@gmail.com', '044444444', 'Prizren'),
('Blerim', 'Shala', 'blerim@gmail.com', '044555555', 'Mitrovica'),
('Sara', 'Rexhepi', 'sara@gmail.com', '044666666', 'Prishtina'),
('Endrit', 'Kelmendi', 'endrit@gmail.com', '044777777', 'Ferizaj'),
('Elisa', 'Morina', 'elisa@gmail.com', '044888888', 'Gjilan'),
('Altin', 'Zeka', 'altin@gmail.com', '044999999', 'Peja'),
('Rina', 'Aliu', 'rina@gmail.com', '044000000', 'Prizren');


-- =========================
-- Programs
-- =========================

INSERT INTO programs (program_name, duration_months, price)
VALUES
('Full Stack Development', 6, 1200),
('Data Engineering', 6, 1500),
('English Language', 4, 500),
('After School Program', 3, 300),
('Cyber Security', 6, 1800);


-- =========================
-- Instructors
-- =========================

INSERT INTO instructors (first_name, last_name, email, specialization)
VALUES
('Ermal', 'Krasniqi', 'ermal@techhub.com', 'Web Development'),
('Arta', 'Berisha', 'arta@techhub.com', 'Data Engineering'),
('Driton', 'Hoxha', 'driton@techhub.com', 'English');


-- =========================
-- Enrollments
-- =========================

INSERT INTO enrollments 
(student_id, program_id, instructor_id, enrollment_date, status)
VALUES

-- Full Stack (many enrollments)
(1,1,1,'2026-01-10','active'),
(2,1,1,'2026-01-12','completed'),
(3,1,1,'2026-02-01','active'),
(4,1,1,'2026-02-05','dropped'),

-- Data Engineering
(5,2,2,'2026-01-15','active'),
(6,2,2,'2026-02-10','completed'),
(7,2,2,'2026-02-20','active'),

-- English
(8,3,3,'2026-01-20','completed'),
(9,3,3,'2026-03-01','active'),

-- After School
(10,4,1,'2026-03-05','active'),

-- Same student in multiple programs
(1,2,2,'2026-03-10','active'),

-- More enrollments
(2,3,3,'2026-03-15','completed'),
(5,1,1,'2026-03-20','active'),
(6,3,3,'2026-03-22','dropped');


-- =========================
-- Attendance
-- =========================

INSERT INTO attendance
(enrollment_id, session_date, attendance_status)
VALUES

-- Strong attendance student
(1,'2026-01-15','Present'),
(1,'2026-01-20','Present'),
(1,'2026-01-25','Present'),
(1,'2026-02-01','Present'),

-- Weak attendance student
(4,'2026-02-10','Absent'),
(4,'2026-02-15','Absent'),
(4,'2026-02-20','Present'),
(4,'2026-02-25','Absent'),

-- Other attendance
(2,'2026-01-20','Present'),
(2,'2026-01-25','Present'),

(3,'2026-02-10','Present'),
(3,'2026-02-15','Absent'),

(5,'2026-02-01','Present'),
(5,'2026-02-05','Present'),
(5,'2026-02-10','Present'),

(6,'2026-02-15','Present'),
(6,'2026-02-20','Present'),

(7,'2026-03-01','Absent'),
(7,'2026-03-05','Present'),

(8,'2026-02-01','Present'),
(8,'2026-02-05','Present'),

(9,'2026-03-10','Present'),
(9,'2026-03-15','Absent'),

(10,'2026-03-15','Present'),
(10,'2026-03-20','Present'),

(11,'2026-03-15','Present'),
(11,'2026-03-20','Present'),

(12,'2026-03-20','Present'),
(12,'2026-03-25','Absent'),

(13,'2026-03-25','Present'),
(14,'2026-03-30','Absent');


-- =========================
-- Payments
-- =========================

INSERT INTO payments
(enrollment_id, payment_month, amount, payment_status, payment_date)
VALUES

(1,'January',200,'Paid','2026-01-15'),
(1,'February',200,'Paid','2026-02-15'),

(2,'January',1200,'Paid','2026-01-20'),

(3,'February',200,'Partial','2026-02-20'),

(4,'February',0,'Unpaid',NULL),

(5,'January',500,'Paid','2026-01-20'),

(6,'February',1500,'Paid','2026-02-25'),

(7,'March',500,'Partial','2026-03-10'),

(8,'January',500,'Paid','2026-01-25'),

(9,'March',0,'Unpaid',NULL),

(10,'March',300,'Paid','2026-03-15'),

(11,'March',700,'Partial','2026-03-20'),

(12,'March',500,'Paid','2026-03-25'),

(13,'March',200,'Unpaid',NULL);


-- =========================
-- Verify Data
-- =========================

SELECT * FROM students;
SELECT * FROM programs;
SELECT * FROM instructors;
SELECT * FROM enrollments;
SELECT * FROM attendance;
SELECT * FROM payments;