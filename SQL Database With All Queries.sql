IF DB_ID('BookStoreManagement') IS NULL 
	CREATE DATABASE BookStoreManagement
GO

USE [BookStoreManagement]
GO


--BOOKSHOP MANAGEMENT SYSTEM
CREATE TABLE BookCategory (
    CategoryID VARCHAR(10) PRIMARY KEY,
    CategoryName NVARCHAR(100) NOT NULL
);
	INSERT INTO BookCategory (CategoryID, CategoryName) VALUES 
		('CAT1', N'Tiểu thuyết'),
		('CAT2', N'Sách nước ngoài'),
		('CAT3', N'Kinh tế'),
		('CAT4', N'Thiếu nhi');


CREATE TABLE SuppliersTb(
		Supplier_ID VARCHAR (55)NOT NULL,
		Supplier_name VARCHAR(55) NOT NULL,
		Supplier_City VARCHAR(55),
		Supplier_email VARCHAR(55),
		Supplier_phone VARCHAR(55) NOT NULL,
		PRIMARY KEY (Supplier_ID)
		);

	INSERT INTO SuppliersTb VALUES('SUP1','SN1','City1','SN1@gmail.com','0321-6020450')
	INSERT INTO SuppliersTb VALUES('SUP2','SN2','City2','SN2@gmail.com','0322-6020450')
	INSERT INTO SuppliersTb VALUES('SUP3','SN3','City3','SN3@gmail.com','0323-6020450')
	INSERT INTO SuppliersTb VALUES('SUP4','SN4','City4','SN4@gmail.com','0324-6020450')
	INSERT INTO SuppliersTb VALUES('SUP5','SN5','City5','SN5@gmail.com','0325-6020450')
	INSERT INTO SuppliersTb VALUES('SUP6','SN6','City6','SN6@gmail.com','0326-6020450')
	INSERT INTO SuppliersTb VALUES('SUP7','SN7','City7','SN7@gmail.com','0327-6020450')
	INSERT INTO SuppliersTb VALUES('SUP8','SN8','City8','SN8@gmail.com','0328-6020450')
	INSERT INTO SuppliersTb VALUES('SUP9','SN9','City9','SN9@gmail.com','0329-6020450')
	INSERT INTO SuppliersTb VALUES('SUP10','SN0','City10','SN10@gmail.com','0330-6020450')
	SELECT * FROM SuppliersTb

	--1
	SELECT Supplier_name, Supplier_phone FROM SuppliersTb 
	--2
	update SuppliersTb SET Supplier_name = 'fahad' WHERE Supplier_ID = 'SUP10';
	--3
	delete FROM SuppliersTb WHERE Supplier_ID = 'SUP10';


	create table StockTb(
		StockID VARCHAR(50) PRIMARY KEY,
		SupplierID VARCHAR(55) FOREIGN KEY REFERENCES SuppliersTb(Supplier_ID),
		BookID VARCHAR(50) NOT NULL,
		CategoryID VARCHAR(10) FOREIGN KEY REFERENCES BookCategory(CategoryID),
		AuthorName VARCHAR(50) NOT NULL,
		BookName VARCHAR(50) NOT NULL,
		PublisherName VARCHAR(50) NOT NULL,
		PublishedYear VARCHAR(50) NOT NULL,
		Price int NOT NULL
	);

	INSERT INTO StockTb VALUES('STK1','SUP1','BOOK1','CAT2','J.R.R Tolken','The Hobbit','Allen & Unwin','1937', 1100);
	INSERT INTO StockTb VALUES('STK2','SUP1','BOOK2','CAT2','Tanith Lee','The Castle of Dark','Macmilla','1930', 1200);
	INSERT INTO StockTb VALUES('STK3','SUP2','BOOK3','CAT2','Tanith Lee','The Winter Players','Macmilla','1977', 1300);
	INSERT INTO StockTb VALUES('STK4','SUP2','BOOK4','CAT2','Anne Rice','Tale of the Thief','Penguin','2016', 1400);
	INSERT INTO StockTb VALUES('STK5','SUP3','BOOK5','CAT2','J.R.R Tolken','The Lord of the Rings : Fellowship of the ring','Allen & Unwin','1937', 1500);
	INSERT INTO StockTb VALUES('STK6','SUP3','BOOK6','CAT2','Mark Stevenson','Prince and the Pauper','American Pushlishing Co','2011', 1600);
	INSERT INTO StockTb VALUES('STK7','SUP4','BOOK7','CAT2','Ribbly Scott','Alien','Morpheus','1996', 1700);
	INSERT INTO StockTb VALUES('STK8','SUP4','BOOK8','CAT2','James Clavell','Gone Girl','Paramount','2015', 1800);
	INSERT INTO StockTb VALUES('STK9','SUP5','BOOK9','CAT2','Megan Miranda','All the Missing Girls','H & R','2016', 1900);
	INSERT INTO StockTb VALUES('STK10','SUP6','BOOK10','CAT2','Sarah Mass','Empire of Storms','Pearson Plc','2006', 2000);
	SELECT * FROM StockTb

	--1
	alter table StockTb
    ADD CONSTRAINT CHK_Price CHECK(Price>=1000);
	--2
	SELECT * FROM StockTb WHERE PublishedYear = 2016
	--3
	SELECT AuthorName, COUNT(PublishedYear)
	FROM StockTb
	GROUP BY AuthorName 
	
	CREATE TABLE Users (
    User_ID VARCHAR(30) PRIMARY KEY, -- ID tự động tăng
    Name NVARCHAR(30) NOT NULL, -- Hỗ trợ nhập dấu
    Username VARCHAR(30) NOT NULL UNIQUE, -- Đảm bảo Username không trùng
    Password VARCHAR(50) NOT NULL,
    Email VARCHAR(50) NOT NULL UNIQUE, -- Email phải duy nhất
    Address NVARCHAR(100) NULL, -- Chỉ khách hàng cần nhập
    PhoneNumber VARCHAR(50) NULL, -- Dùng chung cho Customer & Manager
    Role VARCHAR(30) CHECK (Role IN ('Customer', 'Staff', 'Admin')) NOT NULL DEFAULT 'Customer'
);

