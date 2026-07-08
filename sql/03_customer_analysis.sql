/*
=====================================================
Project : Customer Retention & Revenue Intelligence Platform
Module  : Customer Analysis
=====================================================
*/

USE customer_retention_db;




-- =====================================================
-- Business Question 1
-- Which customer segment contributes the most revenue and profit?
-- =====================================================

SELECT
    segment,
    ROUND(SUM(sales),2) AS total_revenue,
    ROUND(SUM(profit),2) AS total_profit,
    COUNT(DISTINCT customer_id) AS total_customers
FROM superstore
GROUP BY segment
ORDER BY total_revenue DESC;
/*
Insight:
- Consumer segment generates the highest revenue (1.16M) and profit (134.12K).
- Home Office contributes the lowest revenue and profit.
- Consumer segment has the highest customer base (409 customers).

Business Recommendation:
Increase customer retention and personalized marketing campaigns for the Consumer segment while exploring growth opportunities in the Home Office segment.
*/

-- ================================================================
-- Business Question 2
-- Who are the Top 10 customers by total revenue?
-- ================================================================

SELECT
    customer_id,
    customer_name,
    ROUND(SUM(sales),2) AS total_revenue
FROM superstore
GROUP BY customer_id, customer_name
ORDER BY total_revenue DESC
LIMIT 10;

/*
Query Output:
customer_id customer_name       total_revenue
----------------------------------------------
AB-10105	Adrian Barton		14473.57
CC-12370	Christopher Conant	12129.07
HL-15040	Hunter Lopez		12873.3
KL-16645	Ken Lonsdale		14175.23
RB-19360	Raymond Buch		15117.34
SC-20095	Sanjit Chand		14142.33
SE-20110	Sanjit Engle		12209.44
SM-20320	Sean Miller		    25043.05
TA-21385	Tom Ashbrook		14595.62
TC-20980	Tamara Chand		19052.22

Insight:
- The top 10 customers contribute a significant portion of the company's total revenue.
- These customers are the company's highest-value customers.
- Losing even a few of these customers could noticeably impact revenue.

Business Recommendation:
Create VIP loyalty programs, dedicated account management, and personalized offers for these high-value customers to improve long-term retention.
*/


-- ================================================================
-- Business Question 3
-- Who are the Top 10 customers by total profit?
-- ================================================================

SELECT
    customer_id,
    customer_name,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY customer_id, customer_name
ORDER BY total_profit DESC
LIMIT 10;

/*
Query Output:
customer_id customer_name           total_profit
-------------------------------------------------
TC-20980	Tamara Chand		    8981.32
RB-19360	Raymond Buch		    6976.1
SC-20095	Sanjit Chand		    5757.41
HL-15040	Hunter Lopez		    5622.43
AB-10105	Adrian Barton		    5444.81
TA-21385	Tom Ashbrook		    4703.79
CM-12385	Christopher Martinez	3899.89
KD-16495	Keith Dawkins		    3038.63
AR-10540	Andy Reiter		        2884.62
DR-12940	Daniel Raglin		    2869.08

Key Insights:
- The highest profitable customers are not always the highest revenue customers.
- A few customers contribute significantly to overall profit.
- These customers generate maximum business value.

Business Recommendation:
- Focus on retaining highly profitable customers.
- Offer premium services and personalized support to these customers.
- Analyze why these customers are highly profitable and replicate the strategy for others.
*/


-- ================================================================
-- Business Question 4
-- How are customers distributed across different regions?
-- ================================================================

SELECT
    region,
    COUNT(DISTINCT customer_id) AS total_customers
FROM superstore
GROUP BY region
ORDER BY total_customers DESC;

/*
Query Output:
region  total_customers
------------------------
West	   686
East	   674
Central	   629
South	   512

Key Insights:
- Customer distribution varies across regions.
- Regions with more customers generally provide larger business opportunities.
- Regions with fewer customers may have growth potential.

Business Recommendation:
- Increase marketing efforts in regions with fewer customers.
- Continue customer engagement programs in high-performing regions.
- Identify reasons behind regional differences and improve weaker regions.
*/


-- ================================================================
-- Business Question 5
-- What is the average revenue generated per customer?
-- ================================================================

SELECT
    ROUND(SUM(sales) / COUNT(DISTINCT customer_id),2) AS average_revenue_per_customer
FROM superstore;

/*
Query Output:
average_revenue_per_customer
-----------------------------
2896.85

Key Insights:
- This KPI measures the average revenue generated from each customer.
- A higher value indicates customers are spending more on average.
- It is useful for tracking customer value over time.

Business Recommendation:
- Increase average customer spending through cross-selling and upselling.
- Recommend complementary products to existing customers.
- Introduce bundle offers and personalized product recommendations.
*/


-- ================================================================
-- Business Question 6
-- Which customers generate high revenue but low profit?
-- ================================================================

SELECT
    customer_id,
    customer_name,
    ROUND(SUM(sales),2) AS total_revenue,
    ROUND(SUM(profit),2) AS total_profit,
    ROUND((SUM(profit)/SUM(sales))*100,2) AS profit_margin
FROM superstore
GROUP BY customer_id, customer_name
HAVING SUM(sales) > (
    SELECT AVG(customer_sales)
    FROM (
        SELECT SUM(sales) AS customer_sales
        FROM superstore
        GROUP BY customer_id
    ) AS avg_sales
)
ORDER BY total_profit ASC
LIMIT 10;

/*
Query Output:
cutomer_id  customer_name       total_revenue   total_profit    profit_margin
-------------------------------------------------------------------------------
CS-12505	Cindy Stewart	    5690.05	        -6626.39	    -116.46
GT-14635	Grant Thornton	    9351.21	        -4108.66	    -43.94
LF-17185	Luke Foster	        3930.51	        -3583.98	    -91.18
SR-20425	Sharelle Roach	    3233.48	        -3333.91	    -103.11
HG-14965	Henry Goldwyn	    3247.64	        -2797.96	    -86.15
SB-20290	Sean Braxton	    8057.89	        -2082.75	    -25.85
SM-20320	Sean Miller	        25043.05	    -1980.74	    -7.91
CP-12340	Christine Phan	    5888.28	        -1850.3	        -31.42
NF-18385	Natalie Fritzler	8322.83	        -1695.97	    -20.38
BM-11140	Becky Martin	    11789.63	    -1659.96	    -14.08

Key Insights:
- These customers generate above-average revenue but contribute relatively low profit.
- High sales do not always translate into high profitability.
- Heavy discounts or low-margin products may be reducing profits.

Business Recommendation:
- Review discount policies for these customers.
- Promote higher-margin products.
- Analyze purchasing patterns to improve profitability without affecting customer satisfaction.
*/