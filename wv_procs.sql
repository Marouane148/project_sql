CREATE PROCEDURE SEED_DATA(@NB_PLAYERS INT, @PARTY_ID INT)
AS
BEGIN
    DECLARE @i INT = 0;
    WHILE @i < @NB_PLAYERS
    BEGIN
        INSERT INTO players (id_player, pseudo) 
        VALUES (@i + 1, 'Player' + CAST(@i AS VARCHAR));
        
        INSERT INTO players_in_parties (id_party, id_player, id_role, is_alive) 
        VALUES (@PARTY_ID, @i + 1, dbo.get_random_role(), 'yes');
        
        SET @i = @i + 1;
    END
END;

CREATE PROCEDURE COMPLETE_TURN(@TURN_ID INT)
AS
BEGIN
    UPDATE players_play
    SET end_time = GETDATE()
    WHERE id_turn = @TURN_ID;
END;

CREATE PROCEDURE KILL_PLAYER(@PLAYER_ID INT, @PARTY_ID INT)
AS
BEGIN
    UPDATE players_in_parties 
    SET is_alive = 'no' 
    WHERE id_player = @PLAYER_ID AND id_party = @PARTY_ID;
END;