
-- RFM_Scoring

DROP TABLE IF EXISTS rfm_customer_scores;

WITH rfm_scores AS (
    SELECT
        customer_id,
        recency_days,
        order_frequency,
        monetary_value,

        6 - NTILE(5) OVER (ORDER BY recency_days) AS r_score,
        NTILE(5) OVER (ORDER BY order_frequency) AS f_score,
        NTILE(5) OVER (ORDER BY monetary_value) AS m_score
    FROM rfm_customer_base
)
SELECT 
        customer_id,
        recency_days,
        order_frequency,
        monetary_value,
        r_score,
        f_score,
        m_score
INTO rfm_customer_scores
FROM rfm_scores;

-- Validation queries

SELECT
    MIN(r_score) AS min_r,
    MAX(r_score) AS max_r,
    MIN(f_score) AS min_f,
    MAX(f_score) AS max_f,
    MIN(m_score) AS min_m,
    MAX(m_score) AS max_m
FROM rfm_customer_scores;

SELECT
    r_score,
    COUNT(*) AS customer_count
FROM rfm_customer_scores
GROUP BY r_score
ORDER BY r_score;