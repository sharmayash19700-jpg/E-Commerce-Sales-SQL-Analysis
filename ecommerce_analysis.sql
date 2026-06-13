CREATE TABLE ecommerce_sales (
    order_id INT PRIMARY KEY,
    order_date DATE,
    customer_id INT,
    segment VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    sales DECIMAL(10,2),
    quantity INT,
    profit DECIMAL(10,2)
);
INSERT INTO ecommerce_sales (order_id, order_date, customer_id, segment, city, state, category, sub_category, sales, quantity, profit) VALUES
(101, '2026-01-15', 501, 'Consumer', 'Delhi', 'Delhi', 'Electronics', 'Phones', 1200.00, 2, 300.00),
(102, '2026-01-16', 502, 'Corporate', 'Mumbai', 'Maharashtra', 'Furniture', 'Chairs', 850.00, 3, 120.00),
(103, '2026-01-18', 503, 'Consumer', 'Bangalore', 'Karnataka', 'Office Supplies', 'Paper', 45.00, 5, 20.00),
(104, '2026-02-02', 504, 'Home Office', 'Delhi', 'Delhi', 'Furniture', 'Tables', 1500.00, 1, -150.00),
(105, '2026-02-10', 501, 'Consumer', 'Delhi', 'Delhi', 'Electronics', 'Laptops', 2500.00, 1, 500.00),
(106, '2026-02-14', 505, 'Corporate', 'Pune', 'Maharashtra', 'Office Supplies', 'Binders', 12.00, 2, 4.00),
(107, '2026-03-01', 506, 'Consumer', 'Mumbai', 'Maharashtra', 'Electronics', 'Phones', 900.00, 1, 150.00),
(108, '2026-03-05', 507, 'Home Office', 'Chennai', 'Tamil Nadu', 'Furniture', 'Chairs', 600.00, 2, -50.00),
(109, '2026-03-12', 502, 'Corporate', 'Mumbai', 'Maharashtra', 'Office Supplies', 'Art', 35.00, 4, 10.00),
(110, '2026-03-20', 508, 'Consumer', 'Hyderabad', 'Telangana', 'Electronics', 'Accessories', 150.00, 3, 45.00),
(111, '2026-04-02', 509, 'Corporate', 'Bangalore', 'Karnataka', 'Furniture', 'Tables', 1800.00, 2, -200.00),
(112, '2026-04-10', 510, 'Consumer', 'Kolkata', 'West Bengal', 'Office Supplies', 'Paper', 25.00, 2, 11.00),
(113, '2026-04-15', 504, 'Home Office', 'Delhi', 'Delhi', 'Electronics', 'Phones', 1100.00, 2, 250.00),
(114, '2026-04-22', 506, 'Consumer', 'Mumbai', 'Maharashtra', 'Furniture', 'Chairs', 700.00, 2, 90.00),
(115, '2026-04-29', 511, 'Corporate', 'Ahmedabad', 'Gujarat', 'Office Supplies', 'Fasteners', 8.00, 1, 3.00);

select * from ecommerce_sales

-- Q1. What is the total revenue, total profit, and total quantity of products sold by the company?

SELECT
    SUM(sales) AS total_revenue,
    SUM(profit) AS total_net_profit,
    SUM(quantity) AS total_products_sold
FROM ecommerce_sales;

-- Q2. How much total sales and profit has each product category generated?

SELECT 
    category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM ecommerce_sales
GROUP BY category
ORDER BY total_sales DESC;

-- Q3. Which are the top 3 states with the highest sales revenue?

SELECT 
    state,
    SUM(sales) AS total_sales
FROM ecommerce_sales
GROUP BY state
ORDER BY total_sales DESC
LIMIT 3;

-- Q4. Which customer segment generates the highest profit for the company?

SELECT 
    segment,
    SUM(profit) AS total_profit
FROM ecommerce_sales
GROUP BY segment
ORDER BY total_profit DESC;

-- Q5: What is the average sales and average profit per order?
SELECT 
    AVG(sales) AS average_order_value,
    AVG(profit) AS average_profit_per_order
FROM ecommerce_sales;

-- Q6. Which sub-categories are generating an overall loss for the company?

SELECT 
    sub_category,
    SUM(sales) AS total_sales,
    SUM(profit) AS net_loss
FROM ecommerce_sales
GROUP BY sub_category
HAVING SUM(profit) < 0
ORDER BY net_loss ASC;

-- Q7. How many unique customers have placed orders with the company?

SELECT 
    COUNT(DISTINCT customer_id) AS total_unique_customers
FROM ecommerce_sales;

-- Q8. Which orders generated sales greater than $1000 but resulted in a loss?

SELECT 
    order_id,
    city,
    category,
    sales,
    profit
FROM ecommerce_sales
WHERE sales > 1000
AND profit < 0;

-- Q9. How many total orders have been placed in each city?

SELECT 
    city,
    COUNT(order_id) AS total_orders
FROM ecommerce_sales
GROUP BY city
ORDER BY total_orders DESC;

-- Q10. Which sub-category has the highest sales within the Furniture category?

SELECT 
    sub_category,
    SUM(sales) AS total_sales
FROM ecommerce_sales
WHERE category = 'Furniture'
GROUP BY sub_category
ORDER BY total_sales DESC
LIMIT 1;

-- Q11.Show only categories whose sales are above average sales (Subquery)?

SELECT category, SUM(sales) AS total_sales
FROM ecommerce_sales
GROUP BY category
HAVING SUM(sales) >
(
    SELECT AVG(sales)
    FROM ecommerce_sales
);

-- Q12. Classify orders into High, Medium, and Low Sales categories.

SELECT
    order_id,
    sales,
    CASE
        WHEN sales > 1000 THEN 'High Sales'
        WHEN sales BETWEEN 500 AND 1000 THEN 'Medium Sales'
        ELSE 'Low Sales'
    END AS sales_category
FROM ecommerce_sales;

