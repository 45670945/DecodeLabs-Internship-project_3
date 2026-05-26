# STEP 1 – CREATE DATABASE & TABLE

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

# STEP 2 – AFTER importing the CSV via Table Data Import Wizard,
--          verify your data loaded correctly:

SELECT COUNT(*) AS TotalRows FROM orders;  

SELECT * FROM orders LIMIT 5;  

# View all columns (first 10 rows)
SELECT *
FROM   orders
LIMIT  10;

# Select only important business columns
SELECT OrderID,
       Date,
       CustomerID,
       Product,
       Quantity,
       TotalPrice,
       OrderStatus
FROM   orders
LIMIT  20;

# All distinct products in the dataset
SELECT DISTINCT Product
FROM   orders
ORDER BY Product ASC;

# All distinct payment methods
SELECT DISTINCT PaymentMethod
FROM   orders
ORDER BY PaymentMethod ASC;

# All distinct order statuses
SELECT DISTINCT OrderStatus
FROM   orders;

# SECTION 2 – WHERE CLAUSE (Filtering Rows)
-- ============================================================
 
# All delivered orders
SELECT OrderID, CustomerID, Product, TotalPrice
FROM   orders
WHERE  OrderStatus = 'Delivered';

# Orders where TotalPrice is greater than 2000
SELECT OrderID, Product, Quantity, TotalPrice
FROM   orders
WHERE  TotalPrice > 2000
ORDER BY TotalPrice DESC;

# Orders placed in the year 2024
SELECT OrderID, Date, Product, TotalPrice
FROM   orders
WHERE  Date BETWEEN '2024-01-01' AND '2024-12-31'
ORDER BY Date ASC;

# Laptop orders that were cancelled
SELECT OrderID, CustomerID, Date, TotalPrice
FROM   orders
WHERE  Product = 'Laptop'
  AND  OrderStatus = 'Cancelled';
 
# Credit Card orders with TotalPrice above 1000
SELECT OrderID, CustomerID, TotalPrice, PaymentMethod
FROM   orders
WHERE  PaymentMethod = 'Credit Card'
  AND  TotalPrice > 1000
ORDER BY TotalPrice DESC; 

# Orders that used a coupon code
SELECT OrderID, Product, CouponCode, TotalPrice
FROM   orders
WHERE  CouponCode IS NOT NULL
  AND  CouponCode != ''
ORDER BY CouponCode ASC;

# Orders referred from Instagram OR Facebook
SELECT OrderID, Product, ReferralSource, TotalPrice
FROM   orders
WHERE  ReferralSource IN ('Instagram', 'Facebook')
ORDER BY ReferralSource ASC;

# Orders with Quantity between 3 and 5
SELECT OrderID, Product, Quantity, TotalPrice
FROM   orders
WHERE  Quantity BETWEEN 3 AND 5
ORDER BY Quantity DESC;

# Orders from 2023 that are still Pending
SELECT OrderID, Date, Product, OrderStatus
FROM   orders
WHERE  YEAR(Date) = 2023
  AND  OrderStatus = 'Pending';
  

# SECTION 3 – ORDER BY (Sorting Results)
-- ============================================================
 
# Top 10 highest value orders
SELECT OrderID, Product, TotalPrice
FROM   orders
ORDER BY TotalPrice DESC
LIMIT  10;  

# Most recent orders first
SELECT OrderID, Date, Product, OrderStatus
FROM   orders
ORDER BY Date DESC
LIMIT  15;

# Cheapest unit price products first
SELECT OrderID, Product, UnitPrice
FROM   orders
ORDER BY UnitPrice ASC
LIMIT  10;

# Sort by Product name, then TotalPrice descending
SELECT Product, OrderID, TotalPrice
FROM   orders
ORDER BY Product ASC, TotalPrice DESC;


# SECTION 4 – GROUP BY + AGGREGATIONS (COUNT, SUM, AVG)
-- ============================================================
 
# Total number of orders per product
SELECT   Product,
         COUNT(*) AS TotalOrders
FROM     orders
GROUP BY Product
ORDER BY TotalOrders DESC;

# Total revenue per product
SELECT   Product,
         ROUND(SUM(TotalPrice), 2) AS TotalRevenue
FROM     orders
GROUP BY Product
ORDER BY TotalRevenue DESC;

# Average order value per product
SELECT   Product,
         ROUND(AVG(TotalPrice), 2) AS AvgOrderValue
FROM     orders
GROUP BY Product
ORDER BY AvgOrderValue DESC;

# Order count by status
SELECT   OrderStatus,
         COUNT(*) AS OrderCount
FROM     orders
GROUP BY OrderStatus
ORDER BY OrderCount DESC;

# Revenue and order count by payment method
SELECT   PaymentMethod,
         COUNT(*)                      AS TotalOrders,
         ROUND(SUM(TotalPrice), 2)     AS TotalRevenue,
         ROUND(AVG(TotalPrice), 2)     AS AvgOrderValue
FROM     orders
GROUP BY PaymentMethod
ORDER BY TotalRevenue DESC;

