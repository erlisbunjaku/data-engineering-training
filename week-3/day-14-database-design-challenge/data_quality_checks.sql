-- 27. Find students with no enrollments.

SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    s.city

FROM students s

LEFT JOIN enrollments e
ON s.student_id = e.student_id

WHERE e.enrollment_id IS NULL;



-- 28. Find programs with no enrollments.

SELECT
    p.program_id,
    p.program_name

FROM programs p

LEFT JOIN enrollments e
ON p.program_id = e.program_id

WHERE e.enrollment_id IS NULL;




-- 29. Find enrollments with no payment record.

SELECT
    e.enrollment_id,
    s.first_name,
    s.last_name,
    p.program_name

FROM enrollments e

JOIN students s
ON e.student_id = s.student_id

JOIN programs p
ON e.program_id = p.program_id

LEFT JOIN payments pay
ON e.enrollment_id = pay.enrollment_id

WHERE pay.payment_id IS NULL;




-- 30. Find enrollments with no attendance records.

SELECT
    e.enrollment_id,
    s.first_name,
    s.last_name,
    p.program_name

FROM enrollments e

JOIN students s
ON e.student_id = s.student_id

JOIN programs p
ON e.program_id = p.program_id

LEFT JOIN attendance a
ON e.enrollment_id = a.enrollment_id

WHERE a.attendance_id IS NULL;




-- 31. Find active students with unpaid or partial payments.

SELECT
    s.first_name,
    s.last_name,
    p.program_name,
    pay.payment_status,
    pay.amount

FROM enrollments e

JOIN students s
ON e.student_id = s.student_id

JOIN programs p
ON e.program_id = p.program_id

JOIN payments pay
ON e.enrollment_id = pay.enrollment_id

WHERE e.status = 'active'
AND pay.payment_status IN ('Unpaid','Partial');




-- 32. Find students with low attendance but paid payment.

SELECT
    s.first_name,
    s.last_name,
    ROUND(
        SUM(CASE WHEN a.attendance_status = 'Present' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(a.attendance_id),2
    ) AS attendance_rate,
    pay.payment_status

FROM students s

JOIN enrollments e
ON s.student_id = e.student_id

JOIN attendance a
ON e.enrollment_id = a.enrollment_id

JOIN payments pay
ON e.enrollment_id = pay.enrollment_id

WHERE pay.payment_status = 'Paid'

GROUP BY s.student_id, s.first_name, s.last_name, pay.payment_status

HAVING attendance_rate < 70;




-- 33. Find students with high attendance but unpaid or partial payment.

SELECT
    s.first_name,
    s.last_name,
    ROUND(
        SUM(CASE WHEN a.attendance_status = 'Present' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(a.attendance_id),2
    ) AS attendance_rate,
    pay.payment_status

FROM students s

JOIN enrollments e
ON s.student_id = e.student_id

JOIN attendance a
ON e.enrollment_id = a.enrollment_id

JOIN payments pay
ON e.enrollment_id = pay.enrollment_id

WHERE pay.payment_status IN ('Unpaid','Partial')

GROUP BY s.student_id, s.first_name, s.last_name, pay.payment_status

HAVING attendance_rate > 80;




-- 34. Find dropped students who still have paid or partial payment records.

SELECT
    s.first_name,
    s.last_name,
    p.program_name,
    pay.payment_status,
    pay.amount

FROM enrollments e

JOIN students s
ON e.student_id = s.student_id

JOIN programs p
ON e.program_id = p.program_id

JOIN payments pay
ON e.enrollment_id = pay.enrollment_id

WHERE e.status = 'dropped'
AND pay.payment_status IN ('Paid','Partial');




-- 35. Find instructors with no active students.

SELECT
    i.first_name,
    i.last_name

FROM instructors i

LEFT JOIN enrollments e
ON i.instructor_id = e.instructor_id
AND e.status = 'active'

WHERE e.enrollment_id IS NULL;




-- 36. Find risky or incomplete records.

SELECT
    s.first_name,
    s.last_name,
    p.program_name,
    e.status,
    pay.payment_status

FROM enrollments e

JOIN students s
ON e.student_id = s.student_id

JOIN programs p
ON e.program_id = p.program_id

LEFT JOIN payments pay
ON e.enrollment_id = pay.enrollment_id

WHERE pay.payment_id IS NULL
OR pay.payment_status IN ('Unpaid','Partial')
OR e.status = 'dropped';