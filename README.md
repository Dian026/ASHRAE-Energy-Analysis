# ASHRAE Energy Analysis

Analyse des Energieverbrauchs von Gebäuden auf Basis des **ASHRAE Energy Prediction Datensatzes** – von der relationalen Datenbank über explorative und statistische Analyse bis hin zu Machine Learning und einer funktionierenden API.

**Vollständiger Data-Analytics-Workflow:**

```text
SQL / MySQL → Python → Statistik → Feature Engineering → Machine Learning → API
```

---

## Forschungsfrage

**Wie unterscheidet sich der Energieverbrauch nach Gebäudetyp, Zählertyp und Standort, und welche Zusammenhänge bestehen mit Gebäude- und Wetterinformationen?**

---

## Projektziele

* Aufbau und Verwaltung einer relationalen Datenbank
* Integration von Energie-, Gebäude- und Wetterdaten
* Prüfung der Datenqualität
* Explorative Datenanalyse (EDA)
* Statistische Untersuchung des Energieverbrauchs
* Visualisierung wichtiger Ergebnisse
* Feature Engineering
* Entwicklung und Bewertung von Machine-Learning-Modellen
* Bereitstellung einer API für Vorhersage und Wetterdaten
* Dokumentation der Ergebnisse
* Präsentation des Gesamtprojekts

---

## Daten

Das Projekt verwendet den **ASHRAE Energy Prediction Datensatz** mit Energie-, Gebäude- und Wetterinformationen.

Zentrale Tabellen:

* `train`
* `building_metadata`
* `weather_train`
* `train_full`

Wichtige Verknüpfungsschlüssel:

* `building_id`
* `site_id`
* `timestamp`

Der konsolidierte Datensatz `train_full` verbindet Energieverbrauch, Gebäudeinformationen und Wetterdaten.

---

## Datenverarbeitung – Workflow

Die großen originalen ASHRAE-Datendateien werden aufgrund ihrer Dateigröße
nicht im GitHub-Repository gespeichert.

Die SQL-Skripte für Import, Datenaufbereitung und Analyse sind jedoch
vollständig im Repository dokumentiert.

```text
Daten
  ↓
Datenqualität
  ↓
Explorative Datenanalyse (EDA)
  ↓
Statistische Analyse
  ↓
Visualisierung
  ↓
Feature Engineering
  ↓
Machine Learning
  ↓
Modellbewertung
  ↓
Interpretation
  ↓
API
  ↓
Dokumentation / Präsentation
```

---

## SQL / MySQL

Der SQL-Teil bildet die Grundlage der Datenverarbeitung.

### Durchgeführte Schritte

* Erstellung der Datenbank und Tabellen
* Import der Rohdaten
* Prüfung der Datenqualität
* Prüfung von Schlüsselspalten
* Verknüpfung der Tabellen
* Analyse der Energiedaten

Die zentralen SQL-Skripte befinden sich unter:

```text
01_SQL_MySQL/

├── 01_database_setup.sql
├── 02_data_import.sql
├── 03_data_quality.sql
├── 04_train_full.sql
├── 05_analysis.sql
├── joins.sql
└── README.md
```

---

## Python

Der Python-Teil umfasst:

* Datenexploration
* Datenaufbereitung
* statistische Auswertung
* Visualisierung
* Vorbereitung der Machine-Learning-Daten

Notebooks:

```text
02_Python/
├── data_exploration.ipynb
├── statistics.ipynb
└── visualizations.ipynb
```

---

## Statistik

Durchgeführt wurden:

* Deskriptive Statistik
* Verteilungsanalyse
* Vergleich von Gebäude- und Zählertypen
* Korrelationsanalyse
* ANOVA
* Ausreißeranalyse mit der IQR-Methode

Die statistische Analyse befindet sich unter:

```text
03_Statistics/
└── statistical_analysis.ipynb
```

---

## Feature Engineering

Für das Machine Learning wurden zusätzliche zeitliche und analytische Merkmale erzeugt.

Verwendete Merkmale für das aktuelle Random-Forest-Modell:

```text
square_feet
year_built
air_temperature
dew_temperature
wind_speed
sea_level_pressure
hour
day_of_week
month
year
```

