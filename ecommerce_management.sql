DROP DATABASE IF EXISTS EcommerceDB;
CREATE DATABASE EcommerceDB;
USE EcommerceDB;


-- 1. Categories Table
CREATE TABLE Categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL
);

INSERT INTO Categories (category_name) VALUES
('Electronics'),
('Clothing'),
('Books'),
('Home Appliances');

SELECT * FROM Categories;
+-------------+-----------------+
| category_id | category_name   |
+-------------+-----------------+
|           1 | Electronics     |
|           2 | Clothing        |
|           3 | Books           |
|           4 | Home Appliances |
+-------------+-----------------+

-- 2. Products Table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    category_id INT,
    price DECIMAL(10,2),
    stock_quantity INT,
    added_date DATE,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

INSERT INTO Products (product_id,name, category_id, price, stock_quantity, added_date) VALUES
(101,'Laptop',1,55000,768,'2025-01-10'),
(102,'Mobile',1,30000,876,'2025-02-15'),
(103,'T-Shirt',2,800,350,'2025-03-01'),
(104,'Novel',3,500,400,'2025-03-12'),
(105,'Microwave',4,70000,108,'2025-04-01'),
(106,'Headphones',1,2000,725,'2025-04-10');

SELECT * FROM Products;
+------------+------------+-------------+----------+----------------+------------+
| product_id | name       | category_id | price    | stock_quantity | added_date |
+------------+------------+-------------+----------+----------------+------------+
|        101 | Laptop     |           1 | 55000.00 |            768 | 2025-01-10 |
|        102 | Mobile     |           1 | 30000.00 |            876 | 2025-02-15 |
|        103 | T-Shirt    |           2 |   800.00 |            350 | 2025-03-01 |
|        104 | Novel      |           3 |   500.00 |            400 | 2025-03-12 |
|        105 | Microwave  |           4 | 70000.00 |            108 | 2025-04-01 |
|        106 | Headphones |           1 |  2000.00 |            725 | 2025-04-10 |
+------------+------------+-------------+----------+----------------+------------+

-- 3. Customers Table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone_number VARCHAR(15),
    address TEXT,
    registration_date DATE
);

INSERT INTO Customers (customer_id,name,email,phone_number,address,registration_date) VALUES
(2001,'Sakshi Bagul','Sakshi@gmail.com','9876543210','Mumbai','2023-05-10'),
(2002,'Happy Patel','Happy@gmail.com','8767432113','Surat','2024-06-15'),
(2003,'Disha Choudhari','Disha@gmail.com','7287654325','Delhi','2022-08-20'),
(2004,'Mansi Pawar ','Mansi@gmail.com','5658432130','Pune','2025-01-01'),
(2005,'Krishna Patil','Krishna@gmail.com','8780843649','Mumbai','2025-05-21'),
(2006,'komal Patel','komal@gmail.com','7689545685','Surat','2024-04-08');

SELECT * FROM Customers;
+-------------+-----------------+-------------------+--------------+---------+-------------------+
| customer_id | name            | email             | phone_number | address | registration_date |
+-------------+-----------------+-------------------+--------------+---------+-------------------+
|        2001 | Sakshi Bagul    | Sakshi@gmail.com  | 9876543210   | Mumbai  | 2023-05-10        |
|        2002 | Happy Patel     | Happy@gmail.com   | 8767432113   | Surat   | 2024-06-15        |
|        2003 | Disha Choudhari | Disha@gmail.com   | 7287654325   | Delhi   | 2022-08-20        |
|        2004 | Mansi Pawar     | Mansi@gmail.com   | 5658432130   | Pune    | 2025-01-01        |
|        2005 | Krishna Patil   | Krishna@gmail.com | 8780843649   | Mumbai  | 2025-05-21        |
|        2006 | komal Patel     | komal@gmail.com   | 7689545685   | Surat   | 2024-04-08        |
+-------------+-----------------+-------------------+--------------+---------+-------------------+

-- 4. Orders Table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY ,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    status VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

