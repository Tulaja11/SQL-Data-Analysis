CREATE DATABASE sales_analysis;
USE sales_analysis;

SELECT * 
FROM retail_sales_dataset
LIMIT 10;

ALTER TABLE retail_sales_dataset
MODIFY COLUMN Date DATE;

ALTER TABLE retail_sales_dataset
MODIFY COLUMN `Price per Unit` DECIMAL(10,2);

ALTER TABLE retail_sales_dataset
MODIFY COLUMN `Total Amount` DECIMAL(10,2);

CREATE TABLE customers (
    `Customer ID` VARCHAR(20) PRIMARY KEY,
    Gender VARCHAR(10),
    Age INT
);

CREATE TABLE products (
    `Product Category` VARCHAR(50) PRIMARY KEY,
    `Price per Unit` DECIMAL(10,2)
);

CREATE TABLE orders (
    `Transaction ID` INT PRIMARY KEY,
    Date DATE,
    `Customer ID`  VARCHAR(20),
    FOREIGN KEY (`Customer ID`) REFERENCES customers(`Customer ID`)
);

CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    `Transaction ID` INT,
    `Product Category` VARCHAR(50),
    Quantity INT,
	`Total Amount` DECIMAL(10,2),
    FOREIGN KEY (`Transaction ID`) REFERENCES orders(`Transaction ID`),
    FOREIGN KEY (`Product Category` ) REFERENCES products(`Product Category` )
);

