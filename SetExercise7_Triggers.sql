CREATE OR ALTER TRIGGER CW1.trg_AdminTrailInsert
ON CW1.trail
AFTER INSERT
AS
BEGIN
    -- Insert into TrailLog only if the user is an admin
    INSERT INTO CW1.trailLog (trail_id, user_id, traillog_timestamp)
    SELECT i.trail_id, i.user_id, GETDATE()   
    FROM inserted i
    JOIN CW1.[user] u ON i.user_id = u.user_id
    WHERE u.user_role = 'admin';
END; 
GO

/*-- Admin
INSERT INTO CW1.trail (user_id, trail_name, trail_length, trail_duration, trail_type, trail_difficulty)
VALUES (1, 'Admin Trail', 6.0, 1.8, 'Loop', 'Moderate'); */

/*-- User
INSERT INTO CW1.trail (user_id, trail_name, trail_length, trail_duration, trail_type, trail_difficulty)
VALUES (2, 'User Trail', 4.0, 1.2, 'Out & Back', 'Easy'); */

SELECT * FROM CW1.trailLog;