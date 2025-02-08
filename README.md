# -Domino-s-Pizza-Sales-Analysis-2015-
📌 Overview
This project analyzes Domino's pizza sales data for the year 2015. The goal is to extract insights on revenue generation, category-wise sales performance, and the contribution of different pizza types.

📊 Key Analyses

1️⃣ Total Revenue by Pizza Type
Calculates total revenue for each pizza_type_id by summing (quantity * price).
Orders the results in descending order of revenue.

2️⃣ Percentage Contribution of Each Pizza Type to Total Revenue
Determines each pizza type's percentage contribution to overall revenue.
Uses a subquery to compute total revenue and calculate each type's percentage.

3️⃣ Ranking Top 3 Pizzas Per Category Based on Revenue
Uses Common Table Expressions (CTEs) to compute category-wise revenue.
Implements RANK() OVER (PARTITION BY category ORDER BY revenue DESC) to rank pizzas.
Filters to show only the top 3 pizzas per category.

🔍 SQL Queries Used
Joins: INNER JOIN between pizza_types, pizzas, and order_details.
Aggregations: SUM(quantity * price) for revenue calculations.
Window Functions: RANK() OVER (PARTITION BY category ORDER BY revenue DESC).

📂 Dataset Used
Tables: pizza_types, pizzas, order_details
Columns Analyzed: pizza_type_id, category, quantity, price

📈 Insights & Findings
Certain pizza types contribute significantly more revenue than others.
Some categories have a more even revenue distribution, while others are dominated by top-ranked pizzas.
The top 3 pizzas per category can help optimize marketing and menu pricing.

🛠️ Future Improvements
Analyzing seasonal trends in pizza sales.
Customer segmentation based on order patterns.
Predicting demand for different pizzas using machine learning.
