PRAGMA foreign_keys = ON;

-- 1. Which courses have the most enrollments?
SELECT
    c.course_name,
    COUNT(e.enrollment_id) AS total_enrollments
FROM courses c
LEFT JOIN enrollments e
    ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name
ORDER BY total_enrollments DESC;


-- 2. Which students are active in more than one course?
SELECT
    s.full_name AS student_name,
    COUNT(e.course_id) AS active_courses
FROM students s
JOIN enrollments e
    ON s.student_id = e.student_id
WHERE e.status = 'active'
GROUP BY s.student_id, s.full_name
HAVING COUNT(e.course_id) > 1;


-- 3. Which course has the strongest average attendance?
SELECT
    c.course_name,
    AVG(a.minutes_attended) AS average_minutes
FROM attendance a
JOIN enrollments e
    ON a.enrollment_id = e.enrollment_id
JOIN courses c
    ON e.course_id = c.course_id
WHERE a.attended = 1
GROUP BY c.course_id, c.course_name
ORDER BY average_minutes DESC;


-- 4. Which course has the weakest assignment completion?
SELECT
    c.course_name,
    COUNT(sub.submission_id) AS submitted_assignments,
    SUM(CASE
            WHEN sub.status IN ('missing', 'late') THEN 1
            ELSE 0
        END) AS incomplete_assignments
FROM courses c
JOIN assignments a
    ON c.course_id = a.course_id
LEFT JOIN submissions sub
    ON a.assignment_id = sub.assignment_id
GROUP BY c.course_id, c.course_name
ORDER BY incomplete_assignments DESC;


-- 5. Which students need attention because of missing/late submissions?
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
WHERE sub.status IN ('missing', 'late')
ORDER BY s.full_name;


-- 6. Which instructor is responsible for the highest number of active enrollments?
SELECT
    i.full_name AS instructor_name,
    COUNT(e.enrollment_id) AS active_enrollments
FROM instructors i
JOIN courses c
    ON i.instructor_id = c.instructor_id
JOIN enrollments e
    ON c.course_id = e.course_id
WHERE e.status = 'active'
GROUP BY i.instructor_id, i.full_name
ORDER BY active_enrollments DESC;


-- 7. Final manager report
SELECT
    s.full_name AS student_name,
    c.course_name,
    i.full_name AS instructor_name,
    e.status AS enrollment_status,
    COUNT(a.attendance_id) AS total_sessions,
    SUM(a.attended) AS attended_sessions,
    SUM(a.minutes_attended) AS total_minutes,
    AVG(sub.score) AS average_score
FROM enrollments e
JOIN students s
    ON e.student_id = s.student_id
JOIN courses c
    ON e.course_id = c.course_id
JOIN instructors i
    ON c.instructor_id = i.instructor_id
LEFT JOIN attendance a
    ON e.enrollment_id = a.enrollment_id
LEFT JOIN assignments ass
    ON c.course_id = ass.course_id
LEFT JOIN submissions sub
    ON ass.assignment_id = sub.assignment_id
    AND sub.student_id = s.student_id
GROUP BY
    s.student_id,
    s.full_name,
    c.course_id,
    c.course_name,
    i.full_name,
    e.status
ORDER BY
    s.full_name,
    c.course_name;