# Orders and revenue by referral source
SELECT   ReferralSource,
         COUNT(*)                      AS TotalOrders,
         ROUND(SUM(TotalPrice), 2)     AS TotalRevenue,
         ROUND(AVG(TotalPrice), 2)     AS AvgOrderValue
FROM     orders
GROUP BY ReferralSource
ORDER BY TotalRevenue DESC;

# Monthly revenue breakdown (using DATE_FORMAT)
SELECT   DATE_FORMAT(Date, '%Y-%m')    AS YearMonth,
         COUNT(*)                      AS TotalOrders,
         ROUND(SUM(TotalPrice), 2)     AS MonthlyRevenue
FROM     orders
GROUP BY YearMonth
ORDER BY YearMonth ASC;

# Yearly revenue comparison
SELECT   YEAR(Date)                    AS Year,
         COUNT(*)                      AS TotalOrders,
         ROUND(SUM(TotalPrice), 2)     AS YearlyRevenue
FROM     orders
GROUP BY Year
ORDER BY Year ASC;

# Average quantity ordered per product
SELECT   Product,
         ROUND(AVG(Quantity), 2)       AS AvgQuantity
FROM     orders
GROUP BY Product
ORDER BY AvgQuantity DESC;

# Coupon usage frequency
SELECT   CouponCode,
         COUNT(*)                      AS TimesUsed,
         ROUND(SUM(TotalPrice), 2)     AS TotalRevenue
FROM     orders
WHERE    CouponCode IS NOT NULL AND CouponCode != ''
GROUP BY CouponCode
ORDER BY TimesUsed DESC;

# SECTION 5 – HAVING (Filter on Aggregated Results)
-- ============================================================
 
# Products with more than 150 total orders
SELECT   Product,
         COUNT(*) AS TotalOrders
FROM     orders
GROUP BY Product
HAVING   COUNT(*) > 150
ORDER BY TotalOrders DESC;

# Payment methods generating over 50,000 in revenue
SELECT   PaymentMethod,
         ROUND(SUM(TotalPrice), 2) AS TotalRevenue
FROM     orders
GROUP BY PaymentMethod
HAVING   SUM(TotalPrice) > 50000
ORDER BY TotalRevenue DESC;

# Referral sources with average order value above 800
SELECT   ReferralSource,
         ROUND(AVG(TotalPrice), 2) AS AvgOrderValue
FROM     orders
GROUP BY ReferralSource
HAVING   AVG(TotalPrice) > 800
ORDER BY AvgOrderValue DESC;
 
# Products where total quantity sold exceeds 500 units
SELECT   Product,
         SUM(Quantity) AS TotalUnitsSold
FROM     orders
GROUP BY Product
HAVING   SUM(Quantity) > 500
ORDER BY TotalUnitsSold DESC; 

# SECTION 6 – COMBINED QUERIES (Multi-Clause)
-- ============================================================
 
# Revenue per product for DELIVERED orders only
SELECT   Product,
         COUNT(*)                      AS DeliveredOrders,
         ROUND(SUM(TotalPrice), 2)     AS Revenue
FROM     orders
WHERE    OrderStatus = 'Delivered'
GROUP BY Product
ORDER BY Revenue DESC;

# Best referral source by revenue in 2024
SELECT   ReferralSource,
         ROUND(SUM(TotalPrice), 2) AS Revenue2024
FROM     orders
WHERE    YEAR(Date) = 2024
GROUP BY ReferralSource
ORDER BY Revenue2024 DESC
LIMIT    1;

# Cancellation rate per product (%)
SELECT   Product,
         COUNT(*)                                                          AS TotalOrders,
         SUM(CASE WHEN OrderStatus = 'Cancelled' THEN 1 ELSE 0 END)       AS CancelledOrders,
         ROUND(
             100.0 * SUM(CASE WHEN OrderStatus = 'Cancelled' THEN 1 ELSE 0 END)
             / COUNT(*), 2
         )                                                                  AS CancelRate_Pct
FROM     orders
GROUP BY Product
ORDER BY CancelRate_Pct DESC;

# Most popular product per referral source
SELECT   ReferralSource,
         Product,
         COUNT(*) AS Orders
FROM     orders
GROUP BY ReferralSource, Product
ORDER BY ReferralSource, Orders DESC;

# Revenue from coupon users vs non-coupon users
SELECT   CASE
             WHEN CouponCode IS NOT NULL AND CouponCode != '' THEN 'Used Coupon'
             ELSE 'No Coupon'
         END                              AS CouponUsage,
         COUNT(*)                         AS TotalOrders,
         ROUND(SUM(TotalPrice), 2)        AS TotalRevenue,
         ROUND(AVG(TotalPrice), 2)        AS AvgOrderValue
FROM     orders
GROUP BY CouponUsage;

# Top 5 customers by total spending
SELECT   CustomerID,
         COUNT(*)                      AS TotalOrders,
         ROUND(SUM(TotalPrice), 2)     AS TotalSpent
FROM     orders
GROUP BY CustomerID
ORDER BY TotalSpent DESC
LIMIT    5;