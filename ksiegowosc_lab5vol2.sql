-- SCHEMA: ksiegowosc

-- DROP SCHEMA IF EXISTS ksiegowosc ;

CREATE SCHEMA IF NOT EXISTS ksiegowosc
    AUTHORIZATION postgres;
	
	
CREATE TABLE ksiegowosc.pracownicy (
	id_pracownika INTEGER NOT NULL PRIMARY KEY,
	imie VARCHAR(50) NOT NULL,
	nazwisko VARCHAR(50) NOT NULL,
	adres VARCHAR(50) NOT NULL,
	telefon INTEGER NOT NULL
	
	)
	
CREATE TABLE ksiegowosc.godziny (
	id_godziny INTEGER NOT NULL PRIMARY KEY,
	data DATE NOT NULL,
	liczba_godzin INTEGER NOT NULL,
	id_pracownika INTEGER NOT NULL 

	)
	
CREATE TABLE ksiegowosc.pensja (
	id_pensji INTEGER NOT NULL PRIMARY KEY,
	stanowisko VARCHAR(50) NOT NULL ,
	kwota FLOAT NOT NULL	

	)
	
CREATE TABLE ksiegowosc.premia (
	id_premii INTEGER NOT NULL PRIMARY KEY,
	rodzaj VARCHAR(50) NOT NULL,
	kwota FLOAT NOT NULL
	)
--update tabeli bo nie wszyscy pracownicy muszą miec pensje wiekszan niz 0	
ALTER TABLE ksiegowosc.premia ALTER COLUMN kwota DROP NOT NULL;
ALTER TABLE ksiegowosc.premia ALTER COLUMN rodzaj DROP NOT NULL;
	
CREATE TABLE ksiegowosc.wynagrodzenie (
	id_wynagrodzenia INTEGER NOT NULL PRIMARY KEY,
	data DATE NOT NULL,
	id_pracownika INTEGER NOT NULL,
	id_godziny INTEGER NOT NULL,
	id_pensji INTEGER NOT NULL,
	id_premii INTEGER NOT NULL
	)

-- klucz obcy dla id_pracownika w wynagrodzeniach
ALTER TABLE ksiegowosc.wynagrodzenie
ADD CONSTRAINT fk
FOREIGN KEY (id_pracownika)
REFERENCES ksiegowosc.pracownicy (id_pracownika);

ALTER TABLE ksiegowosc.wynagrodzenie
ADD CONSTRAINT fk1
FOREIGN KEY (id_godziny)
REFERENCES ksiegowosc.godziny (id_godziny);
	
ALTER TABLE ksiegowosc.wynagrodzenie
ADD CONSTRAINT fk2
FOREIGN KEY (id_pensji)
REFERENCES ksiegowosc.pensja (id_pensji);

ALTER TABLE ksiegowosc.wynagrodzenie
ADD CONSTRAINT fk3
FOREIGN KEY (id_premii)
REFERENCES ksiegowosc.premia (id_premii);

ALTER TABLE ksiegowosc.godziny
ADD CONSTRAINT fk4
FOREIGN KEY (id_pracownika)
REFERENCES ksiegowosc.pracownicy (id_pracownika);
-- C'est incroyable!

-- komentowanie tabeli
COMMENT ON TABLE ksiegowosc.pracownicy IS 'Tabela która zawiera podstawowe dane osobowe i kontakty pracowników';
-- wyswietlanie tabeli
SELECT obj_description('ksiegowosc.pracownicy'::regclass);

COMMENT ON TABLE ksiegowosc.godziny IS 'Tabela zawierająca dane dotyczące godzin pracy pracowników';
COMMENT ON TABLE ksiegowosc.pensja IS 'Tabela zawierająca informacje o pensjach pracowników';
COMMENT ON TABLE ksiegowosc.premia IS 'Tabela zawierająca dane dotyczące premii wypłacanych pracownikom';
COMMENT ON TABLE ksiegowosc.wynagrodzenie IS 'Tabela zawierająca ogólne informacje o wynagrodzeniach pracowników';

-- dodawanie rekordów

INSERT INTO ksiegowosc.pracownicy VALUES
    (1, 'Kamil', 'Lipa', 'Kraków, Mickiewicza 1', '612345678'),
    (2, 'Karolina', 'Tulipan', 'Kraków, Sienkiewicza 2', '712345679'),
    (3, 'Krzysztof', 'Cis', 'Kraków, Prus 3', '612345680'),
    (4, 'Kasia', 'Róża', 'Kraków, Reymonta 4', '712345681'),
    (5, 'Kacper', 'Brzoza', 'Kraków, Żeromskiego 5', '612345682'),
    (6, 'Kornelia', 'Dalia', 'Kraków, Żeromskiego 6', '712345683'),
    (7, 'Klaudia', 'Bluszcz', 'Kraków, Prus 7', '612345684'),
    (8, 'Kamil', 'Fiołek', 'Kraków, Reymonta 8', '712345685'),
    (9, 'Karol', 'Sosna', 'Kraków, Mickiewicza 9', '612345686'),
    (10, 'Kinga', 'Klon', 'Kraków, Sienkiewicza 10', '712345687');
