/*
====================================================================
Project  : Customer Retention & Revenue Intelligence Platform
Module   : Advanced SQL Business Case Studies
Author   : Mohd Zaid Bin Haneef

Description:
This module demonstrates advanced SQL concepts such as CTEs,
Window Functions, Ranking Functions, Running Totals,
Moving Averages, and Customer Analytics to solve
real-world business problems.

====================================================================
*/


USE customer_retention_db;

-- ================================================================
-- Business Question 1
-- Top 5 Customers by Revenue in Each Region
-- ================================================================

WITH CustomerRevenue AS
(
    SELECT
        region, customer_id, customer_name,
        ROUND(SUM(sales),2) AS total_revenue,

        ROW_NUMBER() OVER(
            PARTITION BY region
            ORDER BY SUM(sales) DESC
        ) AS customer_rank

    FROM superstore

    GROUP BY
        region,
        customer_id,
        customer_name
)
SELECT * FROM CustomerRevenue
WHERE customer_rank<=5;

/*
Query Output:
region  customer_id customer_name           total_revenue   customer_rank  
-------------------------------------------------------------------------
Central	TC-20980	Tamara Chand	        18437.14	    1
Central	AB-10105	Adrian Barton	        12181.59	    2
Central	BM-11140	Becky Martin	        10539.9	        3
Central	SC-20095	Sanjit Chand	        9900.19	        4
Central	HM-14860	Harry Marie	            6621.48	        5
East	TA-21385	Tom Ashbrook	        13723.5	        1
East	HL-15040	Hunter Lopez	        10522.55	    2
East	BS-11365	Bill Shonely	        10022.29	    3
East	GT-14710	Greg Tran	            9382.93	        4
East	SV-20365	Seth Vernon	            9216.57	        5
South	SM-20320	Sean Miller	            23669.2	        1
South	SE-20110	Sanjit Engle	        8805.04	        2
South	GT-14635	Grant Thornton	        8167.42	        3
South	CM-12385	Christopher Martinez	6682.26	        4
South	JE-15610	Jim Epp	                6264.35	        5
West	RB-19360	Raymond Buch	        14345.28	    1
West	KL-16645	Ken Lonsdale	        8472.39	        2
West	EH-13765	Edward Hooks	        7447.77	        3
West	JW-15220	Jane Waco	            7391.53	        4
West	KF-16285	Karen Ferguson	        7182.77	        5

Key Insights        
- Every region has different high-value customers.
- Revenue contribution varies significantly across regions.
- Top customers should be managed separately for every region.

Business Recommendation
- Create region-specific loyalty programs.
- Assign dedicated account managers for premium customers.
- Monitor purchasing behavior of top regional customers.
*/



-- ================================================================
-- Business Question 2
-- Highest Revenue Product in Every Category
-- ================================================================

WITH ProductRevenue AS
(
SELECT category, product_name,
ROUND(SUM(sales),2) total_sales,
RANK() OVER(PARTITION BY category ORDER BY SUM(sales) DESC) product_rank
FROM superstore
GROUP BY category, product_name
)
SELECT * FROM ProductRevenue
WHERE product_rank=1;

/*
Query Output:
category        product_name                                                                total_sales product_rank
--------------------------------------------------------------------------------------------------------------------
Furniture	    HON 5400 Series Task Chairs for Big and Tall	                            21870.58	1
Office Supplies	Fellowes PB500 Electric Punch Plastic Comb Binding Machine with Manual Bind	27453.38	1
Technology	    Canon imageCLASS 2200 Advanced Copier	                                    61599.82	1

Key Insights
- Every category has a different revenue-leading product.
- Category leaders contribute significantly to category sales.
- High-performing products should receive additional attention.

Business Recommendation
- Increase inventory for category-leading products.
- Promote them during seasonal campaigns.
- Bundle them with complementary products.
*/



-- ================================================================
-- Business Question 3
-- Running Revenue Trend
-- ================================================================

SELECT order_date,
ROUND(SUM(sales),2) AS daily_sales,
ROUND(SUM(SUM(sales))
OVER(ORDER BY order_date),2) AS running_revenue
FROM superstore
GROUP BY order_date;

/*

Query Output:
(First 10 Rows)
order_date  daily_sales running_revenue
---------------------------------------
2014-01-03	16.45	    16.45
2014-01-04	288.06	    304.51
2014-01-05	19.54	    324.04
2014-01-06	4407.1	    4731.14
2014-01-07	87.16	    4818.3
2014-01-09	40.54	    4858.85
2014-01-10	54.83	    4913.68
2014-01-11	9.94	    4923.62
2014-01-13	3553.8	    8477.41
2014-01-14	61.96	    8539.37
Total Rows Returned : 1237

Key Insights
- Running revenue continuously increases over time.
- It provides cumulative business growth.
- Useful for executive reporting and performance tracking.

Business Recommendation
- Compare cumulative revenue with business targets.
- Monitor revenue growth regularly.
- Use running totals in management dashboards.
*/



-- ================================================================
-- Business Question 4
-- Month-over-Month Sales Growth
-- ================================================================

WITH MonthlySales AS
(SELECT order_year, order_month,
ROUND(SUM(sales),2) sales
FROM superstore
GROUP BY order_year, order_month)
SELECT order_year, order_month, sales,
LAG(sales)
OVER(
ORDER BY order_year, order_month) AS previous_month_sales,
ROUND(
(sales-
LAG(sales)
OVER(
ORDER BY order_year, order_month))/
LAG(sales) OVER(
ORDER BY order_year, order_month)*100,2) AS growth_percentage
FROM MonthlySales;

/*
Query Output:
order_year  order_month sales       previuos_month_sales    growth_percentage 
-----------------------------------------------------------------------------
2014	    1	        14236.89	NULL                    NULL
2014	    2	        4519.89	    14236.89	            -68.25
2014	    3	        55691.01	4519.89	                1132.13
2014	    4	        28295.34	55691.01	            -49.19
2014	    5	        23648.29	28295.34	            -16.42
2014	    6	        34595.13	23648.29	            46.29
2014	    7	        33946.39	34595.13	            -1.88
2014	    8	        27909.47	33946.39	            -17.78
2014	    9	        81777.35	27909.47	            193.01
2014	    10	        31453.39	81777.35	            -61.54
2014	    11	        78628.72	31453.39	            149.98
2014	    12	        69545.62	78628.72	            -11.55
2015	    1	        18174.08	69545.62	            -73.87
2015	    2	        11951.41	18174.08	            -34.24
2015	    3	        38726.25	11951.41	            224.03
2015	    4   	    34195.21	38726.25	            -11.7
2015	    5	        30131.69	34195.21	            -11.88
2015	    6	        24797.29	30131.69	            -17.7
2015	    7	        28765.32	24797.29	            16
2015	    8	        36898.33	28765.32	            28.27
2015	    9	        64595.92	36898.33	            75.06
2015	    10	        31404.92	64595.92	            -51.38
2015	    11	        75972.56	31404.92	            141.91
2015	    12	        74919.52	75972.56	            -1.39
2016	    1	        18542.49	74919.52	            -75.25
2016	    2	        22978.82	18542.49	            23.93
2016	    3	        51715.88	22978.82	            125.06
2016	    4	        38750.04	51715.88	            -25.07
2016	    5	        56987.73	38750.04	            47.06
2016	    6	        40344.53	56987.73	            -29.2
2016	    7	        39261.96	40344.53	            -2.68
2016	    8	        31115.37	39261.96	            -20.75
2016    	9	        73410.02	31115.37	            135.93
2016	    10	        59687.75	73410.02	            -18.69
2016	    11	        79411.97	59687.75	            33.05
2016	    12	        96999.04	79411.97	            22.15
2017	    1	        43971.37	96999.04	            -54.67
2017	    2	        20301.13	43971.37	            -53.83
2017	    3	        58872.35	20301.13	            190
2017	    4	        36521.54	58872.35	            -37.96
2017	    5	        44261.11	36521.54	            21.19
2017	    6	        52981.73	44261.11	            19.7
2017	    7	        45264.42	52981.73	            -14.57
2017    	8	        63120.89	45264.42	            39.45
2017	    9	        87866.65	63120.89	            39.2
2017	    10	        77776.92	87866.65	            -11.48
2017	    11	        118447.83	77776.92	            52.29
2017	    12	        83829.32	118447.83	            -29.23

Key Insights
- Positive growth indicates increasing sales.
- Negative growth indicates declining performance.
- Helps identify seasonal business patterns.

Business Recommendation
- Investigate reasons for declining months.
- Replicate successful strategies from high-growth months.
- Improve forecasting using growth trends.
*/



-- ================================================================
-- Business Question 5
-- Customer Revenue Contribution Percentage
-- ================================================================

SELECT customer_id, customer_name,
ROUND(SUM(sales),2) total_revenue,
ROUND(SUM(sales)/
SUM(SUM(sales))OVER()*100,2)AS revenue_contribution_percentage
FROM superstore
GROUP BY customer_id,customer_name
ORDER BY total_revenue DESC;

/*
Query Output: 
(First 10 Rows)
customer_id customer_name       total_revenue   revenue_contribution_percentage 
------------------------------------------------------------------------------- 
SM-20320	Sean Miller	        25043.05	    1.09
TC-20980	Tamara Chand	    19052.22	    0.83
RB-19360	Raymond Buch	    15117.34	    0.66
TA-21385	Tom Ashbrook	    14595.62	    0.64
AB-10105	Adrian Barton	    14473.57	    0.63
KL-16645	Ken Lonsdale	    14175.23	    0.62
SC-20095	Sanjit Chand	    14142.33	    0.62
HL-15040	Hunter Lopez	    12873.3	        0.56
SE-20110	Sanjit Engle	    12209.44	    0.53
CC-12370	Christopher Conant	12129.07	    0.53
Total Rows Returned : 793

Key Insights
- Customer contribution is not equally distributed.
- A small percentage of customers contributes a significant share
  of total revenue.
- High-value customers play a critical role in business growth.

Business Recommendation
- Prioritize retention of high-contributing customers.
- Develop personalized marketing campaigns.
- Closely monitor customer churn for premium customers.
*/


-- ================================================================
-- Business Question 6
-- Find Customers Who Contribute Around 80% of Total Revenue
-- (Pareto Analysis - 80/20 Rule)
-- ================================================================

WITH customer_sales AS
(
    SELECT customer_id, customer_name, ROUND(SUM(sales),2) AS total_sales
    FROM superstore
    GROUP BY customer_id, customer_name
),

pareto_data AS
(
    SELECT customer_id, customer_name, total_sales,
        SUM(total_sales) OVER(ORDER BY total_sales DESC) AS cumulative_sales,
        SUM(total_sales) OVER() AS overall_sales
    FROM customer_sales
)

SELECT
    customer_id,customer_name,ROUND(total_sales,2) AS total_sales,
    ROUND(cumulative_sales,2) AS cumulative_sales,
    ROUND((cumulative_sales / overall_sales) * 100,2) AS cumulative_percentage
FROM pareto_data
WHERE cumulative_sales <= overall_sales * 0.80;

/*
Query Output:
(First 10 rows)
customer_id customer_name       total_sales cumulative_sales   cumulative_percentage 
SM-20320	Sean Miller	        25043.05	25043.05	        1.09
TC-20980	Tamara Chand	    19052.22	44095.27	        1.92
RB-19360	Raymond Buch	    15117.34	59212.61	        2.58
TA-21385	Tom Ashbrook	    14595.62	73808.23	        3.21
AB-10105	Adrian Barton	    14473.57	88281.8	            3.84
KL-16645	Ken Lonsdale	    14175.23	102457.03	        4.46
SC-20095	Sanjit Chand	    14142.33	116599.36	        5.08
HL-15040	Hunter Lopez	    12873.3	    129472.66	        5.64
SE-20110	Sanjit Engle	    12209.44	141682.1	        6.17
CC-12370	Christopher Conant	12129.07	153811.17	        6.7
Total Records Returned :  395    

Key Insights:
- A small group of customers is responsible for most of the company's revenue.
- These customers are the most valuable for the business.
- Losing even a few of them can have a noticeable impact on sales.

Business Recommendation:
The company should focus on retaining these high-value customers by
offering loyalty benefits, personalized offers, and better customer
service.
*/



-- ================================================================
-- Business Question 7
-- Calculate 3-Month Moving Average of Monthly Revenue
-- ================================================================

WITH monthly_sales AS
(
    SELECT order_year, order_month, ROUND(SUM(sales),2) AS monthly_revenue
    FROM superstore
    GROUP BY order_year, order_month
)

SELECT order_year, order_month,monthly_revenue,

    ROUND(
        AVG(monthly_revenue) OVER(ORDER BY order_year, order_month
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),2) AS moving_average
FROM monthly_sales;

/*
Query Output:
(First 10 rows)
order_year  order_month monthly_revenue moving_average
------------------------------------------------------
2014	    1	        14236.89	    14236.89
2014	    2	        4519.89	        9378.39
2014	    3	        55691.01	    24815.93
2014	    4	        28295.34	    29502.08
2014	    5	        23648.29    	35878.21
2014	    6	        34595.13	    28846.25
2014	    7	        33946.39	    30729.94
2014	    8	        27909.47	    32150.33
2014	    9	        81777.35	    47877.74
2014	    10	        31453.39        47046.74
Total Rows Returned : 48

Key Insights
- The moving average removes short-term ups and downs in sales.
- It makes the overall revenue trend easier to understand.
- This is useful for identifying long-term business performance.

Business Recommendation
The company can use this trend to improve sales forecasting and
inventory planning. It also helps management understand whether
sales are improving or declining over time.
*/



-- ================================================================
-- Business Question 8
-- Perform RFM Analysis
-- (Recency, Frequency and Monetary Value)
-- ================================================================

WITH rfm_data AS
(
    SELECT customer_id, customer_name,

        DATEDIFF(
            (SELECT MAX(order_date) FROM superstore), MAX(order_date)) AS recency,

        COUNT(DISTINCT order_id) AS frequency,ROUND(SUM(sales),2) AS monetary

    FROM superstore

    GROUP BY customer_id,customer_name
)

SELECT * FROM rfm_data
ORDER BY monetary DESC;

/*
Query Output:
(First 10 rows)
customer_id customer_name       recency frequency   monetary
------------------------------------------------------------
SM-20320	Sean Miller	        79	     5	        25043.05
TC-20980	Tamara Chand	    399	     5	        19052.22
RB-19360	Raymond Buch	    96	     6	        15117.34
TA-21385	Tom Ashbrook	    69	     4	        14595.62
AB-10105	Adrian Barton	    41	     10     	14473.57
KL-16645	Ken Lonsdale	    47	     12	        14175.23
SC-20095	Sanjit Chand	    349	     9	        14142.33
HL-15040	Hunter Lopez	    43	     6	        12873.3
SE-20110	Sanjit Engle	    9	     11	        12209.44
CC-12370	Christopher Conant	43	     5	        12129.07
Total Records Returned : 793

Key Insights:
- Customers with low Recency, high Frequency, and high Monetary value
  are the company's most valuable customers.
- Some customers purchase regularly but spend less.
- Others purchase less often but generate high revenue.

Business Recommendation:
The company should reward loyal customers with special offers and
try to bring inactive customers back through targeted marketing
campaigns.
*/



-- ================================================================
-- Business Question 9
-- Find Customers with the Highest Lifetime Value (CLV)
-- ================================================================

SELECT customer_id, customer_name,
COUNT(DISTINCT order_id) AS total_orders,
ROUND(SUM(sales),2) AS lifetime_revenue,
ROUND(AVG(sales),2) AS average_order_value

FROM superstore

GROUP BY customer_id,customer_name
ORDER BY lifetime_revenue DESC;

