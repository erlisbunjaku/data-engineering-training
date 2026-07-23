-- 21. Show programs with more than 3 enrollments.

SELECT
    p.program_name,
    COUNT(e.enrollment_id) AS total_enrollments

FROM programs p
JOIN enrollments e
    ON p.program_id = e.program_id

GROUP BY p.program_id, p.program_name
HAVING COUNT(e.enrollment_id) > 3;



-- 22. Show cities with more than 2 students.

SELECT city,
       COUNT(student_id) AS total_students

FROM students

GROUP BY city
HAVING COUNT(student_id) > 2;




-- 23. Show students with attendance rate below 70%.

SELECT
    s.first_name,
    s.last_name,

    ROUND(
       SUM(CASE WHEN a.attendance_status = 'Present' THEN 1 ELSE 0 END)
       * 100.0 / COUNT(a.attendance_id), 2
    ) AS attendance_rate

FROM attendance a

JOIN enrollments e
ON a.enrollment_id = e.enrollment_id

JOIN students s
ON e.student_id = s.student_id

GROUP BY s.student_id, s.first_name, s.last_name
HAVING attendance_rate < 70;



-- 24. Show programs with collected revenue greater than 300.

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

HAVING SUM(pay.amount) > 300;




-- 25. Show instructors with more than 3 active enrollments.

SELECT
    i.first_name,
    i.last_name,
    COUNT(e.enrollment_id) AS active_enrollments

FROM instructors i

JOIN enrollments e
ON i.instructor_id = e.instructor_id

WHERE e.status = 'active'

GROUP BY i.instructor_id,
         i.first_name,
         i.last_name

HAVING COUNT(e.enrollment_id) > 3;



-- 26. Show programs with unpaid or partial payment amount greater than 100.

SELECT
    p.program_name,
    SUM(pay.amount) AS unpaid_partial_amount

FROM payments pay

JOIN enrollments e
ON pay.enrollment_id = e.enrollment_id

JOIN programs p
ON e.program_id = p.program_id

WHERE pay.payment_status IN ('Unpaid','Partial')

GROUP BY p.program_id,p.program_name

HAVING SUM(pay.amount) > 100;