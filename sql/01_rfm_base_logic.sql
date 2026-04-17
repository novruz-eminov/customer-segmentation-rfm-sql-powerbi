
-- Create RFM_Base_Logic
DROP TABLE IF EXISTS rfm_customer_base;

DECLARE @snapshot_date DATE;

SELECT @snapshot_date = MAX(order_date)
FROM fact_sales_clean;

WITH rfm_base AS (
   SELECT customer_id,
          DATEDIFF(DAY,MAX(order_date),@snapshot_date) AS recency_days,
          COUNT(DISTINCT order_id) AS order_frequency,
          SUM(total_price) AS monetary_value
    FROM fact_sales_clean
    GROUP BY customer_id
)
SELECT  
    customer_id,
    recency_days,
    order_frequency,
    monetary_value
  INTO rfm_customer_base
  FROM rfm_base;