/*
Query Output:
(First 10 Rows)
    customer_id customer_name   total_orders    lifetime_revenue    average_order_value
    -----------------------------------------------------------------------------------
	SM-20320	Sean Miller	        5	        25043.05	        1669.54
	TC-20980	Tamara Chand	    5	        19052.22	        1587.68
	RB-19360	Raymond Buch	    6	        15117.34	        839.85
	TA-21385	Tom Ashbrook	    4	        14595.62	        1459.56
	AB-10105	Adrian Barton	    10	        14473.57	        723.68
	KL-16645	Ken Lonsdale	    12	        14175.23	        488.8
	SC-20095	Sanjit Chand	    9	        14142.33	        642.83
	HL-15040	Hunter Lopez	    6	        12873.3	            1170.3
	SE-20110	Sanjit Engle	    11	        12209.44	        642.6
	CC-12370	Christopher Conant	5	        12129.07	        1102.64
Total Records Returned : 793

Key Insights:
- A few customers have generated significantly more revenue than others.
- Customers who place more orders usually have higher lifetime value.
- These customers are very important for long-term business growth.

Business Recommendation:
The company should focus on retaining these customers through
exclusive offers, loyalty programs, and personalized communication.
Keeping high-value customers is usually more profitable than
acquiring new ones.
*/



-- ================================================================
-- Business Question 10
-- Rank Products Based on Profit Margin
-- ================================================================

SELECT product_name,
ROUND(SUM(sales),2) AS total_sales, ROUND(SUM(profit),2) AS total_profit,

    ROUND(
        (SUM(profit) / SUM(sales)) * 100,2) AS profit_margin_percentage,

    DENSE_RANK() OVER(ORDER BY (SUM(profit) / SUM(sales)) DESC) AS profit_margin_rank

FROM superstore
GROUP BY product_name
ORDER BY profit_margin_rank;

/*
Query Output:   
(First 10 Rows)
    product_name                                                                            total_sales total_profit  profit_margin_percentage profit_margin_rank
    --------------------------------------------------------------------------------------------------------------------------------------------------------------    
    Adams Telephone Message Book w/Frequently-Called Numbers Space, 400 Messages per Book	223.44	    111.72	      50	                    1
    Canon imageCLASS MF7460 Monochrome Digital Laser Multifunction Copier	                3991.98	    1995.99	      50	                    1
    Southworth Structures Collection	                                                    72.8	    36.4	      50	                    1
    Tops Green Bar Computer Printout Paper	                                                342.58	    171.29	      50	                    1
    Xerox 1890	                                                                            244.7	    122.35	      50	                    1
    Avery 475	                                                                            266.4	    133.2	      50	                    1
    Xerox 1987	                                                                            92.48	    45.32	      49	                    2
    Personal Creations Ink Jet Cards and Labels	                                            321.44	    157.51	      49	                    2
    Xerox 1918	                                                                            155.04	    75.97	      49	                    2
    Avery 5	                                                                                5.76	    2.82	      49	                    2
Total Records Returned : 1850

Key Insights:
- Products with higher sales do not always have higher profit margins.
- Some products generate less revenue but provide better profitability.
- Profit margin is an important metric for evaluating product performance.

Business Recommendation:
The company should promote products with strong profit margins while
reviewing the pricing or discount strategy of low-margin products.
This can help improve overall profitability.
*/



/*
====================================================================

Module Summary

Queries Covered:
1. Top 5 Customers by Revenue in Each Region
2. Highest Revenue Product in Every Category
3. Running Revenue Trend
4. Month-over-Month Sales Growth
5. Customer Revenue Contribution Percentage
6. Pareto Analysis (80/20 Rule)
7. 3-Month Moving Average
8. RFM Analysis
9. Customer Lifetime Value (CLV)
10. Product Profit Margin Ranking

SQL Concepts Used:
- Common Table Expressions (CTEs)
- Window Functions
- ROW_NUMBER()
- RANK()
- DENSE_RANK()
- LAG()
- Aggregate Functions
- Running Total
- Moving Average
- Date Functions
- Customer Segmentation

What I Learned:
- How to solve real business problems using SQL.
- How to use Window Functions for advanced analysis.
- How to identify valuable customers using RFM and CLV.
- How to analyze revenue trends and product profitability.
- How SQL can be used to generate business insights instead of
  simply retrieving data.

====================================================================
*/