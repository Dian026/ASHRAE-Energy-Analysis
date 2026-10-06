-- =====================================================================
-- ASHRAE Energy Analysis
-- Fachliche Analyse des Energieverbrauchs
-- =====================================================================

USE ashrae_energy;


-- =====================================================================
-- 1. Energieverbrauch nach Gebäudenutzung
-- =====================================================================
-- Vergleich der Anzahl der Messungen, des Gesamtverbrauchs,
-- des durchschnittlichen, minimalen und maximalen Verbrauchs
-- nach Gebäudenutzung.

SELECT
    primary_use,
    COUNT(*) AS anzahl_messungen,
    ROUND(SUM(meter_reading), 2) AS gesamtverbrauch,
    ROUND(AVG(meter_reading), 2) AS durchschnitt,
    ROUND(MIN(meter_reading), 2) AS minimalverbrauch,
    ROUND(MAX(meter_reading), 2) AS maximalverbrauch
FROM train_full
GROUP BY primary_use
ORDER BY gesamtverbrauch DESC;


-- =====================================================================
-- 2. Durchschnittlicher Verbrauch ohne Nullwerte
-- =====================================================================
-- Diese Analyse betrachtet nur positive Verbrauchswerte.

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


-- =====================================================================
-- 3. Energieverbrauch nach Gebäudenutzung und Zählertyp
-- =====================================================================
-- Vergleich des durchschnittlichen Verbrauchs nach Gebäudenutzung
-- und Zählertyp.

SELECT
    primary_use,
    meter,
    COUNT(*) AS anzahl_messungen,
    ROUND(AVG(meter_reading), 2)
        AS durchschnittlicher_verbrauch
FROM train_full
WHERE meter_reading IS NOT NULL
GROUP BY
    primary_use,
    meter
ORDER BY
    primary_use,
    durchschnittlicher_verbrauch DESC;


-- =====================================================================
-- 4. Energieverbrauch nach Zählertyp
-- =====================================================================
-- Vergleich der Anzahl der Messungen und des durchschnittlichen
-- Verbrauchs nach Zählertyp.
--
-- Meter:
-- 0 = Electricity
-- 1 = ChilledWater
-- 2 = Steam
-- 3 = HotWater

SELECT
    meter,
    COUNT(*) AS anzahl_messungen,
    ROUND(AVG(meter_reading), 2) AS durchschnittlicher_verbrauch
FROM ashrae_energy.train_full
GROUP BY meter
ORDER BY durchschnittlicher_verbrauch DESC;


-- =====================================================================
-- 5. Gebäude mit dem höchsten Gesamtverbrauch
-- =====================================================================
-- Identifizierung der Gebäude mit dem höchsten Gesamtverbrauch.

SELECT
    building_id,
    primary_use,
    square_feet,
    ROUND(SUM(meter_reading), 2) AS gesamtverbrauch
FROM train_full
GROUP BY
    building_id,
    primary_use,
    square_feet
ORDER BY gesamtverbrauch DESC
LIMIT 10;


-- =====================================================================
-- 6. Entwicklung des Energieverbrauchs im Zeitverlauf
-- =====================================================================
-- Untersuchung der täglichen Entwicklung des durchschnittlichen
-- Energieverbrauchs über den gesamten Analysezeitraum.

SELECT
    DATE(`timestamp`) AS datum,
    ROUND(AVG(meter_reading), 2) AS durchschnittlicher_verbrauch
FROM ashrae_energy.train_full
GROUP BY DATE(`timestamp`)
ORDER BY datum;


-- =====================================================================
-- 7. Zusammenhang zwischen Außentemperatur und Energieverbrauch
-- =====================================================================
-- Untersuchung des Zusammenhangs zwischen Außentemperatur
-- und durchschnittlichem Energieverbrauch.

SELECT
    ROUND(air_temperature, 0) AS temperatur,
    COUNT(*) AS anzahl_messungen,
    ROUND(AVG(meter_reading), 2) AS durchschnittlicher_verbrauch
FROM ashrae_energy.train_full
WHERE air_temperature IS NOT NULL
GROUP BY ROUND(air_temperature, 0)
ORDER BY temperatur;


-- =====================================================================
-- 8. Monatlicher Vergleich der Zähler 1 und 3
-- =====================================================================
-- Vergleich der Verbrauchswerte und Nullverbrauchsraten
-- im Gebäude 1017 im Jahr 2016.

SELECT
    DATE_FORMAT(`timestamp`, '%Y-%m') AS monat,
    meter,
    COUNT(*) AS anzahl_messungen,
    SUM(
        CASE
            WHEN meter_reading = 0 THEN 1
            ELSE 0
        END
    ) AS nullverbrauch,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN meter_reading = 0 THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS nullanteil_prozent,
    ROUND(AVG(meter_reading), 2) AS durchschnitt
FROM train_full
WHERE building_id = 1017
  AND meter IN (1, 3)
  AND `timestamp` >= '2016-01-01'
  AND `timestamp` < '2017-01-01'
GROUP BY DATE_FORMAT(`timestamp`, '%Y-%m'), meter
ORDER BY monat, meter;


-- =====================================================================
-- 9. Monatlicher Energieverbrauch nach Zählertyp
-- =====================================================================
-- Vergleich des monatlichen Gesamtverbrauchs der Zähler 1 und 3
-- für Gebäude 1017 im Jahr 2016.

SELECT
    MONTH(`timestamp`) AS monat,
    meter,
    ROUND(SUM(meter_reading), 2) AS verbrauch
FROM train_full
WHERE building_id = 1017
  AND YEAR(`timestamp`) = 2016
  AND meter IN (1, 3)
GROUP BY monat, meter
ORDER BY meter, monat;


-- =====================================================================
-- 10. Technische Kontrolle der Durchschnittsberechnung
-- =====================================================================
-- Vergleich der manuellen Durchschnittsberechnung mit AVG().
-- Gültige Messwerte ohne 0 werden berücksichtigt;
-- NULL-Werte werden ignoriert.
-- Die Differenz sollte nahe bei 0 liegen.

SELECT
    primary_use,

    COUNT(*) AS anzahl_messungen,

    COUNT(NULLIF(meter_reading, 0))
        AS anzahl_messungen_non_zero,

    SUM(meter_reading)
        AS gesamtverbrauch,

    SUM(meter_reading)
    / COUNT(NULLIF(meter_reading, 0))
        AS durchschnitt_manuell,

    AVG(NULLIF(meter_reading, 0))
        AS durchschnitt_avg,

    (
        SUM(meter_reading)
        / COUNT(NULLIF(meter_reading, 0))
        - AVG(NULLIF(meter_reading, 0))
    ) AS differenz,

    CASE
        WHEN ABS(
            SUM(meter_reading)
            / COUNT(NULLIF(meter_reading, 0))
            - AVG(NULLIF(meter_reading, 0))
        ) < 0.000001
        THEN 'OK'
        ELSE 'FEHLER'
    END AS verifizierung

FROM train_full

GROUP BY primary_use

ORDER BY primary_use;

