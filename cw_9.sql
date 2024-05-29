-- bazy danych ćwiczenia 9

SELECT * FROM production.product;
--UPDATE production.product
--SET "listprice" = 100;
--UPDATE production.product
--SET "listprice" = 100;


/* 1. Napisz zapytanie, które wykorzystuje transakcję (zaczyna ją), a następnie
aktualizuje cenę produktu o ProductID równym 331 (orginalnie to był produkt 680, zmienione na potrzebe realizacji) w tabeli Production.Product
o 10% i następnie zatwierdza transakcję. */

-- uznajemy listprice za cenę
BEGIN;
UPDATE production.product
SET "listprice" = "listprice" * 1.10
WHERE "productid" = 331;
COMMIT;

/*2. Napisz zapytanie, które zaczyna transakcję, usuwa produkt o ProductID równym 329 (orginalny produkt to 707, zmieniony na potrzeby realizacji)
 z tabeli Production. Product, ale następnie wycofuje transakcję. */
BEGIN;
DELETE FROM production.product
WHERE "productid" = 329;
ROLLBACK;

/* 3. Napisz zapytanie, które zaczyna transakcję, dodaje nowy produkt do tabeli
Production.Product, a następnie zatwierdza transakcję. */
-- produkt jest wypełniony losowymi wartościami

BEGIN;
INSERT INTO production.product ("productid", "name", "productnumber", "makeflag", "finishedgoodsflag",
    "color", "safetystocklevel", "reorderpoint", "standardcost", "listprice",
    "size", "sizeunitmeasurecode", "weightunitmeasurecode", "weight",
    "daystomanufacture", "productline", "class", "style",
    "productsubcategoryid", "productmodelid", "sellstartdate",
    "sellenddate", "discontinueddate", "rowguid", "modifieddate") 
VALUES (500, 'X', 'XL-2036', true, false, NULL, 800, 600, 0, 0, NULL, NULL, NULL, 1, 6, NULL, NULL, NULL, NULL, NULL, '2008-04-30 00:00:00', NULL, NULL, '{E73E9750-603B-4131-89F5-3DD15ED5FF80}', '2014-02-08 10:01:36.827000');
COMMIT;



/* 4. Napisz zapytanie, które zaczyna transakcję i aktualizuje StandardCost wszystkich
produktów w tabeli Production.Product o 10%, jeżeli suma wszystkich
StandardCost po aktualizacji nie przekracza 50000. W przeciwnym razie zapytanie
powinno wycofać transakcję. */

BEGIN;
DO $$
DECLARE 
    TotalStandardCost NUMERIC;   
BEGIN
  SELECT  SUM("standardcost") INTO TotalStandardCost FROM production.product;
    IF TotalStandardCost <= 50000 THEN
        RAISE NOTICE 'poszło, suma standard cost: %', TotalStandardCost;
		COMMIT;
    ELSE
     RAISE NOTICE 'przerwano, suma standard cost przekracza limit';
	 ROLLBACK;
    END IF;
END $$;


/* 5. Napisz zapytanie SQL, które zaczyna transakcję i próbuje dodać nowy produkt do
tabeli Production.Product. Jeśli ProductNumber już istnieje w tabeli, zapytanie
powinno wycofać transakcję.*/

BEGIN;
DO $$
DECLARE 
    rekord1 CHARACTER VARYING(25);
BEGIN
	SELECT 1 FROM production.product INTO rekord1 WHERE "productnumber" = 'XL-2036';
    IF "productnumber" = 'XL-2036' THEN
	--ROLLBACK;
    RAISE NOTICE 'Produkt o podanym numerze już istnieje. Transakcja wycofana.';  
    ELSE
    -- Wstawienie nowego produktu do tabeli
    INSERT INTO production.product ("productid", "name", "productnumber", "makeflag", "finishedgoodsflag",
        "color", "safetystocklevel", "reorderpoint", "standardcost", "listprice",
        "size", "sizeunitmeasurecode", "weightunitmeasurecode", "weight",
        "daystomanufacture", "productline", "class", "style",
        "productsubcategoryid", "productmodelid", "sellstartdate",
        "sellenddate", "discontinueddate", "rowguid", "modifieddate") 
    VALUES (500, 'X', 'XL-2036', true, false, NULL, 800, 600, 0, 0, NULL, NULL, NULL, 1, 6, NULL, NULL, NULL, NULL, NULL, '2008-04-30 00:00:00', NULL, NULL, '{E73E9750-603B-4131-89F5-3DD15ED5FF80}', '2014-02-08 10:01:36.827000');
    --COMMIT;
    RAISE NOTICE 'Nowy produkt został dodany pomyślnie.';
	END IF;
END $$;


/* 6. Napisz zapytanie SQL, które zaczyna transakcję i aktualizuje wartość OrderQty
dla każdego zamówienia w tabeli Sales.SalesOrderDetail. Jeżeli którykolwiek z
zamówień ma OrderQty równą 0, zapytanie powinno wycofać transakcję.
*/
BEGIN;
DO $$
BEGIN
UPDATE sales.salesorderdetail
SET "orderqty" = "orderqty"; 
SELECT 1 FROM sales.salesorderdetail WHERE "orderqty" = 0;
    IF "orderqty" = 0 THEN
        RAISE NOTICE 'wycofane';
        ROLLBACK;
    ELSE
        RAISE NOTICE 'zatwierdzone';
		COMMIT;
    END IF;
END $$;

/*7. Napisz zapytanie SQL, które zaczyna transakcję i usuwa wszystkie produkty,
których StandardCost jest wyższy niż średni koszt wszystkich produktów w tabeli
Production.Product. Jeżeli liczba produktów do usunięcia przekracza 10,
zapytanie powinno wycofać transakcję.
*/
BEGIN;
DO $$
DECLARE 
    avg_cost NUMERIC;
    deleted_count INT;
BEGIN
    SELECT AVG("standardcost") INTO avg_cost FROM production.product;
    DELETE FROM production.product
    WHERE "standardcost" > avg_cost;
    SELECT COUNT(*) INTO deleted_count FROM production.product;
    IF deleted_count > 10 THEN
        RAISE NOTICE 'Liczba produktów do usunięcia przekracza 10 transakcja wycofana';
        --ROLLBACK;
    ELSE
        --COMMIT;
        RAISE NOTICE 'Usunięto % produktów, których StandardCost był wyższy niż średni koszt', deleted_count;
    END IF;
END $$;
