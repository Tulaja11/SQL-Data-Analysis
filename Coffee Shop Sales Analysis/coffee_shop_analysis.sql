create database coffee_sales_analysis;
use coffee_sales_analysis;

-- total transactions
SELECT COUNT(*) AS total_transactions FROM coffee_sales;

-- Preview data
SELECT * FROM coffee_sales LIMIT 10;

-- QUERIES 
-- Top 10 Best-Selling Products
SELECT 
    product_name,
    category,
    COUNT(*) AS times_sold,
    SUM(quantity) AS total_quantity_sold,
    ROUND(SUM(total_amount), 2) AS total_revenue
FROM coffee_sales
GROUP BY product_name, category
ORDER BY times_sold DESC
LIMIT 10;

-- Total Revenue by Category
SELECT 
    category,
    COUNT(*) AS total_transactions,
    SUM(quantity) AS total_items_sold,
    ROUND(SUM(total_amount), 2) AS total_revenue,
    ROUND(AVG(total_amount), 2) AS avg_transaction_value
FROM coffee_sales
GROUP BY category
ORDER BY total_revenue DESC;

-- Total Sales by Payment Method
SELECT 
    payment_method,
    COUNT(*) AS number_of_transactions,
    ROUND(SUM(total_amount), 2) AS total_revenue,
    ROUND(AVG(total_amount), 2) AS avg_transaction_amount
FROM coffee_sales
GROUP BY payment_method
ORDER BY total_revenue DESC;

-- Daily Sales Trend Analysis
SELECT 
    STR_TO_DATE(date, '%d-%m-%Y') AS sale_date,
    COUNT(*) AS transactions_count,
    SUM(quantity) AS items_sold,
    ROUND(SUM(total_amount), 2) AS daily_revenue,
    ROUND(AVG(total_amount), 2) AS avg_order_value
FROM coffee_sales
GROUP BY sale_date
ORDER BY sale_date;

-- busiest hours of the day
SELECT 
    HOUR(STR_TO_DATE(time, '%H:%i:%s')) AS hour_of_day,
    COUNT(*) AS number_of_sales,
    SUM(quantity) AS items_sold,
    ROUND(SUM(total_amount), 2) AS hourly_revenue
FROM coffee_sales
GROUP BY hour_of_day
ORDER BY hour_of_day;

-- each product's contribution within its category
SELECT 
    category,
    product_name,
    COUNT(*) AS times_ordered,
    SUM(quantity) AS total_units_sold,
    ROUND(SUM(total_amount), 2) AS product_revenue,
    ROUND(AVG(unit_price), 2) AS avg_price
FROM coffee_sales
GROUP BY category, product_name
ORDER BY category, product_revenue DESC;

-- Weekend vs Weekday Sales
SELECT 
    CASE 
        WHEN DAYOFWEEK(STR_TO_DATE(date, '%d-%m-%Y')) IN (1, 7) THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    COUNT(*) AS transactions,
    ROUND(SUM(total_amount), 2) AS total_revenue,
    ROUND(AVG(total_amount), 2) AS avg_transaction
FROM coffee_sales
GROUP BY day_type;
