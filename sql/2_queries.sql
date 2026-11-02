-- =====================================================
-- BOOKSTORE DATABASE MANAGEMENT SYSTEM
-- SQL Queries
-- =====================================================
--
-- This script contains queries used to retrieve, analyze, and update data in the bookstore database.
--
-- Prerequisite:
-- Run 1_create_insert.sql first to create and populate the database.
--
-- Database: librarie
-- =====================================================
USE librarie;


-- =====================================================
-- 1. BASIC DATA RETRIEVAL
-- =====================================================
-- Query 1: Display all books, including their category and the full name of each author.
-- LEFT JOIN is used to retrieve related information from the authors and categories tables.
SELECT c.id, c.titlu, c.id_autor,
       CONCAT(a.prenume, " ", a.nume) AS autor,
       c.id_categorie, ct.denumire AS categorie, c.pret
FROM carti AS c
LEFT JOIN autori AS a
    ON c.id_autor = a.id
LEFT JOIN categorii AS ct
    ON c.id_categorie = ct.id;

-- Query 2: Display the list of registered customers.
SELECT *
FROM clienti;

-- Query 3: Display all orders registered in the system.
SELECT *
FROM comenzi;


-- =====================================================
-- 2. SORTING AND FILTERING DATA
-- =====================================================
-- Query 4: Display customer orders together with the customer's name and address, ordered from newest to oldest.
SELECT co.id, co.id_client, cl.nume, cl.prenume,
       cl.adresa, co.data_plasarii, co.suma_totala
FROM comenzi AS co
LEFT JOIN clienti AS cl
    ON co.id_client = cl.id
ORDER BY data_plasarii DESC;

-- Query 5: Retrieve the latest order placed by
-- the customer "Ionescu Alexandru".
--
-- Version 1:
-- Uses the MAX() aggregate function in a subquery to identify the latest order date.
SELECT *
FROM comenzi AS co
LEFT JOIN clienti AS cl
    ON co.id_client = cl.id
WHERE cl.nume = "Ionescu"
  AND cl.prenume = "Alexandru"
  AND co.data_plasarii = (
      SELECT MAX(co.data_plasarii)
      FROM comenzi AS co
      LEFT JOIN clienti AS cl
          ON co.id_client = cl.id
      WHERE cl.nume = "Ionescu"
        AND cl.prenume = "Alexandru"
  );

-- Version 2: Alternative solution.
-- Uses ORDER BY DESC and LIMIT 1 in the subquery to retrieve the latest order date.
SELECT *
FROM comenzi AS co
LEFT JOIN clienti AS cl
    ON co.id_client = cl.id
WHERE cl.nume = "Ionescu"
  AND cl.prenume = "Alexandru"
  AND co.data_plasarii = (
      SELECT co.data_plasarii
      FROM comenzi AS co
      LEFT JOIN clienti AS cl
          ON co.id_client = cl.id
      WHERE cl.nume = "Ionescu"
        AND cl.prenume = "Alexandru"
      ORDER BY data_plasarii DESC
      LIMIT 1
  );


-- =====================================================
-- 3. ADDITIONAL EXAMPLES: AGGREGATIONS AND JOINS
-- =====================================================
--
-- The following queries are additional examples used to explore the relationships between tables and practice aggregate functions.
-- They are not separate numbered exam requirements.

-- Count the number of books in each category.
SELECT ct.denumire, COUNT(c.id) AS numar_carti
FROM categorii AS ct
LEFT JOIN carti AS c
    ON ct.id = c.id_categorie
GROUP BY ct.denumire;

-- Display books together with their corresponding sales records.
SELECT *
FROM vanzari AS v
LEFT JOIN carti AS c
    ON v.id_carte = c.id;

-- Count the number of books sold in each category.
SELECT ct.denumire, COUNT(v.id) AS numar_carti
FROM categorii AS ct
LEFT JOIN carti AS c
    ON ct.id = c.id_categorie
LEFT JOIN vanzari AS v
    ON v.id_carte = c.id
