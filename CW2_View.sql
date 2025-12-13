CREATE VIEW CW2.TrailPublicView AS
WITH LocationAgg AS (
    SELECT 
        trail_id, 
        COUNT(*) AS location_count
    FROM CW2.location
    GROUP BY trail_id
),
ReviewAgg AS (
    SELECT 
        trail_id, 
        COUNT(*) AS review_count,
        AVG(CAST(reviews_rating AS DECIMAL(5,2))) AS avg_rating
    FROM CW2.reviews
    GROUP BY trail_id
)
SELECT 
    t.trail_id,
    t.trail_name,
    t.trail_length,
    t.trail_duration,
    t.trail_type,
    t.trail_difficulty,
    t.trail_isPublic,
    COALESCE(l.location_count, 0) AS location_count,
    COALESCE(r.avg_rating, 0) AS avg_rating,
    COALESCE(r.review_count, 0) AS review_count
FROM CW2.trail t
LEFT JOIN LocationAgg l ON t.trail_id = l.trail_id
LEFT JOIN ReviewAgg r ON t.trail_id = r.trail_id
WHERE t.trail_isPublic = 1;
GO