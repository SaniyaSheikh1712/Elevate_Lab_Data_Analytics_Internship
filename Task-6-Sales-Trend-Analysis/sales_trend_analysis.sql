-- TASK 6: SALES TREND ANALYSIS USING AGGREGATIONS

CREATE TABLE online_sales (
    order_id INT,
    order_date DATE,
    amount DECIMAL(10,2),
    product_id INT
);

INSERT INTO online_sales (order_id, order_date, amount, product_id)
VALUES
(1001, '2024-01-05', 500, 101),
(1002, '2024-01-12', 750, 102),
(1003, '2024-01-20', 300, 103),
(1004, '2024-02-03', 900, 101),
(1005, '2024-02-15', 650, 104),
(1006, '2024-02-22', 400, 102),
(1007, '2024-03-05', 1200, 105),
(1008, '2024-03-10', 800, 101),
(1009, '2024-03-18', 450, 103),
(1010, '2024-04-02', 700, 104),
(1011, '2024-04-15', 950, 105),
(1012, '2024-04-25', 600, 102),
(1013, '2024-05-05', 1100, 101),
(1014, '2024-05-12', 850, 104),
(1015, '2024-05-20', 500, 103),
(1016, '2024-06-03', 1300, 105),
(1017, '2024-06-14', 900, 101),
(1018, '2024-06-25', 750, 102),
(1019, '2024-07-05', 1400, 105),
(1020, '2024-07-18', 1000, 104);


-- Verify data
SELECT *
FROM online_sales;


-- Monthly Revenue
SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    SUM(amount) AS monthly_revenue
FROM online_sales
GROUP BY
    YEAR(order_date),
    MONTH(order_date)
ORDER BY
    order_year,
    order_month;


-- Monthly Order Volume
SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    COUNT(DISTINCT order_id) AS order_volume
FROM online_sales
GROUP BY
    YEAR(order_date),
    MONTH(order_date)
ORDER BY
    order_year,
    order_month;


-- Monthly Revenue and Order Volume
SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    SUM(amount) AS total_revenue,
    COUNT(DISTINCT order_id) AS order_volume
FROM online_sales
GROUP BY
    YEAR(order_date),
    MONTH(order_date)
ORDER BY
    order_year,
    order_month;


-- Highest Revenue Month
SELECT TOP 1
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    SUM(amount) AS total_revenue
FROM online_sales
GROUP BY
    YEAR(order_date),
    MONTH(order_date)
ORDER BY total_revenue DESC;


-- Highest Order Volume Month
SELECT TOP 1
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    COUNT(DISTINCT order_id) AS order_volume
FROM online_sales
GROUP BY
    YEAR(order_date),
    MONTH(order_date)
ORDER BY order_volume DESC;


-- Specific Time Period Analysis
SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    SUM(amount) AS total_revenue,
    COUNT(DISTINCT order_id) AS order_volume
FROM online_sales
WHERE order_date >= '2024-01-01'
  AND order_date < '2025-01-01'
GROUP BY
    YEAR(order_date),
    MONTH(order_date)
ORDER BY
    order_year,
    order_month;


-- Product-wise Revenue
SELECT
    product_id,
    SUM(amount) AS total_revenue
FROM online_sales
GROUP BY product_id
ORDER BY total_revenue DESC;
