CREATE DATABASE EcommerceDB;
GO

USE EcommerceDB;
GO


--1. Customers

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    country VARCHAR(50)
);
GO

--2. Products

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);
GO

--3. Orders

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),

    CONSTRAINT FK_Orders_Customers
    FOREIGN KEY (customer_id)
    REFERENCES Customers(customer_id)
);
GO

--4. Order_Items

CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),

    CONSTRAINT FK_OrderItems_Orders
    FOREIGN KEY (order_id)
    REFERENCES Orders(order_id),

    CONSTRAINT FK_OrderItems_Products
    FOREIGN KEY (product_id)
    REFERENCES Products(product_id)
);
GO

-------------Data Insert--------------------

--Customers

INSERT INTO Customers
(customer_id, customer_name, city, country)
VALUES
(1, 'Rahul', 'Nagpur', 'India'),
(2, 'Saniya', 'Mumbai', 'India'),
(3, 'Ayesha', 'Delhi', 'India'),
(4, 'Aman', 'Pune', 'India'),
(5, 'Priya', 'Bangalore', 'India');
GO

--Products

INSERT INTO Products
(product_id, product_name, category, price)
VALUES
(101, 'Laptop', 'Electronics', 55000),
(102, 'Mobile Phone', 'Electronics', 25000),
(103, 'Headphones', 'Electronics', 2000),
(104, 'Shoes', 'Fashion', 3000),
(105, 'T-Shirt', 'Fashion', 1200),
(106, 'Backpack', 'Accessories', 1500);
GO

--Orders

INSERT INTO Orders
(order_id, customer_id, order_date, total_amount)
VALUES
(1001, 1, '2026-01-10', 57000),
(1002, 2, '2026-01-15', 25000),
(1003, 3, '2026-02-05', 5000),
(1004, 1, '2026-02-10', 3000),
(1005, 4, '2026-02-20', 1200),
(1006, 5, '2026-03-01', 27500);
GO

--Order Items

INSERT INTO Order_Items
(order_item_id, order_id, product_id, quantity, price)
VALUES
(1, 1001, 101, 1, 55000),
(2, 1001, 103, 1, 2000),
(3, 1002, 102, 1, 25000),
(4, 1003, 104, 1, 3000),
(5, 1003, 103, 1, 2000),
(6, 1004, 104, 1, 3000),
(7, 1005, 105, 1, 1200),
(8, 1006, 102, 1, 25000),
(9, 1006, 106, 1, 1500);
GO

------------------Data Check-----------------------

SELECT * FROM Customers;
SELECT * FROM Products;
SELECT * FROM Orders;
SELECT * FROM Order_Items;



--SELECT--

SELECT 
    customer_id,
    customer_name,
    city
FROM Customers;



--WHERE--

SELECT *
FROM Products
WHERE price > 5000;



--ORDER BY--

SELECT *
FROM Products
ORDER BY price DESC;



--GROUP BY--
--Category-wise products count:

SELECT
    category,
    COUNT(*) AS product_count
FROM Products
GROUP BY category;


--Aggregate Functions--

SELECT
    SUM(total_amount) AS total_sales,
    AVG(total_amount) AS average_order_value,
    MAX(total_amount) AS highest_order,
    MIN(total_amount) AS lowest_order

FROM Orders;



--INNER JOIN--

SELECT
    c.customer_name,
    o.order_id,
    o.order_date,
    o.total_amount
FROM Customers c
INNER JOIN Orders o
    ON c.customer_id = o.customer_id;



-- LEFT JOIN --

SELECT
    c.customer_name,
    o.order_id,
    o.total_amount
FROM Customers c
LEFT JOIN Orders o
    ON c.customer_id = o.customer_id;



--RIGHT JOIN--

SELECT
    c.customer_name,
    o.order_id,
    o.total_amount
FROM Customers c
RIGHT JOIN Orders o
    ON c.customer_id = o.customer_id;




--Multiple JOIN--

SELECT
    c.customer_name,
    o.order_id,
    p.product_name,
    oi.quantity,
    oi.price
FROM Customers c
INNER JOIN Orders o
    ON c.customer_id = o.customer_id
INNER JOIN Order_Items oi
    ON o.order_id = oi.order_id
INNER JOIN Products p
    ON oi.product_id = p.product_id;




--Subquery--

SELECT *
FROM Orders
WHERE total_amount > (
    SELECT AVG(total_amount)
    FROM Orders
);


---Customer-wise spending---

SELECT
    c.customer_id,
    c.customer_name,
    SUM(o.total_amount) AS total_spent
FROM Customers c
INNER JOIN Orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY total_spent DESC;


--Category-wise sales--

SELECT
    p.category,
    SUM(oi.quantity * oi.price) AS category_sales
FROM Products p
INNER JOIN Order_Items oi
    ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY category_sales DESC;


--Best-selling products--

SELECT
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM Products p
INNER JOIN Order_Items oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY total_quantity_sold DESC;




-----------CREATE VIEW-------------
--Create views for analysis

CREATE VIEW CustomerSales AS
SELECT
    c.customer_id,
    c.customer_name,
    SUM(o.total_amount) AS total_spent
FROM Customers c
INNER JOIN Orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name;
SELECT *
FROM CustomerSales
ORDER BY total_spent DESC;


-----------INDEX----------
--Optimize queries with indexes

CREATE INDEX IX_Orders_CustomerID
ON Orders(customer_id);
GO

CREATE INDEX IX_OrderItems_ProductID
ON Order_Items(product_id);
GO


--Query Optimization using execution plan--

SELECT *
FROM Orders
WHERE customer_id = 1;

