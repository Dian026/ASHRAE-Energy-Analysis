# 🏢 ASHRAE Energy Analysis

**End-to-End Data-Analytics-Projekt** zur Analyse des Energieverbrauchs von Gebäuden – von der relationalen Datenbank über explorative & statistische Analyse bis hin zu Machine Learning und einer produktiven API.

![Python](https://img.shields.io/badge/Python-3.10-blue?logo=python&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-Database-orange?logo=mysql&logoColor=white)
![FastAPI](https://img.shields.io/badge/FastAPI-API-teal?logo=fastapi&logoColor=white)
![scikit--learn](https://img.shields.io/badge/scikit--learn-ML-yellowgreen?logo=scikitlearn)
![License](https://img.shields.io/badge/License-MIT-lightgrey)

```
SQL / MySQL → Python → Statistik → Feature Engineering → Machine Learning → API
```

---

## 🎯 Forschungsfrage

> Wie unterscheidet sich der Energieverbrauch nach Gebäudetyp, Zählertyp und Standort, und welche Zusammenhänge bestehen mit Gebäude- und Wetterinformationen?

---

## ✨ Projekt-Highlights

| Kennzahl | Ergebnis |
|---|---|
| 📊 Datenbasis | > 20 Mio. Zeilen (`train_full`), Analyse auf **500.000 Strommessungen** |
| 🌡️ Temperatur ↔ Verbrauch | Pearson r = **0,227**, p < 0,001 (signifikant positiv) |
| 🏗️ Unterschiede nach Nutzung | ANOVA F = 3,500, p = 0,0084 (signifikant) |
| 🤖 Bestes Modell | **Random Forest** – R² = **0,977**, MAE = 21,51, RMSE = 75,06 |
| 🚀 Deployment | Live vorhersagefähige **FastAPI**-Anwendung mit Swagger-UI |

Das Random-Forest-Modell erklärt **97,7 %** der Varianz im Energieverbrauch und übertrifft die linearen Baseline-Modelle deutlich.

---

## 🧩 Projektziele

- Aufbau und Verwaltung einer relationalen Datenbank (MySQL)
- Integration von Energie-, Gebäude- und Wetterdaten
- Prüfung der Datenqualität
- Explorative Datenanalyse (EDA)
- Statistische Untersuchung des Energieverbrauchs (Korrelation, ANOVA, Ausreißeranalyse)
- Visualisierung zentraler Ergebnisse
- Feature Engineering für das Machine Learning
- Entwicklung und Bewertung mehrerer ML-Modelle
- Bereitstellung einer API für Vorhersage und Live-Wetterdaten
- Dokumentation und Präsentation des Gesamtprojekts

---

## 🗂️ Daten

Verwendet wird der **ASHRAE Energy Prediction Datensatz** mit Energie-, Gebäude- und Wetterinformationen.

**Zentrale Tabellen:** `train`, `building_metadata`, `weather_train`, `train_full`
**Verknüpfungsschlüssel:** `building_id`, `site_id`, `timestamp`

Der konsolidierte Datensatz `train_full` verbindet Energieverbrauch, Gebäudeinformationen und Wetterdaten.

> ℹ️ Die originalen ASHRAE-Rohdaten werden aufgrund ihrer Dateigröße nicht im Repository gespeichert. Alle SQL-Skripte für Import, Aufbereitung und Analyse sind jedoch vollständig dokumentiert.

---

## 🔄 Workflow

```
Daten → Datenqualität → EDA → Statistische Analyse → Visualisierung
      → Feature Engineering → Machine Learning → Modellbewertung
      → Interpretation → API → Dokumentation / Präsentation
```

---

## 🗄️ SQL / MySQL

Grundlage der Datenverarbeitung: Datenbank- und Tabellenaufbau, Import der Rohdaten, Qualitäts- und Schlüsselprüfung, Verknüpfung der Tabellen sowie erste Analysen.

```
01_SQL_MySQL/
├── 01_database_setup.sql
├── 02_data_import.sql
├── 03_data_quality.sql
├── 04_train_full.sql
├── 05_analysis.sql
├── joins.sql
└── README.md
```

### Optimisation des requêtes

Des Index wurden auf den zentralen Verknüpfungsschlüsseln angelegt, u. a. `building_id`, `timestamp` und `(site_id, timestamp)`, um die Performance der SQL-Abfragen zu verbessern.

<details>
<summary>📋 Übersicht der Indizes anzeigen</summary>

```
+-------------------+-----------------------+-------------+
| TABLE_NAME        | INDEX_NAME             | COLUMN_NAME |
+-------------------+-----------------------+-------------+
| building_metadata | idx_building_id        | building_id |
| train             | idx_train_building     | building_id |
| train             | idx_train_timestamp    | timestamp   |
| weather_train     | idx_weather_site_time  | site_id     |
| weather_train     | idx_weather_site_time  | timestamp   |
+-------------------+-----------------------+-------------+
```

</details>

---

## 🐍 Python

Datenexploration, Datenaufbereitung, statistische Auswertung, Visualisierung und Vorbereitung der ML-Daten.

```
02_Python/
├── data_exploration.ipynb
├── statistics.ipynb
└── visualizations.ipynb
```

---

## 📈 Statistik

Durchgeführte Analysen: deskriptive Statistik, Verteilungsanalyse, Vergleich von Gebäude- und Zählertypen, Korrelationsanalyse, ANOVA sowie Ausreißeranalyse mittels IQR-Methode.

```
03_Statistics/
└── statistical_analysis.ipynb
```

### Verteilung des Energieverbrauchs (n = 500.000)

| Kennzahl | Wert |
|---|---|
| Mittelwert | 245,89 |
| Median | 83,14 |
| Standardabweichung | 392,85 |
| Ausreißer (IQR-Methode) | 36.833 von 500.000 (7,37 %) |

---

## 🛠️ Feature Engineering

Für das Machine Learning wurden zusätzliche zeitliche und analytische Merkmale erzeugt:

```
square_feet, year_built, air_temperature, dew_temperature,
wind_speed, sea_level_pressure, hour, day_of_week, month, year
```

Die zeitbezogenen Merkmale (`hour`, `day_of_week`, `month`, `year`) wurden aus `timestamp` abgeleitet. Fehlende numerische Werte wurden per **Median-Imputation** behandelt. Das trainierte Random-Forest-Modell wurde für die spätere Bereitstellung als Modellartefakt (Joblib) gespeichert.

---

## 🤖 Machine Learning

Untersuchte Modelle:

1. Lineare Regression
2. Log-transformierte lineare Regression
3. **Random Forest Regression**

Bewertung anhand von **MAE**, **RMSE** und **R²**.

```
04_Machine_Learning/
└── ml_model.ipynb
```

### Ergebnisübersicht

| Modell | RMSE | R² | MAE |
|---|---|---|---|
| Lineare Regression | 359,67 | 0,165 | – |
| Lineare Regression (log) | 426,45 | −0,174 | – |
| **Random Forest** | **75,06** | **0,9773** | **21,51** |

> ⚠️ **Hinweis zur Fairness:** Die linearen Modelle und der Random Forest wurden in der aktuellen Version auf unterschiedlich großen Testdatensätzen bewertet. Für einen direkten Vergleich sollten künftig alle Modelle auf demselben Train-Test-Split evaluiert werden.

---

## 🔍 Wichtigste Ergebnisse & Interpretation

- Der Energieverbrauch zeigt eine deutliche Streuung und einen statistisch signifikanten **positiven Zusammenhang mit der Außentemperatur**.
- Die ANOVA bestätigt **signifikante Unterschiede** im Verbrauch zwischen mindestens zwei Gebäudenutzungen.
- Die linearen Modelle mit `air_temperature` und `square_feet` liefern nur eine **begrenzte Vorhersagequalität**.
- Der **Random Forest** nutzt zusätzliche Gebäude-, Wetter- und Zeitmerkmale und erzielt eine deutlich höhere Vorhersagegenauigkeit.
- Die Analyse berücksichtigt sowohl Gesamtverbrauch als auch Durchschnittswerte mit und ohne Nullverbrauch, um den Einfluss von Messungen mit Verbrauch = 0 transparent darzustellen.

> **Performance-Hinweis:** `train_full` enthält über 20 Millionen Zeilen. Aggregationen wurden bewusst auf dem vollständigen Datensatz durchgeführt, ohne Daten zu löschen oder zu verändern – Datenintegrität wurde gegenüber reiner Abfrage-Optimierung priorisiert.

Visualisierungen: [`results/figures/`](results/figures/)

---

## 🌐 API

Das Projekt enthält eine **FastAPI**-Anwendung für Vorhersage und Live-Wetterdaten.

### Architektur

```
ASHRAE-Daten → SQL/MySQL → Python/EDA → Statistik → Feature Engineering
                                                          ↓
                              Linear · Log · Random Forest
                                                          ↓
                                                      FastAPI
                                                    ┌────┴────┐
                                               /predict    /weather
```

### Endpoints

| Methode | Endpoint | Beschreibung |
|---|---|---|
| `GET` | `/` | Prüft, ob die API aktiv ist |
| `POST` | `/predict` | Vorhersage des Energieverbrauchs |
| `GET` | `/weather` | Abruf aktueller Wetterdaten |

**Beispiel-Request `/predict`:**

```json
{
  "square_feet": 50000,
  "year_built": 2008,
  "air_temperature": 18.0,
  "dew_temperature": 12.0,
  "wind_speed": 3.0,
  "sea_level_pressure": 1015.0,
  "hour": 12,
  "day_of_week": 2,
  "month": 6,
  "year": 2026
}
```

**Beispiel-Response:**

```json
{
  "predicted_energy_consumption": 166.1364
}
```

**Beispiel `/weather`:**

```json
{
  "latitude": 51.2277,
  "longitude": 6.7735,
  "temperature": 18.7,
  "wind_speed": 6.8
}
```

📖 Interaktive Swagger-Dokumentation: `http://127.0.0.1:8002/docs`

```
05_API/
├── prediction_api.py
├── weather_api.py
├── requirements.txt
└── README.md
```

> Die trainierten Modelle (`*.joblib`) werden lokal genutzt und sind aufgrund ihrer Größe via `.gitignore` von Git ausgeschlossen.

---

## ✅ Datenqualität

Die zentralen Energieverbrauchsdaten sind **vollständig**; fehlende Werte betreffen vor allem ergänzende Gebäude- und Wetterinformationen.

Geprüft wurden: fehlende Werte, Duplikate, Datensatzgrößen, Schlüssel, Verknüpfungen sowie die Vollständigkeit zentraler Messdaten.

---

## 🧰 Technologien

| Bereich | Technologie |
|---|---|
| Datenbank | MySQL |
| Abfragesprache | SQL |
| Programmierung | Python |
| Datenanalyse | Pandas |
| Visualisierung | Matplotlib |
| Statistik | Deskriptive Statistik, ANOVA, Korrelation |
| Machine Learning | Scikit-learn |
| API | FastAPI, Uvicorn |
| Wetterdaten | Open-Meteo API |
| Modellspeicherung | Joblib |
| Dokumentation | GitHub |
| Präsentation | PowerPoint |

---

## 📁 Projektstruktur

```
ASHRAE-Energy-Analysis/
│
├── 01_SQL_MySQL/
│   ├── 01_database_setup.sql
│   ├── 02_data_import.sql
│   ├── 03_data_quality.sql
│   ├── 04_train_full.sql
│   ├── 05_analysis.sql
│   ├── joins.sql
│   └── README.md
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
├── 05_API/
│   ├── prediction_api.py
│   ├── weather_api.py
│   ├── requirements.txt
│   └── README.md
│
├── results/
│   └── figures/
│
├── presentation/
│   └── ASHRAE_Presentation.pptx
│
├── requirements.txt
├── create_qr.py
├── LICENSE
└── README.md
```

---

## ⚙️ Installation

```bash
# Repository klonen
git clone https://github.com/Dian026/ASHRAE-Energy-Analysis.git
cd ASHRAE-Energy-Analysis

# Python-Abhängigkeiten installieren
pip install -r requirements.txt
```

Die Notebooks unter `02_Python/`, `03_Statistics/` und `04_Machine_Learning/` können anschließend in Jupyter geöffnet und ausgeführt werden.

Für den SQL-Teil wird eine lokale MySQL-Instanz benötigt. Die originalen ASHRAE-Datendateien werden separat lokal bereitgestellt und sind nicht Bestandteil des Repositories.

**API starten:**

```bash
pip install -r 05_API/requirements.txt
python -m uvicorn prediction_api:app --app-dir 05_API --port 8002
```

---

## 🎤 Präsentation

Die vollständige Projektpräsentation befindet sich unter [`presentation/ASHRAE_Presentation.pptx`](presentation/ASHRAE_Presentation.pptx).

---

## 🔗 GitHub

**Repository:** [github.com/Dian026/ASHRAE-Energy-Analysis](https://github.com/Dian026/ASHRAE-Energy-Analysis)

Enthält den vollständigen Workflow von SQL und Python über Statistik und Machine Learning bis hin zur FastAPI-Anwendung.

Ein QR-Code, der direkt auf das Repository verweist, kann mit `create_qr.py` erzeugt werden.

---

## 🏁 Fazit

Dieses Projekt demonstriert einen **vollständigen Data-Analytics-Workflow** – von der Datenbank über SQL, Python und Statistik bis hin zu Machine Learning und API-Entwicklung. Im Mittelpunkt stehen:

- strukturierte Datenverarbeitung
- nachvollziehbare statistische Analysen
- durchdachtes Feature Engineering
- Modellierung und Bewertung
- produktionsnahe API-Bereitstellung
- professionelle Dokumentation und Präsentation

---

## 📄 Lizenz

Dieses Projekt steht unter der [MIT-Lizenz](LICENSE).

## 👤 Autor

**Mamadou Dian Diallo**
GitHub: [@Dian026](https://github.com/Dian026)