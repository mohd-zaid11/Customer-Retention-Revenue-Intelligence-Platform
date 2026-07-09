/*
====================================================================
Project  : Customer Retention & Revenue Intelligence Platform
Module   : Product Analysis
Author   : Mohd Zaid Bin Haneef

Description:
This module analyzes product performance, category-wise sales,
profitability, discount impact, and identifies products that
need business attention.
====================================================================
*/

USE customer_retention_db;

-- ================================================================
-- Business Question 1
-- Which are the Top 10 best-selling products?
-- ================================================================

SELECT
    product_name,
    ROUND(SUM(sales),2) AS total_sales
FROM superstore
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;

/*
Query Output:
product_name                                                                total_sales
----------------------------------------------------------------------------------------
Canon imageCLASS 2200 Advanced Copier	                                    61599.82
Fellowes PB500 Electric Punch Plastic Comb Binding Machine with Manual Bind	27453.38
Cisco TelePresence System EX90 Videoconferencing Unit	                    22638.48
HON 5400 Series Task Chairs for Big and Tall	                            21870.58
GBC DocuBind TL300 Electric Binding System	                                19823.48
GBC Ibimaster 500 Manual ProClick Binding System	                        19024.5
Hewlett Packard LaserJet 3310 Copier	                                    18839.69
HP Designjet T520 Inkjet Large Format Printer - 24" Color	                18374.9
GBC DocuBind P400 Electric Binding System	                                17965.07
High Speed Automatic Electric Letter Opener	                                17030.31

Key Insights:
- The listed products generate the highest sales.
- These products are the company's top revenue drivers.
- Maintaining their availability is important.

Business Recommendation:
- Keep these products well-stocked.
- Use them in promotional campaigns.
- Avoid stock shortages.

*/


-- ================================================================
-- Business Question 2
-- Which are the Top 10 most profitable products?
-- ================================================================

SELECT
    product_name,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY product_name
ORDER BY total_profit DESC
LIMIT 10;

/*
Query Output:
product_name                                                                total_profit
-----------------------------------------------------------------------------------------
Canon imageCLASS 2200 Advanced Copier	                                    25199.93
Fellowes PB500 Electric Punch Plastic Comb Binding Machine with Manual Bind	7753.04
Hewlett Packard LaserJet 3310 Copier	                                    6983.88
Canon PC1060 Personal Laser Copier	                                        4570.93
HP Designjet T520 Inkjet Large Format Printer - 24" Color	                4094.98
Ativa V4110MDD Micro-Cut Shredder	                                        3772.95
3D Systems Cube Printer, 2nd Generation, Magenta	                        3717.97
Plantronics Savi W720 Multi-Device Wireless Headset System	                3696.28
Ibico EPK-21 Electric Binding System	                                    3345.28
Zebra ZM400 Thermal Label Printer	                                        3343.54

Key Insights:
- These products generate the highest profit.
- High-profit products are not always the highest-selling products.
- Profitability is more important than sales alone.

Business Recommendation:
- Promote these products aggressively.
- Increase inventory for high-profit products.
- Focus marketing campaigns around these products.

*/


-- ================================================================
-- Business Question 3
-- Which product categories generate the highest revenue?
-- ================================================================

SELECT
    category,
    ROUND(SUM(sales),2) AS total_sales
FROM superstore
GROUP BY category
ORDER BY total_sales DESC;

/*
Query Output:
category        total_sales
----------------------------
Technology	    836154.03
Furniture	    741999.8
Office Supplies	719047.03

Key Insights:
- Different product categories contribute differently to total sales.
- The highest-selling category is the major revenue contributor.

Business Recommendation:
- Allocate higher marketing budgets to strong-performing categories.
- Improve sales strategies for weaker categories.

*/


-- ================================================================
-- Business Question 4
-- Which sub-categories generate the highest profit?
-- ================================================================

SELECT
    sub_category,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY sub_category
ORDER BY total_profit DESC;

/*
Query Output:
sub_category total_profit
--------------------------
Copiers	     55617.82
Phones	     44515.73
Accessories	 41936.64
Paper	     34053.57
Binders	     30221.76
Chairs	     26590.17
Storage	     21278.83
Appliances	 18138.01
Furnishings	 13059.14
Envelopes	 6964.18
Art	         6527.79
Labels	     5546.25
Machines	 3384.76
Fasteners	 949.52
Supplies    -1189.1
Bookcases	-3472.56
Tables	    -17725.48

Key Insights:
- Some sub-categories are significantly more profitable than others.
- Profitability varies within the same category.

Business Recommendation:
- Increase focus on high-profit sub-categories.
- Review pricing strategy for low-profit sub-categories.

Interview Explanation:
Sub-category analysis provides more detailed insights than category-level analysis.
*/

-- ================================================================
-- Business Question 5
-- Does discount affect overall profitability?
-- ================================================================

SELECT
    discount,
    COUNT(*) AS total_orders,
    ROUND(AVG(profit),2) AS average_profit
FROM superstore
GROUP BY discount
ORDER BY discount;

/*
Query Output:
discount total_orders average_profit
------------------------------------
0	     4798	      66.9
0.1	     94	          96.06
0.15	 52	          27.29
0.2	     3657	      24.7
0.3	     227	     -45.68
0.32	 27	         -88.56
0.4	     206	     -111.93
0.45	 11	         -226.65
0.5	     66	         -310.7
0.6	     138	     -43.08
0.7	     418	     -95.87
0.8	     300	     -101.8

Key Insights:
- Profit generally changes with different discount levels.
- High discounts may reduce average profit.

Business Recommendation:
- Avoid excessive discounts unless they increase long-term customer value.
- Review discount policies regularly.

*/


