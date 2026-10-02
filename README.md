# 🏢 ASHRAE Energy Analysis

**End-to-End Data-Analytics-Projekt** zur Analyse des Energieverbrauchs von Gebäuden – von der relationalen Datenbank über explorative & statistische Analyse bis hin zu Machine Learning und einer produktiven API.

![Python](https://img.shields.io/badge/Python-3.10-blue?logo=python&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-Database-orange?logo=mysql&logoColor=white)
![FastAPI](https://img.shields.io/badge/FastAPI-API-teal?logo=fastapi&logoColor=white)
![scikit-learn](https://img.shields.io/badge/scikit--learn-ML-yellowgreen?logo=scikitlearn)
![License](https://img.shields.io/badge/License-MIT-lightgrey)

```text
SQL / MySQL → Python → Statistik → Feature Engineering → Machine Learning → API
```

---

## 👀 Auf einen Blick

* **Was:** Analyse und Vorhersage des Stromverbrauchs von Gebäuden auf Basis des ASHRAE-Datensatzes
* **Umfang:** über 20 Mio. Zeilen in MySQL, 500.000 Messungen für die Analyse und das Machine Learning
* **Methoden:** SQL, EDA, Korrelation, ANOVA, Ausreißeranalyse, lineare Regression, Random Forest
* **Ergebnis:** Random Forest mit R² = **0,9953** auf 100.000 Testdaten
* **Bereitstellung:** FastAPI mit den Endpoints `/predict` und `/weather` sowie Swagger-Dokumentation
* **Code & Doku:** vollständiger Workflow auf GitHub, inklusive Präsentation

---

## 🎯 Forschungsfrage

> Wie unterscheidet sich der Energieverbrauch nach Gebäudetyp, Zählertyp und Standort, und welche Zusammenhänge bestehen mit Gebäude- und Wetterinformationen?

---

## ✨ Projekt-Highlights

| Kennzahl             | Ergebnis                                                                                  |
| -------------------- | ----------------------------------------------------------------------------------------- |
| 📊 Datenbasis        | > 20 Mio. Zeilen in `train_full`, davon 500.000 Messungen für das ML-Modell               |
| 🧹 Datenvorbereitung | 500.000 Beobachtungen beibehalten, fehlende Feature-Werte per Median-Imputation behandelt |
| 🤖 Random Forest     | R² = **0,9953**, MAE = **8,16**, RMSE = **27,04**                                         |
| 🌳 Modell            | RandomForestRegressor mit 100 Bäumen                                                      |
| 🚀 Deployment        | FastAPI-Anwendung mit Swagger/OpenAPI                                                     |
| 🔌 API-Test          | `/predict` erfolgreich mit **440,6812** getestet                                          |

Das finale Random-Forest-Modell wird für die Vorhersage des Energieverbrauchs verwendet und anschließend über eine FastAPI-Anwendung bereitgestellt.

---

## 🧠 Gezeigte Kompetenzen

| Bereich            | Umsetzung im Projekt                                                         |
| ------------------ | ---------------------------------------------------------------------------- |
| Datenbanken        | MySQL-Aufbau, Import, Datenqualitätsprüfung, Joins, Indizes                  |
| Datenanalyse       | EDA mit Python und Pandas, Visualisierung mit Matplotlib                     |
| Statistik          | Deskriptive Statistik, Korrelation, ANOVA, IQR-Ausreißeranalyse              |
| Machine Learning   | Feature Engineering, lineare Regression, Log-Transformation, Random Forest   |
| Modellbewertung    | MAE, RMSE, R², Train-Test-Split, kritische Einordnung der Ergebnisse         |
| Deployment         | FastAPI, Swagger/OpenAPI, Joblib-Pipeline, Anbindung der Open-Meteo-API      |
| Dokumentation      | Strukturiertes GitHub-Repository, README, Präsentation                       |

---

## 🧩 Projektziele

* Aufbau und Verwaltung einer relationalen Datenbank (MySQL)
* Integration von Energie-, Gebäude- und Wetterdaten
* Prüfung der Datenqualität
* Explorative Datenanalyse (EDA)
* Statistische Untersuchung des Energieverbrauchs (Korrelation, ANOVA, Ausreißeranalyse)
* Visualisierung zentraler Ergebnisse
* Feature Engineering für das Machine Learning
* Entwicklung und Bewertung mehrerer ML-Modelle
* Bereitstellung einer API für Vorhersage und Live-Wetterdaten
* Dokumentation und Präsentation des Gesamtprojekts

---

## 🗂️ Daten

Verwendet wird der **ASHRAE Energy Prediction Datensatz** mit Energie-, Gebäude- und Wetterinformationen.

**Zentrale Tabellen:** `train`, `building_metadata`, `weather_train`, `train_full`

**Verknüpfungsschlüssel:** `building_id`, `site_id`, `timestamp`

Der konsolidierte Datensatz `train_full` verbindet Energieverbrauch, Gebäudeinformationen und Wetterdaten.

> ℹ️ Die originalen ASHRAE-Rohdaten werden aufgrund ihrer Dateigröße nicht im Repository gespeichert. Alle SQL-Skripte für Import, Aufbereitung und Analyse sind jedoch vollständig dokumentiert.

---

## 🔄 Workflow

```text
Daten → Datenqualität → EDA → Statistische Analyse → Visualisierung
       → Feature Engineering → Machine Learning → Modellbewertung
       → Interpretation → API → Dokumentation / Präsentation
```

---

## 🗄️ SQL / MySQL

Grundlage der Datenverarbeitung: Datenbank- und Tabellenaufbau, Import der Rohdaten, Qualitäts- und Schlüsselprüfung, Verknüpfung der Tabellen sowie erste Analysen.

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

### Optimierung der Abfragen

Es wurden Indizes auf den zentralen Verknüpfungsschlüsseln angelegt, u. a. `building_id`, `timestamp` und `(site_id, timestamp)`, um die Performance der SQL-Abfragen zu verbessern.

<details>
<summary>📋 Übersicht der Indizes anzeigen</summary>

```text
+-------------------+-----------------------+-------------+
| TABLE_NAME        | INDEX_NAME            | COLUMN_NAME |
+-------------------+-----------------------+-------------+
| building_metadata | idx_building_id       | building_id |
| train             | idx_train_building    | building_id |
| train             | idx_train_timestamp   | timestamp   |
| weather_train     | idx_weather_site_time | site_id     |
| weather_train     | idx_weather_site_time | timestamp   |
+-------------------+-----------------------+-------------+
```

</details>

---

## 🐍 Python

Datenexploration, Datenaufbereitung, statistische Auswertung, Visualisierung und Vorbereitung der ML-Daten.

```text
02_Python/

├── data_exploration.ipynb
├── statistics.ipynb
└── visualizations.ipynb
```

---

## 📈 Statistik

Durchgeführte Analysen: deskriptive Statistik, Verteilungsanalyse, Vergleich von Gebäude- und Zählertypen, Korrelationsanalyse, ANOVA sowie Ausreißeranalyse mittels IQR-Methode.

```text
03_Statistics/

└── statistical_analysis.ipynb
```

### Verteilung des Energieverbrauchs (n = 500.000)

| Kennzahl                |                        Wert |
| ----------------------- | --------------------------: |
| Mittelwert              |                      245,89 |
| Median                  |                       83,14 |
| Standardabweichung      |                      392,85 |
| Ausreißer (IQR-Methode) | 36.833 von 500.000 (7,37 %) |

---

## 🛠️ Feature Engineering

Für das Machine Learning wurden zusätzliche zeitliche und analytische Merkmale erzeugt.

### Features

Das finale Modell verwendet die folgenden **10 Features**:

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

Die Variable `meter_reading` dient als Zielvariable.

### Zeitliche Features

Die zeitbezogenen Merkmale `hour`, `day_of_week`, `month` und `year` werden aus der Spalte `timestamp` abgeleitet:

```python
df["hour"] = df["timestamp"].dt.hour
df["day_of_week"] = df["timestamp"].dt.dayofweek
df["month"] = df["timestamp"].dt.month
df["year"] = df["timestamp"].dt.year
```

Dadurch kann das Modell zeitliche Schwankungen des Energieverbrauchs berücksichtigen.

### Datenvorbereitung

Die verwendeten Features werden in numerische Werte konvertiert.

Die **500.000 ausgewählten Beobachtungen bleiben erhalten**. Fehlende Werte in den numerischen Features werden nicht durch das Löschen von Zeilen behandelt, sondern innerhalb der Machine-Learning-Pipeline durch eine Median-Imputation ersetzt:

```python
SimpleImputer(strategy="median")
```

Dadurch bleiben die verfügbaren Beobachtungen erhalten und fehlende Feature-Werte werden anhand des Medians der Trainingsdaten ersetzt.

Die Zielvariable `meter_reading` wird für die Modellierung verwendet.

### Train-Test-Split

Die Daten werden in einen Trainings- und einen Testdatensatz aufgeteilt:

| Datensatz   |  Anzahl |
| ----------- | ------: |
| Gesamtdaten | 500.000 |
| Training    | 400.000 |
| Test        | 100.000 |

Es wird ein **80/20-Split** mit `random_state=42` verwendet.

### Finaler Feature-Engineering-Prozess

```text
Rohdaten
   ↓
Konvertierung von timestamp
   ↓
Erstellung zeitlicher Features
   ↓
Auswahl der 10 Features
   ↓
Numerische Konvertierung
   ↓
Median-Imputation (in der Pipeline)
   ↓
Random Forest
   ↓
Vorhersage von meter_reading
```

---

## 🤖 Machine Learning

Untersuchte Modelle:

1. Lineare Regression
2. Log-transformierte lineare Regression
3. **Random Forest Regression**

Bewertung anhand von **MAE**, **RMSE** und **R²**.

```text
04_Machine_Learning/

└── ml_model.ipynb
```

### Ergebnisübersicht

Die Modelle wurden anhand der Kennzahlen MAE, RMSE und R² bewertet.

| Modell                        | Merkmale |  MAE ↓ | RMSE ↓ |    R² ↑ |
| ----------------------------- | -------: | -----: | -----: | ------: |
| Lineare Regression            |        2 | 230,26 | 359,67 |  0,1649 |
| Log-transformierte Regression |        2 | 224,47 | 426,45 | -0,1740 |
| Random Forest                 |        2 | 151,01 | 259,10 |  0,5666 |
| Random Forest                 |       10 |  15,93 |  47,97 |  0,9851 |

Die beiden Random-Forest-Modelle wurden mit denselben Trainings- und Testdaten ausgewertet. Die Ergebnisse der linearen Modelle stammen aus der vorherigen Auswertung und sind nur direkt vergleichbar, wenn dieselbe Datenaufteilung und Datenvorverarbeitung verwendet wurden.

### Bewertungskennzahlen

* **MAE (Mean Absolute Error):** Misst die durchschnittliche absolute Abweichung zwischen den tatsächlichen und den vorhergesagten Energieverbrauchswerten.
* **RMSE (Root Mean Squared Error):** Bewertet die Vorhersagefehler und gewichtet größere Abweichungen stärker.
* **R² (Bestimmtheitsmaß):** Gibt an, wie viel der Variabilität des Energieverbrauchs durch das Modell erklärt wird.

Niedrigere MAE- und RMSE-Werte sowie ein höherer R²-Wert weisen im Allgemeinen auf eine bessere Vorhersageleistung hin.

### Finales Random-Forest-Modell

Das finale Random-Forest-Modell verwendet zehn Merkmale zur Vorhersage des Energieverbrauchs.

**Verwendete Merkmale**

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

**Zielvariable:** `meter_reading`

**Aufteilung des Datensatzes**

| Datensatz       | Anzahl der Beobachtungen |
| --------------- | -----------------------: |
| Gesamtdatensatz |                  500.000 |
| Trainingsdaten  |                  400.000 |
| Testdaten       |                  100.000 |

**Modellergebnisse**

| Kennzahl |   Wert |
| -------- | -----: |
| MAE      |  15,93 |
| RMSE     |  47,97 |
| R²       | 0,9851 |

### Fehleranalyse

Die Residuen beschreiben die Differenz zwischen den tatsächlichen und den vorhergesagten Werten:

```text
Residuum = Tatsächlicher Wert - Vorhergesagter Wert
```

Die Residuenanalyse hilft dabei, systematische Fehler und Beobachtungen mit großen Vorhersageabweichungen zu erkennen. Zusammen mit MAE, RMSE und R² ermöglicht sie eine Bewertung der Vorhersageleistung des Modells.

Die Machine-Learning-Pipeline ersetzt fehlende Werte mithilfe einer **Median-Imputation**. Anschließend erfolgt die Vorhersage mit einem `RandomForestRegressor` mit **100 Entscheidungsbäumen**.


### Gespeichertes Random-Forest-Modell

Die Random-Forest-Pipeline wurde erfolgreich gespeichert.

* **Datei:** `05_API/rf_pipeline.joblib`
* **Format:** Joblib
* **Größe:** ca. 2,19 GB
* **Status:** Erfolgreich gespeichert

### Finales Modell für die API

Das finale Modell für die API ist ein:

```text
RandomForestRegressor
```

Das Modell ist in eine Pipeline integriert:

```text
SimpleImputer(strategy="median")
        ↓
RandomForestRegressor
```

mit folgenden Parametern:

```python
RandomForestRegressor(
    n_estimators=100,
    random_state=42,
    n_jobs=-1
)
```

Das trainierte Pipeline-Modell wird gespeichert als:

```text
05_API/rf_pipeline.joblib
```

Das für die API gespeicherte Modell (`rf_pipeline.joblib`) wurde auf den 400.000 Trainingsdaten trainiert und auf den 100.000 Testdaten evaluiert.

### Interpretation der Ergebnisse

Die Verbrauchsdaten weisen eine **asymmetrische Verteilung** auf. Deshalb wurde zusätzlich eine Log-Transformation getestet. Diese führte jedoch zu keiner Verbesserung des RMSE.

Der Random Forest verwendet zehn Gebäude-, Wetter- und Zeitmerkmale:

`square_feet`, `year_built`, `air_temperature`, `dew_temperature`, `wind_speed`, `sea_level_pressure`, `hour`, `day_of_week`, `month` und `year`.

Durch die Verwendung eines Random Forest können auch **nichtlineare Zusammenhänge und Interaktionen zwischen den Merkmalen** berücksichtigt werden.

Mit einem **R² von 0,9846**, einem **MAE von 16,12** und einem **RMSE von 48,62** zeigt das finale Modell eine hohe Vorhersageleistung auf dem verwendeten Testdatensatz.

> **Hinweis zur Aussagekraft:** Der Train-Test-Split erfolgt zufällig. Da Gebäude in stündlichen Messreihen sowohl in den Trainings- als auch in den Testdaten vorkommen, kann die Vorhersagequalität für vollständig unbekannte Gebäude geringer ausfallen. Eine Validierung mit gebäudebasierter Trennung wäre ein sinnvoller nächster Schritt.

---

## 🔍 Wichtigste Ergebnisse & Interpretation

## 🔍 Wichtigste Ergebnisse

* Die Datenanalyse zeigt deutliche Unterschiede im Energieverbrauch zwischen Gebäuden und Nutzungskategorien.
* Ein **Random Forest Regressor** wurde mit Gebäude-, Wetter- und Zeitmerkmalen trainiert.
* Bei der klassischen Evaluation (zufälliger Split, bekannte Gebäude) erreicht das Modell **R² = 0,9846**, **MAE = 16,12** und **RMSE = 48,62**.
* Bei der Evaluation auf **unbekannten Gebäuden** (`GroupShuffleSplit`) sinkt das **R² auf 0,1945**.
* Eine zufällige Datenaufteilung kann die Generalisierungsfähigkeit daher überschätzen. Die gebäudebasierte Validierung liefert eine realistischere Einschätzung.

### 🏗️ Generalisierung auf unbekannte Gebäude

Für die gebäudebasierte Evaluation wurden **40 Gebäude für das Training und 10 Gebäude für den Test** verwendet. Kein Gebäude kommt in beiden Datensätzen vor.

| Evaluation         |    MAE |   RMSE |     R² |
| ------------------ | -----: | -----: | -----: |
| Klassischer Split  |  16,12 |  48,62 | 0,9846 |
| Unbekannte Gebäude | 472,05 | 932,92 | 0,1945 |

**Fazit:** Das Modell erzielt eine hohe Leistung bei bekannten Gebäuden. Auf unbekannten Gebäuden ist die Leistung deutlich geringer. Die **Generalisierung auf neue Gebäude** ist daher die zentrale Herausforderung.

> **Hinweis:** Die gebäudebasierte Evaluation basiert auf einem einzelnen Split mit 10 Testgebäuden. Das Ergebnis kann stark von der Auswahl dieser Gebäude abhängen. Eine Kreuzvalidierung mit `GroupKFold` wäre ein sinnvoller nächster Schritt.

### Key Finding

The model achieves a high R² with the classical evaluation, but its performance decreases significantly when predicting energy consumption for buildings that were not seen during training.

This evaluation highlights the importance of testing **model generalization** using a validation strategy that reflects real-world conditions.



## 🌐 API

Das Projekt enthält eine **FastAPI**-Anwendung für Vorhersage und Live-Wetterdaten.

### Architektur

```text
ASHRAE-Daten → SQL/MySQL → Python/EDA → Statistik → Feature Engineering
                                                          ↓
                                               Linear · Log · Random Forest
                                                          ↓
                                                       FastAPI
                                                      ┌────┴────┐
                                                 /predict    /weather
```

### API-Struktur

```text
05_API/

├── prediction_api.py
├── weather_api.py
├── rf_pipeline.joblib
├── requirements.txt
└── README.md
```

### Modelldatei

Die Datei `rf_pipeline.joblib` enthält die Random-Forest-Pipeline, die von der API verwendet wird.

| Eigenschaft | Wert                              |
| ----------- | --------------------------------- |
| Datei       | `05_API/rf_pipeline.joblib`       |
| Größe       | ca. 2,19 GB (2.191.874.817 Bytes) |
| Format      | Joblib                            |

Aufgrund ihrer Größe ist die Modelldatei nicht im GitHub-Repository enthalten. Um die API lokal auszuführen, muss die Datei im Ordner `05_API/` liegen. Die Datei kann mit dem Notebook `04_Machine_Learning/ml_model.ipynb` erzeugt werden. Die API lädt die Pipeline beim Start automatisch.


### Endpoints

| Methode | Endpoint   | Beschreibung                     |
| ------- | ---------- | -------------------------------- |
| `GET`   | `/`        | Prüft, ob die API aktiv ist      |
| `POST`  | `/predict` | Vorhersage des Energieverbrauchs |
| `GET`   | `/weather` | Abruf aktueller Wetterdaten      |

### Beispiel-Response `/`

```json
{
  "message": "ASHRAE Energy Prediction API is running",
  "model": "Random Forest",
  "version": "1.0.0",
  "features": 10
}
```

### Beispiel-Request `/predict`

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

### Beispiel-Response `/predict`

```json
{
  "predicted_energy_consumption": 440.6812
}
```

Die Vorhersage wurde mit denselben Eingabewerten sowohl im Notebook als auch über die API getestet.

```text
Notebook : 440.6812
API      : 440.6812
```

Damit liefern Notebook und API für dieselben Eingabedaten dieselbe Vorhersage.

### Endpoint `/weather`

Der Endpoint `/weather` ermöglicht den Abruf aktueller Wetterdaten anhand geografischer Koordinaten.

**Parameter:**

| Parameter   | Typ    | Beschreibung        |
| ----------- | ------ | ------------------- |
| `latitude`  | number | Geografische Breite |
| `longitude` | number | Geografische Länge  |

**Beispiel-Request:**

```text
GET /weather?latitude=51.2277&longitude=6.7735
```

Der Endpoint wurde erfolgreich mit HTTP-Statuscode `200` getestet.

**Beispiel-Response:**

```json
{
  "latitude": 51.2277,
  "longitude": 6.7735,
  "temperature": 28.5,
  "wind_speed": 10.4
}
```

> Die Werte sind Live-Daten (Open-Meteo) und ändern sich bei jedem Abruf.

### Swagger / OpenAPI

Die API stellt eine interaktive Swagger/OpenAPI-Dokumentation bereit.

Nach dem Start des Servers ist die Dokumentation erreichbar unter:

```text
http://127.0.0.1:8002/docs
```

Über Swagger können die Endpoints `/`, `/predict` und `/weather` direkt getestet werden.

### API-Status

| Endpoint   | Methode | Status |
| ---------- | ------- | ------ |
| `/`        | GET     | 200 ✅  |
| `/predict` | POST    | 200 ✅  |
| `/weather` | GET     | 200 ✅  |

> Die trainierten Modelle (`*.joblib`) werden lokal genutzt und sind aufgrund ihrer Größe via `.gitignore` von Git ausgeschlossen.

---

## ✅ Datenqualität

Die zentralen Energieverbrauchsdaten sind **vollständig**; fehlende Werte betreffen vor allem ergänzende Gebäude- und Wetterinformationen.

Geprüft wurden: fehlende Werte, Duplikate, Datensatzgrößen, Schlüssel, Verknüpfungen sowie die Vollständigkeit zentraler Messdaten.

---

## 🧰 Technologien

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


## 📁 Projektstruktur

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
│   ├── rf_pipeline.joblib
│   ├── requirements.txt
│   └── README.md
│
├── results/
│   └── figures/
│
├── assets/
│   └── qr_code.png
│
├── presentation/
│   └── ASHRAE_Presentation.pptx
│
├── requirements.txt
├── create_qr.py
├── LICENSE
└── README.md
```

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

Der folgende QR-Code verweist direkt auf das Repository:

<p align="center">
  <img src="assets/qr_code.png" alt="QR-Code zum GitHub-Repository" width="180">
</p>

Der QR-Code kann mit `create_qr.py` neu erzeugt werden:

```bash
python create_qr.py
```

## 🏁 Fazit

Dieses Projekt demonstriert einen **vollständigen Data-Analytics-Workflow** – von der Datenbank über SQL, Python und Statistik bis hin zu Machine Learning und API-Entwicklung.

Im Mittelpunkt stehen:

* strukturierte Datenverarbeitung
* nachvollziehbare statistische Analysen
* durchdachtes Feature Engineering
* Modellierung und Bewertung
* produktionsnahe API-Bereitstellung
* professionelle Dokumentation und Präsentation

---

## 📄 Lizenz

Dieses Projekt steht unter der [MIT-Lizenz](LICENSE).

## 👤 Autor

**Mamadou Dian Diallo**

GitHub: [@Dian026](https://github.com/Dian026)