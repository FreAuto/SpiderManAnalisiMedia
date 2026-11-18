# 🕷️ Spider-Man in tutti i media – Progetto Data Analyst

![Spider-Man nei media](copertina.png)

Progetto personale di **Francesco Autorino**.

🛠️ Strumenti: **Excel · SQL · Python · Power BI**

📅 Dati raccolti il 25 ottobre 2026.

---

## 🧭 1. La domanda del progetto

**Come è cresciuto Spider-Man passando dai fumetti a film, serie TV e videogiochi?**

La divido in 5 domande più piccole:

1️⃣ Quale media ha fatto guadagnare di più?

2️⃣ Come sono andati i film? Quale saga funziona meglio?

3️⃣ Film e videogiochi fanno cercare il fumetto?

4️⃣ Come è cambiato Spider-Man nei videogiochi?

5️⃣ Chi sono i personaggi più importanti del suo mondo?

📝 Le risposte sono in **05Python/CONCLUSIONI.md**.

---

## 🔄 2. Il percorso dei dati

```
INTERNET          01_raccolta.py      02_pulizia.py        ANALISI
Wikipedia ──┐                                         ┌──► 📗 Excel
Google ─────┼──►  ❌ 14 file grezzi  ──►  ✅ 11 tabelle ──┼──► 🗄️ SQL
FiveThirty- │     (1GrezziNonPuliti)  (2Puliti)       ├──► 🐍 Python
Eight ──────┘                                          └──► 📊 Power BI
```

👉 In parole semplici:

1. Lo script **01** scarica i dati da internet.
2. Lo script **02** li pulisce e li ordina in tabelle.
3. Excel, SQL, Python e Power BI leggono **le stesse tabelle pulite**.

---

## 📁 3. Tutti i file, uno per uno

### 📄 Nella cartella principale

| File | A cosa serve |
|---|---|
| `README.md` | Questo file: spiega tutto il progetto |
| `LEGGIMI.md` (in ogni cartella) | Una spiegazione corta di cosa c'è in quella cartella |

---

### 📂 01RaccoltaDati – gli script Python

| File | A cosa serve |
|---|---|
| `01_raccolta.py` | 📥 Scarica i dati da Wikipedia, Google Trends e FiveThirtyEight. Salva tutto in `02Dati/1GrezziNonPuliti`. |
| `02_pulizia.py` | 🧹 Pulisce i dati grezzi: toglie simboli, trasforma "$825,820,266" in 825,8 milioni, unisce le tabelle, corregge gli errori. Salva in `02Dati/2Puliti`. |

🔧 **Le correzioni fatte da `02_pulizia.py`:**

- Il film TV del 1977 ha lo stesso titolo del film del 2002: i dati non vengono mescolati.
- Serie TV con lo stesso nome (es. "Spider-Man" del 1967 e del 2017): aggiunge l'anno al nome.
- Generi dei giochi attaccati ("Action-adventureBeat 'em up"): li separa.
- Sviluppatori lunghi ("Treyarch / Beenox / ..."): tiene solo il principale.
- Copie vendute: usa solo le tabelle ufficiali Wikipedia, non i numeri scritti nel testo.

---

### 📂 02Dati/1GrezziNonPuliti – i dati grezzi (come scaricati)

| File | Fonte | Cosa contiene |
|---|---|---|
| `wiki_film_incassi.csv` | Wikipedia "Spider-Man in film" | Incassi USA, estero, mondiali e budget dei film |
| `wiki_film_biglietti.csv` | Wikipedia "Spider-Man in film" | Biglietti venduti (stima) |
| `wiki_film_voti.csv` | Wikipedia "Spider-Man in film" | Voti Rotten Tomatoes, Metacritic, CinemaScore |
| `wiki_film_attori.csv` | Wikipedia "Spider-Man in film" | Attori di ogni personaggio, per saga |
| `wiki_serie_tv.csv` | Wikipedia "Spider-Man in television" | Stagioni, episodi, date, rete TV |
| `wiki_videogiochi.csv` | Wikipedia "List of Spider-Man video games" | 41 giochi: anno, piattaforme, sviluppatore |
| `wiki_videogiochi_dettagli.csv` | Pagina Wikipedia di ogni gioco | Voti Metacritic e genere |
| `wiki_videogiochi_vendite.csv` | Liste Wikipedia dei giochi più venduti per console | Copie vendute (5 giochi) |
| `wiki_fumetti_testate.csv` | Wikipedia "List of Spider-Man titles" | Testate a fumetti, volumi, numeri, anni |
| `wiki_nemici.csv` | Wikipedia "List of Spider-Man enemies" | 100 nemici, alter ego, debutto |
| `google_trends_media.csv` | Google Trends | Ricerche "Spider-Man" + comic / movie / game / cartoon / toy |
| `google_trends_fumetto.csv` | Google Trends | Ricerche "Spider-Man comic" da sola (scala 0-100) |
| `google_trends_attori.csv` | Google Trends | Ricerche dei tre attori e di Miles Morales |
| `fivethirtyeight_marvel.csv` | FiveThirtyEight (GitHub) | 16.000 personaggi Marvel con apparizioni (dati 2014) |

