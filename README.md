# README.md

# 📊 SQL Data Analysis Project

## 📌 Project Overview

This project focuses on performing **SQL-based Data Analysis** on an e-commerce sales dataset.
The main goal of this project is to extract meaningful business insights using SQL queries such as filtering, grouping, sorting, and aggregation.

The project was completed as part of the **DecodeLabs Industrial Training Program 2026**. 

---

# 🎯 Project Goals

The main objectives of this project are:

* Write SQL SELECT queries
* Use WHERE, ORDER BY, and GROUP BY clauses
* Perform aggregations using COUNT, SUM, and AVG
* Extract business insights from the dataset
* Analyze customer purchasing behavior and sales trends

---

# 📂 Dataset Description

The dataset contains e-commerce order information including:

| Column Name    | Description                  |
| -------------- | ---------------------------- |
| OrderID        | Unique order ID              |
| Date           | Order date                   |
| CustomerID     | Customer identification      |
| Product        | Product name                 |
| Quantity       | Number of products purchased |
| UnitPrice      | Price per product            |
| PaymentMethod  | Payment type                 |
| OrderStatus    | Delivery status              |
| ReferralSource | Customer referral platform   |
| TotalPrice     | Total order amount           |

---

# 🛠 Technologies Used

| Technology     | Purpose             |
| -------------- | ------------------- |
| SQL            | Data Querying       |
| MySQL / SQLite | Database Management |
| Excel          | Dataset Storage     |
| GitHub         | Version Control     |

---

# 🗄 Database Setup

## Create Table

```sql id="4e04xm"
CREATE TABLE orders (
    OrderID VARCHAR(20),
    Date DATE,
    CustomerID VARCHAR(20),
    Product VARCHAR(50),
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    PaymentMethod VARCHAR(50),
    OrderStatus VARCHAR(50),
    ReferralSource VARCHAR(50),
    TotalPrice DECIMAL(10,2)
);
```

---

# 📊 SQL Queries and Analysis

## 1️⃣ View All Records

```sql id="w1b8f4"
SELECT * FROM orders;
```

---

## 2️⃣ Find Total Number of Orders

```sql id="n5hjlwm"
SELECT COUNT(*) AS Total_Orders
FROM orders;
```

### Insight

This query returns the total number of orders in the dataset.

---

## 3️⃣ Find Average Total Price

```sql id="3yxv8r"
SELECT AVG(TotalPrice) AS Average_Order_Value
FROM orders;
```

### Insight

Calculates the average customer spending per order.

---

## 4️⃣ Find Highest Revenue Product

```sql id="rls7t2"
SELECT Product, SUM(TotalPrice) AS Revenue
FROM orders
GROUP BY Product
ORDER BY Revenue DESC;
```

### Insight

Identifies the products generating the highest revenue.

---

## 5️⃣ Find Most Purchased Product

```sql id="mjlwm8"
SELECT Product, SUM(Quantity) AS Total_Quantity
FROM orders
GROUP BY Product
ORDER BY Total_Quantity DESC;
```

### Insight

Shows the most frequently purchased products.

---

## 6️⃣ Analyze Payment Methods

```sql id="mqw9u8"
SELECT PaymentMethod, COUNT(*) AS Usage_Count
FROM orders
GROUP BY PaymentMethod
ORDER BY Usage_Count DESC;
```

### Insight

Determines the most preferred payment methods.

---

## 7️⃣ Analyze Order Status

```sql id="u38p5y"
SELECT OrderStatus, COUNT(*) AS Total_Orders
FROM orders
GROUP BY OrderStatus;
```

### Insight

Shows delivery performance and cancellation trends.

---

## 8️⃣ Referral Source Analysis

```sql id="s4z1xv"
SELECT ReferralSource, COUNT(*) AS Customer_Count
FROM orders
GROUP BY ReferralSource
ORDER BY Customer_Count DESC;
```

### Insight

Identifies which platform brings the most customers.

---

## 9️⃣ Find High-Value Orders

```sql id="gffv8u"
SELECT OrderID, Product, TotalPrice
FROM orders
WHERE TotalPrice > 3000
ORDER BY TotalPrice DESC;
```

### Insight

Detects premium or bulk purchase orders.

---

## 🔟 Monthly Sales Trend

```sql id="b5jv12"
SELECT MONTH(Date) AS Month,
       YEAR(Date) AS Year,
       SUM(TotalPrice) AS Monthly_Revenue
FROM orders
GROUP BY Year, Month
ORDER BY Year, Month;
```

### Insight

Tracks monthly business growth and revenue trends.

---

# 🔍 Key Findings

* Chairs generated the highest revenue.
* Online payment methods were highly preferred.
* Instagram was the strongest referral source.
* Sales increased steadily over time.
* Some orders had exceptionally high values.
* Cancelled and returned orders were relatively high.

---

# 💡 Business Recommendations

* Improve marketing campaigns on Instagram.
* Reduce cancellation rates through customer support improvements.
* Promote high-performing products.
* Investigate reasons for product returns.
* Reward loyal customers and premium buyers.

---

# 📈 Skills Demonstrated

* SQL Query Writing
* Data Filtering
* Aggregation Functions
* Grouping and Sorting
* Business Intelligence Analysis
* Analytical Thinking

---

# 📁 Project Structure

```bash id="ckk5hn"
SQL-Data-Analysis/
│
├── Dataset/
│   └── ecommerce_dataset.xlsx
│
├── SQL Queries/
│   └── analysis_queries.sql
│
├── Reports/
│   └── project_report.pdf
│
└── README.md
```

---

# ▶️ How to Run the Project

## Step 1 — Import Dataset

Import the dataset into MySQL or SQLite.

## Step 2 — Create Database Table

Run:

```sql id="h5x0eo"
CREATE TABLE orders (...);
```

## Step 3 — Execute SQL Queries

Run all SQL analysis queries from:

```bash id="v9z2kh"
analysis_queries.sql
```

---

# 📚 Learning Outcomes

Through this project, I learned:

* SQL fundamentals
* Data querying techniques
* Data grouping and aggregation
* Business insight extraction
* Relational database concepts

---

# 👨‍💻 Author

**Thilani Senarath**
Data Analytics Intern – DecodeLabs

---

# 📜 License

This project is created for educational and learning purposes only.
