-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2024-03-08 12:54:28.295

-- tables
-- Table: Artykuly
CREATE TABLE Artykuly (
    IDZamowienia int   NOT NULL,
    IDpudelka char   NOT NULL,
    Sztuk int  NOT NULL,
    Zamowienia_IDZamowienia int  NOT NULL,
    CONSTRAINT Artykuly_pk PRIMARY KEY (IDZamowienia,IDpudelka)
);

-- Table: Czekoladki
CREATE TABLE Czekoladki (
    IDczekoladki char  NOT NULL,
    Nazwa char  NOT NULL,
    RodzajCzekolady char  NOT NULL,
    RodzajOrzechów char  NOT NULL,
    RodzajNadzienia char  NOT NULL,
    Opis char  NOT NULL,
    Koszt money  NOT NULL,
    Masa int  NOT NULL,
    Zawartosc_IDpudelka int  NOT NULL,
    Zawartosc_IDczekoladki char()  NOT NULL,
    CONSTRAINT Czekoladki_pk PRIMARY KEY (IDczekoladki)
);

-- Table: Klienci
CREATE TABLE Klienci (
    IDklienta int   NOT NULL,
    Nazwa char()  NOT NULL,
    Ulica char()  NOT NULL,
    Miejscowosc char()  NOT NULL,
    Kod char()  NOT NULL,
    Telefon char()  NOT NULL,
    CONSTRAINT Klienci_pk PRIMARY KEY (IDklienta)
);

-- Table: Pudelka
CREATE TABLE Pudelka (
    IDpudelka char  NOT NULL,
    Nazwa char  NOT NULL,
    Opis text  NOT NULL,
    Cena money  NOT NULL,
    Stan int  NOT NULL,
    Artykuly_IDZamowienia int   NOT NULL,
    Artykuly_IDpudelka char   NOT NULL,
    CONSTRAINT Pudelka_pk PRIMARY KEY (IDpudelka)
);

-- Table: Zamowienia
CREATE TABLE Zamowienia (
    IDZamowienia int  NOT NULL,
    IDKlienta char  NOT NULL,
    DataRealizacji date  NOT NULL,
    Klienci_IDklienta int   NOT NULL,
    CONSTRAINT Zamowienia_pk PRIMARY KEY (IDZamowienia)
);

-- Table: Zawartosc
CREATE TABLE Zawartosc (
    IDpudelka int  NOT NULL,
    IDczekoladki char()  NOT NULL,
    Sztuk int  NOT NULL,
    Pudelka_IDpudelka char  NOT NULL,
    CONSTRAINT Zawartosc_pk PRIMARY KEY (IDpudelka,IDczekoladki)
);

-- foreign keys
-- Reference: Artykuly_Zamowienia (table: Artykuly)
ALTER TABLE Artykuly ADD CONSTRAINT Artykuly_Zamowienia
    FOREIGN KEY (IDZamowienia)
    REFERENCES Zamowienia (IDZamowienia)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Czekoladki_Zawartosc (table: Czekoladki)
ALTER TABLE Czekoladki ADD CONSTRAINT Czekoladki_Zawartosc
    FOREIGN KEY (IDczekoladki)
    REFERENCES Zawartosc (IDczekoladki)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Pudelka_Artykuly (table: Pudelka)
ALTER TABLE Pudelka ADD CONSTRAINT Pudelka_Artykuly
    FOREIGN KEY (IDpudelka)
    REFERENCES Artykuly (IDpudelka)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Zamowienia_Klienci (table: Zamowienia)
ALTER TABLE Zamowienia ADD CONSTRAINT Zamowienia_Klienci
    FOREIGN KEY (IDKlienta)
    REFERENCES Klienci (IDklienta)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Zawartosc_Pudelka (table: Zawartosc)
ALTER TABLE Zawartosc ADD CONSTRAINT Zawartosc_Pudelka
    FOREIGN KEY (IDpudelka)
    REFERENCES Pudelka (IDpudelka)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.