💡 La prima colonna `tabella` dice il nome del file: serve allo script per riconoscerlo.

---

### 📂 02Dati/2Puliti – le 11 tabelle pulite

Sono le tabelle usate da Excel, SQL, Python e Power BI.

| Tabella | Righe | Una riga = | Colonne principali |
|---|---|---|---|
| `film.csv` | 12 | un film | titolo, anno, saga, attore, incasso_mondiale_mln, budget_mln, biglietti_mondo_mln, rotten_tomatoes_pct, metacritic, cinemascore, moltiplicatore_budget |
| `videogiochi.csv` | 41 | un gioco | titolo, anno, piattaforme, n_piattaforme, famiglia_principale, sviluppatore, genere_principale, metacritic, copie_milioni, era |
| `serie_tv.csv` | 34 | una stagione | serie, stagione, episodi, data_inizio, data_fine, rete, stato |
| `fumetti_testate.csv` | 267 | una testata (volume) | tipo, titolo, volume, numeri_pubblicati, anno_inizio, anno_fine, in_corso |
| `incassi_franchise.csv` | 5 | una voce di incasso | voce, incasso_milioni_usd, quota_pct |
| `personaggi.csv` | 104 | un personaggio | personaggio, alter_ego, ruolo, anno_debutto, apparizioni |
| `trends_media.csv` | 1.370 | un mese per un media | mese, media, interesse |
| `trends_fumetto.csv` | 274 | un mese | mese, interesse |
| `trends_attori.csv` | 1.096 | un mese per una persona | mese, persona, interesse |
| `eventi_trends.csv` | 15 | un'uscita (film o gioco) | titolo, mese_uscita, fumetto_prima, fumetto_mese_uscita, fumetto_dopo, variazione_pct |
| `timeline_media.csv` | 248 | un'uscita qualsiasi | anno, media, titolo, decennio |

📖 **Le colonne meno chiare:**

- `moltiplicatore_budget` = incasso diviso budget (es. 8,5 vuol dire che ogni dollaro speso ne ha fatti tornare 8,5)
- `cinemascore_numero` = il voto del pubblico (A+, A, B+…) trasformato in numero (A+ = 4,33)
- `interesse` = Google Trends, da 0 a 100 (100 = il mese con più ricerche)
- `fumetto_prima` / `fumetto_dopo` = media delle ricerche del fumetto nei 6 mesi prima / dopo l'uscita
- `famiglia_principale` = la console della prima versione del gioco (Nintendo, PlayStation, PC…)

---

### 📂 03Excel

| File | A cosa serve |
|---|---|
| `SpiderMan_Analisi.xlsx` | 📗 Il file Excel finito (135 formule, zero errori) |
| `crea_excel.py` | Lo script che crea il file Excel dalle tabelle pulite |

**I fogli del file Excel:**

| Foglio | Cosa c'è |
|---|---|
| LEGGIMI | Guida, legenda colori, fonti, limiti |
| Riepilogo | 11 indicatori principali, confronto tra saghe, giochi per decennio, ricerche intorno alle uscite (tutto con formule) |
| Film | Tabella dei film + 4 colonne calcolate (moltiplicatore, profitto, quota estero, prezzo medio del biglietto) |
| Videogiochi | Tabella dei giochi, voti colorati + colonna "giocato" da compilare (SI/NO) |
| Serie_TV, Fumetti, Personaggi | Tabelle complete con filtri |
| Incassi | Voci di incasso, totale con formula, grafico |
| Prima_Dopo | Ricerche del fumetto intorno alle uscite, con picco e variazione calcolati |
| Controllo_Qualita | Valori mancanti, doppioni, controllo che le quote facciano 100 |

🎨 Colonne **arancioni** = formule · celle **gialle con testo blu** = da compilare a mano.

---

### 📂 04SQL

| File | A cosa serve |
|---|---|
| `schema_concettuale.png` | 🧩 Lo schema concettuale (modello Entità-Relazione) |
| `schema_logico.png` | 🗂️ Lo schema logico: tabelle, chiavi PK/FK e collegamenti |
| `crea_schemi.py` | 🛠️ Disegna i 2 schemi con Graphviz |
| `01_crea_database.sql` | 🏗️ Crea il database `SpiderMan` e le 11 tabelle in MySQL |
| `02_carica_dati.py` | 📥 Carica i dati: in SQLite (crea `spiderman.db`) o in MySQL (`--mysql`) |
| `03_query_analisi.sql` | 🔍 21 query divise per domanda (funzionano in MySQL e SQLite) |
| `spiderman.db` | 🗄️ Il database già pronto. Lo apri con **DB Browser for SQLite** |

