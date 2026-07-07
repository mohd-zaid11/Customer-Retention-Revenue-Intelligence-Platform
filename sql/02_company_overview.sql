/*
====================================================================
Project  : Customer Retention & Revenue Intelligence Platform
Module   : Company Overview
Author   : Mohd Zaid Bin Haneef

Description:
This module provides an overview of the company's overall business
performance using key performance indicators (KPIs).
====================================================================
*/

USE customer_retention_db;

-- ================================================================
-- Business Question 1
-- What is the overall business performance?
-- ================================================================

SELECT
    ROUND(SUM(sales),2) AS total_revenue,
    ROUND(SUM(profit),2) AS total_profit,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    ROUND((SUM(profit)/SUM(sales))*100,2) AS profit_margin_percentage
FROM superstore;

/*
Expected Insight
- Total Revenue: 2297200.86
- Total Profit: 286397.02
- Total Orders: 5009
- Total Customers: 793
- Profit Margin (%): 12.47
*/


-- ================================================================
-- Business Question 2
-- Which product category generates the highest revenue?
-- ================================================================

SELECT
    category,
    ROUND(SUM(sales),2) AS total_revenue
FROM superstore
GROUP BY category
ORDER BY total_revenue DESC;

/*
Expected Insight:
- Highest Revenue Category: Consumer with total revenue of 1161401.34
- Lowest Revenue Category: Home Office with total revenue of 429653.15
*/


-- ================================================================
-- Business Question 3
-- Which product category generates the highest profit?
-- ================================================================

SELECT
    category,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY category
ORDER BY total_profit DESC;

/*
Expected Insight:
- Highest Profit Category: Technology (Total Profit- 145454.95)
- Lowest Profit Category: Furniture (Total Profit- 18451.27)
*/


-- ================================================================
-- Business Question 4
-- Which region generates the highest revenue?
-- ================================================================

SELECT
    region,
    ROUND(SUM(sales),2) AS total_revenue
FROM superstore
GROUP BY region
ORDER BY total_revenue DESC;

/*
Expected Insight:
- Highest Revenue Region: West (Total Revenue- 725457.82)
- Lowest Revenue Region: South (Total Revenue- 391721.91)
*/


-- ================================================================
-- Business Question 5
-- Which region generates the highest profit?
-- ================================================================

SELECT
    region,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY region
ORDER BY total_profit DESC;

/*
Expected Insight:
- Highest Profit Region: West (Total Profit- 108418.45)
- Lowest Profit Region: Central (Total Profit- 39706.36)
*/