UPDATE ksiegowosc.pracownicy
SET imie = 'Julian'
WHERE id_pracownika = 3;	
UPDATE ksiegowosc.pracownicy
SET imie = 'Jowita'
WHERE id_pracownika = 7;
INSERT INTO ksiegowosc.godziny VALUES
    (110,'2024-04-01', 8, 1),
    (111,'2024-04-02', 7, 2),
    (112,'2024-04-03', 9, 3),
    (113,'2024-04-04', 8, 4),
    (114,'2024-04-05', 7, 5),
    (115,'2024-04-06', 9, 6),
    (116,'2024-04-07', 8, 7),
    (117,'2024-04-08', 7, 8),
    (118,'2024-04-09', 9, 9),
    (119,'2024-04-10', 8, 10);
-- zmieniamy godziny bo za malo pracują
UPDATE ksiegowosc.godziny
SET liczba_godzin = 170
WHERE id_godziny = 110;

UPDATE ksiegowosc.godziny
SET liczba_godzin = 140
WHERE id_godziny = 11;
UPDATE ksiegowosc.godziny
SET liczba_godzin = 200
WHERE id_godziny = 114;
UPDATE ksiegowosc.godziny
SET liczba_godzin = 180
WHERE id_godziny = 119;
	
INSERT INTO ksiegowosc.pensja VALUES
    (44, 'Księgowy', 5000),
    (45, 'Asystent', 4000),
    (46, 'Manager', 7000),
    (47, 'Analityk', 6000),
    (48, 'Specjalista', 5500),
    (49, 'Auditor', 6500),
    (50, 'Doradca', 4500),
    (51, 'Kierownik', 7500),
    (52, 'Praktykant', 3000),
    (53, 'Administrator', 4800);
-- modyfikacje zeby polecenia A,B,C itd dalo sie zrealizowac
UPDATE ksiegowosc.pensja
SET  kwota = 6000
WHERE id_pensji = 44;
UPDATE ksiegowosc.pensja
SET stanowisko = 'Stażysta', kwota = 500
WHERE id_pensji = 45;
UPDATE ksiegowosc.pensja
SET stanowisko = 'Praktykant junior', kwota = 400
WHERE id_pensji = 46;

INSERT INTO ksiegowosc.premia VALUES
    (54, 'Za dobre wyniki', 1000),
    (55, 'Premia kwartalna', 1500),
    (56, 'Za staż pracy', 800),
    (57, 'Premia motywacyjna', 1200),
    (58, 'Za dodatkowe zadania', 900),
    (59, 'Premia za efektywność', 1300),
    (60, 'Premia uznaniowa', 1100),
    (61, 'Premia za osiągnięcia', 1400),
    (62, 'Premia roczna', 2000),
    (63, 'Premia za innowacje', 1800);
	
-- tu zabieramy premie buahah	
UPDATE ksiegowosc.premia
SET rodzaj = '', kwota = NULL
WHERE id_premii = 54;
UPDATE ksiegowosc.premia
SET rodzaj = '', kwota = NULL
WHERE id_premii = 62;

INSERT INTO ksiegowosc.wynagrodzenie VALUES
    (101, '2024-04-01', 1, 110, 44, 54),
    (102, '2024-04-02', 2, 111, 45, 55),
    (103, '2024-04-03', 3, 112, 46, 56),
    (104, '2024-04-04', 4, 113, 47, 57),
    (105, '2024-04-05', 5, 114, 48, 58),
    (106, '2024-04-06', 6, 115, 49, 59),
    (107, '2024-04-07', 7, 116, 50, 60),
    (108, '2024-04-08', 8, 117, 51, 61),
    (109, '2024-04-09', 9, 118, 52, 62),
    (110, '2024-04-10', 10, 119, 53, 63);
	
/* wyswietlanie dokonanych zmian*/
SELECT * FROM ksiegowosc.pracownicy;
SELECT * FROM ksiegowosc.godziny;
SELECT * FROM ksiegowosc.pensja;
SELECT * FROM ksiegowosc.premia;
SELECT * FROM ksiegowosc.wynagrodzenie;


