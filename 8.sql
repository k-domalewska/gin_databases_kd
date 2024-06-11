--zad1 Wykorzystując wyrażenie CTE zbuduj zapytanie, które znajdzie informacje na temat stawki pracownika oraz jego danych, a następnie zapisze je do tabeli tymczasowej TempEmployeeInfo. Rozwiąż w oparciu o AdventureWorks.

CREATE TEMP TABLE TempEmployeeInfo AS
WITH moja AS (
    SELECT p.BusinessEntityID, p.FirstName, p.LastName, e.Rate
    FROM Person.Person p
    INNER JOIN HumanResources.EmployeePayHistory e ON p.BusinessEntityID = e.BusinessEntityID
)
SELECT * FROM moja;

SELECT * FROM TempEmployeeInfo;

--zad2 Uzyskaj informacje na temat przychodów ze sprzedaży według firmy i kontaktu (za pomocą CTE i bazy AdventureWorksL).

WITH moja2 AS (
    SELECT CONCAT(c.CompanyName, ' (', c.FirstName, ' ', c.LastName, ')') AS CompanyContact, s.TotalDue AS Revenue
    FROM SalesLT.Customer c
    INNER JOIN SalesLT.SalesOrderHeader s ON c.CustomerID = s.CustomerID
)
SELECT * FROM moja2;

--zad3 Napisz zapytanie, które zwróci wartość sprzedaży dla poszczególnych kategorii produktów. Wykorzystaj CTE i bazę AdventureWorksLT.

WITH moja3 AS (
    SELECT c.Name AS Category, od.UnitPrice AS SalesValue
    FROM SalesLT.Product p
    INNER JOIN SalesLT.ProductCategory c ON p.ProductCategoryID = c.ProductCategoryID
    INNER JOIN SalesLT.SalesOrderDetail od ON p.ProductID = od.ProductID
)
SELECT Category, SUM(SalesValue) AS SalesValue
FROM moja3 
GROUP BY Category;
