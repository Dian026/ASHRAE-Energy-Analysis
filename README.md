# ASHRAE Energy Analysis

Analyse des Energieverbrauchs von Gebäuden auf Basis des ASHRAE Energy
Prediction Datensatzes — von der relationalen Datenbank über explorative
und statistische Analyse bis zum Machine-Learning-Modell.

**Vollständiger Data-Analytics-Workflow:** SQL / MySQL → Python → Statistik → Machine Learning

---

## Forschungsfrage

**Wie unterscheidet sich der Energieverbrauch nach Gebäudetyp, Zählertyp und
Standort, und welche Zusammenhänge bestehen mit Gebäude- und
Wetterinformationen?**

---

## Wichtigste Ergebnisse

| Analyse | Ergebnis |
|---|---|
| Temperatur ↔ Energieverbrauch | Pearson r = 0.198, p < 0.001 → signifikanter positiver Zusammenhang |
| Unterschiede nach Gebäudenutzung | ANOVA F = 2.707, p = 0.032 → signifikanter Unterschied zwischen den Nutzungsarten |
| Ausreißer (IQR-Methode) | 67.045 von 500.000 Werten (13,41 %) — überwiegend reale Spitzenverbräuche, keine Fehler |
| Lineare Regression (Original) | RMSE = 359.67, R² = 0.165 |
| Lineare Regression (log-transformiert) | RMSE = 426.45, R² = −0.174 → keine Verbesserung gegenüber dem Originalmodell |

**Kernaussage:** Der Energieverbrauch variiert signifikant zwischen
Gebäudenutzungen und korreliert mit der Außentemperatur. Ein einfaches
lineares Modell mit nur zwei Merkmalen (`air_temperature`, `square_feet`)
erklärt den Verbrauch jedoch nur begrenzt (R² = 0.165) — ein Hinweis darauf,
dass weitere Einflussfaktoren nötig sind.

Visualisierungen dazu befinden sich in [`results/figures/`](results/figures/).

---

## Projektziele

- Aufbau und Verwaltung einer relationalen Datenbank
- Integration von Energie-, Gebäude- und Wetterdaten
- Prüfung der Datenqualität
- Explorative Datenanalyse (EDA)
- Statistische Untersuchung des Energieverbrauchs
- Visualisierung wichtiger Ergebnisse
- Vorbereitung und Anwendung von Machine-Learning-Modellen
- Dokumentation der Ergebnisse

---

## Datenverarbeitung — Workflow

```text
Daten → Datenqualität → Explorative Datenanalyse (EDA) → Statistische Analyse
     → Visualisierung → Feature Engineering → Machine Learning
     → Modellbewertung → Interpretation → Dokumentation → Präsentation
```

---

## Technologien

| Bereich | Technologie |
|---|---|
| Datenbank | MySQL |
| Abfragesprache | SQL |
| Programmierung | Python |
| Datenanalyse | Pandas |
| Visualisierung | Matplotlib |
| Statistik | Deskriptive Statistik, ANOVA, Korrelation |
| Machine Learning | Scikit-learn |
| Dokumentation | GitHub |
| Präsentation | PowerPoint |

---

## Projektstruktur

```text
ASHRAE-Energy-Analysis/
│
├── 01_SQL_MySQL/
│   ├── 01_database_setup.sql
│   ├── 02_data_quality.sql
│   ├── 03_table_joins.sql
│   └── 04_energy_analysis.sql
│
├── 02_Python/
│   ├── data_exploration.ipynb
│   ├── statistics.ipynb
│   └── visualizations.ipynb
│
├── 03_Statistics/
│   └── statistical_analysis.ipynb
│
├── 04_Machine_Learning/
│   └── ml_model.ipynb
│
├── results/
│   └── figures/
│
├── presentation/
│   └── ASHRAE_Presentation.pptx
│
├── requirements.txt
├── create_qr.py
└── README.md
```

---

## Installation

```bash
git clone https://github.com/Dian026/ASHRAE-Energy-Analysis.git
cd ASHRAE-Energy-Analysis
pip install -r requirements.txt
```

Die Notebooks unter `02_Python/`, `03_Statistics/` und `04_Machine_Learning/`
können anschließend direkt in Jupyter geöffnet und ausgeführt werden.
Für den SQL-Teil wird eine lokale MySQL-Instanz benötigt; die Skripte unter
`01_SQL_MySQL/` erstellen Datenbank, Tabellen und Verknüpfungen.

---

## Projektdetails

### 1. SQL / MySQL

- Erstellung der Datenbank und Tabellen
- Import der Rohdaten
- Prüfung der Datenqualität
- Verknüpfung der Tabellen
- Analyse der Energiedaten

Zentrale Tabellen: `train`, `building_metadata`, `weather_train`, `train_full`
Verknüpfung über `building_id`, `site_id` und `timestamp`.
Der konsolidierte Datensatz `train_full` verbindet Energieverbrauchs-,
Gebäude- und Wetterinformationen.

### 2. Python

Datenexploration, Datenaufbereitung, statistische Auswertung,
Visualisierung und Vorbereitung der Machine-Learning-Daten.

### 3. Statistik

Deskriptive Statistik, Verteilungsanalyse, Vergleich von Gebäude- und
Zählertypen, Korrelations- und ANOVA-Tests, Ausreißeranalyse (IQR-Methode).

### 4. Machine Learning

Feature Engineering, Modellierung (lineare Regression, Original- und
log-transformierte Variante), Modellbewertung (MAE, RMSE, R²) und
Interpretation der Ergebnisse.

---

## Datenqualität

Die zentralen Energieverbrauchsdaten sind vollständig. Fehlende Werte
treten hauptsächlich bei ergänzenden Gebäude- und Wetterinformationen auf.
Geprüft wurden: fehlende Werte, Duplikate, Datensatzgrößen, Schlüssel und
Verknüpfungen sowie die Vollständigkeit zentraler Messdaten.

---

## Präsentation

Die vollständige Projektpräsentation befindet sich unter
[`presentation/ASHRAE_Presentation.pptx`](presentation/ASHRAE_Presentation.pptx).

---

## Projektziel

Das Projekt zeigt einen vollständigen Data-Analytics-Workflow von der
Datenbank über SQL, Python und Statistik bis hin zu Machine Learning.
Im Mittelpunkt stehen eine strukturierte Datenverarbeitung, nachvollziehbare
Analysen und eine professionelle Dokumentation.

---

## Lizenz

Dieses Projekt steht unter der [MIT-Lizenz](LICENSE).

---

## Autor

**Dian026**
GitHub: [github.com/Dian026/ASHRAE-Energy-Analysis](https://github.com/Dian026/ASHRAE-Energy-Analysis)