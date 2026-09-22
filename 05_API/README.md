# ASHRAE Energy Prediction API

## Beschreibung

Diese API erweitert das Projekt **ASHRAE Energy Analysis** um eine Anwendungsschicht für:

* die Vorhersage des Energieverbrauchs mit einem Random-Forest-Modell
* den Abruf aktueller Wetterdaten über die Open-Meteo API

Die API wurde mit **FastAPI** umgesetzt.

---

## Architektur

```text
ASHRAE-Daten
     ↓
SQL / MySQL
     ↓
Python + Statistik
     ↓
Feature Engineering
     ↓
Machine Learning
     ↓
FastAPI
   ↙      ↘
/predict  /weather
```

---

## Technologien

* Python
* FastAPI
* Uvicorn
* Pandas
* NumPy
* Scikit-learn
* Joblib
* Requests
* Open-Meteo API

---

## Modell

Für die Vorhersage wird eine Random-Forest-Pipeline verwendet.

Die Pipeline befindet sich lokal in:

```text
05_API/rf_pipeline.joblib
```

Sie verwendet 10 Merkmale:

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

Die Modelldatei wird über `.gitignore` von Git ausgeschlossen.

---

## Installation

Abhängigkeiten installieren:

```powershell
pip install -r 05_API/requirements.txt
```

Optional kann vorher eine virtuelle Umgebung erstellt werden:

```powershell
python -m venv .venv
.venv\Scripts\activate
```

---

## API starten

Aus dem Projektverzeichnis:

```powershell
python -m uvicorn prediction_api:app --app-dir 05_API --port 8002
```

Die API ist anschließend erreichbar unter:

```text
http://127.0.0.1:8002
```

Die interaktive Swagger-Dokumentation befindet sich unter:

```text
http://127.0.0.1:8002/docs
```

---

## Endpoints

| Methode | Endpoint   | Beschreibung                     |
| ------- | ---------- | -------------------------------- |
| GET     | `/`        | Prüft, ob die API aktiv ist      |
| POST    | `/predict` | Vorhersage des Energieverbrauchs |
| GET     | `/weather` | Abruf aktueller Wetterdaten      |

---

## 1. GET /

Test:

```text
http://127.0.0.1:8002/
```

Beispielantwort:

```json
{
  "message": "ASHRAE Energy Prediction API is running"
}
```

---

## 2. POST /predict

Dieser Endpoint berechnet eine Energieverbrauchsprognose mit der Random-Forest-Pipeline.

### Beispielanfrage

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

### Beispielantwort

```json
{
  "predicted_energy_consumption": 166.1364
}
```

Die zurückgegebene Zahl ist die Vorhersage des Machine-Learning-Modells und keine direkt gemessene Verbrauchszahl.

---

## 3. GET /weather

Der Endpoint ruft aktuelle Wetterdaten über die **Open-Meteo API** ab.

Standardkoordinaten:

```text
latitude  = 51.2277
longitude = 6.7735
```

### Test

```powershell
Invoke-RestMethod -Uri "http://127.0.0.1:8002/weather" -Method Get
```

### Tatsächliches Testergebnis

```text
latitude    : 51.2277
longitude   : 6.7735
temperature : 16.0
wind_speed  : 6.8
```

Die API liefert damit die aktuelle Temperatur und Windgeschwindigkeit für die verwendeten Koordinaten.

---

## Projektstruktur

```text
05_API/
│
├── prediction_api.py
├── weather_api.py
├── requirements.txt
├── README.md
└── rf_pipeline.joblib
```

`rf_pipeline.joblib` wird nicht in Git gespeichert.

---

## Status

Die API-Schicht des Projekts ist funktionsfähig.

**Implementiert und getestet:**

* Random-Forest-Pipeline geladen
* `GET /`
* `POST /predict`
* `GET /weather`
* Swagger-Dokumentation über `/docs`

Die API bildet damit die letzte technische Schicht des Projekts:

```text
Datenanalyse
→ Feature Engineering
→ Machine Learning
→ API
```
