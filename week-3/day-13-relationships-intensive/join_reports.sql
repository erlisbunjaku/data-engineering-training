PRAGMA foreign_keys = ON;


-- 1. Show all students with city and email
SELECT
    s.full_name,
    s.city,
    s.email
FROM students s;


-- 2. Show all courses with instructor name and specialization
SELECT
    c.course_name,
    c.level,
    i.full_name AS instructor_name,
    i.specialization
FROM courses c
JOIN instructors i
    ON c.instructor_id = i.instructor_id;


-- 3. Show all assignments with course name and due date
SELECT
    a.title AS assignment_title,
    c.course_name,
    a.due_date
FROM assignments a
JOIN courses c
    ON a.course_id = c.course_id;


-- 4. Show all enrollments with student, course, date, and status
SELECT
    s.full_name AS student_name,
    c.course_name,
    e.enrollment_date,
    e.status
FROM enrollments e
JOIN students s
    ON e.student_id = s.student_id
JOIN courses c
    ON e.course_id = c.course_id;


-- 5. Show only active enrollments
SELECT
    s.full_name AS student_name,
    c.course_name,
    e.enrollment_date
FROM enrollments e
JOIN students s
    ON e.student_id = s.student_id
JOIN courses c
    ON e.course_id = c.course_id
WHERE e.status = 'active';


-- 6. Show attendance records with student, course, session, attended, minutes
SELECT
    s.full_name AS student_name,
    c.course_name,
    a.session_date,
    a.attended,
    a.minutes_attended
FROM attendance a
JOIN enrollments e
    ON a.enrollment_id = e.enrollment_id
JOIN students s
    ON e.student_id = s.student_id
JOIN courses c
    ON e.course_id = c.course_id;


-- 7. Show submissions with student, assignment, course, score, status
SELECT
    s.full_name AS student_name,
    a.title AS assignment_title,
    c.course_name,
    sub.score,
    sub.status
FROM submissions sub
JOIN students s
    ON sub.student_id = s.student_id
JOIN assignments a
    ON sub.assignment_id = a.assignment_id
JOIN courses c
    ON a.course_id = c.course_id;


-- 8. Count students enrolled in each course
SELECT
    c.course_name,
    COUNT(e.student_id) AS student_count
FROM courses c
LEFT JOIN enrollments e
    ON c.course_id = e.course_id
GROUP BY c.course_id;


-- 9. Show students enrolled in more than one course
SELECT
    s.full_name,
    COUNT(e.course_id) AS total_courses
FROM students s
JOIN enrollments e
    ON s.student_id = e.student_id
GROUP BY s.student_id
HAVING COUNT(e.course_id) > 1;


-- 10. Show average attendance minutes by course
SELECT
    c.course_name,
    AVG(a.minutes_attended) AS average_minutes
FROM attendance a
JOIN enrollments e
    ON a.enrollment_id = e.enrollment_id
JOIN courses c
    ON e.course_id = c.course_id
GROUP BY c.course_id;


-- 11. Show average score by course
SELECT
    c.course_name,
    AVG(sub.score) AS average_score
FROM submissions sub
JOIN assignments a
    ON sub.assignment_id = a.assignment_id
JOIN courses c
    ON a.course_id = c.course_id
GROUP BY c.course_id;


-- 12. Show missing or late submissions with student and course context
SELECT
    s.full_name AS student_name,
    c.course_name,
    a.title AS assignment_title,
    sub.status
FROM submissions sub
JOIN students s
    ON sub.student_id = s.student_id
JOIN assignments a
    ON sub.assignment_id = a.assignment_id
JOIN courses c
    ON a.course_id = c.course_id
WHERE sub.status IN ('missing', 'late');


-- 13. Show students with no enrollments using LEFT JOIN
SELECT
    s.full_name,
    s.city,
    s.email
FROM students s
LEFT JOIN enrollments e
    ON s.student_id = e.student_id
WHERE e.enrollment_id IS NULL;


-- 14. Show assignments with no submissions using LEFT JOIN
SELECT
    a.title AS assignment_title,
    c.course_name
FROM assignments a
JOIN courses c
    ON a.course_id = c.course_id
LEFT JOIN submissions sub
    ON a.assignment_id = sub.assignment_id
WHERE sub.submission_id IS NULL;