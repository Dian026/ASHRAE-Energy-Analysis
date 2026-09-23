-- =====================================================================
-- Datenqualität & Plausibilitätsprüfung
-- =====================================================================


-- =====================================================================
-- 5.1 Tabellenübersicht
-- =====================================================================

SHOW TABLES;


-- =====================================================================
-- 5.2 Anzahl der Datensätze
-- =====================================================================

SELECT COUNT(*) AS anzahl_datensaetze
FROM train;
DESCRIBE train;
SELECT COUNT(*) AS anzahl_datensaetze
FROM building_metadata;


-- Datenqualität der Tabelle train überprüfen.
SELECT
    COUNT(*) AS total,
    SUM(building_id IS NULL) AS missing_building,
    SUM(timestamp IS NULL) AS missing_timestamp,
    SUM(meter IS NULL) AS missing_meter,
    SUM(meter_reading IS NULL) AS missing_meter_reading
FROM train;

-- =====================================================================
-- 5.3 Erste Datensätze überprüfen
-- =====================================================================

SELECT *
FROM train
LIMIT 10;

SELECT *
FROM building_metadata
LIMIT 10;

SELECT *
FROM weather_train
LIMIT 10;

-- 6. DATENSTRUKTUR UND DATENQUALITÄT
-- #####################################################################

-- =====================================================================
-- 6.1 Tabellenstruktur überprüfen
-- =====================================================================

DESCRIBE train;

DESCRIBE building_metadata;

DESCRIBE weather_train;


-- =====================================================================
-- 6.2 Fehlende Werte in train
-- =====================================================================
SELECT
    COUNT(*) AS gesamt,
    SUM(building_id IS NULL) AS fehlend_building_id,
    SUM(meter IS NULL) AS fehlend_meter,
    SUM(`timestamp` IS NULL) AS fehlend_timestamp,
    SUM(meter_reading IS NULL) AS fehlend_meter_reading
FROM ashrae_energy.train;


-- =====================================================================
-- 6.3 Fehlende Werte in building_metadata
-- =====================================================================
SELECT
    COUNT(*) AS gesamt,
    SUM(building_id IS NULL) AS fehlend_building_id,
    SUM(site_id IS NULL) AS fehlend_site_id,
    SUM(primary_use IS NULL) AS fehlend_primary_use,
    SUM(square_feet IS NULL) AS fehlend_square_feet,
    SUM(year_built IS NULL) AS fehlend_year_built,
    SUM(floor_count IS NULL) AS fehlend_floor_count
FROM ashrae_energy.building_metadata;


-- =====================================================================
-- 6.4 Fehlende Werte in weather_train
-- =====================================================================
SELECT
    COUNT(*) AS gesamt,
    SUM(site_id IS NULL) AS fehlend_site_id,
    SUM(`timestamp` IS NULL) AS fehlend_timestamp,
    SUM(air_temperature IS NULL) AS fehlend_air_temperature,
    SUM(cloud_coverage IS NULL) AS fehlend_cloud_coverage,
    SUM(dew_temperature IS NULL) AS fehlend_dew_temperature,
    SUM(precip_depth_1_hr IS NULL) AS fehlend_precip_depth,
    SUM(sea_level_pressure IS NULL) AS fehlend_sea_level_pressure,
    SUM(wind_direction IS NULL) AS fehlend_wind_direction,
    SUM(wind_speed IS NULL) AS fehlend_wind_speed
FROM ashrae_energy.weather_train;



-- =====================================================================
-- 6.5 NULL-Werte und 0-Werte im Energieverbrauch
-- =====================================================================
--
-- NULL = fehlender Messwert
-- 0    = gültiger Messwert
--
-- Daher werden 0-Werte nicht als fehlende Daten betrachtet.
-- =====================================================================

SELECT
    COUNT(*) - COUNT(meter_reading) AS null_meter_reading
FROM train;


SELECT
    COUNT(*) AS zero_meter_reading
FROM train
WHERE meter_reading = 0;


