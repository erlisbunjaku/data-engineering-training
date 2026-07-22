# Answers and Explanation

## 1. What problem does a primary key solve?

A primary key uniquely identifies each row in a table and prevents duplicate records.

---

## 2. What problem does AUTOINCREMENT solve?

AUTOINCREMENT automatically generates a unique ID for each new row, so IDs don't need to be entered manually.

---

## 3. What problem does a foreign key solve?

A foreign key connects related tables and prevents records from referencing data that does not exist.

---

## 4. Why is enrollments a bridge table?

The `enrollments` table connects students and courses because one student can join many courses and one course can have many students.

---

## 5. Why is submissions also a relationship table?

The `submissions` table connects students and assignments while storing extra information like score, submission date, and status.

---

## 6. What is one-to-many in your project? Give two examples.

- One instructor can teach many courses.
- One course can have many assignments.

---

## 7. What is many-to-many in your project? Give one example.

Students and courses have a many-to-many relationship, connected through the `enrollments` table.

---

## 8. Why should we not store instructor_name directly inside every course report table?

It would create duplicate data. If an instructor's name changes, it would need to be updated in many places instead of one.

---

## 9. What is the difference between INNER JOIN and LEFT JOIN?

`INNER JOIN` returns only matching rows from both tables. `LEFT JOIN` returns all rows from the left table, even if there is no matching row in the right table.

---

## 10. Which constraint test was most important and why?

The foreign key tests were the most important because they prevent invalid relationships, such as enrolling a student or assigning a course that doesn't exist.

---

## 11. How does this prepare you for Databricks tables and reporting?

It teaches how to design relational databases, enforce data quality with constraints, and write JOIN queries to create business reports, which are essential skills for Databricks and data engineering.