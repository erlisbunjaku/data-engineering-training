PRAGMA foreign_keys = ON;

-- ==========================================
-- Constraint and Foreign Key Tests
-- ==========================================


-- 1. Invalid course instructor
-- Expected: FAIL
-- Reason: instructor_id 999 does not exist in instructors table.

-- INSERT INTO courses (course_name, level, instructor_id)
-- VALUES ('Machine Learning', 'Advanced', 999);



-- 2. Invalid enrollment student
-- Expected: FAIL
-- Reason: student_id 999 does not exist in students table.

-- INSERT INTO enrollments 
-- (student_id, course_id, enrollment_date, status)
-- VALUES (999, 1, '2026-07-20', 'active');



-- 3. Invalid enrollment course
-- Expected: FAIL
-- Reason: course_id 999 does not exist in courses table.

-- INSERT INTO enrollments
-- (student_id, course_id, enrollment_date, status)
-- VALUES (1, 999, '2026-07-20', 'active');



-- 4. Duplicate enrollment
-- Expected: FAIL
-- Reason: UNIQUE(student_id, course_id) prevents duplicate enrollment.

-- INSERT INTO enrollments
-- (student_id, course_id, enrollment_date, status)
-- VALUES (1, 1, '2026-07-21', 'active');



-- 5. Invalid attendance enrollment
-- Expected: FAIL
-- Reason: enrollment_id 999 does not exist.

-- INSERT INTO attendance
-- (enrollment_id, session_date, attended, minutes_attended)
-- VALUES (999, '2026-07-20', 1, 120);



-- 6. Invalid attendance minutes
-- Expected: FAIL
-- Reason: CHECK constraint prevents negative minutes.

-- INSERT INTO attendance
-- (enrollment_id, session_date, attended, minutes_attended)
-- VALUES (1, '2026-07-20', 1, -10);



-- 7. Invalid course level
-- Expected: FAIL
-- Reason: level only allows Beginner, Intermediate, Advanced.

-- INSERT INTO courses
-- (course_name, level, instructor_id)
-- VALUES ('AI Basics', 'Expert', 1);



-- 8. Invalid submission assignment
-- Expected: FAIL
-- Reason: assignment_id 999 does not exist.

-- INSERT INTO submissions
-- (assignment_id, student_id, submitted_at, score, status)
-- VALUES (999, 1, '2026-07-20', 90, 'submitted');



-- 9. Invalid submission score
-- Expected: FAIL (if negative)
-- Reason: CHECK constraint prevents negative scores.
-- Note: score greater than max_score is NOT enforced because
-- CHECK constraints cannot easily compare values from another table.

-- INSERT INTO submissions
-- (assignment_id, student_id, submitted_at, score, status)
-- VALUES (1, 1, '2026-07-20', -5, 'submitted');



-- 10. Duplicate email
-- Expected: FAIL
-- Reason: email column has UNIQUE constraint.

-- INSERT INTO students
-- (full_name, city, email, created_at)
-- VALUES ('Test Student', 'Prishtina', 'arta@gmail.com', '2026-07-20');



-- Successful test
-- This proves the database still accepts valid data.

INSERT INTO students
(full_name, city, email, created_at)
VALUES
('Test Valid Student', 'Prizren', 'valid.student@gmail.com', '2026-07-20');


SELECT * FROM students;