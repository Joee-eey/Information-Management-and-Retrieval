CREATE TRIGGER CW2.tr_trail_insert_log
ON CW2.trail
AFTER INSERT
AS
BEGIN
  SET NOCOUNT ON;

  INSERT INTO CW2.traillog (traillog_id, trail_id, user_id, traillog_timestamp, traillog_action)
  SELECT
    CONVERT(NVARCHAR(50), NEWID()),
    i.trail_id,
    i.user_id,
    SYSUTCDATETIME(),
    'CREATE'
  FROM inserted AS i;
END;
GO 