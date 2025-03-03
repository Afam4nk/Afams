--- No. 1. Product name and quantity/unit. 
SELECT product_id, product_name, quantity_per_unit
FROM products


--- No. 2. Current Product list (Product ID and name).
SELECT product_id, product_name
FROM Products
WHERE discontinued = 0
ORDER BY product_id ASC


---No. 3. Products by Category 
SELECT product_name, category_name
FROM products p
JOIN categories c ON p.category_id = c.category_id

---No. 4.  discontinued Product list (Product ID and name)
SELECT product_id, product_name
FROM Products
WHERE discontinued = 1
ORDER BY product_id ASC

-- No. 5 Most expensive and least expensive product list
(SELECT product_name, unit_price
FROM Products 
Order BY unit_price DESC
Limit 1)
UNION
(SELECT product_name, unit_price
FROM Products 
Order BY unit_price
Limit 1)

---No 6. Product list (id, name, unit price) where current products cost less than $20. 
SELECT product_id, product_name, unit_price Price_Lessthan_$20
FROM Products
WHERE unit_price < 20


---No 7. Product list (id, name, unit price) where products cost between $15 and $25. 
SELECT product_id, product_name, unit_price Price_Between_$15_and_$25
FROM Products
WHERE unit_price BETWEEN 15 and 25

---No 8. Product list (name, unit price) of above average price. 
SELECT product_id, product_name, unit_price Price_Above_$25
FROM Products
WHERE unit_price > 25


---No 9. Product list (name, unit price) of ten most expensive products. 
SELECT product_name, unit_price Most_Expensive_Products, product_id
FROM Products
ORDER BY unit_price DESC
LIMIT 10


--- No. 10 Get Current and Discontinued products
SELECT product_name,
		CASE WHEN discontinued = 0 THEN 1 ELSE 0 END AS current_product,
		CASE WHEN discontinued = 1 THEN 1 ELSE 0 END AS discontinued_products
FROM products

--- To sum the list up
SELECT 
		SUM(CASE WHEN discontinued = 0 THEN 1 ELSE 0 END) AS current_product,
		SUM(CASE WHEN discontinued = 1 THEN 1 ELSE 0 END) AS discontinued_products
FROM products


---No. 11. Product list (name, units on order , units in stock) of stock is less than the quantity on order. 
SELECT product_name, units_on_order,units_in_stock
FROM Products
WHERE units_in_stock < units_on_order


---No. 12 Each employee sales amount
SELECT e.employee_id, CONCAT (e.first_name,' ',e.last_name) employee_name, ROUND(SUM(od.quantity*od.unit_price*(1-od.discount))::NUMERIC, 2) Total_Sales
FROM employees e
JOIN orders o ON e.employee_id = o.employee_id
JOIN order_details od ON o.order_id = od.order_id
GROUP BY e.employee_id
ORDER BY total_sales DESC


---No. 13. Write a query that returns the order and calculates sales price for each order after discount is applied. 
SELECT order_id,unit_price,discount, ROUND(SUM(unit_price*(1-discount))::NUMERIC, 2) sales_price
FROM order_details
GROUP BY order_id,unit_price,discount
ORDER BY order_id


---No. 14. list of products sold and the total sales amount per product
SELECT p.product_id, p.product_name, ROUND(SUM(od.quantity*od.unit_price*(1-od.discount))::NUMERIC, 2) Total_Sales_Amount
FROM products p
JOIN order_details od ON p.product_id = od.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_sales_amount DESC


--- no.15 Show sales figures by category for 1997
SELECT * FROM order_details

SELECT c.category_name, SUM(od.quantity*od.unit_price*(1-od.discount)) Total_Sales
FROM order_details od
JOIN products p ON od.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_name

--- For 1997 ROUNDED TO WHOLE FIGURE
SELECT c.category_name,ROUND(SUM(od.quantity*od.unit_price*(1-od.discount))) Total_Sales
FROM order_details od
JOIN products p ON od.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
JOIN orders o ON od.order_id = o.order_id
WHERE EXTRACT (YEAR FROM o.order_date) =1997
GROUP BY c.category_name

--- ROUNDED TO 2 Decimal Place
SELECT c.category_name,ROUND(SUM(od.quantity*od.unit_price*(1-od.discount))::NUMERIC, 2) Total_Sales
FROM order_details od
JOIN products p ON od.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
JOIN orders o ON od.order_id = o.order_id
WHERE EXTRACT (YEAR FROM o.order_date) =1997
GROUP BY c.category_name




