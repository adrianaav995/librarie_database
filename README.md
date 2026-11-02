\# Bookstore Database Management System



\## Overview


This project implements a relational database for managing the activity of a bookstore. It was developed as part of a SQL course final project, using MySQL.


The database stores information about books, authors, categories, customers, orders, and sales. It models the relationships between these entities and includes SQL queries for retrieving, analyzing, and updating data.



\## Database Structure


The database consists of six tables:


\- \*\*authors\*\* – stores information about book authors.

\- \*\*categories\*\* – stores book categories.

\- \*\*books\*\* – contains book details, including title, author, category, and price.

\- \*\*customers\*\* – stores customer information.

\- \*\*orders\*\* – records customer orders and their details.

\- \*\*sales\*\* – stores the books included in each order, along with their prices.


The relationships between the tables are implemented using primary keys and foreign key constraints.


The Entity-Relationship Diagram (ERD) is available in the `diagram/` directory.



\## SQL Concepts and Features


The project demonstrates the use of:


\- Database and table creation (`CREATE DATABASE`, `CREATE TABLE`)

\- Primary keys, foreign keys, and constraints

\- Data insertion (`INSERT INTO`)

\- Table joins (`INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`)

\- Aggregate functions (`COUNT`, `SUM`, `MAX`)

\- Grouping and filtering aggregated data (`GROUP BY`, `HAVING`)

\- Subqueries, including correlated subqueries

\- Date functions (`YEAR)

\- Data manipulation (`UPDATE`)

\- Views (`CREATE VIEW`)


Several queries also include alternative approaches to solving the same problem, such as using subqueries or views.



\## Repository Structure


```text
librarie-database/

│

├── README.md

├── sql/

│   ├── 1\_create\_insert.sql

│   └── 2\_queries.sql

├── diagrams/

│   └── erd.png

└── screenshots/

&#x20;   ├── 1\_database\_creation.png

&#x20;   ├── 2\_tables\_creation.png

&#x20;   ├── 3\_foreign\_keys.png

&#x20;   ├── 4\_data\_insertion.png

&#x20;   ├── query1.png

&#x20;   ├── query2.png

&#x20;   └── ...

```



\## How to Run


1\. Install MySQL and open a MySQL-compatible SQL editor, such as MySQL Workbench.

2\. Execute `01\_create\_and\_insert.sql` to create the database, tables, relationships, and sample records.

3\. Execute `02\_queries.sql` to run the queries and explore the data.



\## Screenshots


The `screenshots/` directory contains selected screenshots documenting the database creation process, table relationships, data insertion, and query execution results.
