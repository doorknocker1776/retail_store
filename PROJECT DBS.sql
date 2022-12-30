create schema Online_Store;
use Online_Store;
CREATE TABLE Customer
(
  Customer_ID INT AUTO_INCREMENT PRIMARY KEY,
  UserID VARCHAR(45) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  UNIQUE (UserID)
);

CREATE TABLE Item
(
  ItemID INT AUTO_INCREMENT PRIMARY KEY,
  `Name` VARCHAR(45) NOT NULL,
  Price INT NOT NULL,
  `Desc` VARCHAR(45) NOT NULL,
  Availability BOOLEAN DEFAULT true
);

CREATE TABLE Orders
(
  Order_ID INT AUTO_INCREMENT,
  Customer_ID INT,
  ItemID INT NOT NULL,
  Quantity INT NOT NULL,
  PRIMARY KEY (Order_ID, Customer_ID),
  FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
  FOREIGN KEY (ItemID) REFERENCES Item(ItemID)
);

CREATE TABLE Supplier
(
  SupplierID INT AUTO_INCREMENT,
  SupplierName VARCHAR(45) NOT NULL,
  PRIMARY KEY (SupplierID)
);

CREATE TABLE Bill
(
  Bill_ID INT AUTO_INCREMENT,
  Total_Amount INT GENERATED ALWAYS AS (Subtotal-Discount),
  BillDate DATE NOT NULL,
  Subtotal INT NOT NULL,
  Discount INT NOT NULL,
  Order_ID INT,
  Customer_ID INT,
  PRIMARY KEY (Bill_ID),
  FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
  FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
);

CREATE TABLE `Account`
(
  Account_ID INT AUTO_INCREMENT,
  Account_No INT NOT NULL,
  Bank_Name VARCHAR(45) NOT NULL,
  Customer_ID INT,
  PRIMARY KEY (Account_ID),
  FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
  UNIQUE (Account_No)
);

CREATE TABLE Supplied_by
(
  ItemID INT AUTO_INCREMENT,
  SupplierID INT,
  PRIMARY KEY (ItemID, SupplierID),
  FOREIGN KEY (ItemID) REFERENCES Item(ItemID),
  FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
);

CREATE TABLE Supplier_Location
(
  SupplierID INT,
  Location VARCHAR(45) NOT NULL,
  PRIMARY KEY (Location, SupplierID),
  FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
);