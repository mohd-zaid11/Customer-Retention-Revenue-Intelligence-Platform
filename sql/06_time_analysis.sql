/*
====================================================================
Project  : Customer Retention & Revenue Intelligence Platform
Module   : Time Analysis
Author   : Mohd Zaid Bin Haneef

Description:
This module analyzes sales and profit trends over time to identify
seasonality, growth patterns, and operational performance.
====================================================================
*/

USE customer_retention_db;

-- ================================================================
-- Business Question 1
-- What is the monthly revenue trend?
-- ================================================================

SELECT
    order_year,
    order_month_name,
    ROUND(SUM(sales),2) AS total_revenue
FROM superstore
GROUP BY order_year, order_month, order_month_name
ORDER BY order_year, order_month;

/*
Query Output:
order_year  order_month_name    total_revenue
---------------------------------------------
2014	    January	            14236.89
2014	    February	        4519.89
2014	    March	            55691.01
2014	    April	            28295.34
2014	    May	                23648.29
2014	    June	            34595.13
2014	    August	            27909.47
2014	    July	            33946.39
2014	    September	        81777.35
2014	    October	            31453.39
2014	    November	        78628.72
2014	    December	        69545.62
2015	    January	            18174.08
2015	    February	        11951.41
2015	    March	            38726.25
2015	    April	            34195.21
2015	    May	                30131.69
2015	    June	            24797.29
2015	    July	            28765.32
2015	    August	            36898.33
2015	    September	        64595.92
2015	    October	            31404.92
2015	    November	        75972.56
2015	    December	        74919.52
2016	    January	            18542.49
2016	    February	        22978.82
2016	    March	            51715.88
2016	    April	            38750.04
2016	    May	                56987.73
2016	    June	            40344.53
2016	    July	            39261.96
2016	    August	            31115.37
2016	    September	        73410.02
2016	    October	            59687.75
2016	    November	        79411.97
2016	    December	        96999.04
2017	    January	            43971.37
2017	    February	        20301.13
2017	    March	            58872.35
2017	    April	            36521.54
2017	    May	                44261.11
2017	    June	            52981.73
2017	    July	            45264.42
2017	    August	            63120.89
2017	    September	        87866.65
2017	    October	            77776.92
2017	    November	        118447.83
2017	    December	        83829.32

Key Insights:
- Monthly revenue fluctuates throughout the year.
- Peak months indicate periods of high customer demand.
- Low-performing months may require promotional campaigns.

Business Recommendation:
- Plan inventory and marketing based on seasonal demand.
- Launch campaigns during slower months to improve sales.
*/


-- ================================================================
-- Business Question 2
-- What is the monthly profit trend?
-- ================================================================

SELECT
    order_year,
    order_month_name,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY order_year, order_month, order_month_name
ORDER BY order_year, order_month;

/*
Query Output:
order_year  order_month_name    total_profit
--------------------------------------------
2014	    January	            2450.19
2014	    February	        862.31
2014	    March	            498.73
2014	    April	            3488.84
2014	    May	                2738.71
2014	    June	            4976.52
2014	    July	            -841.48
2014	    August	            5318.1
2014	    September	        8328.1
2014	    October	            3448.26
2014	    November	        9292.13
2014	    December	        8983.57
2015	    January	            -3281.01
2015	    February	        2813.85
2015	    March	            9732.1
2015	    April	            4187.5
2015	    May	                4667.87
2015	    June	            3335.56
2015	    July	            3288.65
2015	    August	            5355.81
2015	    September	        8209.16
2015	    October	            2817.37
2015	    November	        12474.79
2015	    December	        8016.97
2016	    January	            2824.82
2016	    February	        5004.58
2016	    March	            3611.97
2016	    April	            2977.81
2016	    May	                8662.15
2016	    June	            4750.38
2016	    July	            4432.88
2016	    August	            2062.07
2016	    September	        9328.66
2016	    October	            16243.14
2016	    November	        4011.41
2016	    December	        17885.31
2017	    January	            7140.44
2017	    February	        1613.87
2017	    March	            14751.89
2017	    April	            933.29
2017	    May	                6342.58
2017	    June	            8223.34
2017	    July	            6952.62
2017	    August	            9040.96
2017	    September	        10991.56
2017	    October	            9275.28
2017	    November        	9690.1
2017	    December	        8483.35

Key Insights:
- Profit trends may differ from revenue trends.
- High sales months do not always generate the highest profit.

Business Recommendation:
- Focus on improving profit margins during high-sales periods.
- Review pricing and discounts in low-profit months.
*/


