use pizzahut;

-- join the necessary table to find the total quantity of each pizza category 
select pizza_types.category,
sum(order_detail.quantity) as quantity
from pizza_types 
join pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_detail on order_detail.pizza_id = pizzas.pizza_id
group by pizza_types.category
order by quantity;

-- determine the distribution of the order by hour of the day
select hour(time) as hours, count(order_id) 
from orders
group by hours; 

-- join the relevant table to find category distributions of pizzas
select pizza_types.category, count(pizza_type_id)
from pizza_types
group by pizza_types.category;

-- group the orders by date and calculate the average number of pizzas ordered per day
SELECT 
    ROUND(AVG(quantity), 2)
FROM
    (SELECT 
        orders.date, SUM(order_detail.quantity) AS quantity
    FROM
        orders
    JOIN order_detail ON orders.order_id = order_detail.order_id
    GROUP BY orders.date) AS order_quantity;

-- determine top 3 most ordered pizzas based on revenue
SELECT 
    pizza_types.name,
    SUM(order_detail.quantity * pizzas.price) AS quant
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    order_detail ON order_detail.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY quant DESC
LIMIT 3;



