-- ADD REVIEW
IF OBJECT_ID('CW2.sp_review_add', 'P') IS NOT NULL DROP PROCEDURE CW2.sp_review_add;
GO
CREATE PROCEDURE CW2.sp_review_add
  @reviews_id NVARCHAR(50),
  @user_id NVARCHAR(50),
  @trail_id NVARCHAR(50),
  @reviews_rating INT,
  @reviews_description NVARCHAR(1000) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        INSERT INTO CW2.reviews (
            reviews_id, user_id, trail_id, reviews_rating, reviews_description
        )
        VALUES (
            @reviews_id, @user_id, @trail_id, @reviews_rating, @reviews_description
        );
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO

-- LIST REVIEW BY TRAIL
IF OBJECT_ID('CW2.sp_review_list_by_trail', 'P') IS NOT NULL DROP PROCEDURE CW2.sp_review_list_by_trail;
GO
CREATE PROCEDURE CW2.sp_review_list_by_trail
  @trail_id NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM CW2.reviews
    WHERE trail_id = @trail_id
    ORDER BY reviews_date DESC;
END;
GO

-- DELETE REVIEW
IF OBJECT_ID('CW2.sp_review_delete', 'P') IS NOT NULL DROP PROCEDURE CW2.sp_review_delete;
GO
CREATE PROCEDURE CW2.sp_review_delete
  @reviews_id NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        DELETE FROM CW2.reviews
        WHERE reviews_id = @reviews_id;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO