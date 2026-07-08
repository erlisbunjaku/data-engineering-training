# Data Pipeline Thinking - Day 3

## Chosen business:

**Gym Membership Management**

## Source Data:

The source data comes from different gym activities such as:

* Membership registration forms
* Monthly membership payments
* Gym visit check-ins
* Membership plan information

This data contains information about members, their plans, payments, visits, and membership status.

## Ingestion:

The ingestion process collects data from gym systems and transfers it into a database.

Examples:

* Importing new member registrations.
* Loading payment records.
* Collecting daily visit check-in data.

## Storage:

The collected data is stored in structured database tables such as:

* `gym_memberships` table for member information.
* Payment tables for tracking membership payments.
* Visit tables for tracking gym attendance.

The stored data can later be used for analysis and reporting.

## Cleaning:

Before analyzing the data, quality problems need to be fixed.

Examples:

* Removing duplicate member records.
* Fixing missing member names.
* Correcting incorrect membership statuses.
* Making sure prices and visit counts contain valid numbers.

## Transformation:

The cleaned data is transformed into useful business information.

Examples:

* Calculating yearly membership revenue.
* Counting active and inactive members.
* Finding the most popular membership plans.
* Calculating average gym visits per member.

## Business Output:

The final output could be:

* Monthly revenue reports.
* Active member dashboards.
* Membership plan analysis.
* Member attendance reports.

These outputs help gym managers make better decisions.

## Business questions we can answer:

1. How many active members does the gym currently have?

2. Which membership plan generates the highest revenue?

3. Which members visit the gym most frequently?

## Possible data problems:

1. Duplicate member records caused by repeated registrations.

2. Missing or incorrect payment information.

3. Incorrect membership statuses or invalid visit counts.
