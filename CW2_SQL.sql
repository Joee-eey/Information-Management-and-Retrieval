CREATE SCHEMA CW2;
GO

-- USER
IF OBJECT_ID('CW2.[user]', 'U') IS NOT NULL DROP TABLE CW2.[user];
GO
CREATE TABLE CW2.[user] (
  user_id NVARCHAR(50) NOT NULL PRIMARY KEY,
  user_name NVARCHAR(100) NOT NULL,
  user_email NVARCHAR(255) NOT NULL,
  user_role NVARCHAR(50) NOT NULL
);
GO

-- TRAIL
IF OBJECT_ID('CW2.trail', 'U') IS NOT NULL DROP TABLE CW2.trail;
GO
CREATE TABLE CW2.trail (
  trail_id NVARCHAR(50) NOT NULL PRIMARY KEY,
  user_id NVARCHAR(50) NOT NULL,
  trail_name NVARCHAR(200) NOT NULL,
  trail_length DECIMAL(8,2) NULL,
  trail_duration DECIMAL(8,2) NULL,
  trail_type NVARCHAR(50) NULL,
  trail_difficulty NVARCHAR(50) NULL,
  trail_isPublic BIT NOT NULL DEFAULT 1,
  CONSTRAINT FK_trail_user FOREIGN KEY (user_id) REFERENCES CW2.[user](user_id)
);
GO

-- LOCATION
IF OBJECT_ID('CW2.location', 'U') IS NOT NULL DROP TABLE CW2.location;
GO
CREATE TABLE CW2.location (
  location_id NVARCHAR(50) NOT NULL PRIMARY KEY,
  trail_id NVARCHAR(50) NOT NULL,
  location_latitude FLOAT NOT NULL,
  location_longitude FLOAT NOT NULL,
  location_pointOrder INT NOT NULL,
  CONSTRAINT FK_location_trail 
      FOREIGN KEY (trail_id) REFERENCES CW2.trail(trail_id)
      ON DELETE CASCADE
);
GO

-- Unique order of points per trail
CREATE UNIQUE INDEX UX_location_order_per_trail
ON CW2.location (trail_id, location_pointOrder);
GO

-- REVIEWS
IF OBJECT_ID('CW2.reviews', 'U') IS NOT NULL DROP TABLE CW2.reviews;
GO
CREATE TABLE CW2.reviews (
  reviews_id NVARCHAR(50) NOT NULL PRIMARY KEY,
  user_id NVARCHAR(50) NOT NULL,
  trail_id NVARCHAR(50) NOT NULL,
  reviews_rating INT NOT NULL,
  reviews_description NVARCHAR(1000) NULL,
  reviews_date DATE NOT NULL DEFAULT CAST(GETDATE() AS DATE),
  CONSTRAINT CK_reviews_rating_range CHECK (reviews_rating BETWEEN 1 AND 5),
  CONSTRAINT FK_reviews_user FOREIGN KEY (user_id) REFERENCES CW2.[user](user_id),
  CONSTRAINT FK_reviews_trail 
      FOREIGN KEY (trail_id) REFERENCES CW2.trail(trail_id)
      ON DELETE CASCADE
);
GO

-- Helpful index for newest reviews first
CREATE INDEX IX_reviews_trail 
ON CW2.reviews (trail_id, reviews_date DESC);
GO

-- TRAILLOG
IF OBJECT_ID('CW2.traillog', 'U') IS NOT NULL DROP TABLE CW2.traillog;
GO
CREATE TABLE CW2.traillog (
  traillog_id NVARCHAR(50) NOT NULL PRIMARY KEY,
  trail_id NVARCHAR(50) NOT NULL,
  user_id NVARCHAR(50) NOT NULL,
  traillog_timestamp DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
  traillog_action NVARCHAR(50) NOT NULL,
  CONSTRAINT FK_traillog_trail 
      FOREIGN KEY (trail_id) REFERENCES CW2.trail(trail_id)
      ON DELETE CASCADE,
  CONSTRAINT FK_traillog_user FOREIGN KEY (user_id) REFERENCES CW2.[user](user_id)
);
GO

-- Helpful index for viewing logs
CREATE INDEX IX_traillog_trail 
ON CW2.traillog (trail_id, traillog_timestamp DESC);
GO