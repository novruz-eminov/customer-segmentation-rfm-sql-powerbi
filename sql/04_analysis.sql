-- Customer count by segment
SELECT customer_segment,
       COUNT(*) AS customer_count
FROM customer_segments
GROUP BY customer_segment
ORDER BY customer_count DESC;

-- Revenue by segment
SELECT customer_segment,
       COUNT(*) total_customers,
       SUM(monetary_value) AS total_revenue,
       ROUND(AVG(monetary_value),2) AS avg_customer_value
FROM customer_segments
GROUP BY customer_segment
ORDER BY total_revenue DESC;

-- Top customers inside VIP
SELECT TOP 10
    customer_id,
    monetary_value,
    order_frequency,
    recency_days
FROM customer_segments
WHERE customer_segment = 'VIP'
ORDER BY monetary_value DESC;

-- At risk customers with hign historical Value
SELECT TOP 10
    customer_id,
    monetary_value,
    order_frequency,
    recency_days
FROM customer_segments 
WHERE customer_segment = 'At Risk'
ORDER BY monetary_value DESC;
