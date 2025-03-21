-- Vue : ALL_PLAYERS 
CREATE VIEW ALL_PLAYERS AS 
SELECT 
    p.pseudo AS nom_du_joueur,
    COUNT(DISTINCT p_parties.id_party) AS nombre_de_parties,
    COUNT(p_play.id_turn) AS nombre_de_tours_joués,
    MIN(t.start_time) AS date_premiere_participation,
    MAX(p_play.end_time) AS date_derniere_action
FROM players p
JOIN players_in_parties p_parties ON p.id_player = p_parties.id_player
JOIN turns t ON p_parties.id_party = t.id_party
LEFT JOIN players_play p_play ON p.id_player = p_play.id_player
GROUP BY p.pseudo;

-- Vue : ALL_PLAYERS_ELAPSED_GAME
CREATE VIEW ALL_PLAYERS_ELAPSED_GAME AS
SELECT 
    p.pseudo AS nom_du_joueur,
    pa.title_party AS nom_de_la_partie,
    (SELECT COUNT(DISTINCT p_in_parties.id_player) 
     FROM players_in_parties p_in_parties 
     WHERE p_in_parties.id_party = pa.id_party) AS nombre_de_participants,
    MIN(p_play.start_time) AS date_premiere_action,
    MAX(p_play.end_time) AS date_derniere_action,
    DATEDIFF(SECOND, MIN(p_play.start_time), MAX(p_play.end_time)) AS nb_secondes_dans_la_partie
FROM players p
JOIN players_in_parties p_parties ON p.id_player = p_parties.id_player
JOIN parties pa ON p_parties.id_party = pa.id_party
LEFT JOIN players_play p_play ON p.id_player = p_play.id_player
GROUP BY p.pseudo, pa.title_party, pa.id_party;

-- Vue : ALL_PLAYERS_ELAPSED_TOUR
CREATE VIEW ALL_PLAYERS_ELAPSED_TOUR AS
SELECT 
    p.pseudo AS nom_du_joueur,
    pa.title_party AS nom_de_la_partie,
    t.id_turn AS numero_du_tour,
    t.start_time AS debut_du_tour,
    p_play.start_time AS decision_du_joueur,
    DATEDIFF(SECOND, t.start_time, p_play.start_time) AS temps_ecoule_pour_joueur
FROM players p
JOIN players_play p_play ON p.id_player = p_play.id_player
JOIN turns t ON p_play.id_turn = t.id_turn
JOIN parties pa ON t.id_party = pa.id_party;
