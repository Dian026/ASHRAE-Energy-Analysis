-- =====================================================================
-- Tabellenverknüpfung & Datenintegration mit JOINs
-- =====================================================================


-- 1. Vorhandene Indizes überprüfen

SHOW INDEX FROM train;

SHOW INDEX FROM weather_train;

SHOW INDEX FROM building_metadata;


-- 2. Vorhandenen Index für den JOIN über building_id löschen (falls vorhanden)

ALTER TABLE train
DROP INDEX IF EXISTS idx_train_building;


-- 3. Index für den JOIN über building_id erstellen

CREATE INDEX idx_train_building
ON train (building_id);


-- 4. Vorhandenen Wetter-Index löschen (falls vorhanden)

ALTER TABLE weather_train
DROP INDEX IF EXISTS idx_weather_site_time;


-- 5. Zusammengesetzten Index für den Wetter-JOIN erstellen

CREATE INDEX idx_weather_site_time
ON weather_train (site_id, `timestamp`);


-- 6. Vorhandenen Gebäude-Index löschen (falls vorhanden)

ALTER TABLE ashrae_energy.building_metadata
DROP INDEX IF EXISTS idx_building_id;


-- 7. Index für building_id erstellen

CREATE INDEX idx_building_id
ON ashrae_energy.building_metadata (building_id);


-- 8. Detaillierte Überprüfung aller Indizes über INFORMATION_SCHEMA

SELECT
    TABLE_NAME,
    INDEX_NAME,
    COLUMN_NAME
FROM INFORMATION_SCHEMA.STATISTICS
WHERE TABLE_SCHEMA = 'ashrae_energy'
  AND INDEX_NAME != 'PRIMARY'
ORDER BY TABLE_NAME, INDEX_NAME;


-- =====================================================================
-- Abfrageplan analysieren, um die Leistung der JOIN-Abfrage zu überprüfen.
-- =====================================================================
EXPLAIN
SELECT
    t.building_id,
    t.meter,
    t.`timestamp`,
    t.meter_reading,
    b.site_id,
    b.primary_use,
    b.square_feet,
    b.year_built,
    b.floor_count,
    w.air_temperature,
    w.cloud_coverage,
    w.dew_temperature,
    w.precip_depth_1_hr,
    w.sea_level_pressure,
    w.wind_direction,
    w.wind_speed
FROM ashrae_energy.train t
INNER JOIN ashrae_energy.building_metadata b
    ON t.building_id = b.building_id
LEFT JOIN ashrae_energy.weather_train w
    ON b.site_id = w.site_id
    AND t.`timestamp` = w.`timestamp`
WHERE t.building_id BETWEEN 0 AND 199;


-- =====================================================================
-- 9. BEFÜLLUNG VON train_full
-- Prozedur zum schrittweisen Befüllen der Tabelle train_full erstellen.
--
-- Schrittweise Befüllung (50 Gebäude pro Durchlauf), um sehr große
-- JOIN-Operationen in einem einzigen Schritt zu vermeiden.
-- =====================================================================

DROP PROCEDURE IF EXISTS remplir_train_full;

DELIMITER $$

CREATE PROCEDURE remplir_train_full()
BEGIN
    DECLARE v_min INT;
    DECLARE v_max INT;
    DECLARE v_start INT;
    DECLARE v_step INT DEFAULT 50;

    SELECT MIN(building_id), MAX(building_id) INTO v_min, v_max
    FROM ashrae_energy.train;

    SET v_start = v_min;

    WHILE v_start <= v_max DO

        INSERT INTO ashrae_energy.train_full
        SELECT
            t.building_id, t.meter, t.`timestamp`, t.meter_reading,
            b.site_id, b.primary_use, b.square_feet, b.year_built, b.floor_count,
            w.air_temperature, w.cloud_coverage, w.dew_temperature,
            w.precip_depth_1_hr, w.sea_level_pressure, w.wind_direction, w.wind_speed
        FROM ashrae_energy.train t
        INNER JOIN ashrae_energy.building_metadata b ON t.building_id = b.building_id
        LEFT JOIN ashrae_energy.weather_train w
            ON b.site_id = w.site_id AND t.`timestamp` = w.`timestamp`
        WHERE t.building_id BETWEEN v_start AND (v_start + v_step - 1);

        SET v_start = v_start + v_step;

    END WHILE;

END$$

DELIMITER ;


-- Tabelle vorher leeren, um die Daten anschließend neu und sauber einzufügen.
TRUNCATE TABLE ashrae_energy.train_full;