GROUP BY ct.denumire;


-- =====================================================
-- 4. AGGREGATE FUNCTIONS AND GROUP FILTERING
-- =====================================================
-- Query 6: Display customers who have placed at least two orders.
-- GROUP BY groups orders by customer, while HAVING filters groups based on the number of orders.
SELECT cl.id, cl.nume, cl.prenume,
       COUNT(co.id) AS numar_comenzi
FROM comenzi AS co
RIGHT JOIN clienti AS cl
    ON cl.id = co.id_client
GROUP BY cl.id
HAVING numar_comenzi >= 2;

-- Additional query: Count the number of customers who have placed at least two orders.
-- A subquery is used to identify qualifying customers before counting the resulting records.
SELECT COUNT(*) AS clienti_cu_minim_2_comenzi
FROM (
    SELECT cl.id, cl.nume, cl.prenume,
           COUNT(co.id) AS numar_comenzi
    FROM clienti AS cl
    RIGHT JOIN comenzi AS co
        ON cl.id = co.id_client
    GROUP BY co.id_client
    HAVING numar_comenzi >= 2
) AS sub;


-- =====================================================
-- 5. DATE FUNCTIONS AND MULTIPLE TABLE JOINS
-- =====================================================
-- Query 7: Display the number of books sold in each category during 2024.
-- Using YEAR() function
SELECT ct.denumire, COUNT(c.id) AS numar_carti
FROM categorii AS ct
LEFT JOIN carti AS c
    ON ct.id = c.id_categorie
LEFT JOIN vanzari AS v
    ON v.id_carte = c.id
LEFT JOIN comenzi AS co
    ON co.id = v.id_comanda
WHERE YEAR(co.data_plasarii) = 2024
GROUP BY ct.denumire;

-- Additional query: Display books and their buyers, including customer, order, and sale information.
SELECT cl.id, cl.nume, cl.prenume,
       co.id AS comanda_id,
       v.id AS vanzare_id,
       c.titlu
FROM clienti AS cl
RIGHT JOIN comenzi AS co
    ON cl.id = co.id_client
RIGHT JOIN vanzari AS v
    ON v.id_comanda = co.id
RIGHT JOIN carti AS c
    ON c.id = v.id_carte;

-- Additional query: Identify customers who have ordered at least three books and display the number of books ordered by each customer.
SELECT cl.id, cl.nume, cl.prenume,
       COUNT(v.id) AS carti_comandate
FROM clienti AS cl
LEFT JOIN comenzi AS co
    ON cl.id = co.id_client
LEFT JOIN vanzari AS v
    ON v.id_comanda = co.id
GROUP BY cl.id
HAVING carti_comandate >= 3;


-- =====================================================
-- 6. SUBQUERIES AND AGGREGATE FUNCTIONS
-- =====================================================
-- Query 8: Identify the book with the lowest number of sales.
-- The subquery calculates the minimum number of sales and the outer query retrieves the corresponding book.
SELECT c.id, c.titlu, c.id_autor,
       CONCAT(a.prenume, " ", a.nume) AS nume_autor,
       COUNT(v.id) AS min_bucati_vandute
FROM carti AS c
LEFT JOIN vanzari AS v
    ON c.id = v.id_carte
LEFT JOIN autori AS a
    ON c.id_autor = a.id
GROUP BY c.id
HAVING min_bucati_vandute = (
    SELECT COUNT(v.id) AS bucati_vandute
    FROM carti AS c
    LEFT JOIN vanzari AS v
        ON c.id = v.id_carte
    GROUP BY c.id
    ORDER BY bucati_vandute ASC
    LIMIT 1
);


-- =====================================================
-- 7. MOST SOLD BOOK IN EACH CATEGORY
-- =====================================================
-- Query 9: Identify the most frequently sold book in each category.
--
-- Version 1: Starts from the categories table and also retrieves the author's name.
-- Uses a correlated subquery to compare the sales of books belonging to the same category.
SELECT ct1.id AS "id_categorie",
       ct1.denumire AS "categorie",
       c.id AS "id_carte",
       c.titlu,
       CONCAT(a.prenume, " ", a.nume) AS "autor",
       COUNT(v.id) AS max_bucati_vandute
