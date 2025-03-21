CREATE TRIGGER trg_UpdateTurn
ON turns
AFTER INSERT
AS
BEGIN
    DECLARE @PARTY_ID INT;
    SELECT @PARTY_ID = inserted.id_party FROM inserted;
    
    -- Logique pour démarrer le tour ou notifier les joueurs
END;

CREATE TRIGGER trg_PlayerStatusChange
ON players_in_parties
AFTER UPDATE
AS
BEGIN
    DECLARE @PLAYER_ID INT;
    SELECT @PLAYER_ID = inserted.id_player FROM inserted;
    
    -- Logique pour gérer le changement de statut du joueur
END;