-- ================================================================
-- Business Question 3
-- Which quarter generates the highest revenue?
-- ================================================================

SELECT
    order_year,
    order_quarter,
    ROUND(SUM(sales),2) AS total_revenue
FROM superstore
GROUP BY order_year, order_quarter
ORDER BY total_revenue DESC;

/*
Query Output:
order_year  order_quarter   total_revenue
-----------------------------------------
2017	    4	            280054.07
2016	    4	            236098.75
2017	    3	            196251.96
2015	    4	            182297.01
2014	    4	            179627.73
2016	    3	            143787.36
2014	    3	            143633.21
2016	    2	            136082.3
2017	    2	            133764.37
2015	    3	            130259.58
2017	    1	            123144.86
2016	    1	            93237.18
2015	    2	            89124.19
2014	    2	            86538.76
2014	    1	            74447.8
2015	    1	            68851.74

Key Insights:
- Some quarters consistently outperform others.
- Seasonal demand significantly impacts quarterly sales.

Business Recommendation:
- Increase inventory before high-performing quarters.
- Plan promotional campaigns ahead of peak seasons.
*/


-- ================================================================
-- Business Question 4
-- Which month records the highest and lowest sales?
-- ================================================================

SELECT
    order_month_name,
    ROUND(SUM(sales),2) AS total_sales
FROM superstore
GROUP BY order_month, order_month_name
ORDER BY total_sales DESC;

/*
Query Output:
order_month_name    total_sales
--------------------------------
November	        352461.07
December	        325293.5
September	        307649.95
March	            205005.49
October	            200322.98
August	            159044.06
May	                155028.81
June	            152718.68
July            	147238.1
April	            137762.13
January	            94924.84
February	        59751.25

Key Insights:
- Sales performance varies across months.
- Identifying the strongest and weakest months supports planning.

Business Recommendation:
- Replicate successful strategies from top-performing months.
- Improve promotions during weaker months.
*/


-- ================================================================
-- Business Question 5
-- What is the average shipping time by ship mode?
-- ================================================================

SELECT
    ship_mode,
    ROUND(AVG(shipping_days),2) AS average_shipping_days
FROM superstore
GROUP BY ship_mode
ORDER BY average_shipping_days;

/*
Query Output:
ship_mode       average_shipping_days
-------------------------------------
Same Day	    0.04
First Class	    2.18
Second Class	3.24
Standard Class	5.01

Key Insights:
- Different shipping modes have different delivery times.
- Faster shipping improves customer satisfaction.

Business Recommendation:
- Optimize slower shipping methods.
- Encourage customers to use efficient shipping options.
*/


-- ================================================================
-- Business Question 6
-- Which year generated the highest revenue and profit?
-- ================================================================

SELECT
    order_year,
    ROUND(SUM(sales),2) AS total_revenue,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY order_year
ORDER BY total_revenue DESC;

/*
Query Output:
order_year  total_revenue   total_profit
----------------------------------------
2017	    733215.26   	93439.27
2016	    609205.6	    81795.17
2014	    484247.5	    49543.97
2015	    470532.51   	61618.6

Key Insights:
- Business performance changes over the years.
- Growth trends indicate overall business expansion.

Business Recommendation:
- Analyze successful years and replicate effective strategies.
- Investigate reasons for weaker years.
*/