-- ================================================================
-- Business Question 6
-- Which products generate high sales but low profit?
-- ================================================================

SELECT
    product_name,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY product_name
HAVING SUM(sales) >
(
    SELECT AVG(product_sales)
    FROM
    (
        SELECT SUM(sales) AS product_sales
        FROM superstore
        GROUP BY product_name
    ) AS avg_sales
)
ORDER BY total_profit ASC
LIMIT 10;

/*
Query Output:
product_name                                                        total_sales  total_profit
---------------------------------------------------------------------------------------------
Cubify CubeX 3D Printer Double Head Print	                        11099.96	-8879.97
Lexmark MX611dhe Monochrome Laser Printer	                        16829.9	    -4589.97
Cubify CubeX 3D Printer Triple Head Print	                        7999.98	    -3839.99
Chromcraft Bull-Nose Wood Oval Conference Tables & Bases	        9917.64	    -2876.12
Bush Advantage Collection Racetrack Conference Table	            9544.72	    -1934.4
GBC DocuBind P400 Electric Binding System	                        17965.07	-1878.17
Cisco TelePresence System EX90 Videoconferencing Unit	            22638.48	-1811.08
Martin Yale Chadless Opener Electric Letter Opener	                16656.2	    -1299.18
Balt Solid Wood Round Tables	                                    6518.75	    -1201.06
BoxOffice By Design Rectangular and Half-Moon Meeting Room Tables	1706.25	    -1148.44

Key Insights:
- These products generate strong revenue but poor profitability.
- High discounts or low margins may be affecting profits.
- Revenue alone should not determine product performance.

Business Recommendation:
- Review pricing and discount strategy.
- Increase margins where possible.
- Promote alternative high-margin products.

*/


-- ================================================================
-- Business Question 7
-- Which products are sold most frequently?
-- ================================================================

SELECT
    product_name,
    COUNT(order_id) AS purchase_frequency
FROM superstore
GROUP BY product_name
ORDER BY purchase_frequency DESC
LIMIT 10;

/*
Query Output:
product_name                                purchase_frequency
--------------------------------------------------------------
Staple envelope	                            48
Staples	                                    46
Easy-staple paper	                        46
Avery Non-Stick Binders	                    20
Staples in misc. colors	                    19
KI Adjustable-Height Table	                18
Staple remover	                            18
Storex Dura Pro Binders	                    17
Staple-based wall hangings	                16
Situations Contoured Folding Chairs, 4/Set	15

Key Insights:
- These are the products purchased most frequently.
- Frequently purchased products indicate consistent customer demand.

Business Recommendation:
- Ensure continuous stock availability.
- Bundle these products with complementary items.
- Use them for customer retention campaigns.

*/


-- ================================================================
-- Business Question 8
-- Which products should the company review or discontinue?
-- ================================================================

SELECT
    product_name,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit,
    COUNT(order_id) AS purchase_frequency
FROM superstore
GROUP BY product_name
HAVING
    SUM(sales) <
    (
        SELECT AVG(product_sales)
        FROM
        (
            SELECT SUM(sales) AS product_sales
            FROM superstore
            GROUP BY product_name
        ) AS avg_sales
    )
AND
    SUM(profit) <
    (
        SELECT AVG(product_profit)
        FROM
        (
            SELECT SUM(profit) AS product_profit
            FROM superstore
            GROUP BY product_name
        ) AS avg_profit
    )
ORDER BY total_sales ASC
LIMIT 10;

/*
Query Output:
product_name                                                        total_sales  total_profit  purchase_frequency
-----------------------------------------------------------------------------------------------------------------
Eureka Disposable Bags for Sanitaire Vibra Groomer I Upright Vac	1.62	    -4.47	        1
Avery 5	                                                            5.76	     2.82	        1
Xerox 20	                                                        6.48	     3.11	        1
Grip Seal Envelopes	                                                7.07	     2.39	        1
Avery Hi-Liter Pen Style Six-Color Fluorescent Set	                7.7	         3.16	        1
Avery Hi-Liter Comfort Grip Fluorescent Highlighter, Yellow Ink	    7.8	         3.04	        2
Xerox 1989	                                                        7.97	     2.69	        1
4009 Highlighters	                                                8.04	     2.73	        1
Stockwell Gold Paper Clips	                                        8.1	         3.4	        2
Newell 308	                                                        8.4	         2.1	        2

Key Insights:
- These products generate below-average sales and below-average profit.
- They contribute very little to overall business performance.
- Such products may be increasing inventory and storage costs.

Business Recommendation:
- Review the pricing and demand for these products.
- Consider replacing them with better-performing alternatives.
- If business value remains low, evaluate whether they should be discontinued.

Interview Explanation:
This analysis helps identify underperforming products so the company can optimize its product portfolio, reduce inventory costs, and improve overall profitability.
*/



/*
====================================================================

Module Summary

Key Findings:
- Top-selling products are not always the most profitable.
- Product profitability varies significantly across sub-categories.
- Higher discounts can reduce overall profitability.
- Some products generate high sales but low profit.
- Frequently purchased products indicate stable customer demand.

Business Impact:
- Improves inventory planning.
- Supports pricing and discount decisions.
- Helps maximize product profitability.
- Enables better product portfolio management.
- Assists marketing teams in product promotions.

====================================================================
*/