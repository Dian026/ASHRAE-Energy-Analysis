##########################################################################################
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