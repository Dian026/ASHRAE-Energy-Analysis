-- =====================================================================
-- ASHRAE Energy Analysis
-- Datenqualität und Plausibilitätsprüfung
-- =====================================================================

USE ashrae_energy;


-- =====================================================================
-- 1. Tabellenübersicht
-- =====================================================================
-- Überblick über die vorhandenen Tabellen.

SHOW TABLES;


-- =====================================================================
-- 2. Tabellenstruktur überprüfen
-- =====================================================================
-- Überprüfung der Spalten und Datentypen der relevanten Tabellen.

DESCRIBE train;

DESCRIBE building_metadata;

DESCRIBE weather_train;


-- =====================================================================
-- 3. Anzahl der Datensätze überprüfen
-- =====================================================================
-- Prüfung der Anzahl der Datensätze in den wichtigsten Tabellen.

SELECT COUNT(*) AS anzahl_datensaetze
FROM train;

SELECT COUNT(*) AS anzahl_datensaetze
FROM building_metadata;


-- =====================================================================
-- 4. Erste Datensätze überprüfen
-- =====================================================================
-- Stichprobenartige Kontrolle der geladenen Daten.

SELECT *
FROM train
LIMIT 10;

SELECT *
FROM building_metadata
LIMIT 10;

SELECT *
FROM weather_train
LIMIT 10;


-- =====================================================================
-- 5. Fehlende Werte in train
-- =====================================================================
-- Prüfung auf fehlende Werte in den zentralen Spalten der Tabelle train.

SELECT
    COUNT(*) AS gesamt,
    SUM(building_id IS NULL) AS fehlend_building_id,
    SUM(meter IS NULL) AS fehlend_meter,
    SUM(`timestamp` IS NULL) AS fehlend_timestamp,
    SUM(meter_reading IS NULL) AS fehlend_meter_reading
FROM ashrae_energy.train;


-- =====================================================================
-- 6. Fehlende Werte in building_metadata
-- =====================================================================
-- Prüfung auf fehlende Gebäude- und Metadaten.

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
-- 7. Fehlende Werte in weather_train
-- =====================================================================
-- Prüfung auf fehlende Wetterdaten.

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
-- 8. NULL- und 0-Werte im Energieverbrauch
-- =====================================================================
-- NULL = fehlender Messwert
-- 0    = vorhandener Messwert mit Verbrauchswert 0
--
-- 0-Werte werden daher nicht als fehlende Daten betrachtet.

SELECT
    COUNT(*) - COUNT(meter_reading) AS null_meter_reading
FROM train;

SELECT
    COUNT(*) AS zero_meter_reading
FROM train
WHERE meter_reading = 0;


-- =====================================================================
-- 9. Datenqualität der Verbrauchswerte in train_full
-- =====================================================================
-- Prüfung auf fehlende, null und negative Verbrauchswerte
-- sowie Ermittlung von Minimum und Maximum.

SELECT
    COUNT(*) AS gesamt,
    SUM(meter_reading IS NULL) AS fehlende_werte,
    SUM(meter_reading = 0) AS werte_null,
    SUM(meter_reading < 0) AS negative_werte,
    MIN(meter_reading) AS minimum,
    MAX(meter_reading) AS maximum
FROM train_full;


-- =====================================================================
-- 10. Verbrauchswerte nach Null- und Positivwerten
-- =====================================================================
-- Berechnung der Anzahl und prozentualen Anteile
-- von Null- und positiven Verbrauchswerten.

SELECT
    COUNT(*) AS gesamt,
    SUM(meter_reading = 0) AS verbrauch_null,
    SUM(meter_reading > 0) AS verbrauch_positiv,
    ROUND(
        100 * SUM(meter_reading = 0) / COUNT(*),
        2
    ) AS anteil_null_prozent,
    ROUND(
        100 * SUM(meter_reading > 0) / COUNT(*),
        2
    ) AS anteil_positiv_prozent
FROM train_full;


-- =====================================================================
-- 11. Allgemeine Prüfung der Energieverbrauchsdaten
-- =====================================================================
-- Zusammenfassende Prüfung der Verbrauchswerte in train_full.

SELECT
    COUNT(*) AS gesamt,
    SUM(meter_reading IS NULL) AS fehlende_werte,
    SUM(meter_reading < 0) AS negative_werte,
    SUM(meter_reading = 0) AS nullverbrauch,
    SUM(meter_reading > 0) AS positiver_verbrauch
FROM train_full;

-- =====================================================================
-- 12. Analyse du Ausführungsplans mit EXPLAIN
-- =====================================================================
-- Überprüfung, wie MySQL die Abfrage ausführt und
-- ob der Index auf primary_use verwendet wird.

EXPLAIN
SELECT
    primary_use,
    COUNT(*) AS anzahl_messungen,
    SUM(meter_reading) AS gesamtverbrauch,
    AVG(meter_reading) AS durchschnitt,
    MIN(meter_reading) AS minimalverbrauch,
    MAX(meter_reading) AS maximalverbrauch
FROM ashrae_energy.train_full
GROUP BY primary_use
ORDER BY gesamtverbrauch DESC;

