-- ==========================================
-- Relationship and Constraint Tests
-- ==========================================

-- Test 1: Invalid student ID
-- Should fail because student_id 999 does not exist.

-- INSERT INTO enrollments
-- (student_id, program_id, instructor_id, enrollment_date, status)

-- VALUES (999, 1, 1, '2026-04-01', 'active');


-- Test 2: Invalid program ID
-- Should fail because program_id 999 does not exist.

--   INSERT INTO enrollments
--  (student_id, program_id, instructor_id, enrollment_date, status)
-- VALUES (1, 999, 1, '2026-04-01', 'active');


-- Test 3: Invalid enrollment ID in attendance
-- Should fail because attendance must reference an existing enrollment.

-- INSERT INTO attendance
-- (enrollment_id, session_date, attendance_status)
-- VALUES (999, '2026-04-05', 'Present');


-- Test 4: Invalid enrollment ID in payments
-- Should fail because payments must reference an existing enrollment.

-- INSERT INTO payment
-- (enrollment_id, payment_month, amount, payment_status, payment_date)
-- VALUES (999, 'April', 200, 'Paid', '2026-04-10');


-- Test 5: Duplicate student email
-- Should fail because email must be unique.

-- INSERT INTO students
--  (first_name, last_name, email, phone, city)
-- VALUES
-- ('John', 'Doe', 'arben@gmail.com', '044123456', 'Prishtina');


-- Test 6: Negative payment amount
-- Should fail because amount cannot be negative.

-- INSERT INTO payments
-- (enrollment_id, payment_month, amount, payment_status, payment_date)
-- VALUES (1, 'April', -100, 'Paid', '2026-04-10');


-- Test 7: Invalid enrollment status
-- Should fail because status must be active, completed, or dropped.

-- INSERT INTO enrollments
-- (student_id, program_id, instructor_id, enrollment_date, status)
--  VALUES (1, 1, 1, '2026-04-01', 'pending');