Zeitbezogene Merkmale wurden aus `timestamp` abgeleitet:

* `hour`
* `day_of_week`
* `month`
* `year`

Zusätzliche Gebäude-, Wetter- und Zeitmerkmale wurden für die Modellierung aufbereitet.

Dazu gehören unter anderem:

 Gebäudefläche und Baujahr 

 Luft- und Taupunkttemperatur 

 Wind- und Luftdruckdaten 

 Stunde, Wochentag und Monat 

Fehlende numerische Werte wurden für das Random-Forest-Modell über eine Median-Imputation behandelt.

Für die Modellbereitstellung wurde das trainierte Random-Forest-Modell als Modellartefakt gespeichert.

---

## Machine Learning

Für die Modellierung wurden mehrere Ansätze untersucht:

1. Lineare Regression
2. Log-transformierte lineare Regression
3. Random Forest Regression

### Modellierung

Das Machine-Learning-Modell befindet sich unter:

```text
04_Machine_Learning/
└── ml_model.ipynb
```

Bewertet wurden die Modelle mit:

* MAE
* RMSE
* R²

---

## Statistische Analyse Die statistische Analyse wurde auf Basis von 500.000 Strommessungen durchgeführt.

 ### Verteilung des Energieverbrauchs 

 - **Mittelwert:** 245,89 
 - **Median:** 83,14 
 - **Standardabweichung:** 392,85


## Wichtigste Ergebnisse

| Analyse / Modell                       | Ergebnis                                                                                         |
| -------------------------------------- | ------------------------------------------------------------------------------------------------ |
| Temperatur ↔ Energieverbrauch          | Pearson r = 0,227, p < 0,001 → signifikanter positiver Zusammenhang                              |
| Unterschiede nach Gebäudenutzung       | ANOVA F = 3,500, p = 0,008407 → signifikanter Unterschied zwischen mindestens zwei Nutzungsarten |
| Ausreißer (IQR-Methode)                | 36.833 von 500.000 Werten (7,37 %)                                                               |
| Lineare Regression (Original)          | RMSE = 359,67, R² = 0,165                                                                        |
| Lineare Regression (log-transformiert) | RMSE = 426,45, R² = −0,174                                                                       |
| Random Forest                          | MAE = 21,51, RMSE = 75,06, R² = 0,9773                                                           |

### Kernaussage

Der Energieverbrauch zeigt eine deutliche Streuung und weist einen statistisch signifikanten positiven Zusammenhang mit der Außentemperatur auf.

Die Ergebnisse der ANOVA zeigen einen statistisch signifikanten Unterschied zwischen mindestens zwei Gebäudenutzungen.

Die linearen Modelle mit `air_temperature` und `square_feet` zeigen eine begrenzte Vorhersagequalität. Der Random Forest verwendet zusätzliche Gebäude-, Wetter- und Zeitmerkmale.

**Hinweis:** Die linearen Modelle und der Random Forest wurden in der aktuellen Projektversion auf unterschiedlich großen Testdatensätzen bewertet. Für einen direkten und fairen Modellvergleich sollten alle Modelle auf demselben Train-Test-Split evaluiert werden.

Visualisierungen befinden sich in:

```text
results/figures/
```

---

## API

Das Projekt enthält eine **FastAPI-Anwendung** für Vorhersage und Wetterdaten.

### Architektur

```text
ASHRAE-Daten
      ↓
SQL / MySQL
      ↓
Python / EDA
      ↓
Statistik
      ↓
Feature Engineering
      ↓
Machine Learning
 ┌────────┬─────────────┐
 ↓        ↓             ↓
Linear    Log      Random Forest
                         ↓
                      FastAPI
                   ┌─────┴─────┐
                   ↓           ↓
               /predict    /weather
```

### FastAPI Endpoints

| Methode | Endpoint   | Beschreibung                     |
| ------- | ---------- | -------------------------------- |
| GET     | `/`        | Prüft, ob die API aktiv ist      |
| POST    | `/predict` | Vorhersage des Energieverbrauchs |
| GET     | `/weather` | Abruf aktueller Wetterdaten      |

### Beispiel für `/predict`

Request:

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

Beispielantwort:

```json
{
  "predicted_energy_consumption": 166.1364
}
```

