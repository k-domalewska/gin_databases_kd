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
SET stanowisko = 'Kierownik', kwota = 7300
WHERE id_pensji = 53;
UPDATE ksiegowosc.pensja
SET stanowisko = 'Specjalista'
WHERE id_pensji = 50;
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
SELECT w.id_pracownika, pensja.kwota -- distinct niepotrzebne tutaj ze wzgledu na unikalnocs
FROM ksiegowosc.wynagrodzenie w -- w jest aliasem
INNER JOIN ksiegowosc .pracownicy ON pracownicy.id_pracownika = w.id_pracownika
INNER JOIN ksiegowosc.pensja ON pensja.id_pensji = w.id_pensji
WHERE pensja.kwota > 1000;
-- C
SELECT DISTINCT w.id_pracownika
FROM ksiegowosc.wynagrodzenie w
INNER JOIN ksiegowosc.pracownicy pr ON pr.id_pracownika = w.id_pracownika
INNER JOIN ksiegowosc.pensja pp ON pp.id_pensji = w.id_pensji
INNER JOIN ksiegowosc.premia pri ON pri.id_premii = w.id_premii
WHERE pp.kwota > 2000 AND pri.kwota IS NULL;
--D
SELECT * FROM ksiegowosc.pracownicy 
WHERE imie LIKE 'J%' ;
--E
SELECT imie, nazwisko FROM ksiegowosc.pracownicy 
WHERE imie LIKE '%a'
AND nazwisko LIKE '%n%';
--F
SELECT  pr.imie, pr.nazwisko, (gd.liczba_godzin -160)
FROM ksiegowosc.godziny gd
INNER JOIN ksiegowosc.pracownicy pr ON pr.id_pracownika = gd.id_pracownika
WHERE gd.liczba_godzin > 160;
--G
SELECT pr.imie, pr.nazwisko
FROM ksiegowosc.wynagrodzenie w
INNER JOIN ksiegowosc.pracownicy pr ON pr.id_pracownika = w.id_pracownika
INNER JOIN ksiegowosc.pensja p ON p.id_pensji = w.id_pensji
WHERE p.kwota BETWEEN 1500 AND 3000;
--H
SELECT pra.imie, pra.nazwisko
FROM ksiegowosc.wynagrodzenie w
INNER JOIN ksiegowosc.premia pre ON pre.id_premii = w.id_premii
INNER JOIN ksiegowosc.godziny g ON g.id_godziny = w.id_godziny
INNER JOIN ksiegowosc.pracownicy pra ON pra.id_pracownika = g.id_pracownika
WHERE g.liczba_godzin > 160
AND pre.kwota IS NULL;
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

-- K -- Zlicz i pogrupuj pracowników według pola ‘stanowisko’.

SELECT pe.stanowisko, COUNT(*) as liczba_pracownikow
FROM ksiegowosc.wynagrodzenie w
INNER JOIN ksiegowosc.pracownicy pra ON pra.id_pracownika = w.id_pracownika
INNER JOIN ksiegowosc.pensja pe ON pe.id_pensji = w.id_pensji
GROUP BY stanowisko

-- L --  Policz średnią, minimalną i maksymalną płacę dla stanowiska ‘kierownik’ (jeżeli takiego nie masz, to przyjmij dowolne inne).

--SELECT * FROM ksiegowosc.pensja;

SELECT AVG(pe.kwota) AS mean_kierownik
FROM ksiegowosc.wynagrodzenie w
INNER JOIN ksiegowosc.pracownicy pra ON pra.id_pracownika = w.id_pracownika
INNER JOIN ksiegowosc.pensja pe ON pe.id_pensji = w.id_pensji
WHERE pe.stanowisko = 'Kierownik';

SELECT MIN(pe.kwota) AS min_kierownik
FROM ksiegowosc.wynagrodzenie w
INNER JOIN ksiegowosc.pracownicy pra ON pra.id_pracownika = w.id_pracownika
INNER JOIN ksiegowosc.pensja pe ON pe.id_pensji = w.id_pensji
WHERE pe.stanowisko = 'Kierownik';

