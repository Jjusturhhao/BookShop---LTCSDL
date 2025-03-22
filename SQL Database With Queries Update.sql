-- New TABLE AUTHOR
CREATE TABLE Author (
    AuthorID INT PRIMARY KEY IDENTITY(1,1),
    AuthorName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255)
);

INSERT INTO Author (AuthorName) VALUES
	('J.R.R Tolken'),
	('Tanith Lee'),
	('Anne Rice'),
	('Mark Stevenson'),
	('Ribbly Scott'),
	('James Clavell'),
	('Megan Miranda'),
	('Sarah Mass');
	SELECT * FROM Author;

ALTER TABLE StockTb
ADD AuthorID INT;

UPDATE StockTb
SET AuthorID = a.AuthorID
FROM StockTb s
JOIN Author a ON s.AuthorName = a.AuthorName;
	SELECT * FROM StockTb;

ALTER TABLE StockTb
ADD CONSTRAINT FK_StockTb_Author
FOREIGN KEY (AuthorID) REFERENCES Author(AuthorID);

ALTER TABLE StockTb
DROP COLUMN AuthorName;

SELECT s.StockID, s.BookName, a.AuthorName, s.Price
FROM StockTb s
JOIN Author a ON s.AuthorID = a.AuthorID;

--Alter TABLE STOCK--
ALTER TABLE StockTb
ADD SupplierName VARCHAR(55);

UPDATE StockTb
SET SupplierName = s.Supplier_name
FROM StockTb st
JOIN SuppliersTb s ON st.SupplierID = s.Supplier_ID;

ALTER TABLE StockTb
ADD Supplier_ID VARCHAR(55);

UPDATE StockTb
SET Supplier_ID = s.Supplier_ID
FROM StockTb st
JOIN SuppliersTb s ON st.SupplierName = s.Supplier_name;

ALTER TABLE StockTb
ADD CONSTRAINT FK_StockTb_Supplier
FOREIGN KEY (Supplier_ID) REFERENCES SuppliersTb(Supplier_ID);

ALTER TABLE StockTb
DROP CONSTRAINT FK__StockTb__Supplie__398D8EEE;

ALTER TABLE StockTb
DROP COLUMN SupplierID;

ALTER TABLE StockTb
DROP COLUMN SupplierName;

EXEC sp_rename 'StockTb.Supplier_ID', 'SupplierID', 'COLUMN';

--BOOK CATEGORY
CREATE TABLE BookCategory (
    CategoryID VARCHAR(10) PRIMARY KEY,
    CategoryName NVARCHAR(100) NOT NULL
);
SELECT * FROM BookCategory

ALTER TABLE StockTb
ADD CategoryID VARCHAR(10);

ALTER TABLE StockTb
ADD CONSTRAINT FK_StockTb_BookCategory
FOREIGN KEY (CategoryID) REFERENCES BookCategory(CategoryID);

INSERT INTO BookCategory (CategoryID, CategoryName) VALUES 
	('CAT1', N'Tiểu thuyết'),
	('CAT2', N'Sách nước ngoài'),
	('CAT3', N'Kinh tế'),
	('CAT4', N'Thiếu nhi');

-- Gán CAT2 (sách nước ngoài) cho BOOK1 đến BOOK10
UPDATE StockTb
SET CategoryID = 'CAT2'
WHERE BookID LIKE 'BOOK%' AND
      TRY_CAST(SUBSTRING(BookID, 5, LEN(BookID)) AS INT) BETWEEN 1 AND 10;

-- Gán CAT1 (tiểu thuyết) cho BOOK11
UPDATE StockTb
SET CategoryID = 'CAT1'
WHERE BookID = 'BOOK11';

	SELECT * FROM StockTb