### Beispiel für `/weather`

Request:

```text
http://127.0.0.1:8002/weather
```

Beispielantwort:

```json
{
  "latitude": 51.2277,
  "longitude": 6.7735,
  "temperature": 18.7,
  "wind_speed": 6.8
}
```

### Swagger-Dokumentation

Die API kann interaktiv über Swagger getestet werden:

```text
http://127.0.0.1:8002/docs
```

### API-Projektstruktur

```text
05_API/

├── prediction_api.py
├── weather_api.py
├── requirements.txt
└── README.md
```

Die trainierten Machine-Learning-Modelle (`*.joblib`) werden lokal verwendet
und aufgrund ihrer Dateigröße über `.gitignore` von Git ausgeschlossen.

Weitere Informationen zur API befinden sich in:

```text
05_API/README.md
```

---

## Datenqualität

Die zentralen Energieverbrauchsdaten sind vollständig. Fehlende Werte treten hauptsächlich bei ergänzenden Gebäude- und Wetterinformationen auf.

Geprüft wurden:

* fehlende Werte
* Duplikate
* Datensatzgrößen
* Schlüssel
* Verknüpfungen
* Vollständigkeit zentraler Messdaten

---

## Technologien

| Bereich           | Technologie                               |
| ----------------- | ----------------------------------------- |
| Datenbank         | MySQL                                     |
| Abfragesprache    | SQL                                       |
| Programmierung    | Python                                    |
| Datenanalyse      | Pandas                                    |
| Visualisierung    | Matplotlib                                |
| Statistik         | Deskriptive Statistik, ANOVA, Korrelation |
| Machine Learning  | Scikit-learn                              |
| API               | FastAPI, Uvicorn                          |
| Wetterdaten       | Open-Meteo API                            |
| Modellspeicherung | Joblib                                    |
| Dokumentation     | GitHub                                    |
| Präsentation      | PowerPoint                                |

---

## Projektstruktur

```text
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

## Installation

Repository klonen:

```bash
git clone https://github.com/Dian026/ASHRAE-Energy-Analysis.git
cd ASHRAE-Energy-Analysis
```

Python-Abhängigkeiten installieren:

```bash
pip install -r requirements.txt
```

Die Notebooks unter `02_Python/`, `03_Statistics/` und `04_Machine_Learning/` können anschließend in Jupyter geöffnet und ausgeführt werden.

Für den SQL-Teil wird eine lokale MySQL-Instanz benötigt.

Die originalen ASHRAE-Datendateien werden separat lokal bereitgestellt
und sind nicht Bestandteil des GitHub-Repositories.

Für die API:

```bash
pip install -r 05_API/requirements.txt
```

Die API kann anschließend mit:

```bash
python -m uvicorn prediction_api:app --app-dir 05_API --port 8002
```

gestartet werden.

---

## Präsentation

Die vollständige Projektpräsentation befindet sich unter:

```text
presentation/ASHRAE_Presentation.pptx
```

---

## GitHub

Das vollständige Projekt ist auf GitHub verfügbar:

**Repository:**

https://github.com/Dian026/ASHRAE-Energy-Analysis

Der Repository enthält den vollständigen Workflow von SQL und Python über Statistik und Machine Learning bis hin zur FastAPI-Anwendung.

---

## QR-Code

Der QR-Code verweist direkt auf das GitHub-Repository.

```text
ASHRAE Energy Analysis

GitHub
[ QR CODE ]

SQL • Python • Statistik • Machine Learning • FastAPI
```

Der QR-Code kann mit `create_qr.py` erzeugt werden.

---

## Projektziel

Das Projekt zeigt einen vollständigen **Data-Analytics-Workflow** von der Datenbank über SQL, Python und Statistik bis hin zu Machine Learning und API-Entwicklung.

Im Mittelpunkt stehen:

* strukturierte Datenverarbeitung
* nachvollziehbare statistische Analysen
* Feature Engineering
* Modellierung und Bewertung
* API-Bereitstellung
* professionelle Dokumentation und Präsentation

---

## Lizenz

Dieses Projekt steht unter der [MIT-Lizenz](LICENSE).

---

## Autor

**Mamadou Dian Diallo**

GitHub: [Dian026](https://github.com/Dian026)
