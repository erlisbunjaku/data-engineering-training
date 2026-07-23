-- 9. Count students by city.
SELECT
    city,
    COUNT(*) AS total_students
FROM students
GROUP BY city
ORDER BY total_students DESC;


-- 10. Count enrollments by status.

SELECT
   status,
    COUNT(*) AS total_enrollments
FROM enrollments
GROUP BY status;


-- 11. Count enrollments by program.
SELECT
    p.program_name,
    COUNT(e.enrollment_id) AS total_enrollments
FROM programs p
LEFT JOIN enrollments e
ON p.program_id = e.program_id
GROUP BY p.program_id, p.program_name
ORDER BY total_enrollments DESC;


-- 12. Count active enrollments by program.

SELECT
    p.program_name,
    COUNT(e.enrollment_id) AS active_enrollments
FROM programs p
JOIN enrollments e
ON p.program_id = e.program_id
WHERE e.status = 'active'
GROUP BY p.program_id, p.program_name
ORDER BY active_enrollments DESC;


-- 13. Calculate total paid amount by program.


SELECT
    p.program_name,
    SUM(pay.amount) AS total_paid
FROM payments pay
JOIN enrollments e
ON pay.enrollment_id = e.enrollment_id
JOIN programs p
ON e.program_id = p.program_id
WHERE pay.payment_status = 'Paid'
GROUP BY p.program_id, p.program_name
ORDER BY total_paid DESC;


-- 14. Calculate unpaid or partial amount by program.

SELECT
    p.program_name,
    SUM(pay.amount) AS unpaid_partial_amount
FROM payments pay
JOIN enrollments e
ON pay.enrollment_id = e.enrollment_id
JOIN programs p
ON e.program_id = p.program_id
WHERE pay.payment_status IN ('Unpaid', 'Partial')
GROUP BY p.program_id, p.program_name
ORDER BY unpaid_partial_amount DESC;


-- 15. Calculate collected revenue by city.

SELECT
    s.city,
    SUM(pay.amount) AS collected_revenue
FROM payments pay
JOIN enrollments e
ON pay.enrollment_id = e.enrollment_id
JOIN students s
ON e.student_id = s.student_id
WHERE pay.payment_status = 'Paid'
GROUP BY s.city
ORDER BY collected_revenue DESC;


-- 16. Calculate average attendance rate by student.

SELECT
    s.first_name,
    s.last_name,
    ROUND(
        SUM(CASE WHEN a.attendance_status = 'Present' THEN 1 ELSE 0 END) * 100.0 /
        COUNT(a.attendance_id),
        2
    ) AS attendance_rate
FROM attendance a
JOIN enrollments e
ON a.enrollment_id = e.enrollment_id
JOIN students s
ON e.student_id = s.student_id
GROUP BY s.student_id, s.first_name, s.last_name
ORDER BY attendance_rate DESC;


-- 17. Calculate average attendance rate by program.
SELECT
    p.program_name,
    ROUND(
        SUM(CASE WHEN a.attendance_status = 'Present' THEN 1 ELSE 0 END) * 100.0 /
        COUNT(a.attendance_id),
        2
     ) AS attendance_rate
FROM attendance a
JOIN enrollments e
ON a.enrollment_id = e.enrollment_id
JOIN programs p
ON e.program_id = p.program_id
GROUP BY p.program_id, p.program_name
ORDER BY attendance_rate DESC;


-- 18. Show top 5 students by attendance rate.

SELECT
    s.first_name,
    s.last_name,
    ROUND(
       SUM(CASE WHEN a.attendance_status = 'Present' THEN 1 ELSE 0 END) * 100.0 /
        COUNT(a.attendance_id),
        2
    ) AS attendance_rate
FROM attendance a
JOIN enrollments e
ON a.enrollment_id = e.enrollment_id
JOIN students s
ON e.student_id = s.student_id
GROUP BY s.student_id, s.first_name, s.last_name
ORDER BY attendance_rate DESC
LIMIT 5;


-- 19. Show top 5 programs by collected revenue.

SELECT
    p.program_name,
    SUM(pay.amount) AS collected_revenue
FROM payments pay
JOIN enrollments e
ON pay.enrollment_id = e.enrollment_id
JOIN programs p
ON e.program_id = p.program_id
WHERE pay.payment_status = 'Paid'
GROUP BY p.program_id, p.program_name
ORDER BY collected_revenue DESC
LIMIT 5;


-- 20. Show instructors ranked by number of active students.
SELECT
    i.first_name,
    i.last_name,
    COUNT(e.enrollment_id) AS active_students
FROM instructors i
JOIN enrollments e
ON i.instructor_id = e.instructor_id
WHERE e.status = 'active'
GROUP BY i.instructor_id, i.first_name, i.last_name
ORDER BY active_students DESC;