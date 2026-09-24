-- =====================================================================
-- Tabellenverknüpfung & Datenintegration mit JOINs
-- Zweck: Verknüpfung von Energie-, Gebäude- und Wetterdaten
-- =====================================================================

USE ashrae_energy;


-- =====================================================================
-- 1. Join-Schlüssel auf Eindeutigkeit prüfen
-- =====================================================================

-- 1.1 building_id in building_metadata
-- Erwartung: Jede building_id sollte genau einmal vorkommen.

SELECT
    building_id,
    COUNT(*) AS anzahl
FROM building_metadata
GROUP BY building_id
HAVING COUNT(*) > 1;


-- 1.2 site_id + timestamp in weather_train
-- Erwartung: Pro Standort und Zeitpunkt sollte höchstens ein Wetterdatensatz
-- vorhanden sein. Mehrfachvorkommen könnten die JOIN-Ergebnisse vervielfachen.

SELECT
    site_id,
    `timestamp`,
    COUNT(*) AS anzahl
FROM weather_train
GROUP BY
    site_id,
    `timestamp`
HAVING COUNT(*) > 1;


-- =====================================================================
-- 2. Prüfen, ob alle Energie-Datensätze ein Gebäude-Matching besitzen
-- =====================================================================

SELECT
    COUNT(*) AS fehlende_building_zuordnungen
FROM train AS t
LEFT JOIN building_metadata AS b
    ON t.building_id = b.building_id
WHERE
    t.building_id BETWEEN 0 AND 199
    AND b.building_id IS NULL;


-- =====================================================================
-- 3. Anzahl der Ausgangsdatensätze prüfen
-- =====================================================================

SELECT
    COUNT(*) AS anzahl_train_datensaetze
FROM train
WHERE building_id BETWEEN 0 AND 199;


-- =====================================================================
-- 4. Ausführungsplan der JOIN-Abfrage prüfen
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

FROM train AS t

INNER JOIN building_metadata AS b
    ON t.building_id = b.building_id

LEFT JOIN weather_train AS w
    ON b.site_id = w.site_id
    AND t.`timestamp` = w.`timestamp`

WHERE t.building_id BETWEEN 0 AND 199;


-- =====================================================================
-- 5. JOIN-Ergebnis anhand von Beispieldaten prüfen
-- =====================================================================

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

ORDER BY
    t.building_id,
    t.`timestamp`,
    t.meter

LIMIT 100;


-- =====================================================================
-- 6. Anzahl der Datensätze nach der JOIN-Verknüpfung prüfen
-- =====================================================================

SELECT
    COUNT(*) AS anzahl_join_datensaetze
FROM train AS t

INNER JOIN building_metadata AS b
    ON t.building_id = b.building_id

LEFT JOIN weather_train AS w
    ON b.site_id = w.site_id
    AND t.`timestamp` = w.`timestamp`

WHERE t.building_id BETWEEN 0 AND 199;


-- =====================================================================
-- 7. Fehlende Wetterzuordnungen prüfen
-- =====================================================================

SELECT
    COUNT(*) AS fehlende_weather_zuordnungen
FROM train AS t

INNER JOIN building_metadata AS b
    ON t.building_id = b.building_id

LEFT JOIN weather_train AS w
    ON b.site_id = w.site_id
    AND t.`timestamp` = w.`timestamp`

WHERE
    t.building_id BETWEEN 0 AND 199
    AND w.site_id IS NULL;