INSERT INTO Orders (order_id,customer_id,order_date,total_amount,status) VALUES
(3401,2001,'2025-04-01',55800,'Pending'),
(3402,2002,'2025-04-02',30000,'Shipped'),
(3403,2001,'2025-04-05',20000,'Delivered'),
(3404,2003,'2025-04-06',500,'Cancelled'),
(3405,2004,'2025-04-08',7000,'Pending'),
(3406,2004,'2025-05-10',47000,'Shipped');

SELECT * FROM Orders;
+----------+-------------+------------+--------------+-----------+
| order_id | customer_id | order_date | total_amount | status    |
+----------+-------------+------------+--------------+-----------+
|     3401 |        2001 | 2025-04-01 |     55800.00 | Pending   |
|     3402 |        2002 | 2025-04-02 |     30000.00 | Shipped   |
|     3403 |        2001 | 2025-04-05 |     20000.00 | Delivered |
|     3404 |        2003 | 2025-04-06 |       500.00 | Cancelled |
|     3405 |        2004 | 2025-04-08 |      7000.00 | Pending   |
|     3406 |        2004 | 2025-05-10 |     47000.00 | Shipped   |
+----------+-------------+------------+--------------+-----------+

-- 5. Order Items Table
CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    subtotal DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Order_Items (order_id,product_id,quantity,subtotal) VALUES
(3401,101,1,55000),
(3403,103,2,4800),
(3405,102,1,3000),
(3401,106,5,22000),
(3404,104,8,85000),
(3402,105,4,7000);

SELECT * FROM Order_Items;
+---------------+----------+------------+----------+----------+
| order_item_id | order_id | product_id | quantity | subtotal |
+---------------+----------+------------+----------+----------+
|             1 |     3401 |        101 |        1 | 55000.00 |
|             2 |     3403 |        103 |        2 |  4800.00 |
|             3 |     3405 |        102 |        1 |  3000.00 |
|             4 |     3401 |        106 |        5 | 22000.00 |
|             5 |     3404 |        104 |        8 | 85000.00 |
|             6 |     3402 |        105 |        4 |  7000.00 |
+---------------+----------+------------+----------+----------+

-- 6. Payments Table

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY ,
    order_id INT,
    payment_date DATE,
    payment_method VARCHAR(50),
    payment_status VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);


INSERT INTO Payments (payment_id,order_id,payment_date,payment_method,payment_status) VALUES
(001,3401,'2025-04-01','UPI','Paid'),
(002,3402,'2025-04-02','Credit Card','Paid'),
(003,3403,'2025-04-10','PayPal','Pending'),
(004,3404,'2025-05-06','UPI','Failed'),
(005,3405,'2025-05-12','Credit Card','Paid'),
(006,3406,'2025-04-06','UPI','Paid');

SELECT * FROM Payments;
+------------+----------+--------------+----------------+----------------+
| payment_id | order_id | payment_date | payment_method | payment_status |
+------------+----------+--------------+----------------+----------------+
|          1 |     3401 | 2025-04-01   | UPI            | Paid           |
|          2 |     3402 | 2025-04-02   | Credit Card    | Paid           |
|          3 |     3403 | 2025-04-10   | PayPal         | Pending        |
|          4 |     3404 | 2025-05-06   | UPI            | Failed         |
|          5 |     3405 | 2025-05-12   | Credit Card    | Paid           |
|          6 |     3406 | 2025-04-06   | UPI            | Paid           |
+------------+----------+--------------+----------------+----------------+

-- 7. Shipping Table
CREATE TABLE Shipping (
    shipping_id INT PRIMARY KEY,
    order_id INT,
    shipping_date DATE,
    delivery_date DATE,
    shipping_status VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);


INSERT INTO Shipping (shipping_id,order_id,shipping_date,delivery_date,shipping_status) VALUES
(7801, 3401, '2025-03-02', '2025-03-08', 'Delivered'),
(7802, 3402, '2025-03-04', '2025-03-10', 'Delivered'),
(7803, 3403, '2025-04-06', NULL, 'Pending'),
(7804, 3404, '2025-04-07', NULL, 'Shipped'),
(7805, 3405, '2025-04-08', '2025-04-10', 'Delivered'),
(7806, 3406, '2025-04-09', NULL, 'Processing');

