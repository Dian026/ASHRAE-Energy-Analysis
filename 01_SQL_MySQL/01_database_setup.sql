-- Projektdatenbank erstellen
CREATE DATABASE IF NOT EXISTS ashrae_energy;


-- Datenbank auswählen
USE ashrae_energy;

-- #####################################################################
-- 2. IMPORT VORBEREITEN
-- #####################################################################

-- Verfügbare Datenbanken anzeigen
SHOW DATABASES;


-- #####################################################################
-- 3. TABELLEN ERSTELLEN
-- #####################################################################

-- =====================================================================
-- 3.1 Gebäudedaten
-- =====================================================================

CREATE TABLE IF NOT EXISTS building_metadata (
    site_id INT,
    building_id INT PRIMARY KEY,
    primary_use VARCHAR(100),
    square_feet INT,
    year_built INT,
    floor_count INT
);


-- =====================================================================
-- 3.2 Wetterdaten
-- =====================================================================

CREATE TABLE IF NOT EXISTS weather_train (
    site_id INT,
    timestamp DATETIME,
    air_temperature FLOAT,
    cloud_coverage FLOAT,
    dew_temperature FLOAT,
    precip_depth_1_hr FLOAT,
    sea_level_pressure FLOAT,
    wind_direction FLOAT,
    wind_speed FLOAT
);


-- =====================================================================
-- 3.3 Energieverbrauchsdaten
-- =====================================================================

CREATE TABLE IF NOT EXISTS train (
    building_id INT,
    meter INT,
    timestamp DATETIME,
    meter_reading FLOAT
);