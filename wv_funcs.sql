-- Fonction pour récupérer le nombre total de parties jouées par un joueur
CREATE FUNCTION dbo.GetPlayerGameCount (@player_id INT)
RETURNS INT
AS
BEGIN
    DECLARE @game_count INT;
    SELECT @game_count = COUNT(DISTINCT id_party)
    FROM players_in_parties
    WHERE id_player = @player_id;
    RETURN @game_count;
END;
GO

-- Fonction pour récupérer le temps total passé par un joueur dans toutes ses parties
CREATE FUNCTION dbo.GetTotalElapsedTime (@player_id INT)
RETURNS INT
AS
BEGIN
    DECLARE @total_time INT;
    SELECT @total_time = SUM(DATEDIFF(SECOND, p_play.start_time, p_play.end_time))
    FROM players_play p_play
    WHERE p_play.id_player = @player_id;
    RETURN ISNULL(@total_time, 0);
END;
GO

-- Fonction pour récupérer le rôle d'un joueur dans une partie donnée
CREATE FUNCTION dbo.GetPlayerRole (@player_id INT, @party_id INT)
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @role_desc VARCHAR(100);
    SELECT @role_desc = r.description_role
    FROM players_in_parties pip
    JOIN roles r ON pip.id_role = r.id_role
    WHERE pip.id_player = @player_id AND pip.id_party = @party_id;
    RETURN @role_desc;
END;
GO
