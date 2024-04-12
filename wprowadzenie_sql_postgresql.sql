-- Database: firma

-- DROP DATABASE IF EXISTS firma;

CREATE DATABASE firma
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Polish_Poland.1250'
    LC_CTYPE = 'Polish_Poland.1250'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

	CREATE SCHEMA rozliczenia
	
	CREATE TABLE rozliczenia.pracownicy (
	id_pracownika INTEGER NOT NULL PRIMARY KEY,
	imie VARCHAR(50) NOT NULL,
	nazwisko VARCHAR(50) NOT NULL,
	adres VARCHAR(50) NOT NULL,
	telefon INTEGER NOT NULL
	
	)
	
		CREATE TABLE rozliczenia.godziny (
	id_godziny INTEGER NOT NULL PRIMARY KEY,
	data DATE NOT NULL,
	liczba_godzin INTEGER NOT NULL,
	id_pracownika INTEGER NOT NULL 
	/*
	FOREIGN KEY(id_pracownika) 
    REFERENCES rozliczenia.pracownicy(id_pracownika)
	*/
	
	)
	
		CREATE TABLE rozliczenia.pensje (
	id_pensji INTEGER NOT NULL PRIMARY KEY,
	stanowisko VARCHAR(50) NOT NULL ,
	kwota FLOAT NOT NULL,
	id_premii  INTEGER NOT NULL
	

	)
	
	CREATE TABLE rozliczenia.premie (
	id_premii INTEGER NOT NULL PRIMARY KEY,
	rodzaj_premii VARCHAR(50) NOT NULL,
	kwota FLOAT NOT NULL
	
	)
	
	
	/*ALTER TABLE rozliczenia.pracownicy ADD id_pracownika INTEGER; --> FOREGIN KEY
	
	FOREIGN KEY(id_pracownika) 
    REFERENCES rozliczenia.pracownicy(id_pracownika)
	*/
	
	INSERT INTO rozliczenia.pracownicy VALUES
    (1,'Janina', 'Kwiatowa', 'ul. Kwiatowa 11, Warszawa', 111222333),
    (2, 'Andrzej', 'Kwiatowy', 'ul. Kwiatowa 12, Kraków', 222333444),
    (3,'Elżbieta', 'Kwiatkowska', 'ul. Kwiatowa 13, Gdańsk', 333444555),
    (4,'Wojciech', 'Kwiatkowski', 'ul. Kwiatowa 14, Wrocław', 444555666),
    (5,'Katarzyna', 'Kwiatek', 'ul. Kwiatowa 15, Poznań', 555666777),
    (6,'Tadeusz', 'Kwiatuszek', 'ul. Kwiatowa 16, Łódź', 666777888),
    (7,'Irena', 'Kwiatkowa', 'ul. Kwiatowa 17, Lublin', 777888999),
    (8,'Marek', 'Kwiatkowski', 'ul. Kwiatowa 18, Katowice', 888999000),
    (9,'Magdalena', 'Kwiatkowska', 'ul. Kwiatowa 19, Szczecin', 999000111),
    (10,'Adam', 'Kwiatkowski', 'ul. Kwiatowa 20, Gdynia', 000111222);
	
	INSERT INTO rozliczenia.godziny VALUES
    (1, '2024-04-01', 8, 1),
    (2, '2024-04-02', 7, 2),
    (3, '2024-04-03', 9, 3),
    (4, '2024-04-04', 8, 4),
    (5, '2024-04-05', 8, 5),
    (6, '2024-04-06', 7, 6),
    (7, '2024-04-07', 9, 7),
    (8, '2024-04-08', 8, 8),
    (9, '2024-04-09', 8, 9),
    (10, '2024-04-10', 7, 10);

	INSERT INTO rozliczenia.pensje VALUES
	 (1, 'Manager', 5000.00, 1),
    (2, 'Analityk', 4000.00, 2),
    (3, 'Specjalista ds. marketingu', 4500.00, 3),
    (4, 'Księgowy', 3800.00, 4),
    (5, 'Inżynier', 4800.00, 5),
    (6, 'Administrator sieci', 4200.00, 6),
    (7, 'Projektant graficzny', 4300.00, 7),
    (8, 'Specjalista ds. HR', 4600.00, 8),
    (9, 'Programista', 4700.00, 9),
    (10, 'Doradca klienta', 3900.00, 10);

	INSERT INTO rozliczenia.premie VALUES
	 (1, 'Premia roczna', 1000.00),
    (2, 'Premia świąteczna', 500.00),
    (3, 'Premia za wyniki', 800.00),
    (4, 'Premia motywacyjna', 600.00),
    (5, 'Premia za staż', 700.00),
    (6, 'Premia za efektywność', 900.00),
    (7, 'Premia za nadgodziny', 400.00),
    (8, 'Premia za innowacje', 1200.00),
    (9, 'Premia za projekt', 1500.00),
    (10, 'Premia za lojalność', 2000.00);
	
	SELECT nazwisko, adres FROM rozliczenia.pracownicy;
	

	
	
	SELECT 
    DATE_PART('dow', data) AS dzien_tygodnia,
    DATE_PART('month', data) AS miesiac
	FROM 
    rozliczenia.godziny;
	
	ALTER TABLE rozliczenia.pensje RENAME COLUMN kwota TO kwota_brutto;
	ALTER TABLE rozliczenia.pensje ADD kwota_netto FLOAT;
	
	/*ALTER TABLE rozliczenia.premie DROP COLUMN kwota_netto; */
	
	UPDATE rozliczenia.pensje SET  kwota_netto = kwota_brutto * 0.7;
	