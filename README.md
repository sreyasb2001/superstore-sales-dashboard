# Superstore Sales and Profitability Analysis: SQL and Power BI

## Business question
Which regions, product categories and discount levels drive or hurt profit, and where should pricing and discount decisions change?

## Data
- Superstore sample retail dataset (a fictional company), from Kaggle: https://www.kaggle.com/datasets/vivek468/superstore-dataset-final
- 9,994 order lines from 2014 to 2017
- The raw file is not included in this repo. Download it from the Kaggle link above.

## Tools
SQL (MySQL), Power Query, DAX, Power BI, Excel

## What I did
1. Cleaned the data in Power Query: fixed US-format dates with the right locale, set data types, removed duplicates by Row ID, and added ship days, profit margin and date fields.
2. Loaded the data into MySQL through a staging table, converted date formats, and checked that row counts and totals matched the source.
3. Wrote SQL for profitability by region and sub-category, month-over-month growth (LAG), top customers, profit by discount band, and top sub-categories per region (window functions).
4. Built a 2-page Power BI dashboard with DAX measures (Total Sales, Total Profit, Profit Margin %, Total Orders), a discount-band column, slicers and a Key Insights panel.

## Key findings
- Total sales of $2.30M and profit of $286K (12.5% margin) across 5,009 orders.
- West ($725K sales, 14.9% margin) and East ($679K, 13.5%) deliver about 70% of profit. Central has the lowest margin at 7.9%.
- Tables (-$17.7K), Bookcases (-$3.5K) and Supplies (-$1.2K) lose money, about -$22K combined.
- Copiers, Phones and Accessories are the largest profit drivers, and Copiers rank first in Central, East and West.
- Orders with no discount earned about $321K. Orders discounted above 20% lost about $135K combined.
- The top customer by sales lost about $2K, so high revenue does not guarantee profit.
- Recommendation: cap discounts near 20%, review pricing on Tables and Bookcases, and promote the top profit categories.

## Limitations
- The data is a sample dataset, not a real company.
- The link between discounts and losses does not prove cause. Discounts may be concentrated on products that were already unprofitable.

## Challenges and fixes
- Dates were in month/day/year format, so I used a locale setting in Power Query to avoid swapped days and months.
- Product names with quotation marks and special characters broke the first import, so I cleaned them and confirmed 9,994 rows loaded before analyzing.

## Files
- sql/ : table setup and analysis queries
- powerbi/ : Power BI dashboard file
- screenshots/ : dashboard images

## Dashboard preview
![Page 1](superstore-sales-dashboard/screenshots/page1.png)
![Page 2](superstore-sales-dashboard/screenshots/page2.png)