SELECT * FROM Shipping;
+-------------+----------+---------------+---------------+-----------------+
| shipping_id | order_id | shipping_date | delivery_date | shipping_status |
+-------------+----------+---------------+---------------+-----------------+
|        7801 |     3401 | 2025-03-02    | 2025-03-08    | Delivered       |
|        7802 |     3402 | 2025-03-04    | 2025-03-10    | Delivered       |
|        7803 |     3403 | 2025-04-06    | NULL          | Pending         |
|        7804 |     3404 | 2025-04-07    | NULL          | Shipped         |
|        7805 |     3405 | 2025-04-08    | 2025-04-10    | Delivered       |
|        7806 |     3406 | 2025-04-09    | NULL          | Processing      |
+-------------+----------+---------------+---------------+-----------------+

-- CRUD OPERATIONS

-- Insert new products
INSERT INTO Products 
(product_id, name, category_id, price, stock_quantity, added_date)
VALUES
(107,'Smart Watch',1,3500,20,'2025-04-12');

mysql> SELECT * FROM Products;
+------------+-------------+-------------+----------+----------------+------------+
| product_id | name        | category_id | price    | stock_quantity | added_date |
+------------+-------------+-------------+----------+----------------+------------+
|        101 | Laptop      |           1 | 55000.00 |            768 | 2025-01-10 |
|        102 | Mobile      |           1 | 30000.00 |            876 | 2025-02-15 |
|        103 | T-Shirt     |           2 |   800.00 |            350 | 2025-03-01 |
|        104 | Novel       |           3 |   500.00 |            400 | 2025-03-12 |
|        105 | Microwave   |           4 | 70000.00 |            108 | 2025-04-01 |
|        106 | Headphones  |           1 |  2000.00 |            725 | 2025-04-10 |
|        107 | Smart Watch |           1 |  3500.00 |             20 | 2025-04-12 |
+------------+-------------+-------------+----------+----------------+------------+

-- Insert new customers
INSERT INTO Customers
(customer_id, name, email, phone_number, address, registration_date)
VALUES
(2007,'Riya Sharma','riya@gmail.com','9876543299','Mumbai','2025-04-12');

mysql> SELECT * FROM Customers;
+-------------+-----------------+-------------------+--------------+---------+-------------------+
| customer_id | name            | email             | phone_number | address | registration_date |
+-------------+-----------------+-------------------+--------------+---------+-------------------+
|        2001 | Sakshi Bagul    | Sakshi@gmail.com  | 9876543210   | Mumbai  | 2023-05-10        |
|        2002 | Happy Patel     | Happy@gmail.com   | 8767432113   | Surat   | 2024-06-15        |
|        2003 | Disha Choudhari | Disha@gmail.com   | 7287654325   | Delhi   | 2022-08-20        |
|        2004 | Mansi Pawar     | Mansi@gmail.com   | 5658432130   | Pune    | 2025-01-01        |
|        2005 | Krishna Patil   | Krishna@gmail.com | 8780843649   | Mumbai  | 2025-05-21        |
|        2006 | komal Patel     | komal@gmail.com   | 7689545685   | Surat   | 2024-04-08        |
|        2007 | Riya Sharma     | riya@gmail.com    | 9876543299   | Mumbai  | 2025-04-12        |
+-------------+-----------------+-------------------+--------------+---------+-------------------+

-- Insert new orders
INSERT INTO Orders
(order_id, customer_id, order_date, total_amount, status)
VALUES
(3407,2007,'2025-04-12',3500,'Pending');

mysql> SELECT * FROM Orders;
+----------+-------------+------------+--------------+-----------+
| order_id | customer_id | order_date | total_amount | status    |
+----------+-------------+------------+--------------+-----------+
|     3401 |        2001 | 2025-04-01 |     55800.00 | Pending   |
|     3402 |        2002 | 2025-04-02 |     30000.00 | Shipped   |
|     3403 |        2001 | 2025-04-05 |     20000.00 | Delivered |
|     3404 |        2003 | 2025-04-06 |       500.00 | Cancelled |
|     3405 |        2004 | 2025-04-08 |      7000.00 | Pending   |
|     3406 |        2004 | 2025-05-10 |     47000.00 | Shipped   |
|     3407 |        2007 | 2025-04-12 |      3500.00 | Pending   |
+----------+-------------+------------+--------------+-----------+

