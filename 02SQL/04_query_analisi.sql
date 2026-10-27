-- =====================================================================
--  PROGETTO SPIDER-MAN – 03) QUERY DI ANALISI 🔍
--  Funzionano in MySQL 8 e in SQLite.
-- =====================================================================
-- USE spiderman;


-- =====================================================================
--  DOMANDA 1 – QUALE MEDIA HA FATTO GUADAGNARE DI PIÙ SPIDER-MAN? 💰
-- =====================================================================

-- 1.1  Incassi del franchise per voce, con quota sul totale
SELECT voce, incasso_milioni_usd, quota_pct
FROM incassi_franchise
ORDER BY incasso_milioni_usd DESC;

-- 1.2  Box office totale dei film contro copie dei videogiochi più venduti
SELECT 'Film (box office, mln $)'     AS indicatore, ROUND(SUM(incasso_mondiale_mln), 0) AS valore FROM film
UNION ALL
SELECT 'Videogiochi (copie note, mln)', ROUND(SUM(copie_milioni), 1) FROM videogiochi
UNION ALL
SELECT 'Numeri di fumetti pubblicati', SUM(numeri_pubblicati) FROM fumetti_testate
UNION ALL
SELECT 'Episodi di serie TV', SUM(episodi) FROM serie_tv;


-- =====================================================================
--  DOMANDA 2 – COME SONO ANDATI I FILM? QUALE SAGA FUNZIONA MEGLIO? 🎬
-- =====================================================================

-- 2.1  Tutti i film: incasso, budget e quante volte il budget è stato ripagato
SELECT anno, titolo, saga, incasso_mondiale_mln, budget_mln, moltiplicatore_budget,
       rotten_tomatoes_pct, metacritic, cinemascore
FROM film
WHERE anno >= 2002
ORDER BY anno;

-- 2.2  Confronto tra le saghe
SELECT saga, attore,
       COUNT(*)                                  AS n_film,
       ROUND(AVG(incasso_mondiale_mln), 0)       AS incasso_medio_mln,
       ROUND(SUM(incasso_mondiale_mln), 0)       AS incasso_totale_mln,
       ROUND(AVG(moltiplicatore_budget), 2)      AS moltiplicatore_medio,
       ROUND(AVG(rotten_tomatoes_pct), 0)        AS critica_rt,
       ROUND(AVG(cinemascore_numero), 2)         AS pubblico_cinemascore
FROM film
WHERE anno >= 2002
GROUP BY saga, attore
ORDER BY incasso_medio_mln DESC;

-- 2.3  Il film migliore di ogni saga (funzione finestra)
WITH classifica AS (
    SELECT saga, titolo, incasso_mondiale_mln,
           RANK() OVER (PARTITION BY saga ORDER BY incasso_mondiale_mln DESC) AS posizione
    FROM film WHERE anno >= 2002
)
SELECT saga, titolo, incasso_mondiale_mln FROM classifica WHERE posizione = 1;

-- 2.4  Incassi in crescita? Variazione rispetto al film precedente
SELECT anno, titolo, incasso_mondiale_mln,
       ROUND(incasso_mondiale_mln - LAG(incasso_mondiale_mln) OVER (ORDER BY anno), 0) AS differenza_dal_precedente
FROM film
WHERE anno >= 2002 AND animazione = 'NO'
ORDER BY anno;

-- 2.5  Biglietti venduti: il pubblico reale (non influenzato dal prezzo del biglietto)
SELECT titolo, anno, ROUND(biglietti_mondo_mln, 1) AS biglietti_mln,
       ROUND(incasso_mondiale_mln / biglietti_mondo_mln, 2) AS prezzo_medio_stimato_usd
FROM film
WHERE biglietti_mondo_mln IS NOT NULL
ORDER BY biglietti_mln DESC;

-- 2.6  Critica e pubblico vanno d'accordo con gli incassi?
SELECT CASE WHEN rotten_tomatoes_pct >= 90 THEN '1) RT 90%+'
            WHEN rotten_tomatoes_pct >= 70 THEN '2) RT 70-89%'
            ELSE '3) RT sotto 70%' END AS fascia_critica,
       COUNT(*) AS n_film,
       ROUND(AVG(incasso_mondiale_mln), 0) AS incasso_medio_mln
FROM film
WHERE rotten_tomatoes_pct IS NOT NULL
GROUP BY fascia_critica
ORDER BY fascia_critica;


-- =====================================================================
--  DOMANDA 3 – FILM E GIOCHI FANNO CERCARE IL FUMETTO? 📈
-- =====================================================================

-- 3.1  Ricerche del fumetto: 6 mesi prima, mese di uscita, 6 mesi dopo
SELECT tipo, titolo, mese_uscita, fumetto_prima, fumetto_mese_uscita, fumetto_dopo, variazione_pct,
       ROUND(fumetto_mese_uscita / fumetto_prima, 2) AS picco_rispetto_a_prima