SELECT MAX(pe.kwota) AS max_kierownik
FROM ksiegowosc.wynagrodzenie w
INNER JOIN ksiegowosc.pracownicy pra ON pra.id_pracownika = w.id_pracownika
INNER JOIN ksiegowosc.pensja pe ON pe.id_pensji = w.id_pensji
WHERE pe.stanowisko = 'Kierownik';

-- M -- Policz sumę wszystkich wynagrodzeń.
-- wynagrodzenie czyli pensja+bonus
-- SELECT SUM( pr.kwota+ pe.kwota)AS sum_wynagrzodzen -- tak było ale działało źle
SELECT SUM( COALESCE(pr.kwota, 0)+ pe.kwota)AS sum_wynagrzodzen
FROM ksiegowosc.wynagrodzenie w
INNER JOIN ksiegowosc.pracownicy pra ON pra.id_pracownika = w.id_pracownika
INNER JOIN ksiegowosc.premia pr ON pr.id_premii = w.id_premii
INNER JOIN ksiegowosc.pensja pe ON pe.id_pensji = w.id_pensji

-- F -- Policz sumę wynagrodzeń w ramach danego stanowiska.
SELECT pe.stanowisko, SUM( COALESCE(pr.kwota, 0)+ pe.kwota) AS sum_wynagrzodzen_stanowiska
FROM ksiegowosc.wynagrodzenie w
INNER JOIN ksiegowosc.pracownicy pra ON pra.id_pracownika = w.id_pracownika
INNER JOIN ksiegowosc.premia pr ON pr.id_premii = w.id_premii
INNER JOIN ksiegowosc.pensja pe ON pe.id_pensji = w.id_pensji
GROUP BY  pe.stanowisko
-- COALESCE() interpretuje wartosci NULL z kolumny kwota jako zero
--'To treat NULL values as 0, you can use the COALESCE function.'
-- jest to postgresowy odpowiednik NVL() w Oracle

/*
bez funkcji coalesce, zle liczy:

SELECT pe.stanowisko, SUM(pr.kwota+ pe.kwota)  AS sum_wynagrzodzen_stanowiska
FROM ksiegowosc.wynagrodzenie w
INNER JOIN ksiegowosc.pracownicy pra ON pra.id_pracownika = w.id_pracownika
INNER JOIN ksiegowosc.premia pr ON pr.id_premii = w.id_premii
INNER JOIN ksiegowosc.pensja pe ON pe.id_pensji = w.id_pensji
GROUP BY  pe.stanowisko, pr.kwota
HAVING  pr.kwota IS NOT NULL
*/

-- G -- Wyznacz liczbę premii przyznanych dla pracowników danego stanowiska.

SELECT pe.stanowisko, COUNT(pr.kwota) as liczba_premii
FROM ksiegowosc.wynagrodzenie w
INNER JOIN ksiegowosc.pracownicy pra ON pra.id_pracownika = w.id_pracownika
INNER JOIN ksiegowosc.pensja pe ON pe.id_pensji = w.id_pensji
INNER JOIN ksiegowosc.premia pr ON pr.id_premii = w.id_premii
GROUP BY  pe.stanowisko

-- H -- Usuń wszystkich pracowników mających pensję mniejszą niż 1200 zł. - DO  POPRAWY

--SELECT * FROM ksiegowosc.pracownicy p ORDER BY kwota
DELETE FROM ksiegowosc.pracownicy
WHERE id_pracownika IN (
SELECT pra.id_pracownika
FROM ksiegowosc.wynagrodzenie w
INNER JOIN ksiegowosc.pracownicy pra ON pra.id_pracownika = w.id_pracownika
INNER JOIN ksiegowosc.pensja pe ON pe.id_pensji = w.id_pensji
WHERE pe.kwota < 1200
);

-- zadania z pliku 6B
SELECT * FROM ksiegowosc.pracownicy;

-- A --Zmodyfikuj numer telefonu w tabeli pracownicy, dodając do niego kierunkowy dla Polski w nawiasie (+48)

ALTER TABLE ksiegowosc.pracownicy ADD COLUMN prefix_telefon VARCHAR(50); 