-- Admin: Không cần nhập Address và PhoneNumber
	INSERT INTO Users (User_ID, Name, Username, Password, Email, Role) 
	VALUES 
	('A1', N'Ngọc Hân', 'Lele', '123', 'lele@gmail.com', 'Admin'),
	('A2',N'Hoàn Hảo', 'Hao', '123', 'hhao@gmail.com', 'Admin');

-- Manager, Customer: Cần nhập Address và PhoneNumber
	INSERT INTO Users (User_ID, Name, Username, Password, Email, Address, PhoneNumber, Role) 
	VALUES 
	('S1',N'Đan Hạnh', 'Tu', '000', 'tutu@gmail.com', 'Nhà Bè', '0123456789', 'Staff'),
	('S2',N'Phương Thảo', 'APT', '000', 'apt@gmail.com', 'Nhà Bè', '0223456789', 'Staff'),
	('S3',N'Gia Hân', 'Bao', '000', 'abao@gmail.com', 'Tân Bình', '0323456789', 'Staff'),
	('C1',N'Huệ Tin', 'Tin', '456', 'htk@gmail.com', N'Quận 7', '0987654321', 'Customer'),
	('C2',N'Hân Hân', 'hhan', '456', 'hhan@gmail.com', N'Nhà Bè', '0987654322', 'Customer'),
	('C3',N'Mỹ Diên', 'Dien', '456', 'mdien@gmail.com', N'Nhà Bè', '0987654323', 'Customer');


	CREATE TABLE Orders (
    Order_ID VARCHAR(55) NOT NULL PRIMARY KEY, -- Nếu cần Order_ID là mã chuỗi
    Customer_ID VARCHAR(30) NOT NULL, -- Đổi sang INT nếu Users dùng INT
    Employee_ID VARCHAR(30) NOT NULL, 
    StockID VARCHAR(50) NOT NULL, -- StockID cũng nên là INT nếu có thể
    Qty_sold INT CHECK (Qty_sold > 0), -- Đảm bảo số lượng bán phải lớn hơn 0
    Order_Date DATE NOT NULL, -- Dùng DATE thay vì VARCHAR

    -- Thiết lập khóa ngoại
    CONSTRAINT FK_Orders_Customer FOREIGN KEY (Customer_ID) REFERENCES Users(User_ID),
    CONSTRAINT FK_Orders_Employee FOREIGN KEY (Employee_ID) REFERENCES Users(User_ID),
    CONSTRAINT FK_Orders_Stock FOREIGN KEY (StockID) REFERENCES StockTb(StockID)
);

	INSERT INTO Orders VALUES('ORD1','C1','S1','STK1',1,'2-2-2022')
	INSERT INTO Orders VALUES('ORD2','C2','S2','STK2',2,'3-2-2022')
	INSERT INTO Orders VALUES('ORD3','C3','S3','STK1',1,'4-2-2022')
	INSERT INTO Orders VALUES('ORD4','C1','S1','STK3',2,'5-2-2022')
	INSERT INTO Orders VALUES('ORD5','C3','S3','STK4',1,'6-2-2022')

	SELECT * FROM Orders

	--1
	Update Orders SET Qty_sold = 3 WHERE Order_ID = 'ORD1';
	SELECT * FROM Orders Order By Qty_sold Desc; 
	--2
	SELECT Customer_ID, Qty_sold FROM Orders
	GROUP BY Customer_ID, Qty_sold
	--3
	SELECT * FROM Orders
	WHERE Order_Date BETWEEN '2-2-2022'AND'5-2-2022';
	
	CREATE TABLE Bill_Generate(
	Bill_ID VARCHAR(50) PRIMARY KEY,
	Order_ID VARCHAR(55) FOREIGN KEY REFERENCES Orders(Order_ID),
	Customer_ID VARCHAR(30) FOREIGN KEY REFERENCES Users(User_ID),
	BookID VARCHAR(50) NOT NULL,
	Bill_Date date,
	Total_Cost INT CHECK(Total_Cost>0) NOT NULL,
	);
	INSERT INTO Bill_Generate VALUES('BILL1','ORD1','C1','BOOK1','6-2-2022',1100)
	INSERT INTO Bill_Generate VALUES('BILL2','ORD2','C2','BOOK2','7-2-2022',1200)
	INSERT INTO Bill_Generate VALUES('BILL3','ORD3','C3','BOOK1','8-2-2022',1100)
	INSERT INTO Bill_Generate VALUES('BILL4','ORD4','C1','BOOK3','9-2-2022',1300)
	INSERT INTO Bill_Generate VALUES('BILL5','ORD5','C3','BOOK4','10-2-2022',1300)
	SELECT * FROM Bill_Generate

	--1
	SELECT Customer_ID, BooKID FROM Bill_Generate
	GROUP BY Customer_ID, BookID
	--2
	SELECT Customer_ID, COUNT(BookID)
	FROM Bill_Generate
	GROUP BY Customer_ID

	CREATE TABLE PAYMENTS(
	Payment_ID VARCHAR(50) PRIMARY KEY,
	Bill_ID VARCHAR(50) FOREIGN KEY REFERENCES Bill_Generate(Bill_ID),
	Customer_ID VARCHAR(30) FOREIGN KEY REFERENCES Users(User_ID),
	Credit_card_numb VARCHAR(55) NOT NULL,
	Credit_card_expiry VARCHAR(55) NOT NULL,
	Total_Cost INT CHECK(Total_Cost>0) NOT NULL,
	);

	INSERT INTO PAYMENTS VALUES('PAY1','BILL1','C1','1717-22-233','11-17-2024',1100)
	INSERT INTO PAYMENTS VALUES('PAY2','BILL2','C2','1718-23-233','01-17-2025',1200)
	INSERT INTO PAYMENTS VALUES('PAY3','BILL3','C3','1719-24-233','03-17-2023',1100)
	INSERT INTO PAYMENTS VALUES('PAY4','BILL4','C1','1720-25-233','05-17-2030',1300)
	INSERT INTO PAYMENTS VALUES('PAY5','BILL5','C3','1721-26-233','07-17-2045',1300)
	SELECT * FROM PAYMENTS;
	--1
	SELECT Sum(Total_Cost) As 'Total Sale' FROM PAYMENTS;
	--2
	SELECT Customer_ID, Sum(Total_Cost)
	FROM Payments
	GROUP BY Customer_ID
	having Sum(Total_Cost) >= 2200

	--SQL JOINTS

	--INNER JOIN
	SELECT Orders.Order_ID, Users.Name, Orders.Order_Date
	FROM Orders	
	INNER JOIN Users ON Orders.Customer_ID=Users.User_ID;

	--LEFT JOIN
	SELECT Orders.Order_ID, Users.Name, Orders.Order_Date
	FROM Users	
	LEFT JOIN Orders ON Orders.Customer_ID=Users.User_ID;

	--RIGHT JOIN
	SELECT  Users.Name, Orders.Order_ID
	FROM Users
	RIGHT JOIN Orders ON Orders.Customer_ID=Users.User_ID;

	--FULL JOIN
	SELECT Orders.Order_ID, Users.Name, Orders.Order_Date
	FROM Users	
	FULL JOIN Orders ON Orders.Customer_ID=Users.User_ID;

