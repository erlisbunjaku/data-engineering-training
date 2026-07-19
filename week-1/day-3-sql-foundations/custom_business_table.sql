-- ==========================================
-- Day 3 SQL Foundations
-- Custom Business Table
-- Business: Gym Membership System
-- Purpose: Practice filtering, sorting,
-- calculated columns, and business reporting
-- ==========================================


-- Remove table if it already exists
DROP TABLE IF EXISTS gym_memberships;


-- Create gym memberships table
CREATE TABLE gym_memberships (
    member_id INTEGER,
    member_name TEXT,
    membership_plan TEXT,
    monthly_price INTEGER,
    visits INTEGER,
    status TEXT,
    join_date TEXT
);


-- Insert gym membership data
INSERT INTO gym_memberships (
    member_id,
    member_name,
    membership_plan,
    monthly_price,
    visits,
    status,
    join_date
)
VALUES
(1, 'Arta', 'Premium', 50, 12, 'active', '2026-01-10'),
(2, 'Blend', 'Basic', 25, 5, 'active', '2026-02-15'),
(3, 'Dren', 'Premium', 50, 20, 'active', '2026-01-05'),
(4, 'Elira', 'Standard', 35, 8, 'inactive', '2025-12-20'),
(5, 'Luan', 'Basic', 25, 3, 'active', '2026-03-01'),
(6, 'Sara', 'Premium', 50, 15, 'active', '2026-02-01'),
(7, 'Era', 'Standard', 35, 7, 'inactive', '2025-11-18'),
(8, 'Blerim', 'Premium', 50, 25, 'active', '2026-01-20');



-- ==========================================
-- Query 37: Show all rows from custom table
-- ==========================================

SELECT *
FROM gym_memberships;



-- ==========================================
-- Query 38: Show selected columns only
-- ==========================================

SELECT
    member_name,
    membership_plan,
    status
FROM gym_memberships;



-- ==========================================
-- Query 39: Filter rows by status
-- ==========================================

SELECT *
FROM gym_memberships
WHERE status = 'active';



-- ==========================================
-- Query 40: Filter rows by numeric column
-- Members with more than 10 visits
-- ==========================================

SELECT *
FROM gym_memberships
WHERE visits > 10;



-- ==========================================
-- Query 41: Combine two conditions using AND
-- Active premium members
-- ==========================================

SELECT *
FROM gym_memberships
WHERE status = 'active'
AND membership_plan = 'Premium';



-- ==========================================
-- Query 42: Combine two conditions using OR
-- Premium or Standard memberships
-- ==========================================

SELECT *
FROM gym_memberships
WHERE membership_plan = 'Premium'
OR membership_plan = 'Standard';



-- ==========================================
-- Query 43: Sort rows by numeric column
-- Highest monthly price first
-- ==========================================

SELECT *
FROM gym_memberships
ORDER BY monthly_price DESC;



-- ==========================================
-- Query 44: Show top 3 members by visits
-- ==========================================

SELECT *
FROM gym_memberships
ORDER BY visits DESC
LIMIT 3;



-- ==========================================
-- Query 45: Create calculated column
-- Yearly membership payment
-- ==========================================

SELECT
    member_name,
    membership_plan,
    monthly_price,
    monthly_price * 12 AS yearly_payment
FROM gym_memberships;



-- ==========================================
-- Query 46: Business-ready query
-- Active premium members with high engagement
-- ==========================================

SELECT
    member_name,
    membership_plan,
    visits,
    monthly_price * 12 AS yearly_payment
FROM gym_memberships
WHERE status = 'active'
AND membership_plan = 'Premium'
AND visits > 10
ORDER BY yearly_payment DESC;