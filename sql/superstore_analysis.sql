-- 1. Sales and profit by region
SELECT Region, ROUND(SUM(Sales),0) AS sales, ROUND(SUM(Profit),0) AS profit,
       ROUND(100*SUM(Profit)/SUM(Sales),1) AS margin_pct
FROM sales GROUP BY Region ORDER BY sales DESC;

-- 2. Category and sub-category profitability
SELECT Category, SubCategory, ROUND(SUM(Sales),0) AS sales, ROUND(SUM(Profit),0) AS profit
FROM sales GROUP BY Category, SubCategory ORDER BY profit;

-- 3. Month-over-month sales growth (CTE + LAG)
WITH monthly AS (
  SELECT Year, Month, ROUND(SUM(Sales),0) AS sales
  FROM sales GROUP BY Year, Month
)
SELECT Year, Month, sales,
       LAG(sales) OVER (ORDER BY Year, Month) AS prev_sales,
       ROUND(100*(sales - LAG(sales) OVER (ORDER BY Year, Month))
             / LAG(sales) OVER (ORDER BY Year, Month), 1) AS growth_pct
FROM monthly ORDER BY Year, Month;

-- 4. Top 10 customers by sales
SELECT CustomerName, ROUND(SUM(Sales),0) AS sales, ROUND(SUM(Profit),0) AS profit
FROM sales GROUP BY CustomerName ORDER BY sales DESC LIMIT 10;

-- 5. Profit by discount band
SELECT CASE WHEN Discount = 0 THEN '0%'
            WHEN Discount <= 0.2 THEN '1-20%'
            WHEN Discount <= 0.4 THEN '21-40%'
            ELSE '40%+' END AS discount_band,
       COUNT(*) AS orders, ROUND(SUM(Profit),0) AS profit
FROM sales GROUP BY discount_band ORDER BY profit DESC;

-- 6. Top 3 sub-categories by profit in each region
WITH ranked AS (
  SELECT Region, SubCategory, ROUND(SUM(Profit),0) AS profit,
         RANK() OVER (PARTITION BY Region ORDER BY SUM(Profit) DESC) AS rnk
  FROM sales GROUP BY Region, SubCategory
)
SELECT * FROM ranked WHERE rnk <= 3 ORDER BY Region, rnk;