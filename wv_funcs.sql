CREATE FUNCTION get_random_role()
RETURNS INT
AS
BEGIN
    DECLARE @random_role INT;
    SELECT @random_role = id_role 
    FROM roles 
    ORDER BY NEWID() 
    OFFSET 0 ROWS 
    FETCH NEXT 1 ROWS ONLY;
    RETURN @random_role;
END;

CREATE FUNCTION get_player_status(@player_id INT)
RETURNS VARCHAR(10)
AS
BEGIN
    DECLARE @status VARCHAR(10);
    SELECT @status = is_alive 
    FROM players_in_parties 
    WHERE id_player = @player_id;
    RETURN @status;
END;