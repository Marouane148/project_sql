-- Trigger pour empêcher un joueur de rejoindre une partie s'il y est déjà inscrit
CREATE TRIGGER trg_PreventDuplicatePlayers
ON players_in_parties
FOR INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM players_in_parties pip
        JOIN inserted i ON pip.id_party = i.id_party AND pip.id_player = i.id_player
    )
    BEGIN
        RAISERROR ('Le joueur est déjà inscrit dans cette partie.', 16, 1);
        ROLLBACK;
    END;
END;
GO

-- Trigger pour empêcher qu’un joueur effectue plusieurs actions dans le même tour
CREATE TRIGGER trg_LimitPlayerActionsPerTurn
ON players_play
FOR INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN players_play p ON i.id_player = p.id_player AND i.id_turn = p.id_turn
    )
    BEGIN
        RAISERROR ('Un joueur ne peut effectuer qu''une seule action par tour.', 16, 1);
        ROLLBACK;
    END;
END;
GO

-- Trigger pour mettre à jour la date de fin d'un tour quand tous les joueurs ont joué
CREATE TRIGGER trg_UpdateTurnEndTime
ON players_play
AFTER INSERT
AS
BEGIN
    DECLARE @id_turn INT, @id_party INT, @total_players INT, @played_count INT;
    
    SELECT @id_turn = id_turn FROM inserted;
    SELECT @id_party = t.id_party FROM turns t WHERE t.id_turn = @id_turn;

    -- Nombre total de joueurs dans la partie
    SELECT @total_players = COUNT(*) FROM players_in_parties WHERE id_party = @id_party;

    -- Nombre de joueurs ayant déjà joué ce tour
    SELECT @played_count = COUNT(DISTINCT id_player) FROM players_play WHERE id_turn = @id_turn;

    -- Si tous les joueurs ont joué, on clôture le tour
    IF @played_count = @total_players
    BEGIN
        UPDATE turns
        SET end_time = GETDATE()
        WHERE id_turn = @id_turn;
    END;
END;
GO
