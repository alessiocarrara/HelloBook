DECLARE @i INT = 1;
DECLARE @street VARCHAR(50);
DECLARE @city VARCHAR(30);
DECLARE @zip_code INT;
DECLARE @firstname VARCHAR(20);
DECLARE @lastname VARCHAR(20);
DECLARE @nationality VARCHAR(50);
DECLARE @title VARCHAR(20);
DECLARE @author_id INT;
DECLARE @price INT;
DECLARE @published_date DATETIME;
DECLARE @stock INT;
DECLARE @firstname_users VARCHAR(20);
DECLARE @lastname_users VARCHAR(20);
DECLARE @email VARCHAR(50);
DECLARE @password VARCHAR(16);
DECLARE @address_id INT;
DECLARE @created_at DATETIME;

WHILE @i <= 1000
BEGIN
    -- Generazione di dati casuali per l'indirizzo
    SET @street = (SELECT TOP 1 street FROM (VALUES 
        ('123 Main St, Springfield'),
        ('456 Oak Rd, Maplewood'),
        ('789 Pine Ave, Rivertown'),
        ('101 Elm St, Greenfield'),
        ('202 Birch Ln, Lakeview')
    ) AS street_table(street) ORDER BY NEWID());

    SET @city = (SELECT TOP 1 city FROM (VALUES 
        ('New York'),
        ('Los Angeles'),
        ('Chicago'),
        ('Houston'),
        ('Phoenix')
    ) AS city_table(city) ORDER BY NEWID());

    SET @zip_code = ABS(CHECKSUM(NEWID())) % 100000 + 10000; -- Genera un CAP casuale

    -- Generazione di dati casuali per l'autore
    SET @firstname = (SELECT TOP 1 firstname FROM (VALUES 
        ('John'),
        ('Emma'),
        ('James'),
        ('Olivia'),
        ('William')
    ) AS firstname_table(firstname) ORDER BY NEWID());

    SET @lastname = (SELECT TOP 1 lastname FROM (VALUES 
        ('Smith'),
        ('Johnson'),
        ('Brown'),
        ('Williams'),
        ('Taylor')
    ) AS lastname_table(lastname) ORDER BY NEWID());

    SET @nationality = (SELECT TOP 1 nationality FROM (VALUES 
        ('American'),
        ('British'),
        ('Canadian'),
        ('Australian'),
        ('German')
    ) AS nationality_table(nationality) ORDER BY NEWID());

    -- Generazione di dati casuali per il libro
    SET @title = (SELECT TOP 1 title FROM (VALUES 
        ('The Great Adventure'),
        ('The Lost World'),
        ('Secrets of the Past'),
        ('A Journey Through Time'),
        ('Beyond the Horizon')
    ) AS title_table(title) ORDER BY NEWID());

    SET @price = ABS(CHECKSUM(NEWID())) % 50 + 10; -- Prezzo tra 10 e 60

    SET @published_date = DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 3650, '2000-01-01'); -- Data casuale negli ultimi 10 anni

    SET @stock = ABS(CHECKSUM(NEWID())) % 100 + 1; -- Stock tra 1 e 100

    -- Generazione di dati casuali per gli utenti
    SET @firstname_users = (SELECT TOP 1 firstname FROM (VALUES 
        ('John'),
        ('Emma'),
        ('James'),
        ('Olivia'),
        ('William')
    ) AS firstname_table(firstname) ORDER BY NEWID());

    SET @lastname_users = (SELECT TOP 1 lastname FROM (VALUES 
        ('Smith'),
        ('Johnson'),
        ('Brown'),
        ('Williams'),
        ('Taylor')
    ) AS lastname_table(lastname) ORDER BY NEWID());

    SET @email = @firstname_users + '.' + @lastname_users + '@example.com';

    SET @password = 'password' + CAST(@i AS VARCHAR);

    SET @created_at = DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 3650, '2000-01-01'); -- Data di creazione casuale

    -- Inserimento in Address
    INSERT INTO Address(Street, City, Zip_code) 
    VALUES (@street, @city, @zip_code);

    -- Inserimento in Authors
    INSERT INTO Authors(Firstname, Lastname, Nationality) 
    VALUES (@firstname, @lastname, @nationality);

    SET @author_id = SCOPE_IDENTITY(); -- Ottieni l'ID dell'autore appena inserito

    -- Inserimento in Books
    INSERT INTO Books(Title, Author_id, Price, Published_date, Stock) 
    VALUES (@title, @author_id, @price, @published_date, @stock);

    SET @address_id = SCOPE_IDENTITY(); -- Ottieni l'ID dell'indirizzo appena inserito

    -- Inserimento in Users
    INSERT INTO Users(Firstname, Lastname, Email, Password, Address_id, Created_at) 
    VALUES (@firstname_users, @lastname_users, @email, @password, @address_id, @created_at);

    -- Incremento del contatore
    SET @i = @i + 1;
END
