-- 1. Show all students with their programs and instructors.

SELECT
    s.first_name,
    s.last_name,
    p.program_name,
    i.first_name AS instructor_first_name,
    i.last_name AS instructor_last_name
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN programs p ON e.program_id = p.program_id
JOIN instructors i ON e.instructor_id = i.instructor_id;


-- 2. Show active enrollments only.

SELECT
    s.first_name,
    s.last_name,
    p.program_name,
    i.first_name AS instructor_first_name,
    i.last_name AS instructor_last_name,
    e.status
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN programs p ON e.program_id = p.program_id
JOIN instructors i ON e.instructor_id = i.instructor_id
WHERE e.status = 'active';


-- 3. Show completed enrollments with student and program information.

SELECT
    s.first_name,
    s.last_name,
    p.program_name,
    e.status
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN programs p ON e.program_id = p.program_id
WHERE e.status = 'completed';


-- 4. Show dropped students and the program they dropped from.

SELECT
s.first_name,
s.last_name,
p.program_name,
e.status
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN programs p ON e.program_id = p.program_id
WHERE e.status = 'dropped';


-- 5. Show attendance records with student name, program name, session date, and attendance status.
SELECT
    s.first_name,
    s.last_name,
    p.program_name,
    a.session_date,
    a.attendance_status
FROM attendance a
JOIN enrollments e ON a.enrollment_id = e.enrollment_id
JOIN students s ON e.student_id = s.student_id
JOIN programs p ON e.program_id = p.program_id;


-- 6. Show payment records with student name, program name, payment month, payment status, and amount.

SELECT
    s.first_name,
    s.last_name,
    p.program_name,
    pay.payment_month,
    pay.payment_status,
    pay.amount

FROM payments pay
JOIN enrollments e ON pay.enrollment_id = e.enrollment_id
JOIN students s ON e.student_id = s.student_id
JOIN programs p ON e.program_id = p.program_id;


-- 7. Show each student with their city and all programs they are enrolled in.

SELECT
s.first_name,
    s.last_name,
    s.city,
    p.program_name
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN programs p ON e.program_id = p.program_id
ORDER BY s.last_name;


-- 8. Show instructors and the students/programs they are responsible for.
SELECT
    i.first_name,
    i.last_name,
    p.program_name,
    s.first_name AS student_first_name,
    s.last_name AS student_last_name
FROM enrollments e
JOIN instructors i ON e.instructor_id = i.instructor_id
JOIN students s ON e.student_id = s.student_id
JOIN programs p ON e.program_id = p.program_id
ORDER BY i.last_name;