-- ZAD1 Napisz procedurę wypisującą do konsoli ciąg Fibonacciego. Procedura musi przyjmować jako argument wejściowy liczbę n. Generowanie ciągu Fibonacciego musi zostać zaimplementowane jako osobna funkcja, wywoływana przez procedurę.

CREATE PROCEDURE wypisywanie_fibonacci2(n INT)
LANGUAGE plpgsql AS $$
DECLARE 
    pierwszy INT := 0;
    drugi INT := 1;
    suma INT;
    iterator INT := 3; 
BEGIN
    RAISE NOTICE '0'; 
    RAISE NOTICE '1'; 
    WHILE iterator <= n LOOP
        suma := tworzenie_fibonacci(pierwszy, drugi);
        RAISE NOTICE '%', suma; 
        pierwszy := drugi;
        drugi := suma;
        iterator := iterator + 1;
    END LOOP;
END;
$$;

-- Wywołanie procedury
CALL wypisywanie_fibonacci2(20);

-- ZAD 2 Napisz trigger DML, który po wprowadzeniu danych do tabeli Persons, zmodyfikuje nazwisko tak, aby bylo napisane duzymi literami. 

CREATE OR REPLACE FUNCTION update_nazwisko() 
RETURNS TRIGGER AS $$
BEGIN
    -- Ustawienie LastName na wielkie litery
    NEW.lastname := UPPER(NEW.lastname);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_nazwisko_trigger
BEFORE INSERT OR UPDATE ON person.Person
FOR EACH ROW
EXECUTE FUNCTION update_nazwisko();

INSERT INTO person.Person (businessentityid, persontype, namestyle, title, firstname, middlename, lastname, suffix, emailpromotion, additionalcontactinfo, demographics, rowguid, modifieddate) 
VALUES (11, 'EM', FALSE, 'Mr.', 'Chris', 'K.', 'Roberts', 'Jr.', 1, '<contact><phone>234-567-8901</phone></contact>', '<demographics><gender>M</gender><maritalStatus>S</maritalStatus><yearlyIncome>40000</yearlyIncome><totalChildren>0</totalChildren></demographics>', '3F2504E0-4F89-11D3-9A0C-0305E82C3311', '2024-01-01 10:00:00');

UPDATE person.Person SET lastname = 'Thompson' WHERE businessentityid = 1;



-- ZAD 3 Przygotuj trigger ‘taxRateMonitoring’, który wywwietli komunikat o bledzie, 
--		 jezeli nastapi zmiana wartosci w polu ‘TaxRate’o wiecej niz 30%.


CREATE OR REPLACE FUNCTION high_tax() 
RETURNS TRIGGER AS $$
DECLARE 
    new_tax_rate DECIMAL;
    old_tax_rate DECIMAL;
BEGIN
    new_tax_rate := NEW.taxrate;
    old_tax_rate := COALESCE(OLD.taxrate, 0); 
    
    IF new_tax_rate > 1.3 * old_tax_rate OR new_tax_rate < 0.7 * old_tax_rate THEN
        RAISE EXCEPTION 'Zmiana stawki podatkowej o więcej niż 30%%!';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER taxRateMonitoring
BEFORE INSERT OR UPDATE ON sales.SalesTaxRate
FOR EACH ROW
EXECUTE FUNCTION high_tax();

UPDATE sales.SalesTaxRate
SET TaxRate = 100
WHERE SalesTaxRateID = 1;

SELECT * FROM sales.SalesTaxRate