-- A
SELECT id_pracownika, nazwisko FROM ksiegowosc.pracownicy;
-- B
SELECT DISTINCT wynagrodzenie.id_pracownika, pensja.kwota
FROM ksiegowosc.wynagrodzenie
INNER JOIN ksiegowosc.pracownicy ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
INNER JOIN ksiegowosc.pensja ON pensja.id_pensji = wynagrodzenie.id_pensji
WHERE pensja.kwota > 1000;
-- C
SELECT DISTINCT wynagrodzenie.id_pracownika, premia.kwota, pensja.kwota
FROM ksiegowosc.wynagrodzenie
INNER JOIN ksiegowosc.pracownicy ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
INNER JOIN ksiegowosc.pensja ON pensja.id_pensji = wynagrodzenie.id_pensji
INNER JOIN ksiegowosc.premia ON premia.id_premii = wynagrodzenie.id_premii
WHERE pensja.kwota > 2000
AND premia.kwota IS NULL;
--D
SELECT imie FROM ksiegowosc.pracownicy 
WHERE imie LIKE 'J%' ;
--E
SELECT imie, nazwisko FROM ksiegowosc.pracownicy 
WHERE imie LIKE '%a'
AND nazwisko LIKE '%n%';
--F
SELECT DISTINCT  pracownicy.imie, pracownicy.nazwisko
FROM ksiegowosc.godziny
INNER JOIN ksiegowosc.pracownicy ON pracownicy.id_pracownika = godziny.id_pracownika
WHERE godziny.liczba_godzin > 160;
--G
SELECT pracownicy.imie, pracownicy.nazwisko
FROM ksiegowosc.wynagrodzenie
INNER JOIN ksiegowosc.pracownicy ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
INNER JOIN ksiegowosc.pensja ON pensja.id_pensji = wynagrodzenie.id_pensji
WHERE pensja.kwota BETWEEN 1500 AND 3000;
--H
SELECT DISTINCT pracownicy.imie, pracownicy.nazwisko
FROM ksiegowosc.wynagrodzenie
INNER JOIN ksiegowosc.premia ON premia.id_premii = wynagrodzenie.id_premii
INNER JOIN ksiegowosc.godziny ON godziny.id_godziny = wynagrodzenie.id_godziny
INNER JOIN ksiegowosc.pracownicy ON pracownicy.id_pracownika = godziny.id_pracownika
WHERE godziny.liczba_godzin > 160
AND premia.kwota IS NULL;
--I
SELECT DISTINCT pracownicy.id_pracownika, pracownicy.imie, pracownicy.nazwisko, pracownicy.adres, pracownicy.telefon, pensja.kwota
FROM ksiegowosc.wynagrodzenie
INNER JOIN ksiegowosc.pracownicy ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
INNER JOIN ksiegowosc.pensja ON pensja.id_pensji = wynagrodzenie.id_pensji
ORDER BY pensja.kwota;
--J
--1. Pensji
SELECT DISTINCT pracownicy.id_pracownika, pracownicy.imie, pracownicy.nazwisko, pracownicy.adres, pracownicy.telefon, pensja.kwota, premia.kwota
FROM ksiegowosc.wynagrodzenie
INNER JOIN ksiegowosc.pracownicy ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
INNER JOIN ksiegowosc.pensja ON pensja.id_pensji = wynagrodzenie.id_pensji
INNER JOIN ksiegowosc.premia ON premia.id_premii = wynagrodzenie.id_premii
ORDER BY pensja.kwota DESC;
--2. Premii
SELECT DISTINCT pracownicy.id_pracownika, pracownicy.imie, pracownicy.nazwisko, pracownicy.adres, pracownicy.telefon, pensja.kwota, premia.kwota
FROM ksiegowosc.wynagrodzenie
INNER JOIN ksiegowosc.pracownicy ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
INNER JOIN ksiegowosc.pensja ON pensja.id_pensji = wynagrodzenie.id_pensji
INNER JOIN ksiegowosc.premia ON premia.id_premii = wynagrodzenie.id_premii
ORDER BY premia.kwota DESC;
--3.Razem
SELECT DISTINCT pracownicy.id_pracownika, pracownicy.imie, pracownicy.nazwisko, pracownicy.adres, pracownicy.telefon, pensja.kwota, premia.kwota
FROM ksiegowosc.wynagrodzenie
INNER JOIN ksiegowosc.pracownicy ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika
INNER JOIN ksiegowosc.pensja ON pensja.id_pensji = wynagrodzenie.id_pensji
INNER JOIN ksiegowosc.premia ON premia.id_premii = wynagrodzenie.id_premii
ORDER BY pensja.kwota DESC, premia.kwota DESC;