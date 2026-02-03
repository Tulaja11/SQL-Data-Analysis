CREATE DATABASE banktransaction_analysis;
use banktransaction_analysis;

SELECT * FROM banking_dataset
limit 10;

SELECT COUNT(*) AS total_records 
FROM banking_dataset;

-- QUERIES 

-- Total Transactions by Type
SELECT 
    Transaction_Type,
    COUNT(*) AS total_transactions,
    SUM(Transaction_Amount) AS total_amount,
    AVG(Transaction_Amount) AS avg_amount
FROM banking_dataset
GROUP BY Transaction_Type;

-- Account Type Distribution
SELECT 
    Account_Type,
    COUNT(*) AS number_of_accounts,
    AVG(Account_Balance) AS avg_balance
FROM banking_dataset
GROUP BY Account_Type
ORDER BY avg_balance DESC;

-- Branch-wise Transaction Analysis
SELECT 
    Branch,
    COUNT(*) AS total_transactions,
    SUM(Transaction_Amount) AS total_transaction_value,
    AVG(Account_Balance) AS avg_account_balance
FROM banking_dataset
GROUP BY Branch
ORDER BY total_transaction_value DESC;

-- Top 10 Customers by Account Balance
SELECT 
    Account_ID,
    Customer_Name,
    Account_Type,
    Account_Balance,
    Currency
FROM banking_dataset
ORDER BY Account_Balance DESC
LIMIT 10;

-- High-Value Transactions
SELECT 
    Account_ID,
    Customer_Name,
    Transaction_Type,
    Transaction_Amount,
    Branch
FROM banking_dataset
WHERE Transaction_Amount > 4000
ORDER BY Transaction_Amount DESC;

-- Currency Distribution Analysis
SELECT 
    Currency,
    COUNT(*) AS transaction_count,
    SUM(Transaction_Amount) AS total_amount,
    AVG(Account_Balance) AS avg_balance
FROM banking_dataset
GROUP BY Currency
ORDER BY transaction_count DESC;

-- Customer Segmentation by Balance
SELECT 
    CASE 
        WHEN Account_Balance < 10000 THEN 'Low Balance'
        WHEN Account_Balance BETWEEN 10000 AND 50000 THEN 'Medium Balance'
        ELSE 'High Balance'
    END AS customer_segment,
    COUNT(*) AS customer_count,
    AVG(Transaction_Amount) AS avg_transaction
FROM banking_dataset
GROUP BY customer_segment;

-- Branch Performance by Account Type
SELECT 
    Branch,
    Account_Type,
    COUNT(*) AS account_count,
    SUM(Transaction_Amount) AS total_transactions
FROM banking_dataset
GROUP BY Branch, Account_Type
ORDER BY Branch, total_transactions DESC;

-- Debit vs Credit Ratio per Branch
SELECT 
    Branch,
    SUM(CASE WHEN Transaction_Type = 'Debit' THEN Transaction_Amount ELSE 0 END) AS total_debits,
    SUM(CASE WHEN Transaction_Type = 'Credit' THEN Transaction_Amount ELSE 0 END) AS total_credits,
    SUM(CASE WHEN Transaction_Type = 'Credit' THEN Transaction_Amount ELSE 0 END) - 
    SUM(CASE WHEN Transaction_Type = 'Debit' THEN Transaction_Amount ELSE 0 END) AS net_flow
FROM banking_dataset
GROUP BY Branch
ORDER BY net_flow DESC;

-- Customers with Multiple Account Types
SELECT 
    Customer_Name,
    COUNT(DISTINCT Account_Type) AS num_account_types,
    SUM(Account_Balance) AS total_balance
FROM banking_dataset
GROUP BY Customer_Name
HAVING COUNT(DISTINCT Account_Type) > 1
ORDER BY total_balance DESC;

-- Rank Customers by Total Transaction Volume
SELECT 
    Customer_Name,
    Branch,
    SUM(Transaction_Amount) AS total_transaction_volume,
    RANK() OVER (ORDER BY SUM(Transaction_Amount) DESC) AS customer_rank
FROM banking_dataset
GROUP BY Customer_Name, Branch
LIMIT 20;