-- Update stock when an order is placed
UPDATE Products
SET stock_quantity = stock_quantity - 2
WHERE product_id = 105;

mysql> SELECT * FROM Products;
+------------+-------------+-------------+----------+----------------+------------+
| product_id | name        | category_id | price    | stock_quantity | added_date |
+------------+-------------+-------------+----------+----------------+------------+
|        101 | Laptop      |           1 | 55000.00 |            768 | 2025-01-10 |
|        102 | Mobile      |           1 | 30000.00 |            876 | 2025-02-15 |
|        103 | T-Shirt     |           2 |   800.00 |            350 | 2025-03-01 |
|        104 | Novel       |           3 |   500.00 |            400 | 2025-03-12 |
|        105 | Microwave   |           4 | 70000.00 |            106 | 2025-04-01 |
|        106 | Headphones  |           1 |  2000.00 |            725 | 2025-04-10 |
|        107 | Smart Watch |           1 |  3500.00 |             20 | 2025-04-12 |
+------------+-------------+-------------+----------+----------------+------------+

-- Delete orders that were cancelled more than 30 days ago
DELETE FROM Order_Items
WHERE order_id IN (
    SELECT order_id
    FROM Orders
    WHERE status = 'Cancelled'
    AND order_date < CURDATE() - INTERVAL 30 DAY
);

mysql> select * from Order_Items;
+---------------+----------+------------+----------+----------+
| order_item_id | order_id | product_id | quantity | subtotal |
+---------------+----------+------------+----------+----------+
|             1 |     3401 |        101 |        1 | 55000.00 |
|             2 |     3403 |        103 |        2 |  4800.00 |
|             3 |     3405 |        102 |        1 |  3000.00 |
|             4 |     3401 |        106 |        5 | 22000.00 |
|             6 |     3402 |        105 |        4 |  7000.00 |
+---------------+----------+------------+----------+----------+

-- all orders placed in the last 1 year 
SELECT * FROM Orders
WHERE order_date >= CURDATE() - INTERVAL 1 YEAR;
+----------+-------------+------------+--------------+---------+
| order_id | customer_id | order_date | total_amount | status  |
+----------+-------------+------------+--------------+---------+
|     3406 |        2004 | 2025-05-10 |     47000.00 | Shipped |
+----------+-------------+------------+--------------+---------+

-- the top 5 highest-priced products
SELECT * FROM Products
ORDER BY price DESC
LIMIT 5;
+------------+-------------+-------------+----------+----------------+------------+
| product_id | name        | category_id | price    | stock_quantity | added_date |
+------------+-------------+-------------+----------+----------------+------------+
|        105 | Microwave   |           4 | 70000.00 |            106 | 2025-04-01 |
|        101 | Laptop      |           1 | 55000.00 |            768 | 2025-01-10 |
|        102 | Mobile      |           1 | 30000.00 |            876 | 2025-02-15 |
|        107 | Smart Watch |           1 |  3500.00 |             20 | 2025-04-12 |
|        106 | Headphones  |           1 |  2000.00 |            725 | 2025-04-10 |
+------------+-------------+-------------+----------+----------------+------------+

-- customers who have placed more than 1 orders
SELECT customer_id, COUNT(order_id) total_orders
FROM Orders
GROUP BY customer_id
HAVING COUNT(order_id) > 1;
+-------------+--------------+
| customer_id | total_orders |
+-------------+--------------+
|        2001 |            2 |
|        2004 |            2 |
+-------------+--------------+


--all orders where status 
SELECT Orders.order_id, Orders.status, Payments.payment_status
FROM Orders
JOIN Payments ON Orders.order_id = Payments.order_id
WHERE Orders.status = 'Pending'
AND Payments.payment_status = 'Paid';

