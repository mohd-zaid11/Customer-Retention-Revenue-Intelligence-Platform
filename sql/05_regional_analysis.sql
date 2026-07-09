/*
====================================================================
Project  : Customer Retention & Revenue Intelligence Platform
Module   : Regional Analysis
Author   : Mohd Zaid Bin Haneef

Description:
This module analyzes regional business performance by comparing
sales, profit, customer distribution, and identifying
high-performing and underperforming locations.
====================================================================
*/

USE customer_retention_db;

-- ================================================================
-- Business Question 1
-- Which regions generate the highest revenue?
-- ================================================================

SELECT
    region,
    ROUND(SUM(sales),2) AS total_revenue
FROM superstore
GROUP BY region
ORDER BY total_revenue DESC;

/*
Query Output:
region  total_revenue
---------------------
West	725457.82
East	678781.24
Central	501239.89
South	391721.91

Key Insights:
- The highest revenue comes from the top-performing region.
- Revenue contribution varies across regions.
- Lower-performing regions may need additional business focus.

Business Recommendation:
- Continue investing in high-performing regions.
- Analyze customer behavior in low-performing regions and improve marketing efforts.
*/


-- ================================================================
-- Business Question 2
-- Which regions generate the highest profit?
-- ================================================================

SELECT
    region,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY region
ORDER BY total_profit DESC;

/*
Query Output:
region  total_profit
--------------------
West	108418.45
East	91522.78
South	46749.43
Central	39706.36

Key Insights:
- Profitability differs across regions.
- High revenue does not always mean high profit.

Business Recommendation:
- Improve pricing and discount strategies in low-profit regions.
- Study successful regions and replicate their strategy.
*/


-- ================================================================
-- Business Question 3
-- Which states contribute the highest revenue?
-- ================================================================

SELECT
    state,
    ROUND(SUM(sales),2) AS total_revenue
FROM superstore
GROUP BY state
ORDER BY total_revenue DESC
LIMIT 10;

/*
Query Output:
state           total_revenue
-----------------------------
California	    457687.63
New York	    310876.27
Texas	        170188.05
Washington	    138641.27
Pennsylvania	116511.91
Florida	        89473.71
Illinois	    80166.1
Ohio	        78258.14
Michigan	    76269.61
Virginia	    70636.72

Key Insights:
- Top states contribute a major share of company revenue.
- Business performance is concentrated in a few states.

Business Recommendation:
- Increase investments in high-performing states.
- Develop targeted campaigns in lower-performing states.
*/


-- ================================================================
-- Business Question 4
-- Which states generate the highest profit?
-- ================================================================

SELECT
    state,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY state
ORDER BY total_profit DESC
LIMIT 10;

/*
Query Output:
state       total_profit
------------------------
California	76381.39
New York	74038.55
Washington	33402.65
Michigan	24463.19
Virginia	18597.95
Indiana	    18382.94
Georgia	    16250.04
Kentucky	11199.7
Minnesota	10823.19
Delaware	9977.37

Key Insights:
- Some states generate consistently higher profits.
- Profit leaders may differ from revenue leaders.

Business Recommendation:
- Focus on expanding profitable markets.
- Identify factors behind high-performing states.
*/


-- ================================================================
-- Business Question 5
-- Which cities generate the highest revenue?
-- ================================================================

SELECT
    city,
    ROUND(SUM(sales),2) AS total_revenue
FROM superstore
GROUP BY city
ORDER BY total_revenue DESC
LIMIT 10;

/*
Query Output:
city            total_reveune
-----------------------------
New York City	256368.16
Los Angeles	    175851.34
Seattle     	119540.74
San Francisco	112669.09
Philadelphia	109077.01
Houston	        64504.76
Chicago	        48539.54
San Diego	    47521.03
Jacksonville	44713.18
Springfield 	43054.34

Key Insights:
- A small number of cities contribute a large portion of revenue.
- These cities represent key business markets.

Business Recommendation:
- Strengthen customer engagement in top cities.
- Expand operations where demand is consistently high.
*/


-- ================================================================
-- Business Question 6
-- Which cities generate high sales but low profit?
-- ================================================================

SELECT
    city,
    ROUND(SUM(sales),2) AS total_revenue,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY city
HAVING SUM(sales) >
(
    SELECT AVG(city_sales)
    FROM
    (
        SELECT SUM(sales) AS city_sales
        FROM superstore
        GROUP BY city
    ) AS avg_sales
)
ORDER BY total_profit ASC
LIMIT 10;

/*
Query Output:
city            total_revenue   total_profit
--------------------------------------------
Philadelphia	109077.01	    -13837.77
Houston	        64504.76	    -10153.55
San Antonio	    21843.53	    -7299.05
Lancaster	    9891.46	        -7239.07
Chicago	        48539.54	    -6654.57
Burlington	    21668.08	    -3622.88
Dallas	        20131.93	    -2846.53
Phoenix	        11000.26	    -2790.88
Aurora	        11656.48	    -2691.74
Jacksonville	44713.18	    -2323.83

Key Insights:
- These cities generate strong sales but weak profitability.
- High discounts or operational costs may be reducing profits.

Business Recommendation:
- Review pricing and promotional strategies.
- Focus on improving profit margins in these cities.
*/


-- ================================================================
-- Business Question 7
-- Which regions have the highest average order value?
-- ================================================================

SELECT
    region,
    ROUND(SUM(sales) / COUNT(DISTINCT order_id),2) AS average_order_value
FROM superstore
GROUP BY region
ORDER BY average_order_value DESC;

/*
Query Output:
region  average_order_value
---------------------------
East	484.5
South	476.55
West	450.32
Central	426.59

Key Insights:
- Average Order Value (AOV) differs across regions.
- Higher AOV indicates customers spend more per order.

Business Recommendation:
- Increase AOV through cross-selling and bundled offers.
- Apply successful strategies from top regions to others.
*/


/*
====================================================================

Module Summary

Key Findings:
- Business performance varies significantly across regions.
- Some states and cities dominate revenue generation.
- High revenue locations are not always highly profitable.
- Average Order Value differs by region.
- Regional insights support strategic expansion.

Business Impact:
- Improves regional planning.
- Supports marketing budget allocation.
- Identifies profitable growth opportunities.
- Helps optimize pricing strategies.
- Enables data-driven expansion decisions.

====================================================================
*/