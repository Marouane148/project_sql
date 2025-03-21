CREATE VIEW ALL_PLAYERS AS
SELECT 
    p.pseudo AS player_name,
    COUNT(pip.id_party) AS number_of_parties,
    SUM(CASE WHEN pip.is_alive = 'yes' THEN 1 ELSE 0 END) AS alive_count
FROM players p
LEFT JOIN players_in_parties pip ON p.id_player = pip.id_player
GROUP BY p.pseudo;

CREATE VIEW ALL_PARTIES AS
SELECT 
    p.id_party,
    p.title_party,
    COUNT(pip.id_player) AS number_of_players
FROM parties p
LEFT JOIN players_in_parties pip ON p.id_party = pip.id_party
GROUP BY p.id_party, p.title_party;

CREATE VIEW ALL_TURNS AS
SELECT 
    t.id_turn,
    p.title_party,
    t.start_time,
    t.end_time,
    DATEDIFF(SECOND, t.start_time, t.end_time) AS duration
FROM turns t
JOIN parties p ON t.id_party = p.id_party;