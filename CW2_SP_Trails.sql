-- CREATE
IF OBJECT_ID('CW2.sp_trail_create', 'P') IS NOT NULL DROP PROCEDURE CW2.sp_trail_create;
GO
CREATE PROCEDURE CW2.sp_trail_create
  @trail_id NVARCHAR(50),
  @user_id NVARCHAR(50),
  @trail_name NVARCHAR(200),
  @trail_length DECIMAL(8,2) = NULL,
  @trail_duration DECIMAL(8,2) = NULL,
  @trail_type NVARCHAR(50) = NULL,
  @trail_difficulty NVARCHAR(50) = NULL,
  @trail_isPublic BIT = 1
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        INSERT INTO CW2.trail (
            trail_id, user_id, trail_name, trail_length, trail_duration,
            trail_type, trail_difficulty, trail_isPublic
        )
        VALUES (
            @trail_id, @user_id, @trail_name, @trail_length, @trail_duration,
            @trail_type, @trail_difficulty, @trail_isPublic
        );
    END TRY
    BEGIN CATCH
        THROW; 
    END CATCH
END;
GO

-- READ BY ID
IF OBJECT_ID('CW2.sp_trail_read', 'P') IS NOT NULL DROP PROCEDURE CW2.sp_trail_read;
GO
CREATE PROCEDURE CW2.sp_trail_read
  @trail_id NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT *
    FROM CW2.trail
    WHERE trail_id = @trail_id;
END;
GO

-- READ LIST
IF OBJECT_ID('CW2.sp_trail_list', 'P') IS NOT NULL DROP PROCEDURE CW2.sp_trail_list;
GO
CREATE PROCEDURE CW2.sp_trail_list
  @owner_user_id NVARCHAR(50) = NULL,
  @include_private BIT = 0
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM CW2.trail
    WHERE trail_isPublic = 1
       OR (@include_private = 1 AND user_id = @owner_user_id);
END;
GO

-- UPDATE
IF OBJECT_ID('CW2.sp_trail_update', 'P') IS NOT NULL DROP PROCEDURE CW2.sp_trail_update;
GO
CREATE PROCEDURE CW2.sp_trail_update
  @trail_id NVARCHAR(50),
  @trail_name NVARCHAR(200) = NULL,
  @trail_length DECIMAL(8,2) = NULL,
  @trail_duration DECIMAL(8,2) = NULL,
  @trail_type NVARCHAR(50) = NULL,
  @trail_difficulty NVARCHAR(50) = NULL,
  @trail_isPublic BIT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        UPDATE CW2.trail
        SET
            trail_name       = COALESCE(@trail_name, trail_name),
            trail_length     = COALESCE(@trail_length, trail_length),
            trail_duration   = COALESCE(@trail_duration, trail_duration),
            trail_type       = COALESCE(@trail_type, trail_type),
            trail_difficulty = COALESCE(@trail_difficulty, trail_difficulty),
            trail_isPublic   = COALESCE(@trail_isPublic, trail_isPublic)
        WHERE trail_id = @trail_id;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO

-- DELETE
IF OBJECT_ID('CW2.sp_trail_delete', 'P') IS NOT NULL DROP PROCEDURE CW2.sp_trail_delete;
GO
CREATE PROCEDURE CW2.sp_trail_delete
  @trail_id NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        DELETE FROM CW2.trail
        WHERE trail_id = @trail_id;
        -- ON DELETE CASCADE handles child tables automatically
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO