# =================================================================
# weather_api.py
# Zweck: Externe Wetterdaten über Open-Meteo abrufen
# =================================================================

import requests


def get_weather(latitude: float, longitude: float):
    """
    Ruft aktuelle Wetterdaten für einen Standort ab.
    """

    url = "https://api.open-meteo.com/v1/forecast"

    params = {
        "latitude": latitude,
        "longitude": longitude,
        "current": "temperature_2m,wind_speed_10m",
        "timezone": "auto"
    }

    response = requests.get(
        url,
        params=params,
        timeout=10
    )

    response.raise_for_status()

    return response.json()


if __name__ == "__main__":

    weather = get_weather(
        latitude=51.2277,
        longitude=6.7735
    )

    print("Aktuelle Wetterdaten:")
    print(weather)