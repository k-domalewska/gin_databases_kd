-- SCHEMA: tabelagch

-- DROP SCHEMA IF EXISTS tabelagch ;

CREATE SCHEMA IF NOT EXISTS tabelagch
    AUTHORIZATION postgres;

-- tworzenie poszczególnych tabel	
CREATE TABLE tabelagch.GeoEon (
	id_eon INTEGER NOT NULL PRIMARY KEY,
	nazwa_eon VARCHAR(50) NOT NULL);
	
CREATE TABLE tabelagch.GeoEra (
	id_era INTEGER NOT NULL PRIMARY KEY,
	nazwa_era VARCHAR(50) NOT NULL,
	id_eon INTEGER NOT NULL);
	
CREATE TABLE tabelagch.GeoOkres (
	id_okres INTEGER NOT NULL PRIMARY KEY,
	nazwa_okres VARCHAR(50) NOT NULL,
	id_era INTEGER NOT NULL);
	
CREATE TABLE tabelagch.GeoEpoka (
	id_epoka INTEGER NOT NULL PRIMARY KEY,
	nazwa_epoka VARCHAR(50) NOT NULL,
	id_okres INTEGER NOT NULL
);
CREATE TABLE tabelagch.GeoPietro (
	id_pietro INTEGER NOT NULL PRIMARY KEY,
	nazwa_pietro VARCHAR(50) NOT NULL,
	id_epoka INTEGER NOT NULL
);

-- dodawanie kluczy obcych
ALTER TABLE tabelagch.GeoEra
ADD CONSTRAINT fk
FOREIGN KEY (id_eon)
REFERENCES tabelagch.GeoEon (id_eon);

ALTER TABLE tabelagch.GeoOkres
ADD CONSTRAINT fk
FOREIGN KEY (id_era)
REFERENCES tabelagch.GeoEra (id_era);

ALTER TABLE tabelagch.GeoEpoka
ADD CONSTRAINT fk
FOREIGN KEY (id_okres)
REFERENCES tabelagch.GeoOkres (id_okres);

ALTER TABLE tabelagch.GeoPietro
ADD CONSTRAINT fk
FOREIGN KEY (id_epoka)
REFERENCES tabelagch.GeoEpoka (id_epoka);

--dodawanie rekorddow

--> Eon
INSERT INTO tabelagch.GeoEon (id_eon, nazwa_eon) VALUES
(1, 'Fanerozoik');

--> Era
INSERT INTO tabelagch.GeoEra (id_era, nazwa_era, id_eon) VALUES
(1, 'Kenozoik', 1),
(2, 'Mezozoik', 1),
(3, 'Paleozoik', 1);

--> Okres
INSERT INTO tabelagch.GeoOkres (id_okres, nazwa_okres, id_era) VALUES
(1, 'Dewon',1) ,
(2, 'Karbon',1) ,
(3, 'Perm',1) ,
(4, 'Trias',2) ,
(5, 'Jura',2) ,
(6, 'Kreda',2) ,
(7, 'Trzeciorzed: Palogen',3) ,
(8, 'Trzeciorzed: Neogen',3) ,
(9, 'Czwartorzad',3) ;

--> Epoka
INSERT INTO tabelagch.GeoEpoka (id_epoka, nazwa_epoka, id_okres) VALUES
(1, 'Dolny', 1),
(2, 'Srodkowy', 1),
(3, 'Gorny', 1),
(4, 'Dolny', 2),
(5, 'Gorny', 2),
(6, 'Dolny', 3),
(7, 'Gorny', 3),
(8, 'Dolny', 4),
(9, 'Srodkowy', 4),
(10, 'Gorny', 4),
(11, 'Dolna', 5),
(12, 'Srodkowa', 5),
(13, 'Gorna', 5),
(14, 'Dolna', 6),
(15, 'Gorna', 6),
(16, 'Paleocen', 7),
(17, 'Eocen', 7),
(18, 'Oligocen', 7),
(19, 'Miocen', 8),
(20, 'Pliocen', 8),
(21, 'Plejstocen', 9),
(22, 'Holocen', 9);