FROM eventi_trends
ORDER BY mese_uscita;

-- 3.2  In media: film contro videogiochi
SELECT tipo,
       COUNT(*)                                                          AS n_uscite,
       ROUND(AVG(fumetto_mese_uscita / fumetto_prima), 2)                AS picco_medio,
       ROUND(AVG(variazione_pct), 1)                                     AS variazione_media_6_mesi_pct,
       SUM(CASE WHEN differenza > 0 THEN 1 ELSE 0 END)                   AS uscite_con_crescita
FROM eventi_trends
GROUP BY tipo;

-- 3.3  Quale media cercano di più le persone? Media annuale per tipo
SELECT SUBSTR(mese, 1, 4) AS anno, media, ROUND(AVG(interesse), 1) AS interesse_medio
FROM trends_media
GROUP BY SUBSTR(mese, 1, 4), media
ORDER BY anno, interesse_medio DESC;

-- 3.4  Il mese di massimo interesse per ogni media
WITH massimi AS (
    SELECT media, mese, interesse,
           ROW_NUMBER() OVER (PARTITION BY media ORDER BY interesse DESC, mese) AS r
    FROM trends_media
)
SELECT media, mese, interesse FROM massimi WHERE r = 1;


-- =====================================================================
--  DOMANDA 4 – SPIDER-MAN NEI VIDEOGIOCHI 🎮
-- =====================================================================

-- 4.1  Quanti giochi per decennio, su quante piattaforme, che voti
SELECT decennio,
       COUNT(*)                          AS n_giochi,
       ROUND(AVG(n_piattaforme), 1)      AS piattaforme_medie,
       ROUND(AVG(metacritic), 0)         AS metacritic_medio,
       COUNT(metacritic)                 AS giochi_con_voto
FROM videogiochi
GROUP BY decennio
ORDER BY decennio;

-- 4.2  Su quali console è uscito
SELECT famiglia_principale, COUNT(*) AS n_giochi
FROM videogiochi
GROUP BY famiglia_principale
ORDER BY n_giochi DESC;

-- 4.3  I giochi migliori secondo la critica
SELECT titolo, anno, sviluppatore, metacritic, copie_milioni
FROM videogiochi
WHERE metacritic IS NOT NULL
ORDER BY metacritic DESC
LIMIT 10;

-- 4.4  Gli sviluppatori che hanno fatto più giochi
SELECT sviluppatore, COUNT(*) AS n_giochi, MIN(anno) AS primo, MAX(anno) AS ultimo,
       ROUND(AVG(metacritic), 0) AS metacritic_medio
FROM videogiochi
WHERE sviluppatore IS NOT NULL
GROUP BY sviluppatore
HAVING COUNT(*) >= 2
ORDER BY n_giochi DESC;


-- =====================================================================
--  DOMANDA 5 – I PERSONAGGI DEL SUO MONDO 🦹
-- =====================================================================

-- 5.1  I personaggi con più apparizioni nei fumetti (dati 2014)
SELECT personaggio, ruolo, apparizioni, anno_debutto
FROM personaggi
WHERE apparizioni IS NOT NULL
ORDER BY apparizioni DESC
LIMIT 15;

-- 5.2  Quando sono nati i nemici? (per decennio del debutto)
SELECT anno_debutto - (anno_debutto % 10) AS decennio, COUNT(*) AS nuovi_nemici
FROM personaggi
WHERE ruolo = 'Nemico' AND anno_debutto IS NOT NULL
GROUP BY decennio
ORDER BY decennio;

-- 5.3  I nemici "classici" (primi 50 numeri di Amazing Spider-Man) contro gli altri
SELECT CASE WHEN numero_debutto_amazing <= 50 THEN 'Classici (#1-50)' ELSE 'Successivi' END AS gruppo,
       COUNT(*) AS n_nemici, ROUND(AVG(apparizioni), 0) AS apparizioni_medie
FROM personaggi
WHERE ruolo = 'Nemico' AND apparizioni IS NOT NULL
GROUP BY gruppo;


-- =====================================================================
--  VISTA RIEPILOGATIVA: tutte le uscite per decennio e tipo di media
-- =====================================================================
CREATE VIEW v_media_per_decennio AS
SELECT decennio,
       SUM(CASE WHEN media = 'Film' THEN 1 ELSE 0 END)                    AS film,
       SUM(CASE WHEN media = 'Serie TV' THEN 1 ELSE 0 END)                AS serie_tv,
       SUM(CASE WHEN media = 'Videogioco' THEN 1 ELSE 0 END)              AS videogiochi,
       SUM(CASE WHEN media = 'Fumetto (nuova testata)' THEN 1 ELSE 0 END) AS nuove_testate
FROM timeline_media
GROUP BY decennio;

SELECT * FROM v_media_per_decennio ORDER BY decennio;
