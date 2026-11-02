# Bookstore Database Management System

## Overview

This project implements a relational database for managing the operations of a bookstore. It was developed as a final project for a SQL course using MySQL.

The database stores information about books, authors, categories, customers, orders, and sales. It models the relationships between these entities and includes a variety of SQL queries for retrieving, analyzing, and updating data.

---

## Database Structure

The database consists of the following tables:

- **authors** – stores information about book authors.
- **categories** – stores book categories.
- **books** – contains book details, including title, author, category, and price.
- **customers** – stores customer information.
- **orders** – records customer orders.
- **sales** – stores books included in each order along with their sale prices.

Relationships between tables are implemented using primary keys and foreign key constraints.

The Entity-Relationship Diagram (ERD) is available in the `diagram/` directory.

---

## SQL Concepts and Features

This project demonstrates the use of:

- Database and table creation (`CREATE DATABASE`, `CREATE TABLE`)
- Primary keys, foreign keys, and constraints
- Data insertion (`INSERT INTO`)
- Table joins (`INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`)
- Aggregate functions (`COUNT`, `SUM`, `MAX`)
- Grouping and filtering aggregated data (`GROUP BY`, `HAVING`)
- Subqueries, including correlated subqueries
- Date functions (`YEAR`)
- Data manipulation (`UPDATE`)
- Views (`CREATE VIEW`)

Several queries also demonstrate alternative approaches to solving the same problem, such as using subqueries or views.

---

## Repository Structure

```text
bookstore-database/
├── README.md
├── sql/
│   ├── 1_create_and_insert.sql
│   └── 2_queries.sql
├── diagram/
│   └── erd.png
└── screenshots/
    ├── 1_database_creation.png
    ├── 2_tables_creation.png
    ├── 3_foreign_keys.png
    ├── 4_data_insertion.png
    ├── query1.png
    ├── query2.png
    └── ...
```
---

## How to Run

1. Install MySQL and open a MySQL-compatible SQL editor such as MySQL Workbench.
2. Execute `1_create_insert.sql` to:
   - Create the database
   - Create all tables
   - Define relationships and constraints
   - Insert sample data
3. Execute `2_queries.sql` to run the SQL queries and explore the dataset.

---

## Screenshots

The `screenshots/` directory contains screenshots documenting:

- Database creation
- Table creation
- Foreign key relationships
- Data insertion
- Query execution and results

These screenshots provide visual evidence of the project's implementation and functionality.

---

## Technologies Used

- MySQL
- SQL
- MySQL Workbench (or another compatible SQL editor)

---

## Author

Created as a final project for a SQL database course.