+----------+---------+----------------+
| order_id | status  | payment_status |
+----------+---------+----------------+
|     3401 | Pending | Paid           |
|     3405 | Pending | Paid           |
+----------+---------+----------------+

-- all products that are NOT out of stock
SELECT * FROM Products
 WHERE stock_quantity > 0;

+------------+-------------+-------------+----------+----------------+------------+
| product_id | name        | category_id | price    | stock_quantity | added_date |
+------------+-------------+-------------+----------+----------------+------------+
|        101 | Laptop      |           1 | 55000.00 |            768 | 2025-01-10 |
|        102 | Mobile      |           1 | 30000.00 |            876 | 2025-02-15 |
|        103 | T-Shirt     |           2 |   800.00 |            350 | 2025-03-01 |
|        104 | Novel       |           3 |   500.00 |            400 | 2025-03-12 |
|        105 | Microwave   |           4 | 70000.00 |            106 | 2025-04-01 |
|        106 | Headphones  |           1 |  2000.00 |            725 | 2025-04-10 |
|        107 | Smart Watch |           1 |  3500.00 |             20 | 2025-04-12 |
+------------+-------------+-------------+----------+----------------+------------+

-- who registered after 2022 OR  purchases above ₹10,000
SELECT *
FROM Customers
WHERE registration_date > '2022-12-31'
OR customer_id IN (
SELECT customer_id FROM Orders WHERE total_amount > 10000
);

+-------------+---------------+-------------------+--------------+---------+-------------------+
| customer_id | name          | email             | phone_number | address | registration_date |
+-------------+---------------+-------------------+--------------+---------+-------------------+
|        2001 | Sakshi Bagul  | Sakshi@gmail.com  | 9876543210   | Mumbai  | 2023-05-10        |
|        2002 | Happy Patel   | Happy@gmail.com   | 8767432113   | Surat   | 2024-06-15        |
|        2004 | Mansi Pawar   | Mansi@gmail.com   | 5658432130   | Pune    | 2025-01-01        |
|        2005 | Krishna Patil | Krishna@gmail.com | 8780843649   | Mumbai  | 2025-05-21        |
|        2006 | komal Patel   | komal@gmail.com   | 7689545685   | Surat   | 2024-04-08        |
|        2007 | Riya Sharma   | riya@gmail.com    | 9876543299   | Mumbai  | 2025-04-12        |
+-------------+---------------+-------------------+--------------+---------+-------------------+

--  all products in descending order
SELECT * FROM Products
ORDER BY price DESC;

+------------+-------------+-------------+----------+----------------+------------+
| product_id | name        | category_id | price    | stock_quantity | added_date |
+------------+-------------+-------------+----------+----------------+------------+
|        105 | Microwave   |           4 | 70000.00 |            106 | 2025-04-01 |
|        101 | Laptop      |           1 | 55000.00 |            768 | 2025-01-10 |
|        102 | Mobile      |           1 | 30000.00 |            876 | 2025-02-15 |
|        107 | Smart Watch |           1 |  3500.00 |             20 | 2025-04-12 |
|        106 | Headphones  |           1 |  2000.00 |            725 | 2025-04-10 |
|        103 | T-Shirt     |           2 |   800.00 |            350 | 2025-03-01 |
|        104 | Novel       |           3 |   500.00 |            400 | 2025-03-12 |
+------------+-------------+-------------+----------+----------------+------------+

-- the number of orders placed by each customer
SELECT customer_id, COUNT(order_id) total_orders
FROM Orders
GROUP BY customer_id;

+-------------+--------------+
| customer_id | total_orders |
+-------------+--------------+
|        2001 |            2 |
|        2002 |            1 |
|        2003 |            1 |
|        2004 |            2 |
|        2007 |            1 |
+-------------+--------------+

-- total revenue generated per category
SELECT C.category_name, SUM(OI.subtotal) AS total_revenue
FROM Categories C
JOIN Products P 
ON C.category_id = P.category_id
JOIN Order_Items OI
 ON P.product_id = OI.product_id
GROUP BY C.category_name;