--> Piętro
INSERT INTO tabelagch.GeoPietro VALUES(1,'Lochkow',1);
INSERT INTO tabelagch.GeoPietro VALUES(2,'Prag',1);
INSERT INTO tabelagch.GeoPietro VALUES(3,'Ems',1);
INSERT INTO tabelagch.GeoPietro VALUES(4,'Eifel',2);
INSERT INTO tabelagch.GeoPietro VALUES(5,'Zywet',2);
INSERT INTO tabelagch.GeoPietro VALUES(6,'Fran',3);
INSERT INTO tabelagch.GeoPietro VALUES(7,'Famen',3);
INSERT INTO tabelagch.GeoPietro VALUES(8,'Turnej',4);
INSERT INTO tabelagch.GeoPietro VALUES(9,'Wizen',4);
INSERT INTO tabelagch.GeoPietro VALUES(10,'Serpuchow',4);
INSERT INTO tabelagch.GeoPietro VALUES(11,'Baszkir',5);
INSERT INTO tabelagch.GeoPietro VALUES(12,'Moskow',5);
INSERT INTO tabelagch.GeoPietro VALUES(13,'Kasimow',5);
INSERT INTO tabelagch.GeoPietro VALUES(14,'Gzel',5);
INSERT INTO tabelagch.GeoPietro VALUES(15,'Assel',6);
INSERT INTO tabelagch.GeoPietro VALUES(16,'Sakmar',6);
INSERT INTO tabelagch.GeoPietro VALUES(17,'Artinsk',6);
INSERT INTO tabelagch.GeoPietro VALUES(18,'Kungur',6);
INSERT INTO tabelagch.GeoPietro VALUES(19,'Road',7);
INSERT INTO tabelagch.GeoPietro VALUES(20,'Word',7);
INSERT INTO tabelagch.GeoPietro VALUES(21,'Kapitan',7);
INSERT INTO tabelagch.GeoPietro VALUES(22,'Wucziaping',7);
INSERT INTO tabelagch.GeoPietro VALUES(23,'Czangsing',7);
INSERT INTO tabelagch.GeoPietro VALUES(24,'Ind',8);
INSERT INTO tabelagch.GeoPietro VALUES(25,'Olenek',8);
INSERT INTO tabelagch.GeoPietro VALUES(26,'Anizyk',9);
INSERT INTO tabelagch.GeoPietro VALUES(27,'Ladyn',9);
INSERT INTO tabelagch.GeoPietro VALUES(28,'Karnik',10);
INSERT INTO tabelagch.GeoPietro VALUES(29,'Noryk',10);
INSERT INTO tabelagch.GeoPietro VALUES(30,'Retyk',10);
INSERT INTO tabelagch.GeoPietro VALUES(31,'Hettang',11);
INSERT INTO tabelagch.GeoPietro VALUES(32,'Synemur',11);
INSERT INTO tabelagch.GeoPietro VALUES(33,'Pliensbach',11);
INSERT INTO tabelagch.GeoPietro VALUES(34,'Toark',11);
INSERT INTO tabelagch.GeoPietro VALUES(35,'Aalen',12);
INSERT INTO tabelagch.GeoPietro VALUES(36,'Bajos',12);
INSERT INTO tabelagch.GeoPietro VALUES(37,'Baton',12);
INSERT INTO tabelagch.GeoPietro VALUES(38,'Kelowej',12);
INSERT INTO tabelagch.GeoPietro VALUES(39,'oksford',13);
INSERT INTO tabelagch.GeoPietro VALUES(40,'Kimeryd',13);
INSERT INTO tabelagch.GeoPietro VALUES(41,'Tyton',13);
INSERT INTO tabelagch.GeoPietro VALUES(42,'Berrias',14);
INSERT INTO tabelagch.GeoPietro VALUES(43,'Walanzyn',14);
INSERT INTO tabelagch.GeoPietro VALUES(44,'Hoteryw',14);
INSERT INTO tabelagch.GeoPietro VALUES(45,'Barrem',14);
INSERT INTO tabelagch.GeoPietro VALUES(46,'Apt',14);
INSERT INTO tabelagch.GeoPietro VALUES(47,'Alb',14);
INSERT INTO tabelagch.GeoPietro VALUES(48,'Cenoman',15);
INSERT INTO tabelagch.GeoPietro VALUES(49,'Turon',15);
INSERT INTO tabelagch.GeoPietro VALUES(50,'Koniak',15);
INSERT INTO tabelagch.GeoPietro VALUES(51,'Santon',15);
INSERT INTO tabelagch.GeoPietro VALUES(52,'Kampan',15);
INSERT INTO tabelagch.GeoPietro VALUES(53,'Mastrycht',15);
INSERT INTO tabelagch.GeoPietro VALUES(54,'Dan',16);
INSERT INTO tabelagch.GeoPietro VALUES(55,'Zeland',16);
INSERT INTO tabelagch.GeoPietro VALUES(56,'Tanet',16);
INSERT INTO tabelagch.GeoPietro VALUES(57,'Iprez',17);
INSERT INTO tabelagch.GeoPietro VALUES(58,'Lutet',17);
INSERT INTO tabelagch.GeoPietro VALUES(59,'Barton',17);
INSERT INTO tabelagch.GeoPietro VALUES(60,'Priabon',17);
INSERT INTO tabelagch.GeoPietro VALUES(61,'Rupel',18);
INSERT INTO tabelagch.GeoPietro VALUES(62,'Szat',18);
INSERT INTO tabelagch.GeoPietro VALUES(63,'Akwitan',19);
INSERT INTO tabelagch.GeoPietro VALUES(64,'Burdyga',19);
INSERT INTO tabelagch.GeoPietro VALUES(65,'Lang',19);
INSERT INTO tabelagch.GeoPietro VALUES(66,'Serrawal',19);
INSERT INTO tabelagch.GeoPietro VALUES(67,'Torton',19);
INSERT INTO tabelagch.GeoPietro VALUES(68,'Messyn',19);
INSERT INTO tabelagch.GeoPietro VALUES(69,'Zankl',20);
INSERT INTO tabelagch.GeoPietro VALUES(70,'Piacent',20);
INSERT INTO tabelagch.GeoPietro VALUES(71,'Gelas',21);
INSERT INTO tabelagch.GeoPietro VALUES(72,'Kalabr',21);
INSERT INTO tabelagch.GeoPietro VALUES(73,'Chiban',21);
INSERT INTO tabelagch.GeoPietro VALUES(74,'Tarant',21);
INSERT INTO tabelagch.GeoPietro VALUES(75,'Grenland',22);
INSERT INTO tabelagch.GeoPietro VALUES(76,'Nortgryp',22);
INSERT INTO tabelagch.GeoPietro VALUES(77,'Megalaj',22);

