# Zepto Quick-Commerce Case Study

This is a complete, real-world data analyst portfolio project based on an e-commerce inventory dataset scraped from Zepto — one of India’s fastest-growing quick-commerce startups. This project simulates real analyst workflows, from raw data exploration to business-focused data analysis.

This project is perfect for:

* 📊 Data Analyst aspirants who want to build a strong Portfolio Project for interviews and LinkedIn
* 📚 Anyone learning SQL hands-on
* 💼 Preparing for interviews in retail, e-commerce, or product analytics

---

## 📁 Dataset Overview

The dataset was sourced from Kaggle and was originally scraped from Zepto’s official product listings. It mimics what you’d typically encounter in a real-world e-commerce inventory system.

Each row represents a unique SKU (Stock Keeping Unit) for a product. Duplicate product names exist because the same product may appear multiple times in different package sizes, weights, discounts, or categories to improve visibility – exactly how real catalog data looks.

### 🧾 Columns:

* `sku_id`: Unique identifier for each product entry (Synthetic Primary Key)
* `name`: Product name as it appears on the app
* `category`: Product category like Fruits, Snacks, Beverages, etc.
* `mrp`: Maximum Retail Price (originally in paise, converted to ₹)
* `discountPercent`: Discount applied on MRP
* `discountedSellingPrice`: Final price after discount (also converted to ₹)
* `availableQuantity`: Units available in inventory
* `weightInGms`: Product weight in grams
* `outOfStock`: Boolean flag indicating stock availability
* `quantity`: Number of units per package (mixed with grams for loose produce)

---

## 🔧 Project Workflow

Here’s a step-by-step breakdown of what we do in this project:

### 1. Database & Table Creation

We start by creating a SQL table with appropriate data types:

````sql`
CREATE TABLE zepto (
  sku_id SERIAL PRIMARY KEY,
  category VARCHAR(120),
  name VARCHAR(150) NOT NULL,
  mrp NUMERIC(8,2),
  discountPercent NUMERIC(5,2),
  availableQuantity INTEGER,
  discountedSellingPrice NUMERIC(8,2),
  weightInGms INTEGER,
  outOfStock BOOLEAN,
  quantity INTEGER); ```` `

## 2. Data Import

Loaded CSV using pgAdmin's import feature.

If you're not able to use the import feature, write this code instead:

```sql
\copy zepto(category,name,mrp,discountPercent,availableQuantity,
            discountedSellingPrice,weightInGms,outOfStock,quantity)
FROM 'data/zepto_v2.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', ENCODING 'UTF8');
