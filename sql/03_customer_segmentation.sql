-- Creating customer_segments table

DROP TABLE IF EXISTS customer_segments
SELECT 
    customer_id,
    recency_days,
    order_frequency,
    monetary_value,
    r_score,
    f_score,
    m_score,
    CAST(r_score AS VARCHAR(1)) + 
    CAST(f_score AS VARCHAR(1)) + 
    CAST(m_score AS VARCHAR(1)) AS rfm_code,
    (r_score + f_score + m_score) AS rfm_total_score,
    CASE 
        WHEN r_score >= 4 AND f_score >= 4 AND m_score >= 4 THEN 'VIP'
        WHEN r_score >= 3 AND f_score >= 4 AND m_score >= 3 THEN 'Loyal Customers'
        WHEN m_score = 5 AND f_score <= 3 THEN 'Big Spenders' 
        WHEN r_score >= 4 AND f_score BETWEEN 2 AND 3 AND m_score BETWEEN 2 AND 4 THEN 'Potential Loyalists'
        WHEN r_score <= 2 AND f_score >= 3 AND m_score >= 3 THEN 'At Risk'
        WHEN r_score = 1 AND f_score <= 2 AND m_score <= 2 THEN 'Lost Customers'
        ELSE 'Regular Customers'
        END AS customer_segment
INTO customer_segments
FROM rfm_customer_scores;