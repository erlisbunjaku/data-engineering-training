# Day 13 - Intensive Relationships and Foreign Keys

## Project Goal

The goal of this project was to design a relational database, create relationships between tables, insert realistic data, and build SQL reports using JOINs.

## Database Design

The database contains students, instructors, courses, enrollments, attendance, assignments, and submissions. Each table has a specific purpose and is connected using foreign keys.

## Tables and Relationships

* **students** – Stores student information.
* **instructors** – Stores instructor information.
* **courses** – Stores course details and links to instructors.
* **enrollments** – Connects students and courses.
* **attendance** – Tracks attendance for each enrollment.
* **assignments** – Stores course assignments.
* **submissions** – Stores student assignment submissions.

## Primary Keys, Foreign Keys, and Constraints

Every table uses a primary key with `AUTOINCREMENT`. Foreign keys maintain relationships between tables. `NOT NULL`, `UNIQUE`, and `CHECK` constraints help keep the data valid and consistent.

## Seed Data

Inserted realistic sample data, including:

* 8 students
* 3 instructors
* 5 courses
* 12 enrollments
* 18 attendance records
* 6 assignments
* 12 submissions

## Constraint Tests

Tested foreign keys, unique constraints, and check constraints to verify that invalid data cannot be inserted into the database.

## JOIN Reports

Created beginner, intermediate, and advanced JOIN queries to combine data from multiple tables and generate useful reports.

## Manager Report

Built business-focused reports showing course enrollments, attendance, assignment completion, instructor performance, and a final combined student report.

## Screenshots

Include screenshots showing:

* Database schema
* Seed data
* JOIN report results
* Manager report results

## What I Can Explain Live

* Primary keys and foreign keys
* One-to-many and many-to-many relationships
* Bridge tables
* INNER JOIN vs LEFT JOIN
* SQL constraints
* Aggregate functions and GROUP BY

## What I Would Improve Next

* Add more sample data.
* Create database views for reporting.
* Add indexes to improve query performance.
* Build dashboards using the SQL reports.
