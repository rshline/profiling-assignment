-- Querying Data
SELECT * FROM products;

-- Sorting Data 
SELECT productName, productVendor, quantityInStock, buyPrice 
FROM products
ORDER BY buyPrice DESC;

SELECT customerName, phone FROM customers
ORDER BY customerName;

-- Filtering Data
SELECT productName, productVendor, quantityInStock, buyPrice 
FROM products
WHERE productName LIKE '19%' AND quantityInStock < 1000
ORDER BY buyPrice;

SELECT customerName, addressLine1, creditLimit FROM customers
WHERE country in ('USA', 'UK')
ORDER BY creditLimit DESC
LIMIT 10;

-- Join
SELECT orderDate, productName, quantityOrdered FROM orders o
INNER JOIN orderdetails d ON o.orderNumber = d.orderNumber
INNER JOIN products p ON d.productCode = p.productCode
ORDER BY orderDate desc;

SELECT 
	CONCAT(e.firstName, ' ', e.lastName) as employee,
    CONCAT(l.firstName, ' ', l.lastName) as leader
FROM employees e
INNER JOIN employees l ON e.reportsTo = l.employeeNumber; 

-- Aggregate
SELECT productLine, AVG(buyPrice) AS averagePrice
FROM products 
GROUP BY productLine
HAVING averagePrice > 50
ORDER BY averagePrice desc;

SELECT 
    CONCAT(e.firstName, ' ', e.lastName) as employee, 
    COUNT(c.customerNumber) as total,
    ROUND(AVG(c.creditLimit), 2) as avgCreditLimit
FROM employees e
INNER JOIN customers c ON c.salesRepEmployeeNumber = e.employeeNumber
GROUP BY employeeNumber
ORDER BY avgCreditLimit;

-- Cursor
DELIMITER $$
CREATE PROCEDURE getAveragePrice()
	BEGIN
		DECLARE averagePrice DECIMAL;
		DECLARE avgPrice CURSOR FOR SELECT AVG(buyPrice) FROM products;
        OPEN avgPrice;
        FETCH avgPrice INTO averagePrice;
        CLOSE avgPrice;
	END $$
DELIMITER ;
CALL getAveragePrice;

-- Indexing
EXPLAIN SELECT * FROM products WHERE productName = 'The Titanic'; /* tanpa index */
CREATE INDEX product_name ON products(productName);
EXPLAIN SELECT * FROM products WHERE productName = 'The Titanic'; /* dengan index */

