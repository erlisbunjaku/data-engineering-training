# Database Design

## Project Goal

This database manages a training platform where students enroll in courses, instructors teach courses, attendance is tracked, assignments are created, and students submit their work. The design reduces duplicate data and keeps relationships organized.

---

## Tables

### students
Stores student information.

**Primary Key:** `student_id`

### instructors
Stores instructor information.

**Primary Key:** `instructor_id`

### courses
Stores course information.

**Primary Key:** `course_id`

**Foreign Key:** `instructor_id` → `instructors(instructor_id)`

### enrollments
Connects students and courses.

**Primary Key:** `enrollment_id`

**Foreign Keys:**
- `student_id` → `students(student_id)`
- `course_id` → `courses(course_id)`

### attendance
Stores attendance records.

**Primary Key:** `attendance_id`

**Foreign Key:** `enrollment_id` → `enrollments(enrollment_id)`

### assignments
Stores course assignments.

**Primary Key:** `assignment_id`

**Foreign Key:** `course_id` → `courses(course_id)`

### submissions
Stores student submissions and scores.

**Primary Key:** `submission_id`

**Foreign Keys:**
- `student_id` → `students(student_id)`
- `assignment_id` → `assignments(assignment_id)`

---

## One-to-Many Relationships

- One instructor → many courses
- One course → many assignments
- One student → many enrollments
- One enrollment → many attendance records

---

## Many-to-Many Relationship

Students and courses have a many-to-many relationship. The **enrollments** table acts as the bridge table by connecting `student_id` and `course_id`.

---

## Why Not Store `course_name` in `students`?

A student can enroll in multiple courses, so storing `course_name` in the `students` table would create duplicate data. Keeping courses in a separate table makes the database easier to maintain.

---

## Relationship Diagram

```text
instructors
      ↓
   courses
   ↓      ↓
enrollments → assignments
      ↓           ↓
 attendance   submissions
      ↑
   students
```