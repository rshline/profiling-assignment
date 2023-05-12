-- SELECT statement
SELECT customerNumber, customerName, creditLimit FROM customers
WHERE customerNumber IN (
	SELECT customerNumber FROM customers
    WHERE creditLimit > 100000
);

-- INSERT statement
INSERT INTO customers (customerNumber, customerName, contactLastName, contactFirstName, phone, addressLine1, addressLine2, city, state, postalCode, country, salesRepEmployeeNumber, creditLimit) VALUES (
	497,
    'Amygdala Co.',
    'Zuckerberg',
    'Elon',
    '+6281234567890',
    '1234 Baker St.',
    NULL,
    'Helsinki',
    NULL,
    '21240',
    'Finland',
    (SELECT employeeNumber FROM employees WHERE email = 'dmurphy@classicmodelcars.com'),
    '0.00'
);
SELECT * FROM customers WHERE customerNumber=497;

-- UPDATE statement
UPDATE customers
SET creditLimit = creditLimit * 0.7
WHERE customerNumber IN (
	SELECT customerNumber FROM (
		SELECT customerNumber FROM customers WHERE creditLimit > 200000
	) AS temp_table
);

SELECT * FROM customers WHERE creditLimit > 140000;

-- DELETE statement
SELECT * FROM payments ORDER BY AMOUNT desc;
DELETE FROM payments
WHERE checkNumber IN (
    SELECT temp_table.checkNumber
    FROM (
        SELECT checkNumber FROM payments WHERE amount >115000
    ) AS temp_table
);
SELECT * FROM payments ORDER BY AMOUNT desc;

-- Filter dari column dengan agregasi nilai paling besar
SELECT * FROM products 
WHERE buyPrice IN (
	SELECT MAX(buyPrice) FROM products 
);

-- Query dari Subquery sebagai source data
SELECT customerName, SUM(quantityOrdered) AS totalQty
FROM (
	SELECT customerName, quantityOrdered FROM customers c
	JOIN orders o ON c.customerNumber = o.customerNumber
	JOIN orderdetails d ON d.orderNumber = o.orderNumber
) AS customerOrderedQty
GROUP BY customerName 
ORDER BY totalQty DESC;

-- Combine query UNION 
(SELECT l.firstName, l.lastName
FROM employees e
INNER JOIN employees l ON e.reportsTo = l.employeeNumber)
UNION
(SELECT e.firstName, e.lastName
FROM employees e
INNER JOIN employees l ON e.reportsTo = l.employeeNumber);

-- Combine query INTERSECT
(SELECT l.firstName, l.lastName
FROM employees e
INNER JOIN employees l ON e.reportsTo = l.employeeNumber)
INTERSECT
(SELECT e.firstName, e.lastName
FROM employees e
INNER JOIN employees l ON e.reportsTo = l.employeeNumber);