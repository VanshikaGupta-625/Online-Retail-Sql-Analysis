# Online-Retail-Sql-Analysis
​📊 Unlocking retail insights with SQL! End-to-end data analysis covering customer segmentation, market basket patterns, and sales performance trends.

## 📌 Project Overview
In this project, I performed an end-to-end data analysis on an **Online Retail Transaction Dataset** using **SQLite**. 

The main goal was to analyze customer purchasing behavior, find top-performing products, calculate overall revenue metrics, and discover sales trends to help a retail store make better business decisions.

---

## 🛠️ Tools & Technologies Used
- **Database Tool:** SQLite (via sqliteonline.com)
- **Language:** SQL
- **Key Concepts Learned & Used:** 
  - Data Cleaning (`WHERE` clause, `CAST`)
  - Aggregations (`SUM`, `AVG`, `COUNT`)
  - Data Grouping & Filtering (`GROUP BY`, `HAVING`)
  - Advanced Subqueries & Self-JOINs
  - Date & Text Formatting (`SUBSTR`)

---

## 🔍 What I Did & How I Did It (Step-by-Step Analysis)

### 1. Data Cleaning
- **What I Did:** Filtered out bad data entries like negative order quantities or zero unit prices.
- **How I Did It:** Used `WHERE CAST(c4 AS NUMERIC) > 0 AND CAST(c6 AS NUMERIC) > 0` to keep only valid purchase records.

### 2. Identifying Top 5 Spenders
- **What I Did:** Calculated total spending per customer to find our highest-value clients.
- **How I Did It:** Used `SUM(Quantity * UnitPrice)`, grouped by `Customer_ID`, sorted in descending order, and limited the output to 5 records.

### 3. Product Pairing Analysis (Market Basket Analysis)
- **What I Did:** Found products that customers frequently buy together in the same order.
- **How I Did It:** Used a **Self-JOIN** on the transaction table matching on the same Invoice ID (`c1`) with non-matching Item Codes (`c3`).

### 4. High-Value Customer Filtering
- **What I Did:** Filtered customers whose overall spending was greater than the store's average customer spend.
- **How I Did It:** Wrote a nested **Subquery** inside a `HAVING` clause to compare individual customer spending against the global average.

### 5. Overall Store Performance Summary
- **What I Did:** Summarized key performance metrics for the entire business.
- **How I Did It:** Calculated `Total Revenue`, `Average Order Value`, and `Total Unique Orders` using aggregate functions.

### 6. Monthly Sales Trend Analysis
- **What I Did:** Tracked month-by-month sales performance to identify sales growth over time.
- **How I Did It:** Used `SUBSTR(c5, 1, 7)` to extract the Year-Month format and grouped order counts and total revenue per month (Top 10 months).

### 7. Top 10 Revenue-Generating Products
- **What I Did:** Found the best-selling inventory items based on revenue generated.
- **How I Did It:** Grouped items by description, summed quantity and revenue, and sorted descending with `LIMIT 10`.

### 8. Geographical Revenue Split (Country-wise)
- **What I Did:** Analyzed sales distribution across different global markets.
- **How I Did It:** Grouped valid sales transactions by Country (`c8`) to see top revenue-contributing countries (Top 10).

---

## 📁 Repository Structure
- `queries.sql` - Complete SQL script containing all 8 analysis steps.
- `README.md` - Complete project documentation and step-wise explanation.
- `/screenshots` - Execution results and visual proof for each query.
