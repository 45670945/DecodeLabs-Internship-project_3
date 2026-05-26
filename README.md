# 🛢️ DecodeLabs — Data Analytics Project 3
### SQL Data Analysis | Industrial Training Kit | Batch 2026

> **"Before you build automated reporting pipelines, you must master the fundamental art of writing structured queries to filter, group, and aggregate raw data into actionable business intelligence."**
> — DecodeLabs

---

## 📋 Project Overview

This project demonstrates SQL Data Analysis skills using a real-world **e-commerce orders dataset** (1,200 rows). The goal is to extract business insights using structured SQL queries — covering filtering, grouping, sorting, and aggregation.

| Detail | Info |
|--------|------|
| 🏢 **Organization** | DecodeLabs |
| 📦 **Project** | Project 3 — SQL Data Analysis |
| 🗄️ **Database** | MySQL (MySQL Workbench) |
| 📊 **Dataset** | E-commerce Orders — 1,200 rows, 14 columns |
| 🔢 **Total Queries** | 38 SQL queries across 6 sections |
| 📅 **Batch** | 2026 |

---

## 📁 Repository Structure

```
decodelabs-data-analytics-project3/
│
├── 📄 README.md                          ← You are here
├── 🗄️ project3_mysql.sql                 ← All 38 SQL queries
└── 📊 Dataset_for_Data_Analytics.csv     ← E-commerce orders dataset
```

---

## 🗂️ Dataset Overview

**File:** `Dataset_for_Data_Analytics.csv` — **1,200 rows × 14 columns**

| Column | Type | Sample Values |
|--------|------|--------------|
| `OrderID` | VARCHAR | ORD200000, ORD200001 |
| `Date` | DATE | 2023-01-04, 2024-08-23 |
| `CustomerID` | VARCHAR | C72649, C75739 |
| `Product` | VARCHAR | Laptop, Phone, Tablet, Monitor, Printer, Desk, Chair |
| `Quantity` | INT | 1 – 5 |
| `UnitPrice` | DECIMAL | 49.14 – 664.42 |
| `ShippingAddress` | VARCHAR | Street addresses |
| `PaymentMethod` | VARCHAR | Cash, Credit Card, Debit Card, Gift Card, Online |
| `OrderStatus` | VARCHAR | Delivered, Shipped, Pending, Cancelled, Returned |
| `TrackingNumber` | VARCHAR | TRK37947903 |
| `ItemsInCart` | INT | 1 – 10 |
| `CouponCode` | VARCHAR | SAVE10, FREESHIP, WINTER15 |
| `ReferralSource` | VARCHAR | Google, Facebook, Instagram, Email, Referral |
| `TotalPrice` | DECIMAL | Quantity × UnitPrice |

---

## 🚀 How to Set Up & Run (MySQL Workbench)

