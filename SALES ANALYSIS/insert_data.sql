-- data insertion

INSERT INTO customers
SELECT DISTINCT
    `Customer ID`,
    Gender,
    Age
FROM retail_sales_dataset;

INSERT INTO products
SELECT 
    `Product Category`,
    AVG(`Price per Unit`)
FROM retail_sales_dataset
GROUP BY `Product Category`;
 
INSERT INTO orders
SELECT DISTINCT
    `Transaction ID`,
    Date,
    `Customer ID`
FROM retail_sales_dataset;

INSERT INTO order_items (`Transaction ID`, `Product Category`, Quantity, `Total Amount`)
SELECT
    `Transaction ID`,
    `Product Category`,
    Quantity,
    `Total Amount`
FROM retail_sales_dataset;


