-- Procédure pour ajouter un nouveau joueur
CREATE PROCEDURE dbo.AddPlayer
    @pseudo VARCHAR(100)
AS
BEGIN
    INSERT INTO players (pseudo)
    VALUES (@pseudo);
END;
GO

-- Procédure pour ajouter un joueur à une partie avec un rôle
CREATE PROCEDURE dbo.AddPlayerToGame
    @player_id INT,
    @party_id INT,
    @role_id INT
AS
BEGIN
    INSERT INTO players_in_parties (id_party, id_player, id_role, is_alive)
    VALUES (@party_id, @player_id, @role_id, 1);
END;
GO

-- Procédure pour enregistrer une action d’un joueur dans un tour
CREATE PROCEDURE dbo.RecordPlayerAction
    @player_id INT,
    @turn_id INT,
    @action VARCHAR(20),
    @origin_col INT,
    @origin_row INT,
    @target_col INT,
    @target_row INT
AS
BEGIN
    INSERT INTO players_play (id_player, id_turn, action, origin_position_col, origin_position_row, target_position_col, target_position_row)
    VALUES (@player_id, @turn_id, @action, @origin_col, @origin_row, @target_col, @target_row);
END;
GO

-- Procédure pour marquer un joueur comme mort dans une partie
CREATE PROCEDURE dbo.MarkPlayerAsDead
    @player_id INT,
    @party_id INT
AS
BEGIN
    UPDATE players_in_parties
    SET is_alive = 0
    WHERE id_player = @player_id AND id_party = @party_id;
END;
GO
