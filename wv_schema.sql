CREATE TABLE parties (
    id_party INT PRIMARY KEY,
    title_party VARCHAR(100)
);

CREATE TABLE roles (
    id_role INT PRIMARY KEY,
    description_role TEXT
);

CREATE TABLE players (
    id_player INT PRIMARY KEY,
    pseudo VARCHAR(100)
);

CREATE TABLE players_in_parties (
    id_party INT,
    id_player INT,
    id_role INT,
    is_alive VARCHAR(3),
    FOREIGN KEY (id_party) REFERENCES parties(id_party),
    FOREIGN KEY (id_player) REFERENCES players(id_player),
    FOREIGN KEY (id_role) REFERENCES roles(id_role)
);

CREATE TABLE turns (
    id_turn INT PRIMARY KEY,
    id_party INT,
    start_time DATETIME,
    end_time DATETIME,
    FOREIGN KEY (id_party) REFERENCES parties(id_party)
);

CREATE TABLE players_play (
    id_player INT,
    id_turn INT,
    action VARCHAR(10),
    origin_position_col INT,
    origin_position_row INT,
    target_position_col INT,
    target_position_row INT,
    PRIMARY KEY (id_player, id_turn),
    FOREIGN KEY (id_player) REFERENCES players(id_player),
    FOREIGN KEY (id_turn) REFERENCES turns(id_turn)
);