+-----------------+---------------+
| category_name   | total_revenue |
+-----------------+---------------+
| Electronics     |      80000.00 |
| Clothing        |       4800.00 |
| Home Appliances |       7000.00 |
+-----------------+---------------+

-- the total revenue generated by the store
SELECT SUM(total_amount) TotalRevenue FROM Orders;

+--------------+
| TotalRevenue |
+--------------+
|    163800.00 |
+--------------+

-- the most purchased product
SELECT product_id, SUM(quantity) as Total_Purchased
FROM Order_Items
GROUP BY product_id
ORDER BY Total_Purchased DESC
LIMIT 1;
+------------+-----------------+
| product_id | Total_Purchased |
+------------+-----------------+
|        106 |               5 |
+------------+-----------------+

-- the average order value
SELECT AVG(total_amount) AverageOrderValue FROM Orders;

+-------------------+
| AverageOrderValue |
+-------------------+
|      23400.000000 |
+-------------------+

-- Orders table → Customer se linked
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    status VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Order_Items table -> Order + Product se linked
CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    subtotal DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Payments Table -> Order Table se linked
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_date DATE,
    payment_method VARCHAR(50),
    payment_status VARCHAR(50),

    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);
-- JOINS

-- products with category names using INNER JOIN
SELECT P.product_id,P.name,C.category_name
FROM Products P
INNER JOIN Categories C
ON P.category_id = C.category_id;

+------------+-------------+-----------------+
| product_id | name        | category_name   |
+------------+-------------+-----------------+
|        101 | Laptop      | Electronics     |
|        102 | Mobile      | Electronics     |
|        106 | Headphones  | Electronics     |
|        107 | Smart Watch | Electronics     |
|        103 | T-Shirt     | Clothing        |
|        104 | Novel       | Books           |
|        105 | Microwave   | Home Appliances |
+------------+-------------+-----------------+

-- orders with customer details using LEFT JOIN
SELECT O.order_id,O.order_date,C.name,C.email
FROM Orders O
LEFT JOIN Customers C
ON O.customer_id = C.customer_id;

+----------+------------+-----------------+------------------+
| order_id | order_date | name            | email            |
+----------+------------+-----------------+------------------+
|     3401 | 2025-04-01 | Sakshi Bagul    | Sakshi@gmail.com |
|     3402 | 2025-04-02 | Happy Patel     | Happy@gmail.com  |
|     3403 | 2025-04-05 | Sakshi Bagul    | Sakshi@gmail.com |
|     3404 | 2025-04-06 | Disha Choudhari | Disha@gmail.com  |
|     3405 | 2025-04-08 | Mansi Pawar     | Mansi@gmail.com  |
|     3406 | 2025-05-10 | Mansi Pawar     | Mansi@gmail.com  |
|     3407 | 2025-04-12 | Riya Sharma     | riya@gmail.com   |
+----------+------------+-----------------+------------------+

-- orders that haven’t been shipped using RIGHT JOIN
SELECT O.order_id,S.shipping_status
FROM Shipping S
RIGHT JOIN Orders O
ON S.order_id = O.order_id
WHERE S.shipping_id IS NULL;

+----------+-----------------+
| order_id | shipping_status |
+----------+-----------------+
|     3407 | NULL            |
+----------+-----------------+

-- customers who never placed an order using FULL OUTER JOIN
SELECT C.customer_id,C.name
FROM Customers C
LEFT JOIN Orders O
ON C.customer_id = O.customer_id

UNION

SELECT C.customer_id,C.name
FROM Customers C
RIGHT JOIN Orders O
ON C.customer_id = O.customer_id
WHERE O.order_id IS NULL;

+-------------+-----------------+
| customer_id | name            |
+-------------+-----------------+
|        2001 | Sakshi Bagul    |
|        2002 | Happy Patel     |
|        2003 | Disha Choudhari |
|        2004 | Mansi Pawar     |
|        2005 | Krishna Patil   |
|        2006 | komal Patel     |
|        2007 | Riya Sharma     |
+-------------+-----------------+

-- SUBQUERIES

-- Orders placed by customers who registered after 2022
SELECT * FROM Orders
WHERE customer_id IN (
SELECT customer_id 
FROM Customers
WHERE registration_date>'2022-12-31'
);

