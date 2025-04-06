create database pizza_db;

# 1. second Highest selling pizaa category and size include pizaa name and quantity and order date ?
 SELECT pizza_category, pizza_size, pizza_name, SUM(quantity) AS total_quantity
FROM pizza_sales
GROUP BY pizza_category, pizza_size, pizza_name
ORDER BY total_quantity DESC
limit 1 OFFSET 1;

# 2. Average Pizzas Per Order ?
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
AS Avg_Pizzas_per_order
FROM pizza_sales;

# 3.Top 5 Pizaa soled most ?
SELECT pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC
LIMIT 5;

# 4. Least sellers pizza ?
Select p.pizaa_name,sum(quantity) as total_pizaa_sold
from pizaa_sales
group by pizaa_name
order by total_pizaa_sold desc
limit 5;

# 5.Average pizaa sales ?
SELECT pizza_name, pizza_category, AVG(total_price) AS Average_price
FROM pizza_sales
GROUP BY pizza_name, pizza_category
ORDER BY pizza_name, pizza_category
limit 1;

# 6. Category wise sales of pizaa by pizza category ?
select pizza_category,pizza_name,sum(quantity) as Total_category_wise_sales
from pizza_sales
group by pizza_category,pizza_name
order by Total_category_wise_sales;


# 7. pizza sales by sizes by pizza size ?
SELECT pizza_size, SUM(quantity) AS total_sales
FROM pizza_sales
GROUP BY pizza_size
ORDER BY total_sales DESC;


# 8. Total Orders,Total Pizaa sold,Total Revenue. Kpi ?
select sum(order_id ) as Total_orders,sum(quantity) as Total_pizaa_sold,sum(total_price) as Total_revenue,
avg(quantity) as Average_quantity_sold
from pizza_sales;

# 9. Daily Trends in Sales Day wise ?
DESCRIBE pizza_sales; # in this we observed that our date column was stored in text type 
SELECT 
  DAYNAME(STR_TO_DATE(order_date, '%Y-%m-%d')) AS order_day,
  COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DAYNAME(STR_TO_DATE(order_date, '%Y-%m-%d'))
order by order_day desc;

# 10.Monthly sales ?
SELECT 
  MONTH(STR_TO_DATE(order_date, '%d-%m-%Y')) AS month_num,
  MONTHNAME(STR_TO_DATE(order_date, '%d-%m-%Y')) AS month_name,
  SUM(quantity) AS total_pizzas_sold
FROM pizza_sales
GROUP BY 
  MONTH(STR_TO_DATE(order_date, '%d-%m-%Y')),
  MONTHNAME(STR_TO_DATE(order_date, '%d-%m-%Y'))
ORDER BY month_num;

# 11. Quanter and year  wise sales?
SELECT 
  CONCAT('Q', quarter, ' ', year) AS quarter_year,
  SUM(quantity) AS total_pizzas_sold
FROM (
  SELECT 
    quantity,
    QUARTER(STR_TO_DATE(order_date, '%d-%m-%Y')) AS quarter,
    YEAR(STR_TO_DATE(order_date, '%d-%m-%Y')) AS year
  FROM pizza_sales
) AS sub
GROUP BY quarter, year
ORDER BY year, quarter;

# 12. Hourly trends ?
SELECT 
  HOUR(STR_TO_DATE(order_time, '%H:%i:%s')) AS order_hour,
  SUM(quantity) AS total_pizzas_sold
FROM pizza_sales
GROUP BY order_hour
ORDER BY order_hour desc;