-- ================================================================
-- Business Question 7
-- What is the monthly average order value?
-- ================================================================

SELECT
    order_year,
    order_month_name,
    ROUND(SUM(sales)/COUNT(DISTINCT order_id),2) AS average_order_value
FROM superstore
GROUP BY order_year, order_month, order_month_name
ORDER BY order_year, order_month;

/*
Query Output:
order_year  order_month_year    average_order_value
---------------------------------------------------
2014	    January	            444.9
2014	    February	        161.42
2014	    March	            784.38
2014	    April	            428.72
2014	    May	                342.73
2014	    June	            524.17
2014	    July	            522.25
2014	    August	            387.63
2014	    September	        629.06
2014	    October	            403.25
2014	    November	        520.72
2014	    December	        493.23
2015	    January	            626.69
2015	    February	        331.98
2015	    March	            490.21
2015	    April	            474.93
2015	    May	                407.18
2015	    June	            364.67
2015	    July	            435.84
2015	    August	            542.62
2015	    September	        461.4
2015	    October	            360.98
2015	    November	        480.84
2015	    December	        465.34
2016	    January	            386.3
2016	    February	        510.64
2016	    March	            601.35
2016	    April	            435.39
2016	    May	                527.66
2016	    June	            415.92
2016	    July	            408.98
2016	    August	            345.73
2016	    September	        382.34
2016	    October	            568.45
2016	    November	        433.95
2016	    December	        551.13
2017	    January	            637.27
2017	    February	        383.04
2017	    March	            498.92
2017	    April	            314.84
2017	    May	                375.09
2017	    June	            398.36
2017	    July	            407.79
2017	    August	            568.66
2017	    September	        388.79
2017	    October	            529.09
2017	    November	        453.82
2017	    December	        374.24

Key Insights:
- Average Order Value (AOV) varies each month.
- Higher AOV indicates customers spend more per transaction.

Business Recommendation:
- Increase AOV using cross-selling and bundle offers.
- Study successful months to improve future performance.
*/


-- ================================================================
-- Business Question 8
-- Which months have above-average sales?
-- ================================================================

SELECT
    order_year,
    order_month_name,
    ROUND(SUM(sales),2) AS total_sales
FROM superstore
GROUP BY order_year, order_month, order_month_name
HAVING SUM(sales) >
(
    SELECT AVG(monthly_sales)
    FROM
    (
        SELECT SUM(sales) AS monthly_sales
        FROM superstore
        GROUP BY order_year, order_month
    ) AS avg_sales
)
ORDER BY total_sales DESC;

/*
Query Output:
order_year  order_month_name    total_sale
------------------------------------------
2017	    November	        118447.83
2016	    December	        96999.04
2017	    September	        87866.65
2017	    December	        83829.32
2014	    September	        81777.35
2016	    November	        79411.97
2014	    November	        78628.72
2017	    October	            77776.92
2015	    November	        75972.56
2015	    December	        74919.52
2016	    September	        73410.02
2014	    December	        69545.62
2015	    September	        64595.92
2017	    August	            63120.89
2016	    October	            59687.75
2017	    March	            58872.35
2016	    May	                56987.73
2014	    March	            55691.01
2017	    June	            52981.73
2016	    March	            51715.88

Key Insights:
- These months outperform the overall monthly average.
- They represent peak business periods.

Business Recommendation:
- Prepare inventory and workforce before peak months.
- Replicate marketing strategies used during these months.
*/


/*
====================================================================

Module Summary

Key Findings:
- Sales and profit fluctuate throughout the year.
- Certain quarters consistently outperform others.
- Monthly trends reveal seasonal demand patterns.
- Shipping performance varies by shipping mode.
- Average Order Value changes across months.
- Above-average months indicate peak business periods.

Business Impact:
- Improves demand forecasting.
- Supports inventory planning.
- Enhances marketing strategy.
- Optimizes logistics.
- Enables data-driven seasonal planning.

====================================================================
*/