FROM categorii AS ct1
LEFT JOIN carti AS c
    ON ct1.id = c.id_categorie
LEFT JOIN autori AS a
    ON c.id_autor = a.id
LEFT JOIN vanzari AS v
    ON v.id_carte = c.id
GROUP BY ct1.denumire, c.id
HAVING max_bucati_vandute = (
    SELECT COUNT(v.id) AS bucati_vandute
    FROM carti AS c
    LEFT JOIN vanzari AS v
        ON v.id_carte = c.id
    WHERE ct1.id = c.id_categorie
    GROUP BY c.id
    ORDER BY bucati_vandute DESC
    LIMIT 1
);

-- Version 2: Alternative solution
-- First, create a view that calculates the total number of sales for each book.
-- Use the view to identify the most frequently sold book in each category.
CREATE OR REPLACE VIEW view_vanzari_carti AS
SELECT c.id AS id_carte,
       c.titlu,
       c.id_autor,
       c.id_categorie,
       COUNT(v.id) AS bucati_vandute
FROM carti AS c
LEFT JOIN vanzari AS v
    ON v.id_carte = c.id
GROUP BY c.id;

-- Display the contents of the view.
SELECT *
FROM view_vanzari_carti;

-- Use the view to identify the most frequently sold book in each category.
SELECT ct.id AS id_categorie,
       ct.denumire AS categorie,
       vv.id_carte,
       vv.titlu AS carte,
       CONCAT(a.prenume, ' ', a.nume) AS autor,
       vv.bucati_vandute
FROM categorii AS ct
LEFT JOIN view_vanzari_carti AS vv
    ON vv.id_categorie = ct.id
LEFT JOIN autori AS a
    ON vv.id_autor = a.id
WHERE vv.bucati_vandute = (
    SELECT MAX(vv2.bucati_vandute)
    FROM view_vanzari_carti AS vv2
    WHERE vv2.id_categorie = ct.id
)
ORDER BY ct.id;


-- =====================================================
-- 8. UPDATING DATA AND CREATING VIEWS
-- =====================================================
-- Query 10: Update the suma_totala column in the comenzi table with the corresponding order total.
--
-- Version 1: First, calculate the sum of sales for each order to verify the values before updating the table.
SELECT co.id, co.data_plasarii, SUM(v.pret)
FROM comenzi AS co
LEFT JOIN vanzari AS v
    ON v.id_comanda = co.id
GROUP BY co.id;

-- Display the sales records before performing the update.
SELECT *
FROM vanzari;

-- Update the total amount for each order.
-- The derived table calculates the sum of sales for every order and provides the values used in the UPDATE statement.
UPDATE comenzi AS co1
SET suma_totala = (
    SELECT total
    FROM (
        SELECT co2.id, SUM(v.pret) AS total
        FROM comenzi AS co2
        LEFT JOIN vanzari AS v
            ON v.id_comanda = co2.id
        GROUP BY co2.id
    ) AS sub
    WHERE sub.id = co1.id
);

-- Verify the updated order totals.
SELECT *
FROM comenzi;

-- Version 2: Alternative solution.
-- Create a view that calculates the total sales amount for each order.
-- Using IF() function 
CREATE OR REPLACE VIEW view_suma_totala_comenzi AS
SELECT co.id AS id_comanda,
       IF(SUM(v.pret) IS NOT NULL, SUM(v.pret), 0)
           AS suma_totala
FROM comenzi AS co
LEFT JOIN vanzari AS v
    ON v.id_comanda = co.id
GROUP BY co.id;

-- Display the calculated order totals from the view.
SELECT *
FROM view_suma_totala_comenzi;

-- =====================================================
-- END OF SCRIPT
-- =====================================================