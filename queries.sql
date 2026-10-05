

-- Step 1: Cleaning basic data (removing invalid quantity and price)
SELECT * 
FROM data 
WHERE CAST(c4 AS NUMERIC) > 0 
  AND CAST(c6 AS NUMERIC) > 0;


-- Step 2: Top 5 customers who spent the most money 
SELECT 
    c7 AS Customer_ID, 
    ROUND(SUM(CAST(c4 AS NUMERIC) * CAST(c6 AS NUMERIC)), 2) AS Total_Spent
FROM data
WHERE CAST(c4 AS NUMERIC) > 0 
  AND CAST(c6 AS NUMERIC) > 0 
  AND c7 IS NOT NULL 
  AND c7 != ''
GROUP BY c7
ORDER BY Total_Spent DESC
LIMIT 5;


-- Step 3: Products frequently bought together (Self Join)
SELECT 
    A.c3 AS Item_1, 
    B.c3 AS Item_2, 
    COUNT(*) AS Pair_Count
FROM data A
JOIN data B 
    ON A.c1 = B.c1 
   AND A.c3 < B.c3
WHERE CAST(A.c4 AS NUMERIC) > 0 
  AND CAST(B.c4 AS NUMERIC) > 0
GROUP BY Item_1, Item_2
ORDER BY Pair_Count DESC
LIMIT 5;


-- Step 4: Customers spending more than average spend (Subquery)
SELECT 
    c7 AS Customer_ID, 
    ROUND(SUM(CAST(c4 AS NUMERIC) * CAST(c6 AS NUMERIC)), 2) AS Total_Spent
FROM data
WHERE CAST(c4 AS NUMERIC) > 0 
  AND CAST(c6 AS NUMERIC) > 0 
  AND c7 IS NOT NULL 
  AND c7 != ''
GROUP BY c7
HAVING Total_Spent > (
    SELECT AVG(CAST(c4 AS NUMERIC) * CAST(c6 AS NUMERIC)) 
    FROM data 
    WHERE CAST(c4 AS NUMERIC) > 0 AND CAST(c6 AS NUMERIC) > 0
)
ORDER BY Total_Spent DESC;


-- Step 5: Overall summary metrics of the store
SELECT 
    ROUND(SUM(CAST(c4 AS NUMERIC) * CAST(c6 AS NUMERIC)), 2) AS Total_Revenue, 
    ROUND(AVG(CAST(c4 AS NUMERIC) * CAST(c6 AS NUMERIC)), 2) AS Average_Order_Value,
    COUNT(DISTINCT c1) AS Total_Orders
FROM data
WHERE CAST(c4 AS NUMERIC) > 0 
  AND CAST(c6 AS NUMERIC) > 0;


-- Step 6: Monthly sales trend (Top 10 months)
SELECT 
    c5 AS Date, 
    COUNT(DISTINCT c1) AS Total_Orders,
    ROUND(SUM(CAST(c4 AS NUMERIC) * CAST(c6 AS NUMERIC)), 2) AS Revenue
FROM data
WHERE CAST(c4 AS NUMERIC) > 0 
  AND CAST(c6 AS NUMERIC) > 0
GROUP BY Date
ORDER BY Date ASC
LIMIT 10;


-- Step 7: Top 10 selling products by revenue
SELECT 
    c3 AS Product_Name, 
    SUM(CAST(c4 AS NUMERIC)) AS Total_Quantity,
    ROUND(SUM(CAST(c4 AS NUMERIC) * CAST(c6 AS NUMERIC)), 2) AS Total_Revenue
FROM data
WHERE CAST(c4 AS NUMERIC) > 0 
  AND CAST(c6 AS NUMERIC) > 0
GROUP BY c3
ORDER BY Total_Revenue DESC
LIMIT 10;


-- Step 8: Top 10 countries by sales
SELECT 
    c8 AS Country, 
    COUNT(DISTINCT c1) AS Orders_Count,
    ROUND(SUM(CAST(c4 AS NUMERIC) * CAST(c6 AS NUMERIC)), 2) AS Revenue
FROM data
WHERE CAST(c4 AS NUMERIC) > 0 
  AND CAST(c6 AS NUMERIC) > 0 
  AND c8 IS NOT NULL 
  AND c8 != ''
GROUP BY c8
ORDER BY Revenue DESC
LIMIT 10;