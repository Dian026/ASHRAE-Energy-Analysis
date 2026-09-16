-- #####################################################################
-- 4. DATENIMPORT
-- #####################################################################

-- Integritätsprüfungen während des Imports deaktivieren
SET SESSION unique_checks = 0;
SET SESSION foreign_key_checks = 0;


-- =====================================================================
-- 4.1 Import der Energieverbrauchsdaten
-- =====================================================================

LOAD DATA LOCAL INFILE
'C:/Users/MamadouDianDiallo/Desktop/ASHRAE_Project/train.csv'
INTO TABLE train
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    building_id,
    meter,
    `timestamp`,
    meter_reading
);


-- =====================================================================
-- 4.2 Import der Wetterdaten
-- =====================================================================

LOAD DATA LOCAL INFILE
'C:/Users/MamadouDianDiallo/Desktop/ASHRAE_Project/weather_train.csv'
INTO TABLE weather_train
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    site_id,
    `timestamp`,
    @air_temperature,
    @cloud_coverage,
    @dew_temperature,
    @precip_depth_1_hr,
    @sea_level_pressure,
    @wind_direction,
    @wind_speed
)
SET
    air_temperature    = NULLIF(@air_temperature, ''),
    cloud_coverage     = NULLIF(@cloud_coverage, ''),
    dew_temperature    = NULLIF(@dew_temperature, ''),
    precip_depth_1_hr  = NULLIF(@precip_depth_1_hr, ''),
    sea_level_pressure = NULLIF(@sea_level_pressure, ''),
    wind_direction     = NULLIF(@wind_direction, ''),
    wind_speed         = NULLIF(@wind_speed, '');


-- =====================================================================
-- 4.3 Import der Gebäudedaten
-- =====================================================================

LOAD DATA LOCAL INFILE
'C:/Users/MamadouDianDiallo/Desktop/ASHRAE_Project/building_metadata.csv'
INTO TABLE building_metadata
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    site_id,
    building_id,
    primary_use,
    square_feet,
    @year_built,
    @floor_count
)
SET
    year_built  = NULLIF(@year_built, ''),
    floor_count = NULLIF(@floor_count, '');


-- Integritätsprüfungen nach dem Import wieder aktivieren
SET SESSION unique_checks = 1;
SET SESSION foreign_key_checks = 1;


-- #####################################################################
-- 5. DATENIMPORT ÜBERPRÜFEN
-- #####################################################################

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


############################################################################################
-- Abfrageplan analysieren, um die Leistung der JOIN-Abfrage zu überprüfen.
############################################################################################
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


-- Überprüfen, ob für denselben Standort und Zeitstempel 
-- mehrere Wetterdatensätze vorhanden sind.
SELECT
    site_id,
    `timestamp`,
    COUNT(*) AS anzahl,
    COUNT(DISTINCT air_temperature) AS verschiedene_temperaturen,
    COUNT(DISTINCT wind_speed) AS verschiedene_windgeschwindigkeiten
FROM weather_train
GROUP BY site_id, `timestamp`
HAVING COUNT(*) > 1
LIMIT 20;


-- Alle Tabellen anzeigen, deren Name "train" enthält.
SHOW TABLES FROM ashrae_energy
LIKE '%train%';
