-- Retrieve the total number of orders placed.
SELECT 
    COUNT(*) AS total_no_of_orders
FROM
    orders;

-- Calculate the total revenue generated from pizza sales.
SELECT 
    ROUND(SUM(quantity * price), 2) AS total_order_amount
FROM
    order_details od
        INNER JOIN
    pizzas p ON od.pizza_id = p.pizza_id;

-- Identify the highest-priced pizza.

SELECT 
    name, price
FROM
    pizza_types pt
        JOIN
    pizzas p ON p.pizza_type_id = pt.pizza_type_id
ORDER BY price DESC
LIMIT 1;


-- Identify the most common pizza size ordered.
SELECT 
    size, COUNT(od.order_details_id) AS orders_per_size
FROM
    pizzas p
        JOIN
    order_details od ON p.pizza_id = od.pizza_id
GROUP BY 1
ORDER BY orders_per_size DESC
LIMIT 1;

-- List the top 5 most ordered pizza types along with their quantities.
SELECT 
    name, sum(od.quantity) AS count
FROM
    order_details od
        JOIN
    pizzas p ON p.pizza_id = od.pizza_id
    join pizza_types pt on p.pizza_type_id = pt.pizza_type_id
GROUP BY 1 
ORDER BY count DESC
LIMIT 5;

 -- find the total quantity of each pizza category ordered.
 
 SELECT 
    category, sum(od.quantity) AS count
FROM
    order_details od
        JOIN
    pizzas p ON p.pizza_id = od.pizza_id
    join pizza_types pt on p.pizza_type_id = pt.pizza_type_id
GROUP BY 1 
ORDER BY count DESC;

-- Determine the distribution of orders by hour of the day.

SELECT 
    COUNT(order_id) AS orders_each_hour,
    SUBSTR(order_time, 1, 2) AS hour
FROM
    orders
GROUP BY 2
ORDER BY orders_each_hour DESC;

-- find the category-wise distribution of pizzas.
SELECT 
    category, COUNT(order_details_id) AS count
FROM
    pizza_types pt
        LEFT JOIN
    pizzas p ON p.pizza_type_id = pt.pizza_type_id
        INNER JOIN
    order_details od ON p.pizza_id = od.pizza_id
GROUP BY 1 order by count desc;


-- calculate the average number of pizzas ordered per day
 
with cte as (
SELECT 
    SUM(od.quantity) AS quantity_per_day, order_date
FROM
    order_details od
        INNER JOIN
    orders ord ON od.order_id = ord.order_id
GROUP BY 2
)
SELECT 
    ROUND(AVG(quantity_per_day), 0) AS avg_quantity_per_day
FROM
    cte;


-- top 3 most ordered pizza types based on revenue.
SELECT 
     pizza_type_id, sum(quantity * price) AS revenue
FROM
    pizzas p
        INNER JOIN
    order_details od ON p.pizza_id = od.pizza_id
    group by 1
ORDER BY revenue DESC limit 3


 -- percentage contribution of each pizza type to total revenue.
 
SELECT 
    pizza_type_id,
    SUM(quantity * price) AS revenue,
    ROUND((SUM(quantity * price) / (SELECT 
                    SUM(quantity * price)
                FROM
                    pizzas p
                        INNER JOIN
                    order_details od ON p.pizza_id = od.pizza_id) * 100),
            2) AS percentage_contribution
FROM
    pizzas p
        INNER JOIN
    order_details od ON p.pizza_id = od.pizza_id
GROUP BY pizza_type_id
ORDER BY revenue DESC;

-- cumulative revenue generated over time.
with revenue_per_day as (
SELECT 
    ord.order_date, SUM(quantity * price) AS revenue
FROM
    order_details od
        JOIN
    pizzas p ON od.pizza_id = p.pizza_id
        JOIN
    orders ord ON ord.order_id = od.order_id
GROUP BY ord.order_date
 )
select order_date , revenue , sum(revenue) over(order by order_Date) as cum_revenue from  revenue_per_day;
 
 
-- top 3 most ordered pizza types based on revenue for each pizza category.
WITH cte AS (
    SELECT 
        SUM(quantity * price) AS revenue, 
        category,
        pt.name,
        RANK() OVER (PARTITION BY category ORDER BY SUM(quantity * price) DESC) AS ranking
    FROM pizza_types pt 
    INNER JOIN pizzas p ON p.pizza_type_id = pt.pizza_type_id
    INNER JOIN order_details od ON od.pizza_id = p.pizza_id
    GROUP BY category, pt.name
)
SELECT 
    category, 
    name, 
    revenue, 
    ranking
FROM cte
WHERE ranking <= 3;

