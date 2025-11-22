/* -- Create (Insert) Procedure
CREATE PROCEDURE CW1.InsertTrail
    @user_id INT,
    @trail_name VARCHAR(100),
    @trail_length FLOAT,
    @trail_duration FLOAT,
    @trail_type VARCHAR(50),
    @trail_difficulty VARCHAR(50)
AS
BEGIN
    INSERT INTO CW1.trail (user_id, trail_name, trail_length, trail_duration, trail_type, trail_difficulty)
    VALUES (@user_id, @trail_name, @trail_length, @trail_duration, @trail_type, @trail_difficulty);
END;
GO 

-- Insert a new trail
EXEC CW1.InsertTrail 
    @user_id = 1, 
    @trail_name = 'Forest Path', 
    @trail_length = 4.8, 
    @trail_duration = 1.2, 
    @trail_type = 'Loop', 
    @trail_difficulty = 'Easy'; */




/*-- Read Procedure
CREATE PROCEDURE CW1.GetTrailByID
    @trail_id INT
AS
BEGIN
    SELECT 
        T.trail_id, T.trail_name, T.trail_length, T.trail_duration, 
        T.trail_type, T.trail_difficulty, U.user_name
    FROM CW1.trail T
    JOIN CW1.[user] U ON T.user_id = U.user_id
    WHERE T.trail_id = @trail_id;
END; 

-- Read trail by ID
-- Old demo data
EXEC CW1.GetTrailByID @trail_id = 1; 
-- New demo data
EXEC CW1.GetTrailByID @trail_id = 2; */




/*-- Update Procedure
CREATE PROCEDURE CW1.UpdateTrail
    @trail_id INT,
    @trail_name VARCHAR(100),
    @trail_length FLOAT,
    @trail_duration FLOAT,
    @trail_type VARCHAR(50),
    @trail_difficulty VARCHAR(50)
AS
BEGIN
    UPDATE CW1.trail
    SET trail_name = @trail_name,
        trail_length = @trail_length,
        trail_duration = @trail_duration,
        trail_type = @trail_type,
        trail_difficulty = @trail_difficulty
    WHERE trail_id = @trail_id;
END; 

-- Update trail
EXEC CW1.UpdateTrail 
    @trail_id = 1, 
    @trail_name = 'Plymbridge Circular Updated', 
    @trail_length = 5.5, 
    @trail_duration = 1.6, 
    @trail_type = 'Loop', 
    @trail_difficulty = 'Moderate';
GO 

SELECT * FROM CW1.trail WHERE trail_id = 1; */




/*-- Delete Procedure
CREATE PROCEDURE CW1.DeleteTrail
    @trail_id INT
AS
BEGIN
    DELETE FROM CW1.trail WHERE trail_id = @trail_id;
END;
GO  

-- Delete trail
EXEC CW1.DeleteTrail @trail_id = 2; 
EXEC CW1.DeleteTrail @trail_id = 3; 
GO 

-- trail_id = 2
SELECT * FROM CW1.trail WHERE trail_id = 2;
-- all 
SELECT * FROM CW1.trail; */