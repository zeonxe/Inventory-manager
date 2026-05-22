DROP DATABASE IF EXISTS inventory_db;
CREATE DATABASE inventory_db;
USE inventory_db;

-- Create Products table
CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(5,2) NOT NULL,
    quantity INT NOT NULL
);

-- Create Transactions table
CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    change_amount INT NOT NULL,
    transaction_type ENUM('RESTOCK', 'SALE') NOT NULL,
    transaction_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Insert sample data
INSERT INTO Products (product_name, price, quantity) VALUES
('Turkey Sandwich', 6.00, 10),
('Tuna Sandwich', 6.99, 8),
('Protein Bar', 1.50, 20),
('Chips', 2.00, 15),
('Water Bottle', 1.00, 19),
('Energy Drink', 2.50, 10),
('Apple', 0.60, 14),
('Chicken Wrap', 5.00, 17);

-- Test restock
UPDATE Products
SET quantity = quantity + 10
WHERE product_id = 1;

INSERT INTO Transactions (product_id, change_amount, transaction_type)
VALUES (1, 10, 'RESTOCK');

-- Test sale
UPDATE Products
SET quantity = quantity - 3
WHERE product_id = 2;

INSERT INTO Transactions (product_id, change_amount, transaction_type)
VALUES (2, -3, 'SALE');

-- Show current inventory
SELECT * FROM Products;

-- Show transaction history
SELECT * FROM Transactions;

-- Show readable transaction history with product names
SELECT 
    t.transaction_id,
    p.product_name,
    t.change_amount,
    t.transaction_type,
    t.transaction_date
FROM Transactions t
JOIN Products p
    ON t.product_id = p.product_id
ORDER BY t.transaction_date DESC;

-- Show low stock items
SELECT *
FROM Products
WHERE quantity < 10;