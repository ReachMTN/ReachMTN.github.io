/*
iPhone Checkout Analytics — SQL Server starter script
IMPORTANT: This is a portfolio demonstration using synthetic/sample records.
Do not treat the generated rows as actual purchase history.
*/

CREATE TABLE dbo.CheckoutTransactions (
    checkout_id       VARCHAR(20)    NOT NULL PRIMARY KEY,
    checkout_datetime DATETIME2      NOT NULL,
    product_name      VARCHAR(150)   NOT NULL,
    product_color     VARCHAR(40)    NULL,
    price_usd         DECIMAL(12,2)  NOT NULL,
    retailer          VARCHAR(80)    NOT NULL,
    status            VARCHAR(20)    NOT NULL,
    saved_usd         DECIMAL(12,2)  NOT NULL DEFAULT 0,
    failure_flag      BIT            NOT NULL DEFAULT 0,
    profile           VARCHAR(80)    NULL,
    account           VARCHAR(80)    NULL,
    order_reference   VARCHAR(40)    NULL
);
GO

-- Import checkout_transactions_sample.csv into dbo.CheckoutTransactions
-- using SQL Server Import Flat File, SSMS import wizard, or your preferred loader.

-- KPI summary
SELECT
    SUM(price_usd) AS total_spent_usd,
    SUM(saved_usd) AS total_saved_usd,
    COUNT(*) AS total_checkouts,
    SUM(CAST(failure_flag AS INT)) AS failed_checkouts
FROM dbo.CheckoutTransactions;

-- Spend trend by date
SELECT
    CAST(checkout_datetime AS DATE) AS checkout_date,
    SUM(price_usd) AS daily_spend_usd,
    COUNT(*) AS checkout_count
FROM dbo.CheckoutTransactions
GROUP BY CAST(checkout_datetime AS DATE)
ORDER BY checkout_date;

-- Product and color mix
SELECT
    product_name,
    product_color,
    COUNT(*) AS checkout_count,
    SUM(price_usd) AS total_spend_usd
FROM dbo.CheckoutTransactions
GROUP BY product_name, product_color
ORDER BY total_spend_usd DESC;

-- Retailer performance
SELECT
    retailer,
    COUNT(*) AS checkout_count,
    SUM(price_usd) AS total_spend_usd,
    SUM(CAST(failure_flag AS INT)) AS failed_checkouts
FROM dbo.CheckoutTransactions
GROUP BY retailer
ORDER BY total_spend_usd DESC;

-- Data quality checks
SELECT checkout_id, COUNT(*) AS duplicate_count
FROM dbo.CheckoutTransactions
GROUP BY checkout_id
HAVING COUNT(*) > 1;

SELECT *
FROM dbo.CheckoutTransactions
WHERE price_usd < 0 OR saved_usd < 0 OR checkout_datetime IS NULL;