-- Prozedur zum Befüllen der Tabelle train_full ausführen.
CALL remplir_train_full();


-- Fehlende Werte in train_full prüfen.
SELECT
    COUNT(*) AS gesamt,
    SUM(building_id IS NULL) AS fehlend_building_id,
    SUM(meter IS NULL) AS fehlend_meter,
    SUM(`timestamp` IS NULL) AS fehlend_timestamp,
    SUM(meter_reading IS NULL) AS fehlend_meter_reading,
    SUM(site_id IS NULL) AS fehlend_site_id,
    SUM(primary_use IS NULL) AS fehlend_primary_use,
    SUM(square_feet IS NULL) AS fehlend_square_feet,
    SUM(year_built IS NULL) AS fehlend_year_built,
    SUM(floor_count IS NULL) AS fehlend_floor_count,
    SUM(air_temperature IS NULL) AS fehlend_air_temperature,
    SUM(cloud_coverage IS NULL) AS fehlend_cloud_coverage,
    SUM(dew_temperature IS NULL) AS fehlend_dew_temperature,
    SUM(precip_depth_1_hr IS NULL) AS fehlend_precip_depth,
    SUM(sea_level_pressure IS NULL) AS fehlend_sea_level_pressure,
    SUM(wind_direction IS NULL) AS fehlend_wind_direction,
    SUM(wind_speed IS NULL) AS fehlend_wind_speed
FROM ashrae_energy.train_full;


-- #####################################################################
-- 10. KONTROLLE DES ANALYSEDATENSATZES
-- #####################################################################

-- =====================================================================
-- 10.1 Struktur
-- =====================================================================

DESCRIBE train_full;


-- =====================================================================
-- 10.2 Anzahl der Datensätze
-- =====================================================================

SELECT
    COUNT(*) AS anzahl_datensaetze
FROM train_full;


-- =====================================================================
-- 10.3 Erste Datensätze
-- =====================================================================

SELECT *
FROM train_full
LIMIT 10;


-- =====================================================================
-- 10.4 Fehlende Temperaturwerte
-- =====================================================================

SELECT
    COUNT(*) - COUNT(air_temperature) AS anzahl_null_temperatur
FROM train_full;


-- =====================================================================
-- 10.5 Zeitraum der Daten
-- =====================================================================

SELECT
    MIN(`timestamp`) AS zeitraum_beginn,
    MAX(`timestamp`) AS zeitraum_ende
FROM train_full;


-- =====================================================================
-- 10.6 Gebäudenutzungen
-- =====================================================================

SELECT DISTINCT
    primary_use
FROM train_full
ORDER BY primary_use;


-- =====================================================================
-- 10.7 Verteilung der Zählertypen
-- =====================================================================

SELECT
    meter,
    COUNT(*) AS anzahl_zeilen
FROM train_full
GROUP BY meter
ORDER BY meter;


-- =====================================================================
-- 10.8 Verbrauchswerte: 0 und positive Werte
-- =====================================================================

SELECT
    COUNT(*) AS gesamt_datensaetze,
    SUM(meter_reading = 0) AS zero_meter_reading,
    SUM(meter_reading > 0) AS positive_meter_reading
FROM train_full;


-- #####################################################################
-- 11. EXPLORATIVE ANALYSE
-- #####################################################################

-- =====================================================================
-- 11.1 Energieverbrauch nach Gebäudenutzung
-- =====================================================================

SELECT
    primary_use,
    COUNT(*) AS anzahl_messungen,
    ROUND(SUM(meter_reading), 2) AS gesamtverbrauch,
    ROUND(AVG(meter_reading), 2) AS durchschnittlicher_verbrauch
FROM train_full
GROUP BY primary_use
ORDER BY durchschnittlicher_verbrauch DESC;


-- =====================================================================
-- 11.2 Durchschnittlicher Verbrauch ohne Nullwerte
--
-- Diese Analyse betrachtet nur positive Verbrauchswerte.
-- =====================================================================

SELECT
    primary_use,
    COUNT(*) AS anzahl_messungen,
    COUNT(NULLIF(meter_reading, 0)) AS anzahl_messungen_non_zero,
    ROUND(SUM(meter_reading), 2) AS gesamtverbrauch,
    ROUND(AVG(NULLIF(meter_reading, 0)), 2)
        AS durchschnittlicher_verbrauch
FROM train_full
GROUP BY primary_use
ORDER BY durchschnittlicher_verbrauch DESC;