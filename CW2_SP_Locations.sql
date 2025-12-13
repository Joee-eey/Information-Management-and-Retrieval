-- ADD LOCATIONS
IF OBJECT_ID('CW2.sp_location_add', 'P') IS NOT NULL DROP PROCEDURE CW2.sp_location_add;
GO
CREATE PROCEDURE CW2.sp_location_add
  @location_id NVARCHAR(50),
  @trail_id NVARCHAR(50),
  @location_latitude FLOAT,
  @location_longitude FLOAT,
  @location_pointOrder INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        INSERT INTO CW2.location (
            location_id, trail_id, location_latitude, location_longitude, location_pointOrder
        )
        VALUES (
            @location_id, @trail_id, @location_latitude, @location_longitude, @location_pointOrder
        );
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO

-- LIST LOCATIONS BY TRAIL (ordered)
IF OBJECT_ID('CW2.sp_location_list_by_trail', 'P') IS NOT NULL DROP PROCEDURE CW2.sp_location_list_by_trail;
GO
CREATE PROCEDURE CW2.sp_location_list_by_trail
  @trail_id NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM CW2.location
    WHERE trail_id = @trail_id
    ORDER BY location_pointOrder;
END;
GO

-- DELETE LOCATIONS
IF OBJECT_ID('CW2.sp_location_delete', 'P') IS NOT NULL DROP PROCEDURE CW2.sp_location_delete;
GO
CREATE PROCEDURE CW2.sp_location_delete
  @location_id NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        DELETE FROM CW2.location
        WHERE location_id = @location_id;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO