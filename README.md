# Hackatonnight
Case Study Exam: Banggood Product Data Pipeline &amp; Analysis
   ┌──────────────┐
   │ Banggood.com │
   └──────┬───────┘
          │ Web Scraping (requests / Selenium / BeautifulSoup)
          ▼
   ┌──────────────┐
   │ CSV Storage  │
   │ banggood_5categories.csv │
   └──────┬───────┘
          │ Data Cleaning & Feature Engineering (Python & Pandas)
          ▼
   ┌──────────────┐
   │ DataFrame    │
   │ + Derived Features (Value_Metric, Reviews_per_Pound)
   └──────┬───────┘
          │ Load into SQL Server (pyodbc)
          ▼
   ┌──────────────┐
   │ SQL Server   │
   │ BanggoodDB   │
   │ Table:      │
   │ BanggoodProducts │
   └──────┬───────┘
          │ Python & SQL Analysis
          ▼
   ┌──────────────┐
   │ Insights &   │
   │ Visualizations│
   └──────────────┘
# Banggood Product Data Pipeline & Analysis

## Overview
This project demonstrates a complete data pipeline for analyzing product trends on [Banggood.com](https://www.banggood.com). The pipeline involves scraping product data from multiple categories, cleaning and transforming the data, performing exploratory analysis using Python, storing data in SQL Server, and running aggregated SQL queries to derive actionable insights.

The goal is to provide a structured workflow for understanding product trends, stock availability, pricing, and customer reviews across selected categories.

---

## Project Structure

---

## Scraping Methodology
- **Categories Selected:** Example categories include:
  - Bluetooth Accessories  
  - Smart Home Devices  
  - Wireless Speakers  
  - Car Gadgets  
  - Wearable Tech  
- **Libraries Used:**  
  - `requests` + `BeautifulSoup` for static pages  
  - `Selenium` for dynamic pages and pagination  
- **Data Collected per Product:**  
  - `product_name`  
  - `Price`  
  - `product_score` (Rating)  
  - `product_review_count`  
  - `product_url`  
- **Pagination:** Multiple pages scraped per category to ensure a comprehensive dataset.

---

## Data Cleaning & Transformation
- Convert price strings (e.g., "£23.22") to numeric values.  
- Fill missing values for `product_score` and `product_review_count` with `0`.  
- Add derived features:
  - `Value_Metric = product_score / Price` (Rating per pound)  
  - `Reviews_per_Pound = product_review_count / Price` (Popularity per pound)  
- Add `Stock` column if missing: `0 = Out of Stock`, `1 = In Stock`.  
- Ensure `category` column exists for aggregation and analysis.

---

## Python Exploratory Analysis
The project includes at least five analyses using Python and visualization libraries (`matplotlib`, `seaborn`):
1. **Price distribution per category** – Boxplots to visualize spread and outliers.  
2. **Rating vs Price correlation** – Scatterplots showing relationships.  
3. **Top 5 reviewed products** – Highlighting most popular products.  
4. **Best value product per category** – Highest rating per pound metric.  
5. **Stock availability analysis** – Percentage of in-stock vs out-of-stock products.

---

## SQL Server Integration
- Create a unified table: `BanggoodProducts`.  
- Columns include: `category`, `product_name`, `Price`, `product_score`, `product_review_count`, `product_url`, `Stock`.  
- Load cleaned data into SQL Server using `pyodbc`.  
- Validate data by querying row counts per table.

---

## SQL Aggregated Analysis
Examples of aggregated insights that can be extracted:

- **Average price per category**
```sql
SELECT category, AVG(Price) AS avg_price
FROM BanggoodProducts
GROUP BY category;
