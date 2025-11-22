CREATE DATABASE BanggoodDB;
import pyodbc

select * from [dbo].[BanggoodProducts];

SELECT 
    category,
    AVG(Price) AS avg_price
FROM BanggoodProducts
GROUP BY category;


SELECT 
    category,
    AVG(product_score) AS avg_rating
FROM BanggoodProducts
GROUP BY category;


SELECT 
    category,
    COUNT(*) AS product_count
FROM BanggoodProducts
GROUP BY category;


WITH RankedReviews AS (
    SELECT
        category,
        product_name,
        product_review_count,
        ROW_NUMBER() OVER(PARTITION BY category ORDER BY product_review_count DESC) AS rn
    FROM BanggoodProducts
)
SELECT category, product_name, product_review_count
FROM RankedReviews
WHERE rn <= 5
ORDER BY category, product_review_count DESC;



SELECT 
    category,
    COUNT(*) AS total_products,
    SUM(CAST(Stock AS INT)) AS in_stock,
    SUM(CAST(1 - Stock AS INT)) AS out_of_stock,
    CAST(SUM(CAST(Stock AS INT)) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS in_stock_percentage,
    CAST(SUM(CAST(1 - Stock AS INT)) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS out_of_stock_percentage
FROM BanggoodProducts
GROUP BY category;
