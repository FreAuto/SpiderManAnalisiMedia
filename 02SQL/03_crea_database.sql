-- =====================================================================
--  PROGETTO SPIDER-MAN – 01) CREAZIONE DEL DATABASE 🕷️🗄️
--  MySQL 8  ·  Autore: Francesco Autorino
-- =====================================================================
DROP DATABASE IF EXISTS spiderman;
CREATE DATABASE spiderman CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE spiderman;

CREATE TABLE film (
    id_film                    VARCHAR(5) PRIMARY KEY,
    titolo                     VARCHAR(100),
    anno                       INT,
    saga                       VARCHAR(60),
    attore                     VARCHAR(60),
    incasso_usa_mln            DECIMAL(10,2),
    incasso_estero_mln         DECIMAL(10,2),
    incasso_mondiale_mln       DECIMAL(10,2),
    budget_mln                 DECIMAL(10,2),
    posizione_mondo_di_sempre  INT,
    biglietti_mondo_mln        DECIMAL(10,2),
    rotten_tomatoes_pct        INT,
    metacritic                 INT,
    cinemascore                VARCHAR(5),
    cinemascore_numero         DECIMAL(4,2),
    moltiplicatore_budget      DECIMAL(6,2),
    quota_estero_pct           DECIMAL(5,1),
    animazione                 VARCHAR(3),
    nota                       VARCHAR(100)
);

CREATE TABLE serie_tv (
    id           INT AUTO_INCREMENT PRIMARY KEY,
    serie        VARCHAR(100),
    stagione     VARCHAR(30),
    episodi      INT,
    data_inizio  DATE,
    data_fine    DATE,
    anno_inizio  INT,
    decennio     INT,
    rete         VARCHAR(100),
    stato        VARCHAR(20)
);

CREATE TABLE videogiochi (
    id_gioco             VARCHAR(5) PRIMARY KEY,
    titolo               VARCHAR(150),
    piattaforme          TEXT,
    sviluppatore         VARCHAR(100),
    editore              VARCHAR(100),
    genere               VARCHAR(200),
    anno                 INT,
    n_piattaforme        INT,
    famiglia_principale  VARCHAR(40),
    metacritic           INT,
    copie_milioni        DECIMAL(6,2),
    genere_principale    VARCHAR(60),
    decennio             INT,
    era                  VARCHAR(40),
    sviluppatori_tutti   TEXT
);

CREATE TABLE fumetti_testate (
    id_testata         VARCHAR(5) PRIMARY KEY,
    tipo               VARCHAR(40),
    titolo             VARCHAR(200),
    volume             INT,
    numeri_pubblicati  INT,
    anno_inizio        INT,
    anno_fine          INT,
    in_corso           VARCHAR(3),
    decennio           INT,
    data_inizio        VARCHAR(30),
    data_fine          VARCHAR(30),
    testo_originale    TEXT
);

CREATE TABLE incassi_franchise (
    voce                 VARCHAR(40) PRIMARY KEY,
    incasso_milioni_usd  DECIMAL(10,2),
    quota_pct            DECIMAL(5,1),
    fonte                VARCHAR(200)
);

CREATE TABLE trends_media (
    mese       DATE,
    media      VARCHAR(20),
    interesse  INT,
    PRIMARY KEY (mese, media)
);

CREATE TABLE trends_fumetto (
    termine    VARCHAR(40),
    mese       DATE,
    interesse  INT,
    PRIMARY KEY (termine, mese)
);

CREATE TABLE trends_attori (
    mese       DATE,
    persona    VARCHAR(30),
    interesse  INT,
    PRIMARY KEY (mese, persona)
);

CREATE TABLE eventi_trends (
    tipo                   VARCHAR(20),
    titolo                 VARCHAR(100),
    mese_uscita            DATE,
    fumetto_prima          DECIMAL(6,2),
    fumetto_mese_uscita    INT,
    fumetto_dopo           DECIMAL(6,2),
    mesi_dopo_disponibili  INT,
    differenza             DECIMAL(6,2),
    variazione_pct         DECIMAL(6,1),
    PRIMARY KEY (tipo, titolo)
);

CREATE TABLE personaggi (
    personaggio             VARCHAR(80) PRIMARY KEY,
    alter_ego               VARCHAR(200),
    ruolo                   VARCHAR(30),
    numero_debutto_amazing  INT,
    anno_debutto            INT,
    nome_fivethirtyeight    VARCHAR(150),
    apparizioni             INT,
    allineamento            VARCHAR(20),
    vivo                    VARCHAR(3)
);

CREATE TABLE timeline_media (
    id        INT AUTO_INCREMENT PRIMARY KEY,
    anno      INT,
    media     VARCHAR(40),
    titolo    VARCHAR(200),
    decennio  INT
);
