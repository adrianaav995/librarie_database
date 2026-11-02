-- =============================================
-- 1. Database creation
-- =============================================
CREATE DATABASE librarie;
USE librarie;

-- =============================================
-- 2. Table creation
-- =============================================
CREATE TABLE carti
(
	id int primary key auto_increment,
    titlu varchar(255) not null,
    id_autor int not null,
    id_categorie int,
    pret decimal(8, 2)
);

CREATE TABLE autori
(
	 id int primary key auto_increment,
     nume varchar(100) not null,
     prenume varchar(100),
     data_nasterii date
);

CREATE TABLE categorii
(
	 id int primary key auto_increment,
     denumire varchar(100) not null unique,
     descriere varchar(255)
);

CREATE TABLE clienti
(
	 id int primary key auto_increment,
     nume varchar(100) not null,
     prenume varchar(100) not null,
     email varchar(255),
     telefon varchar(20),
     adresa varchar(255)
);

CREATE TABLE comenzi
(
	 id int primary key auto_increment,
     id_client int not null,
     data_plasarii date,
     suma_totala decimal(10, 2)
);

CREATE TABLE vanzari
(
	 id int primary key auto_increment,
     id_comanda int not null,
     id_carte int not null,
     pret decimal(8, 2)
);

-- =============================================
-- 3. Foreign key constraints
-- =============================================
ALTER TABLE carti
ADD FOREIGN KEY FK1(id_autor) REFERENCES autori(id)
	ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY FK2(id_categorie) REFERENCES categorii(id)
	ON DELETE SET NULL ON UPDATE CASCADE;
    
ALTER TABLE comenzi
ADD FOREIGN KEY FK3(id_client) REFERENCES clienti(id)
	ON DELETE CASCADE ON UPDATE CASCADE;
    
ALTER TABLE vanzari
ADD FOREIGN KEY FK4(id_comanda) REFERENCES comenzi(id)
	ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY FK5(id_carte) REFERENCES carti(id)
	ON DELETE CASCADE ON UPDATE CASCADE;
    
-- =============================================
-- 4. Sample data insertion
-- =============================================
insert into categorii (id, denumire) values
	(1, "clasici"),
    (2, "contemporani"),
    (3, "fantastic"),
    (4, "horror"),
    (5, "romantic"),
    (6, "non-fictiune");

insert into autori values
	(1, "Kafka", "Franz", "1883-07-03"),
    (2, "Wilde", "Oscar", "1854-10-16"),
    (3, "Backman", "Fredrik", "1981-06-02"),
    (4, "Haig", "Matt", "1975-07-03"),
    (5, "King", "Stephen", "1947-09-21"),
    (6, "de Botton", "Alain", "1969-12-20"),
    (7, "Jenkins Reid", "Taylor", "1983-12-20");

insert into carti values
	(1, "Metamorfoza si alte povestiri", 1, 1, 15.00),
    (2, "Portretul lui Dorian Grey", 2, 1, 16.50),
    (3, "Oameni anxiosi", 3, 2, 30.00),
    (4, "Bunica mi-a zis sa-ti spun ca-i pare rau", 3, 2, 31.99),
    (5, "Umanii", 4, 3, 30.00),
    (6, "Familia Radley", 4, 3, 25.00),
    (7, "Cimitirul animalelor", 5, 4, 30.00),
    (8, "Arhitectura fericirii", 6, 6, 26.50);
    

insert into clienti (id, nume, prenume) values
	(1, "Ionescu", "Alexandru"),
    (2, "Patrascu", "Adelina"),
    (3, "Mihaiescu", "Bogdan"),
    (4, "Maracine", "Ilinca");
    
insert into comenzi (id, id_client, data_plasarii) values
	(1, 1, "2023-05-05"),
    (2, 1, "2024-02-14"),
    (3, 2, "2024-12-20"),
    (4, 3, "2024-10-15"),
    (5, 3, "2025-09-18");
    
insert into vanzari values 
	(1, 1, 5, 30.00),
    (2, 1, 8, 26.50),
    (3, 2, 1, 30.00),
    (4, 2, 2, 16.50),
    (5, 2, 4, 31.99),
    (6, 3, 1, 15.00),
    (7, 4, 2, 16.50),
    (8, 4, 4, 31.99),
    (9, 4, 7, 30.00);