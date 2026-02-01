-- Queries


-- Total Revenue
SELECT SUM(`Total Amount`) AS total_revenue
FROM order_items;

-- Total Orders Count
SELECT COUNT(DISTINCT `Transaction ID`) AS total_orders
FROM orders;

-- Total Quantity Sold
SELECT SUM(Quantity) AS total_items_sold
FROM order_items;

-- Revenue by Category
SELECT 
    `Product Category`,
    SUM(`Total Amount`) AS revenue
FROM order_items
GROUP BY `Product Category`;

-- Top 5 Customers by Spending
SELECT 
    c.`Customer ID`,
    SUM(oi.`Total Amount`) AS total_spent
FROM customers c
JOIN orders o 
  ON c.`Customer ID` = o.`Customer ID`
JOIN order_items oi 
  ON o.`Transaction ID` = oi.`Transaction ID`
GROUP BY c.`Customer ID`
ORDER BY total_spent DESC
LIMIT 5;

-- Monthly Sales Trend
SELECT 
    MONTH(o.Date) AS month,
    SUM(oi.`Transaction ID`) AS monthly_sales
FROM orders o
JOIN order_items oi 
  ON o.`Transaction ID` = oi.`Transaction ID`
GROUP BY MONTH(o.Date)
ORDER BY month;

-- Average Order Value 
SELECT 
    AVG(order_total) AS avg_order_value
FROM (
    SELECT 
        `Transaction ID`,
        SUM(`Total Amount`) AS order_total
    FROM order_items
    GROUP BY `Transaction ID`
) t;