### Prerequisites
- ✅ [MySQL Community Server](https://dev.mysql.com/downloads/mysql/) — install first
- ✅ [MySQL Workbench](https://dev.mysql.com/downloads/workbench/) — install after

---

### Step 1 — Connect to MySQL

1. Open **MySQL Workbench**
2. Click **"+"** next to MySQL Connections
3. Set: Hostname `127.0.0.1` · Port `3306` · Username `root`
4. Click **Test Connection** → enter your password → **OK**
5. Double-click the connection to open it

---

### Step 2 — Create Database & Table

Run this in the SQL editor (`Ctrl + Enter`):

```sql
CREATE DATABASE IF NOT EXISTS decodelabs_project3;
USE decodelabs_project3;

CREATE TABLE orders (
    OrderID         VARCHAR(20),
    Date            DATE,
    CustomerID      VARCHAR(20),
    Product         VARCHAR(50),
    Quantity        INT,
    UnitPrice       DECIMAL(10,2),
    ShippingAddress VARCHAR(255),
    PaymentMethod   VARCHAR(50),
    OrderStatus     VARCHAR(50),
    TrackingNumber  VARCHAR(50),
    ItemsInCart     INT,
    CouponCode      VARCHAR(20),
    ReferralSource  VARCHAR(50),
    TotalPrice      DECIMAL(10,2)
);
```

---

### Step 3 — Import the CSV

1. Left panel → expand `decodelabs_project3` → expand `Tables`
2. **Right-click** on `orders` → **"Table Data Import Wizard"**
3. Browse → select `Dataset_for_Data_Analytics.csv` → **Next**
4. Choose ✅ **"Use existing table"** → `decodelabs_project3.orders` → **Next**
5. Columns auto-map → **Next** → wait for import → **Finish**

---

### Step 4 — Verify Import

```sql
SELECT COUNT(*) AS TotalRows FROM orders;
-- ✅ Expected: 1200
```

---

### Step 5 — Run the SQL File

- **File → Open SQL Script** → select `project3_mysql.sql`
- Click inside any query → press `Ctrl + Enter` to run it
- Results appear in the **Result Grid** at the bottom

---

## 📝 SQL Queries — Section Summary

### Section 1 — Basic SELECT (Q1–Q5)
```sql
-- View all data
SELECT * FROM orders LIMIT 10;

-- Distinct products
SELECT DISTINCT Product FROM orders ORDER BY Product;
```

### Section 2 — WHERE Filtering (Q6–Q14)
```sql
-- Delivered orders only
SELECT OrderID, Product, TotalPrice FROM orders
WHERE OrderStatus = 'Delivered';

-- Orders above $2000
SELECT OrderID, Product, TotalPrice FROM orders
WHERE TotalPrice > 2000
ORDER BY TotalPrice DESC;
```

### Section 3 — ORDER BY Sorting (Q15–Q18)
```sql
-- Top 10 highest value orders
SELECT OrderID, Product, TotalPrice FROM orders
ORDER BY TotalPrice DESC
LIMIT 10;
```

### Section 4 — GROUP BY + Aggregations (Q19–Q28)
```sql
-- Total revenue per product
SELECT Product, ROUND(SUM(TotalPrice), 2) AS TotalRevenue
FROM orders
GROUP BY Product
ORDER BY TotalRevenue DESC;

-- Monthly revenue breakdown
SELECT DATE_FORMAT(Date, '%Y-%m') AS YearMonth,
       COUNT(*) AS TotalOrders,
       ROUND(SUM(TotalPrice), 2) AS MonthlyRevenue
FROM orders
GROUP BY YearMonth
ORDER BY YearMonth;
```

### Section 5 — HAVING (Q29–Q32)
```sql
-- Products with more than 150 orders
SELECT Product, COUNT(*) AS TotalOrders
FROM orders
GROUP BY Product
HAVING COUNT(*) > 150;
```

### Section 6 — Combined Queries (Q33–Q38)
```sql
-- Cancellation rate per product
SELECT Product,
       COUNT(*) AS TotalOrders,
       SUM(CASE WHEN OrderStatus = 'Cancelled' THEN 1 ELSE 0 END) AS Cancelled,
       ROUND(100.0 * SUM(CASE WHEN OrderStatus = 'Cancelled' THEN 1 ELSE 0 END) / COUNT(*), 2) AS CancelRate_Pct
FROM orders
GROUP BY Product
ORDER BY CancelRate_Pct DESC;
```

---

## 🧠 SQL Concepts Covered

| Concept | Purpose |
|---------|---------|
| `SELECT` | Choose columns to display |
| `WHERE` | Filter rows before grouping |
| `ORDER BY` | Sort results ASC or DESC |
| `GROUP BY` | Collapse rows into categories |
| `HAVING` | Filter after grouping |
| `COUNT(*)` | Count total rows |
| `SUM()` | Total up numeric values |
| `AVG()` | Calculate the average |
| `ROUND()` | Round to decimal places |
| `YEAR()` | Extract year from a date |
| `DATE_FORMAT()` | Format dates for grouping |
| `BETWEEN` | Filter within a range |
| `IN` | Match multiple values |
| `CASE WHEN` | Conditional logic inside queries |
| `DISTINCT` | Remove duplicate values |
| `LIMIT` | Cap the number of results |

---

## ⚙️ SQL Execution Order

MySQL processes your query in this order — **not** top to bottom:

```
1. FROM       ← Identify the table
2. WHERE      ← Filter individual rows
3. GROUP BY   ← Create category buckets
4. HAVING     ← Filter the buckets
5. SELECT     ← Pick columns & calculate
6. ORDER BY   ← Sort final output
7. LIMIT      ← Cap rows shown
```

> ⚠️ **Common mistake:** You cannot use a `SELECT` alias inside `WHERE` — the alias doesn't exist yet when `WHERE` runs.

---

## ✅ Project Checklist

- [x] MySQL Server installed and running
- [x] Workbench connected to localhost
- [x] `decodelabs_project3` database created
- [x] `orders` table created with correct schema
- [x] CSV imported — 1200 rows confirmed
- [x] All 6 query sections completed
- [x] Screenshots of query results captured
- [x] Project published to GitHub

---

## 🛠️ Tools Used

![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![MySQL Workbench](https://img.shields.io/badge/MySQL_Workbench-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)
![CSV](https://img.shields.io/badge/Dataset-CSV-green?style=for-the-badge)

---

## 👨‍💻 Author
 
| | |
|--|--|
| 👤 **Name** | Thilani Senarath |
| 💼 **Role** | Data Analytics Intern |
| 🏢 **Organization** | DecodeLabs |
| 📅 **Batch** | 2026 |
 
---
 
## 📜 License
 
This project is created for **educational and learning purposes only**.
 
All SQL queries, analysis, and documentation in this repository are part of the DecodeLabs Industrial Training Program and are intended solely for skill development and portfolio building.
 
---

## 📞 About DecodeLabs

| | |
|--|--|
| 🌐 Website | [www.decodelabs.tech](https://www.decodelabs.tech) |
| 📧 Email | decodelabs.tech@gmail.com |
| 📞 Phone | +91 89330 06408 |
| 📍 Location | Greater Lucknow, India |

---

<div align="center">

**DecodeLabs Industrial Training Kit — Batch 2026**

*"Your journey to becoming a professional analyst begins right here, right now, with the very first SELECT statement you execute today."*

</div>


