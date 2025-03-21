-- Création d'un index sur les pseudos des joueurs pour accélérer les recherches
CREATE INDEX idx_players_pseudo ON players (pseudo);
GO

-- Création d'un index sur le titre des parties pour accélérer les recherches
CREATE INDEX idx_parties_title ON parties (title_party);
GO

-- Index sur la table `players_in_parties` pour optimiser les recherches par joueur et partie
CREATE INDEX idx_players_in_parties ON players_in_parties (id_player, id_party);
GO

-- Index sur la table `players_play` pour accélérer les recherches par joueur et tour
CREATE INDEX idx_players_play ON players_play (id_player, id_turn);
GO

-- Index sur la table `turns` pour accélérer les recherches des tours par partie
CREATE INDEX idx_turns_party ON turns (id_party, start_time);
GO

-- Index pour optimiser la récupération des actions d’un joueur dans une partie
CREATE INDEX idx_players_play_action ON players_play (id_player, action);
GO
