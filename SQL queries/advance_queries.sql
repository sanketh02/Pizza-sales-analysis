use pizzahut;

-- calculate the percentage contribution of each pizza type to total revenue

select round(sum(order_detail.quantity * pizzas.price),2) as total_revenue
from order_detail
join pizzas on order_detail.pizza_id = pizzas.pizza_id;

SELECT 
    pizza_types.category,
    (SUM(order_detail.quantity * pizzas.price) / (SELECT 
            ROUND(SUM(order_detail.quantity * pizzas.price),
                        2) AS total_revenue
        FROM
            order_detail
                JOIN
            pizzas ON order_detail.pizza_id = pizzas.pizza_id)) * 100 AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_detail ON pizzas.pizza_id = order_detail.pizza_id
GROUP BY category
ORDER BY revenue;

-- analyze the cummulative revenue generated over time

select date,
sum(daily_revenue) over(order by date) as cumulative_revenue
from
(select orders.date,
sum(order_detail.quantity * pizzas.price) as daily_revenue
from orders join order_detail
on orders.order_id = order_detail.order_id
join pizzas
on pizzas.pizza_id = order_detail.pizza_id
group by orders.date) as daily_sales;

-- determine the top 3 most ordered pizza types based on revenue for each pizza category

select name , revenue
from
(select category, name, revenue,
rank() over(partition by category order by revenue desc) as ranking
from(
select pizza_types.category, pizza_types.name,
sum(order_detail.quantity * pizzas.price) as revenue
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_detail
on pizzas.pizza_id = order_detail.pizza_id
group by pizza_types.category, pizza_types.name) as a) as b
where ranking <= 3;





