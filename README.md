# zepto-quick-commerce-casestudy

Zepto E-commerce Inventory Analysis with SQLA comprehensive analysis of an e-commerce inventory dataset from the Indian quick-commerce platform, Zepto. This project uses PostgreSQL to clean, explore, and derive actionable business insights from product and inventory data.📝 Table of ContentsProject OverviewDatasetTools UsedData Cleaning & PreparationExploratory Data Analysis & Key QuestionsSQL Queries ShowcaseHow to ReplicateContact🎯 Project OverviewIn the fast-paced world of quick commerce, effective inventory management is crucial for profitability and customer satisfaction. This project simulates a real-world analyst workflow to dissect an inventory dataset from Zepto. The primary goal is to use SQL to transform raw data into strategic insights, focusing on category performance, pricing strategies, stock availability, and potential revenue opportunities.💾 DatasetThe analysis is based on a single table, zepto, which contains detailed information about each product Stock Keeping Unit (SKU).Database SchemaThe database was structured with the following schema to ensure data integrity and prepare for analysis:CREATE TABLE zepto(
    sku_id SERIAL PRIMARY KEY,
    category VARCHAR(120),
    name VARCHAR(150) NOT NULL,
    mrp NUMERIC(8,2),
    discountPercent NUMERIC(5,2),
    availableQuantity INTEGER,
    discountSellingPrice NUMERIC(8,2),
    weightInGms INTEGER,
    outOfStock BOOLEAN,
    quantity INTEGER
);
🛠️ Tools UsedDatabase: PostgreSQLLanguage: SQL🧼 Data Cleaning & PreparationBefore analysis, the data was cleaned and prepared to ensure accuracy. The key steps included:Checking for Null Values: Ensured that critical columns did not contain any nulls that could skew the analysis.Investigating Duplicate Product Names: Identified products that have multiple SKUs, which could be variations in weight or packaging.Correcting Price Data: The mrp and discountSellingPrice columns were initially in paise. An UPDATE query was run to convert these values into rupees for accurate financial calculations.-- Converting price from paise to rupees for accurate calculations
UPDATE zepto
SET mrp = mrp / 100.0,
    discountSellingPrice = discountSellingPrice / 100.0;
📈 Exploratory Data Analysis & Key QuestionsThe core of the project involved writing SQL queries to answer key business questions:Which product categories are the most and least prominent?What is the ratio of in-stock vs. out-of-stock products?What are the most heavily discounted products?Which high-value items are currently out of stock, representing lost revenue?Which categories generate the most potential revenue?What is the average discount strategy per category?How do products compare on a price-per-gram basis?🚀 SQL Queries ShowcaseBelow is a selection of the SQL queries written to extract insights from the dataset. The full script can be found in the repository.1. Top 5 Categories by Average DiscountThis query identifies which product categories receive the highest average discounts, shedding light on promotional strategies.-- Identify the top 5 categories offering the highest average discount percentage
SELECT
    category,
    ROUND(AVG(discountPercent), 2) AS avg_discount
FROM
    zepto
GROUP BY
    category
ORDER BY
    avg_discount DESC
LIMIT 5;
Insight: This helps understand which categories are used to attract customers through aggressive pricing.2. High-Value Products That Are Out of StockThis query pinpoints high-priced items that are unavailable, highlighting immediate opportunities to recapture lost sales.-- What are the products with high MRP but are out of stock?
SELECT
    DISTINCT name,
    mrp
FROM
    zepto
WHERE
    outOfStock = TRUE AND mrp > 300
ORDER BY
    mrp DESC;
Insight: The resulting list is a priority for the inventory management team to restock.3. Potential Revenue Per CategoryThis query calculates the total potential revenue from the available stock in each category, helping to identify the most valuable categories.-- Calculate potential revenue for each category based on available stock
SELECT
    category,
    SUM(discountSellingPrice * availableQuantity) AS total_revenue
FROM
    zepto
GROUP BY
    category
ORDER BY
    total_revenue DESC;
Insight: This shows where the bulk of inventory value lies and which categories are most critical to keep in stock.4. Price-per-Gram Value AnalysisThis query calculates the price per gram for products, allowing for a "value for money" comparison that isn't immediately obvious from the MRP.-- Find the price per gram for products above 100g and sort by the best value
SELECT
    DISTINCT name,
    weightInGms,
    discountSellingPrice,
    ROUND(discountSellingPrice / weightInGms, 2) AS price_per_gram
FROM
    zepto
WHERE
    weightInGms >= 100
ORDER BY
    price_per_gram ASC;
Insight: This can be used for marketing campaigns highlighting the best value products or for competitive analysis.5. Product Weight CategorizationThis query uses a CASE statement to segment products into standardized weight categories, useful for logistical planning and analysis.-- Group the products into categories like 'low', 'medium', and 'bulk'
SELECT
    DISTINCT name,
    weightInGms,
    CASE
        WHEN weightInGms < 1000 THEN 'Low'
        WHEN weightInGms < 5000 THEN 'Medium'
        ELSE 'Bulk'
    END AS weight_category
FROM
    zepto;
Insight: Helps in understanding the distribution of product sizes in the inventory.⚙️ How to ReplicateTo run this analysis yourself, follow these steps:Clone the Repository:git clone https://github.com/your-username/zepto-inventory-analysis.git
cd zepto-inventory-analysis
Setup PostgreSQL:Ensure you have PostgreSQL installed.Create a new database (e.g., zepto_db).Create and Populate the Table:Run the CREATE TABLE script found in schema.sql to set up the zepto table.Load your data (assuming it's in a CSV file named zepto_data.csv) into the table using the COPY command in psql:\copy zepto(sku_id, category, name, mrp, discountPercent, availableQuantity, discountSellingPrice, weightInGms, outOfStock, quantity) FROM 'path/to/your/zepto_data.csv' WITH (FORMAT CSV, HEADER);
Run the Analysis:Execute the queries in the analysis.sql file in your preferred SQL client (like pgAdmin or DBeaver) connected to your database.📞 ContactI am passionate about turning data into data-driven decisions and am always open to discussing new opportunities in data analytics.LinkedIn: [Your LinkedIn Profile URL]GitHub: [Your GitHub Profile URL]
