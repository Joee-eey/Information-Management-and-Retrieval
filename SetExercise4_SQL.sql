DROP TABLE IF EXISTS CW1.trailLog;
DROP TABLE IF EXISTS CW1.activity;
DROP TABLE IF EXISTS CW1.reviews;
DROP TABLE IF EXISTS CW1.location;
DROP TABLE IF EXISTS CW1.trail;
DROP TABLE IF EXISTS CW1.health;
DROP TABLE IF EXISTS CW1.[user];
DROP SCHEMA IF EXISTS CW1;
GO

CREATE SCHEMA CW1;
GO

-- User Table
CREATE TABLE CW1.[user] (
    user_id INT PRIMARY KEY IDENTITY(1,1),
    user_name VARCHAR(100) NOT NULL,
    user_age INT,
    user_gender VARCHAR(10),
    user_contact VARCHAR(20),
    user_email VARCHAR(100) UNIQUE NOT NULL,
    user_password VARCHAR(100) NOT NULL,
    user_role VARCHAR(50) NOT NULL
);

-- Health Table
CREATE TABLE CW1.health (
    health_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    health_status VARCHAR(50),
    user_bmi FLOAT,
    user_height FLOAT,
    user_weight FLOAT,
    recorded_date DATE NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES CW1.[user](user_id)
);

-- Trail Table
CREATE TABLE CW1.trail (
    trail_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    trail_name VARCHAR(100) NOT NULL,
    trail_length FLOAT NOT NULL,
    trail_duration FLOAT NOT NULL,
    trail_type VARCHAR(50),
    trail_difficulty VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES CW1.[user](user_id)
);

-- Location Table
CREATE TABLE CW1.location (
    location_id INT PRIMARY KEY IDENTITY(1,1),
    trail_id INT NOT NULL,
    location_longitude DECIMAL(9,6) NOT NULL,
    location_latitude DECIMAL(9,6) NOT NULL,
    FOREIGN KEY (trail_id) REFERENCES CW1.trail(trail_id)
);

-- Reviews Table
CREATE TABLE CW1.reviews (
    reviews_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    trail_id INT NOT NULL,
    reviews_rating INT CHECK (reviews_rating BETWEEN 1 AND 5),
    reviews_description NVARCHAR(MAX),
    reviews_date DATE NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES CW1.[user](user_id),
    FOREIGN KEY (trail_id) REFERENCES CW1.trail(trail_id)
);

-- Activity Table
CREATE TABLE CW1.activity (
    activity_id INT PRIMARY KEY IDENTITY(1,1),
    trail_id INT NOT NULL,
    activity_name VARCHAR(100) NOT NULL,
    activity_start_time TIME,
    activity_end_time TIME,
    FOREIGN KEY (trail_id) REFERENCES CW1.trail(trail_id)
);

-- TrailLog Table
CREATE TABLE CW1.trailLog (
    traillog_id INT PRIMARY KEY IDENTITY(1,1),
    trail_id INT NOT NULL,
    user_id INT NOT NULL,
    traillog_timestamp DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (trail_id) REFERENCES CW1.trail(trail_id),
    FOREIGN KEY (user_id) REFERENCES CW1.[user](user_id)
);

-- Insert Users 
INSERT INTO CW1.[user] (user_name, user_age, user_gender, user_contact, user_email, user_password, user_role)
VALUES 
('Hermione Granger', 46, 'Female', '0123456789', 'hermione@example.com', 'hermione123', 'admin'),
('Harry Potter', 45, 'Male', '0987654321', 'harry@example.com', 'harry123', 'user');

-- Insert Health Records
INSERT INTO CW1.health (user_id, health_status, user_bmi, user_height, user_weight)
VALUES 
(1, 'Healthy', 22.5, 165, 60),
(2, 'Overweight', 28.0, 175, 85);

-- Insert Trails
INSERT INTO CW1.trail (user_id, trail_name, trail_length, trail_duration, trail_type, trail_difficulty)
VALUES 
(1, 'Plymbridge Circular', 5.2, 1.5, 'Loop', 'Moderate');

-- Insert Locations
INSERT INTO CW1.location (trail_id, location_longitude, location_latitude)
VALUES 
(1, -4.123456, 50.412345),
(1, -4.124567, 50.413456);

-- Insert Reviews
INSERT INTO CW1.reviews (user_id, trail_id, reviews_rating, reviews_description)
VALUES 
(1, 1, 5, 'Beautiful woodland trail!');

-- Insert Activities
INSERT INTO CW1.activity (trail_id, activity_name, activity_start_time, activity_end_time)
VALUES 
(1, 'Trail Run', '15:00:00', '17:15:00');

-- Insert TrailLog
INSERT INTO CW1.trailLog (trail_id, user_id)
VALUES 
(1, 1);

SELECT * FROM CW1.[user];
SELECT * FROM CW1.health;
SELECT * FROM CW1.trail;
SELECT * FROM CW1.location;
SELECT * FROM CW1.reviews;
SELECT * FROM CW1.activity;
SELECT * FROM CW1.trailLog;