**Le tecniche SQL usate:** GROUP BY, HAVING, CASE WHEN, CTE (WITH), funzioni finestra (RANK, ROW_NUMBER, LAG), UNION ALL, viste.


🧩 **Schema concettuale**

![Schema concettuale](04SQL/schema_concettuale.png)

🗂️ **Schema logico**

![Schema logico](04SQL/schema_logico.png)

---

### 📂 05Python

| File | A cosa serve |
|---|---|
| `analisi_spiderman.ipynb` | 📓 Il notebook con tutte le analisi, già eseguito (lo apri con Jupyter) |
| `crea_notebook.py` | Lo script che crea il notebook |
| `CONCLUSIONI.md` | 📝 Le risposte alle 5 domande, con i numeri |
| `Grafici/` | 🖼️ I 13 grafici in PNG |

**I 13 grafici:**

| N° | Grafico | Domanda |
|---|---|---|
| 01 | Incassi del franchise per voce | 1 |
| 02 | Incasso mondiale di ogni film | 2 |
| 03 | Critica contro incassi | 2 |
| 04 | Biglietti venduti per film | 2 |
| 05 | Ricerche Google per tipo di media | 3 |
| 06 | Ricerche del fumetto con le date di uscita | 3 |
| 07 | Ricerche del fumetto prima, durante e dopo ogni film | 3 |
| 08 | Ricerche dei tre attori e di Miles Morales | 2-3 |
| 09 | Voti Metacritic dei videogiochi nel tempo | 4 |
| 10 | Videogiochi per decennio e console | 4 |
| 11 | Episodi delle serie TV | – |
| 12 | Nuove testate a fumetti per decennio | – |
| 13 | I 15 personaggi con più apparizioni | 5 |

**I test statistici:** correlazione di Spearman (critica e incassi), test di Wilcoxon (ricerche prima e dopo i film).

---

### 📂 06PowerBi

| File | A cosa serve |
|---|---|
| `SpiderManDashboard/SpiderMan_Dashboard.pbip` | 📊 **La dashboard pronta**: doppio clic per aprirla in Power BI Desktop (Windows) |
| `SpiderManDashboard/…SemanticModel/` | Il modello dati: 11 tabelle con i dati incorporati e 21 misure DAX (formato TMDL, file di testo) |
| `SpiderManDashboard/…Report/` | Le 7 pagine della dashboard in formato PBIR (la prima è "La storia"): una cartella per pagina, un file `visual.json` per grafico. In `StaticResources/` ci sono il tema e gli sfondi |
| `SpiderMan_Dashboard.pdf` | Il PDF della dashboard finale (7 pagine) |
| `Script/crea_powerbi.py` | Crea una versione base del progetto Power BI (`SpiderManDashboardBase`): non tocca la dashboard finale |
| `Script/sistema_layout.py` | Mette al posto giusto le immagini inserite a mano e aggiunge la pagina "La storia" |
| `Script/crea_immagini.py` | Disegna da zero le grafiche originali della dashboard (ragnatele, intestazione blu) |
| `Immagini/GraficheOriginali/` | Le grafiche create da zero: sfondi e ragnatele |
| `Immagini/SpiderMan/` | Le immagini inserite a mano nella dashboard |
| `GUIDA_POWER_BI.md` | Come aprire la dashboard, cosa fare se non si apre, e come costruirla a mano |
| `misure_DAX.txt` | Le misure DAX spiegate, da copiare se costruisci a mano |
| `tema_spiderman.json` | Il tema rosso e blu: è già applicato al report |

**Le 6 pagine della dashboard:**

| Pagina | Cosa mostra |
|---|---|
| 1 Panoramica | 6 numeri chiave, incassi per voce, uscite per decennio e tipo di media |
| 2 I film | Incasso di ogni film, incasso medio per saga, critica contro incassi, tabella di dettaglio, filtro per saga |
| 3 Ricerche Google | Ricerche per tipo di media, picco del fumetto alle uscite, prima/durante/dopo ogni film, attori |
| 4 Videogiochi | Voti Metacritic nel tempo, giochi per decennio e console, i giochi migliori |
| 5 Fumetti, TV, personaggi | Personaggi con più apparizioni, episodi per serie, testate per decennio e tipo |
| 6 Conclusioni | Le risposte alle 5 domande e i limiti |

---

## ▶️ 4. Come rifare tutto da zero

Apri il Terminale e copia questi comandi uno alla volta:

```bash
cd ~/Desktop/Work/Esercitazioni/ProgettoSpiderMan/01RaccoltaDati
pip install pandas requests lxml beautifulsoup4 pytrends openpyxl nbformat nbconvert
python 01_raccolta.py
python 02_pulizia.py
cd ../03Excel && python crea_excel.py
cd ../04SQL && python 02_carica_dati.py
cd ../05Python && python crea_notebook.py
cd ../06PowerBi && python Script/crea_immagini.py && python Script/crea_powerbi.py
```

💡 Se `python` non funziona, scrivi `python3`.

---

## 🔗 5. Da dove arrivano i dati (link)

| Fonte | Cosa ho preso | Link |
|---|---|---|
| Wikipedia – Spider-Man in film | Incassi, budget, biglietti, voti, attori dei 12 film | https://en.wikipedia.org/wiki/Spider-Man_in_film |
| Wikipedia – Spider-Man in television | Serie TV, stagioni, episodi, reti | https://en.wikipedia.org/wiki/Spider-Man_in_television |
| Wikipedia – List of Spider-Man video games | I 41 videogiochi: anno, piattaforme, sviluppatore | https://en.wikipedia.org/wiki/List_of_Spider-Man_video_games |
| Wikipedia – pagina di ogni gioco | Voto Metacritic e genere | (link nella colonna `articolo_wikipedia` di `wiki_videogiochi_dettagli.csv`) |
| Wikipedia – giochi più venduti per console | Copie vendute di 5 giochi | https://en.wikipedia.org/wiki/List_of_best-selling_PlayStation_video_games · https://en.wikipedia.org/wiki/List_of_best-selling_PlayStation_2_video_games · https://en.wikipedia.org/wiki/List_of_best-selling_PlayStation_4_video_games · https://en.wikipedia.org/wiki/List_of_best-selling_PlayStation_5_video_games |
| Wikipedia – List of Spider-Man titles | Testate a fumetti, volumi, numeri, anni | https://en.wikipedia.org/wiki/List_of_Spider-Man_titles |
| Wikipedia – List of Spider-Man enemies | I nemici e il loro debutto | https://en.wikipedia.org/wiki/List_of_Spider-Man_enemies |
| Wikipedia – List of highest-grossing media franchises | Incasso totale del franchise per voce | https://en.wikipedia.org/wiki/List_of_highest-grossing_media_franchises |
| Google Trends | Ricerche mese per mese dal 2004 | https://trends.google.com/trends/explore?date=all&q=Spider-Man%20comic |
| FiveThirtyEight (GitHub) | Personaggi Marvel e numero di apparizioni | https://github.com/fivethirtyeight/data/tree/master/comic-characters |

📅 Tutti i dati sono stati raccolti il **25 ottobre 2026**: le pagine Wikipedia possono cambiare nel tempo.

---

## 🪜 6. Tutti i passaggi fatti, in ordine

1️⃣ **Domanda**: ho scelto la domanda principale e le 5 domande più piccole.

2️⃣ **Fattibilità**: ho controllato che per ogni domanda esistessero dati pubblici e gratuiti.

3️⃣ **Raccolta** (`01_raccolta.py`): ho scaricato 14 file grezzi da Wikipedia, Google Trends e FiveThirtyEight.

4️⃣ **Pulizia** (`02_pulizia.py`):
   - trasformato testi come "$825,820,266" in numeri (825,8 milioni);
   - separato film e serie con lo stesso titolo aggiungendo l'anno;
   - separato i generi dei giochi attaccati;
   - tenuto solo lo sviluppatore principale;
   - sommato i numeri dei fumetti dagli intervalli "#1–700";
   - unito i nemici di Wikipedia con le apparizioni di FiveThirtyEight;
   - creato 11 tabelle pulite.

5️⃣ **Excel** (`crea_excel.py`): 10 fogli con formule, menu a tendina e foglio di controllo qualità.

6️⃣ **SQL** (`02_carica_dati.py` + `03_query_analisi.sql`): database con 11 tabelle e 21 query di analisi.

7️⃣ **Python** (notebook): 13 grafici e un test statistico (Wilcoxon) sull'effetto dei film sulle ricerche del fumetto.

8️⃣ **Power BI**: dashboard di 7 pagine con tema rosso e blu, sfondi disegnati da zero, pagina "La storia" e immagini inserite a mano.

9️⃣ **Conclusioni**: risposte alle 5 domande in `05Python/CONCLUSIONI.md` e PDF della dashboard.

---

## ⚠️ 7. Limiti dei dati

📌 Le copie vendute sono note solo per **5 videogiochi**.

📌 Le vendite dei singoli fumetti **non sono pubbliche**.

📌 Google Trends misura le **ricerche**, non le vendite.

📌 *Brand New Day* (2026) è appena uscito: incassi e biglietti possono ancora crescere.

📌 I personaggi sono aggiornati al **2014** (FiveThirtyEight).

📌 I numeri dei fumetti sono contati dagli intervalli scritti su Wikipedia (ristampe comprese).