UPDATE ksiegowosc.pracownicy 
SET prefix_telefon = CONCAT('(+48)', nr_telefonu);
-- The CONCAT() function adds two or more strings together.
ALTER TABLE ksiegowosc.pracownicy DROP COLUMN nr_telefonu;

ALTER TABLE ksiegowosc.pracownicy RENAME COLUMN prefix_telefon TO nr_telefonu;

-- B -- Zmodyfikuj atrybut telefon w tabeli pracownicy tak, aby numer oddzielony był myślnikami wg wzoru: ‘555-222-333’

UPDATE ksiegowosc.pracownicy
SET nr_telefonu = CONCAT(LEFT(nr_telefonu, 5), ' ', SUBSTRING(nr_telefonu FROM 6 FOR 3),'-', SUBSTRING(nr_telefonu FROM 9 FOR 3), '-', RIGHT(nr_telefonu, 3));

-- C -- Wyświetl wszystkie dane pracownika, którego nazwisko jest najdłuższe, używając dużych liter
SELECT * FROM ksiegowosc.pracownicy
WHERE CHARACTER_LENGTH(nazwisko) = (SELECT MAX(CHARACTER_LENGTH(nazwisko)) FROM ksiegowosc.pracownicy);

-- D -- Wyświetl dane pracowników i ich pensje zakodowane przy pomocy algorytmu md5

/* algorytm MD5 został zaprojektowany do konwersji ciągu znaków na 32-znakowy ciąg tekstowy
przy użyciu 128-bitowego szyfrowania. Funkcja MD5 jest ważną i użyteczną funkcją w PostgreSQL 
ponieważ funkcji MD5 możemy użyć np.: w momencie tworzenia użytkownika, aby zapewnić użytkownikowi 
zaszyfrowane hasło.
*/
SELECT * FROM ksiegowosc.pracownicy;
SELECT MD5(CONCAT(pr.id_pracownika, pr.imie, pr.nazwisko,pr.adres,  pr.nr_telefonu, p.kwota )) AS zakodowane_dane
FROM ksiegowosc.wynagrodzenie w
INNER JOIN ksiegowosc.pracownicy pr ON pr.id_pracownika = w.id_pracownika
INNER JOIN ksiegowosc.pensja p ON p.id_pensji = w.id_pensji;

-- F -- Wyświetl pracowników, ich pensje oraz premie. Wykorzystaj złączenie lewostronne.
SELECT *
FROM ksiegowosc.wynagrodzenie w
LEFT JOIN ksiegowosc.pracownicy pr ON pr.id_pracownika = w.id_pracownika
LEFT JOIN ksiegowosc.pensja pp ON pp.id_pensji = w.id_pensji
LEFT JOIN ksiegowosc.premia pri ON pri.id_premii = w.id_premii;

-- G -- wygeneruj raport (zapytanie), które zwróci w wyniki treść wg poniższego szablonu:
SELECT CONCAT('Pracownik ', pr.imie, ' ', pr.nazwisko, ', w dniu ', w.data, ' otrzymał pensję całkowitą na kwotę ',
              SUM(pp.kwota + COALESCE(pri.kwota, 0)), ' zł, gdzie wynagrodzenie zasadnicze wynosiło: ', pp.kwota, ' zł, premia: ',
              COALESCE(pri.kwota, 0), ' zł, nadgodziny:',(CASE WHEN gd.liczba_godzin > 160 THEN (gd.liczba_godzin - 160) ELSE 0 END), 'h'  )
FROM ksiegowosc.wynagrodzenie w
LEFT JOIN ksiegowosc.pracownicy pr ON pr.id_pracownika = w.id_pracownika
LEFT JOIN ksiegowosc.pensja pp ON pp.id_pensji = w.id_pensji
LEFT JOIN ksiegowosc.premia pri ON pri.id_premii = w.id_premii
LEFT JOIN ksiegowosc.godziny gd ON gd.id_godziny = w.id_godziny
GROUP BY pr.imie, pr.nazwisko, w.data, pp.kwota, pri.kwota, gd.liczba_godzin


