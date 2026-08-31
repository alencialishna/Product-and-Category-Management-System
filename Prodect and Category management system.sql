CREATE DATABASE IF NOT EXISTS ecommerce_category_db;

USE ecommerce_category_db;

DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Category;

CREATE TABLE Category (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(255) NOT NULL
);
CREATE TABLE Product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category_id INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL,

    CONSTRAINT chk_product_price
    CHECK (price > 0),

    CONSTRAINT chk_stock_quantity
    CHECK (stock_quantity >= 0),

    CONSTRAINT fk_product_category
    FOREIGN KEY (category_id)
    REFERENCES Category(category_id)
);
INSERT INTO Category (category_name, description)
VALUES
('Electronics', 'Electronic devices and accessories'),
('Clothing', 'Fashion and clothing products'),
('Books', 'Educational and entertainment books'),
('Home Appliances', 'Appliances used at home'),
('Sports', 'Sports equipment and accessories');

INSERT INTO Product
(product_name, category_id, price, stock_quantity)
VALUES
('Laptop', 1, 65000.00, 15),
('Smartphone', 1, 30000.00, 25),
('Wireless Headphones', 1, 2500.00, 40),
('Smart Watch', 1, 5000.00, 20),
('Bluetooth Speaker', 1, 3500.00, 30),
('USB Keyboard', 1, 1200.00, 50),

('T-Shirt', 2, 799.00, 50),
('Jeans', 2, 1499.00, 30),
('Hoodie', 2, 1999.00, 20),

('Java Programming', 3, 650.00, 25),
('Data Structures', 3, 750.00, 20),
('Artificial Intelligence', 3, 900.00, 15),

('Washing Machine', 4, 28000.00, 10),
('Microwave Oven', 4, 12000.00, 12),
('Air Cooler', 4, 9000.00, 18);

SELECT * FROM Category;

SELECT * FROM Product;

INSERT INTO Product
(product_name, category_id, price, stock_quantity)
VALUES
('Gaming Mouse', 1, 1800.00, 35);


SELECT * FROM Product
WHERE product_name = 'Gaming Mouse';

UPDATE Product
SET price = 68000.00
WHERE product_name = 'Laptop';

SELECT * FROM Product
WHERE product_name = 'Laptop';


UPDATE Product
SET stock_quantity = 25
WHERE product_name = 'Laptop';

SELECT * FROM Product
WHERE product_name = 'Laptop';


DELETE FROM Product
WHERE product_name = 'Bluetooth Speaker';


SELECT * FROM Product;

SELECT
    c.category_name,
    p.product_name,
    p.price,
    p.stock_quantity
FROM Category c
INNER JOIN Product p
ON c.category_id = p.category_id
ORDER BY c.category_name;

SELECT
    c.category_name,
    COUNT(p.product_id) AS product_count
FROM Category c
LEFT JOIN Product p
ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name
ORDER BY c.category_name;

SELECT
    c.category_name,
    p.product_name,
    p.price AS highest_price
FROM Category c
INNER JOIN Product p
ON c.category_id = p.category_id
WHERE p.price = (
    SELECT MAX(p2.price)
    FROM Product p2
    WHERE p2.category_id = p.category_id
)
ORDER BY c.category_name;


SELECT
    c.category_name,
    COUNT(p.product_id) AS product_count
FROM Category c
INNER JOIN Product p
ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name
HAVING COUNT(p.product_id) > 5;

SELECT
    c.category_name,
    ROUND(AVG(p.price), 2) AS average_price
FROM Category c
INNER JOIN Product p
ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name
ORDER BY c.category_name;

SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    p.price,
    p.stock_quantity
FROM Product p
INNER JOIN Category c
ON p.category_id = c.category_id
ORDER BY p.product_id;