--weryfikacja

SELECT * FROM tabelagch.GeoPietro;
SELECT * FROM tabelagch.GeoEpoka;
SELECT * FROM tabelagch.GeoOkres;
SELECT * FROM tabelagch.GeoEra;
SELECT * FROM tabelagch.GeoEon;

--tworzenie geotabeli
CREATE TABLE tabelagch.GeoTabela AS 
(SELECT * FROM tabelagch.GeoPietro 
NATURAL JOIN tabelagch.GeoEpoka 
NATURAL JOIN tabelagch.GeoOkres 
NATURAL JOIN tabelagch.GeoEra 
NATURAL JOIN tabelagch.GeoEon );

--weryfikacja
SELECT * FROM tabelagch.GeoTabela;

-- tworzenie tabeli dziesiec
CREATE TABLE Dziesiec(cyfra int, bit int);

-- dodawanie rekordów
INSERT INTO Dziesiec (cyfra, bit)VALUES 
(0, 0), 
(1, 1), 
(2, 2),
(3, 3), 
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9);

-- weryfikacja poprawności
SELECT * FROM Dziesiec;

-- tworzenie tabeli milion


CREATE TABLE Milion(liczba int,cyfra int, bit int);
INSERT INTO Milion 
SELECT a1.cyfra +10* a2.cyfra +100*a3.cyfra + 1000*a4.cyfra + 10000*a5.cyfra + 10000*a6.cyfra 
AS liczba , a1.cyfra AS cyfra, a1.bit AS bit
FROM Dziesiec a1, Dziesiec a2, Dziesiec a3, Dziesiec a4, Dziesiec a5, Dziesiec a6 ;

-- weryfikacja poprawności
SELECT * FROM Milion;

-- CZEŚĆ 1 - BEZ INDEKSÓW
-- zapytanie 1

SELECT COUNT(*) FROM Milion 
INNER JOIN tabelagch.GeoTabela ON (mod(Milion.liczba,77)=(tabelagch.GeoTabela.id_pietro));

-- Wynik: Successfully run. Total query runtime: 148 msec. 1 rows affected.

-- zapytanie 2


SELECT COUNT(*) FROM Milion 
INNER JOIN tabelagch.GeoPietro ON (mod(Milion.liczba,77)=tabelagch.GeoPietro.id_pietro) 
NATURAL JOIN tabelagch.GeoEpoka 
NATURAL JOIN tabelagch.GeoOkres
NATURAL JOIN tabelagch.GeoEra 
NATURAL JOIN tabelagch.GeoEon;


-- zapytanie 3

SELECT COUNT(*) FROM Milion 
WHERE mod(Milion.liczba,77)
=(SELECT id_pietro FROM tabelagch.GeoTabela WHERE mod(Milion.liczba,77)=(id_pietro));

-- zapytanie 4


SELECT COUNT(*)
FROM Milion
WHERE mod(Milion.liczba,77) IN (SELECT tabelagch.GeoPietro.id_pietro FROM tabelagch.GeoPietro
NATURAL JOIN tabelagch.GeoEpoka
NATURAL JOIN tabelagch.GeoOkres
NATURAL JOIN tabelagch.GeoEra
NATURAL JOIN tabelagch.GeoEon);
	
	
-- CZEŚĆ 2 - z INDEKSAMI

CREATE INDEX idxEon ON tabelagch.GeoEon (id_eon);
CREATE INDEX idxOkres ON tabelagch.GeoOkres (id_okres,  id_era);
CREATE INDEX idxEpoka ON tabelagch.GeoEpoka (id_epoka, id_okres);
CREATE INDEX idxPietro ON tabelagch.GeoPietro (id_pietro,id_epoka);
CREATE INDEX idxEra ON tabelagch.GeoEra (id_era, id_eon);
CREATE INDEX idxMln ON Milion(liczba);
CREATE INDEX idxGeoTab ON tabelagch.GeoTabela(id_pietro, id_epoka, id_era, id_okres,id_eon);
