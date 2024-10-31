use pizzahut;

-- retrieve the total number of order placed
select count(order_id) from orders;

-- calculate the total revenue generated from pizza sales
SELECT 
    ROUND(SUM(order_detail.quantity * pizzas.price),
            2) AS total_revenue
FROM
    order_detail
        JOIN
    pizzas ON order_detail.pizza_id = pizzas.pizza_id;
    
-- identify the highest price pizza
select pizza_types.name, pizza_types.category, pizzas.price as p
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
order by p desc limit 1;

-- identify the most common pizza size order

select pizzas.size, count(order_detail.order_detail_id) as count_order
from pizzas join order_detail
on pizzas.pizza_id = order_detail.pizza_id
group by pizzas.size
order by count_order desc limit 1;

-- list  5 most order pizza type along with their quantity

SELECT 
    pizza_types.name, SUM(order_detail.quantity) AS quant
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_detail ON pizzas.pizza_id = order_detail.pizza_id
GROUP BY pizza_types.name
ORDER BY quant DESC
LIMIT 5;

