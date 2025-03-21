-- Index pour la table players_in_parties sur la colonne id_party et id_player
CREATE INDEX idx_players_in_parties_party_player
ON players_in_parties (id_party, id_player);

-- Index pour la table turns sur la colonne id_party pour améliorer les requêtes liées aux tours
CREATE INDEX idx_turns_party
ON turns (id_party);

-- Index pour la table players_in_parties sur la colonne is_alive, utile pour les requêtes sur l'état des joueurs
CREATE INDEX idx_players_in_parties_alive
ON players_in_parties (is_alive);

-- Index pour la table players_play sur la colonne id_turn, afin de faciliter la recherche des actions des joueurs par tour
CREATE INDEX idx_players_play_turn
ON players_play (id_turn);