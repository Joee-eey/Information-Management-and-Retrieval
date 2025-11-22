-- Combines User, Trail, and Reviews
CREATE OR ALTER VIEW CW1.TrailReviewSummary AS
SELECT 
    T.trail_id,
    T.trail_name,
    T.trail_length,
    T.trail_duration,
    T.trail_type,
    T.trail_difficulty,
    U.user_name AS OwnerName,
    R.reviews_rating,
    R.reviews_description,
    R.reviews_date
FROM CW1.trail T
JOIN CW1.[user] U ON T.user_id = U.user_id
LEFT JOIN CW1.reviews R ON T.trail_id = R.trail_id;

GO
SELECT * FROM CW1.TrailReviewSummary; 



