-- =====================================================================
-- Tabellenverknüpfung & Datenintegration mit JOINs
-- Zweck: Verknüpfung von Energie-, Gebäude- und Wetterdaten
-- =====================================================================-

USE ashrae_energy;


-- =====================================================================
-- 1. Abfrageplan analysieren
-- =====================================================================
-- Ziel:
-- Überprüfung des Ausführungsplans und der verwendeten Indizes.

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

FROM train AS t

INNER JOIN building_metadata AS b
    ON t.building_id = b.building_id

LEFT JOIN weather_train AS w
    ON b.site_id = w.site_id
    AND t.`timestamp` = w.`timestamp`

WHERE t.building_id BETWEEN 0 AND 199;


-- =====================================================================
-- 2. JOIN-Ergebnis überprüfen
-- =====================================================================
-- Ziel:
-- Überprüfung der tatsächlich zusammengeführten Datensätze.

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

FROM train AS t

INNER JOIN building_metadata AS b
    ON t.building_id = b.building_id

LEFT JOIN weather_train AS w
    ON b.site_id = w.site_id
    AND t.`timestamp` = w.`timestamp`

WHERE t.building_id BETWEEN 0 AND 199

LIMIT 100;



-- Anzahl der Datensätze nach der Verknüpfung überprüfen

SELECT COUNT(*) AS anzahl_join_datensaetze
FROM train AS t
INNER JOIN building_metadata AS b
    ON t.building_id = b.building_id
LEFT JOIN weather_train AS w
    ON b.site_id = w.site_id
    AND t.`timestamp` = w.`timestamp`
WHERE t.building_id BETWEEN 0 AND 199;