+----------+-------------+------------+--------------+-----------+
| order_id | customer_id | order_date | total_amount | status    |
+----------+-------------+------------+--------------+-----------+
|     3401 |        2001 | 2025-04-01 |     55800.00 | Pending   |
|     3403 |        2001 | 2025-04-05 |     20000.00 | Delivered |
|     3402 |        2002 | 2025-04-02 |     30000.00 | Shipped   |
|     3405 |        2004 | 2025-04-08 |      7000.00 | Pending   |
|     3406 |        2004 | 2025-05-10 |     47000.00 | Shipped   |
|     3407 |        2007 | 2025-04-12 |      3500.00 | Pending   |
+----------+-------------+------------+--------------+-----------+

-- Identify the customer who has spent the most 
SELECT customer_id,
SUM(total_amount) AS total_spent
FROM Orders
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 1;

+-------------+-------------+
| customer_id | total_spent |
+-------------+-------------+
|        2001 |    75800.00 |
+-------------+-------------+

-- Get products that have never been ordered
SELECT * FROM Products
WHERE product_id NOT IN (
SELECT product_id
FROM Order_Items
);
+------------+-------------+-------------+---------+----------------+------------+
| product_id | name        | category_id | price   | stock_quantity | added_date |
+------------+-------------+-------------+---------+----------------+------------+
|        104 | Novel       |           3 |  500.00 |            400 | 2025-03-12 |
|        107 | Smart Watch |           1 | 3500.00 |             20 | 2025-04-12 |
+------------+-------------+-------------+---------+----------------+------------+

-- Extract month from order_date
SELECT MONTH(order_date) AS Month,
COUNT(*) AS TotalOrders
FROM Orders
GROUP BY MONTH(order_date);

+-------+-------------+
| Month | TotalOrders |
+-------+-------------+
|     4 |           6 |
|     5 |           1 |
+-------+-------------+

-- Calculate delivery time 
SELECT shipping_id,
DATEDIFF(delivery_date,shipping_date) AS Delivery_Days
FROM Shipping;

+-------------+---------------+
| shipping_id | Delivery_Days |
+-------------+---------------+
|        7801 |             6 |
|        7802 |             6 |
|        7803 |          NULL |
|        7804 |          NULL |
|        7805 |             2 |
|        7806 |          NULL |
+-------------+---------------+

-- Format order_date as DD-MM-YYYY
SELECT order_id,order_date,
DATE_FORMAT(order_date, '%d-%m-%Y') AS formatted_date
FROM Orders;

+----------+------------+----------------+
| order_id | order_date | formatted_date |
+----------+------------+----------------+
|     3401 | 2025-04-01 | 01-04-2025     |
|     3402 | 2025-04-02 | 02-04-2025     |
|     3403 | 2025-04-05 | 05-04-2025     |
|     3404 | 2025-04-06 | 06-04-2025     |
|     3405 | 2025-04-08 | 08-04-2025     |
|     3406 | 2025-05-10 | 10-05-2025     |
|     3407 | 2025-04-12 | 12-04-2025     |
+----------+------------+----------------+

-- Convert all product names to uppercase
SELECT name,
UPPER(name) AS PN_uppercase
 FROM Products;

+-------------+--------------+
| name        | PN_uppercase |
+-------------+--------------+
| Laptop      | LAPTOP       |
| Mobile      | MOBILE       |
| T-Shirt     | T-SHIRT      |
| Novel       | NOVEL        |
| Microwave   | MICROWAVE    |
| Headphones  | HEADPHONES   |
| Smart Watch | SMART WATCH  |
+-------------+--------------+

-- Trim whitespace from customer names
SELECT TRIM(name) AS customer_name 
 FROM Customers;

+-----------------+
| customer_name   |
+-----------------+
| Sakshi Bagul    |
| Happy Patel     |
| Disha Choudhari |
| Mansi Pawar     |
| Krishna Patil   |
| komal Patel     |
| Riya Sharma     |
+-----------------+

-- Replace missing email values with "Not Provided"
SELECT  name,
IFNULL(email,'Not Provided') AS email_status
FROM Customers;

