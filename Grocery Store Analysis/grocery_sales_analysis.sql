Create database grocery_store_analysis;
use grocery_store_analysis;

-- Queries 
-- all transactions from GreenGrocer Plaza
SELECT * 
FROM grocery_chain_data
WHERE store_name = 'GreenGrocer Plaza'
LIMIT 100;

-- Count the total number of transactions in the database
SELECT COUNT(*) AS total_transactions
FROM grocery_chain_data;

-- top 10 most sold products by quantity
SELECT product_name, SUM(quantity) AS total_quantity_sold
FROM grocery_chain_data
GROUP BY product_name
ORDER BY total_quantity_sold DESC
LIMIT 10;

-- Calculate total revenue for each store
SELECT store_name, 
       SUM(final_amount) AS total_revenue,
       COUNT(*) AS total_transactions
FROM grocery_chain_data
GROUP BY store_name
ORDER BY total_revenue DESC;

-- Calculate average discount percentage per category
SELECT product_category,
       ROUND(AVG((discount_amount / total_amount) * 100), 2) AS avg_discount_percentage
FROM grocery_chain_data
WHERE total_amount > 0
GROUP BY product_category
ORDER BY avg_discount_percentage DESC;

-- Top 5 products by sales in each category
SELECT * FROM (
    SELECT 
        product_category,
        product_name,
        SUM(quantity) AS total_quantity_sold,
        SUM(final_amount) AS total_revenue,
        ROW_NUMBER() OVER(PARTITION BY product_category ORDER BY SUM(final_amount) DESC) AS rank_in_category
    FROM grocery_chain_data
    GROUP BY product_category, product_name
) AS ranked
WHERE rank_in_category <= 5;

-- Customer Segmentation Based on Loyalty Points with Revenue Contribution
SELECT 
    CASE 
        WHEN loyalty_points BETWEEN 0 AND 100 THEN 'Bronze (0-100)'
        WHEN loyalty_points BETWEEN 101 AND 300 THEN 'Silver (101-300)'
        WHEN loyalty_points BETWEEN 301 AND 500 THEN 'Gold (301-500)'
        ELSE 'Platinum (500+)'
    END AS customer_segment,
    COUNT(DISTINCT customer_id) AS total_customers,
    COUNT(*) AS total_transactions,
    SUM(final_amount) AS total_revenue,
    ROUND(AVG(final_amount), 2) AS avg_transaction_value,
    ROUND(SUM(final_amount) * 100.0 / (SELECT SUM(final_amount) FROM grocery_chain_data), 2) AS revenue_percentage
FROM grocery_chain_data
GROUP BY customer_segment
ORDER BY total_revenue DESC;

-- Find the top 5 customers based on their total spending
SELECT customer_id, 
       SUM(final_amount) AS total_spent,
       SUM(loyalty_points) AS total_loyalty_points,
       COUNT(*) AS transaction_count
FROM grocery_chain_data
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 5;