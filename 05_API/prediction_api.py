# =================================================================
# prediction_api.py
# Zweck: Energieverbrauch über eine API vorhersagen
# =================================================================

from pathlib import Path

import joblib
import pandas as pd
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel


# -----------------------------------------------------------------
# 1. API erstellen
# -----------------------------------------------------------------

app = FastAPI(
    title="ASHRAE Energy Prediction API",
    description="API zur Vorhersage des Energieverbrauchs",
    version="1.0.0"
)


# -----------------------------------------------------------------
# 2. Aktuelle Random-Forest-Pipeline laden
# -----------------------------------------------------------------

BASE_DIR = Path(__file__).resolve().parent

pipeline_path = BASE_DIR / "rf_pipeline.joblib"

rf_pipeline = joblib.load(pipeline_path)

print("Random-Forest-Pipeline erfolgreich geladen.")

# Kontrolle
if hasattr(rf_pipeline, "n_features_in_"):
    print(
        "Anzahl Features:",
        rf_pipeline.n_features_in_
    )

if hasattr(rf_pipeline, "feature_names_in_"):
    print(
        "Features:",
        list(rf_pipeline.feature_names_in_)
    )


# -----------------------------------------------------------------
# 3. Eingabedaten
#    Genau dieselben 10 Features wie beim aktuellen Modell
# -----------------------------------------------------------------

class PredictionInput(BaseModel):

    square_feet: float
    year_built: float
    air_temperature: float
    dew_temperature: float
    wind_speed: float
    sea_level_pressure: float

    hour: int
    day_of_week: int
    month: int
    year: int


# -----------------------------------------------------------------
# 4. Startseite
# -----------------------------------------------------------------

@app.get("/")
def root():

    return {
        "message": "ASHRAE Energy Prediction API is running"
    }


# -----------------------------------------------------------------
# 5. Prediction Endpoint
# -----------------------------------------------------------------

@app.post("/predict")
def predict_energy(data: PredictionInput):

    try:

        # Daten exakt in der Reihenfolge des Modells
        input_data = pd.DataFrame([{
            "square_feet": data.square_feet,
            "year_built": data.year_built,
            "air_temperature": data.air_temperature,
            "dew_temperature": data.dew_temperature,
            "wind_speed": data.wind_speed,
            "sea_level_pressure": data.sea_level_pressure,
            "hour": data.hour,
            "day_of_week": data.day_of_week,
            "month": data.month,
            "year": data.year
        }])

        # Pipeline:
        # Imputation + Random Forest
        prediction = rf_pipeline.predict(input_data)[0]

        return {
            "predicted_energy_consumption": round(
                float(prediction),
                4
            )
        }

    except Exception as e:

        raise HTTPException(
            status_code=500,
            detail=f"Prediction error: {str(e)}"
        )