+-----------------+-------------------+
| name            | email_status      |
+-----------------+-------------------+
| Sakshi Bagul    | Sakshi@gmail.com  |
| Happy Patel     | Happy@gmail.com   |
| Disha Choudhari | Disha@gmail.com   |
| Mansi Pawar     | Mansi@gmail.com   |
| Krishna Patil   | Krishna@gmail.com |
| komal Patel     | komal@gmail.com   |
| Riya Sharma     | riya@gmail.com    |
+-----------------+-------------------+

-- Rank customers based on total spending
SELECT customer_id,
SUM(total_amount) AS total_spending,
RANK() OVER (ORDER BY SUM(total_amount) DESC) AS customer_rank
FROM Orders
GROUP BY customer_id;

+-------------+----------------+---------------+
| customer_id | total_spending | customer_rank |
+-------------+----------------+---------------+
|        2001 |       75800.00 |             1 |
|        2004 |       54000.00 |             2 |
|        2002 |       30000.00 |             3 |
|        2007 |        3500.00 |             4 |
|        2003 |         500.00 |             5 |
+-------------+----------------+---------------+

-- Show cumulative total revenue per month
SELECT MONTH(order_date) AS month,
SUM(total_amount) AS monthly_revenue,
SUM(SUM(total_amount)) OVER (ORDER BY MONTH(order_date)) AS cumulative_revenue
FROM Orders
GROUP BY MONTH(order_date);

+-------+-----------------+--------------------+
| month | monthly_revenue | cumulative_revenue |
+-------+-----------------+--------------------+
|     4 |       116800.00 |          116800.00 |
|     5 |        47000.00 |          163800.00 |
+-------+-----------------+--------------------+

-- Display running total of orders placed
SELECT order_id,order_date,
COUNT(order_id) OVER (ORDER BY order_date) AS running_total_orders
FROM Orders;

+----------+------------+----------------------+
| order_id | order_date | running_total_orders |
+----------+------------+----------------------+
|     3401 | 2025-04-01 |                    1 |
|     3402 | 2025-04-02 |                    2 |
|     3403 | 2025-04-05 |                    3 |
|     3404 | 2025-04-06 |                    4 |
|     3405 | 2025-04-08 |                    5 |
|     3407 | 2025-04-12 |                    6 |
|     3406 | 2025-05-10 |                    7 |
+----------+------------+----------------------+

-- Assign Loyalty_Status to customers
SELECT customer_id,
SUM(total_amount) AS total_spent,
CASE
    WHEN SUM(total_amount) > 50000 THEN 'Gold'
    WHEN SUM(total_amount) BETWEEN 20000 AND 50000 THEN 'Silver'
    ELSE 'Bronze'
END AS Loyalty_Status
FROM Orders
GROUP BY customer_id;

+-------------+-------------+----------------+
| customer_id | total_spent | Loyalty_Status |
+-------------+-------------+----------------+
|        2001 |    75800.00 | Gold           |
|        2002 |    30000.00 | Silver         |
|        2003 |      500.00 | Bronze         |
|        2004 |    54000.00 | Gold           |
|        2007 |     3500.00 | Bronze         |
+-------------+-------------+----------------+

-- Categorize products
SELECT product_id,name,stock_quantity,
CASE
    WHEN stock_quantity > 500 THEN 'Best Seller'
    WHEN stock_quantity BETWEEN 200 AND 500 THEN 'Popular'
    ELSE 'Regular'
END AS Product_Category
FROM Products;

+------------+-------------+----------------+------------------+
| product_id | name        | stock_quantity | Product_Category |
+------------+-------------+----------------+------------------+
|        101 | Laptop      |            768 | Best Seller      |
|        102 | Mobile      |            876 | Best Seller      |
|        103 | T-Shirt     |            350 | Popular          |
|        104 | Novel       |            400 | Popular          |
|        105 | Microwave   |            106 | Regular          |
|        106 | Headphones  |            725 | Best Seller      |
|        107 | Smart Watch |             20 | Regular          |
+------------+-------------+----------------+------------------+