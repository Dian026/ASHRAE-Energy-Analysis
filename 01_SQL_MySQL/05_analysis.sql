-- =====================================================================
-- SQL-Datenanalyse & statistische Kennzahlen
-- =====================================================================

-- =====================================================================
-- 1. Energieverbrauch nach Gebäudenutzung
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
-- 2. Durchschnittlicher Verbrauch ohne Nullwerte
-- =====================================================================
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


-- =====================================================================
-- 3. Energieverbrauch nach Gebäudenutzung und Zählertyp
-- =====================================================================
--
-- Diese Analyse vermeidet die direkte Vermischung
-- unterschiedlicher Zählertypen.
-- =====================================================================

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
-- 4. Gebäude mit dem höchsten Gesamtverbrauch
-- =====================================================================

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


-- #####################################################################
-- 5. TECHNISCHE KONTROLLE DER DURCHSCHNITTSBERECHNUNG
-- #####################################################################
-- Vergleich der manuellen Durchschnittsberechnung mit AVG().
-- Gültige Messwerte einschließlich 0 werden berücksichtigt;
-- NULL-Werte werden ignoriert. Die Differenz sollte nahe bei 0 liegen.

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


- ╔══════════════════════════════════════════════════════════════════════════╗
--║ PROJEKT: ASHRAE Energy Prediction                                        ║
--║ ABSCHNITT: 16 - Explorative Analyse                                      ║
--║ ZIEL: Untersuchung des Energieverbrauchs nach Zeit, Temperatur,          ║
--║       Gebäudenutzung, Zählertyp und Gebäude                              ║
--╚══════════════════════════════════════════════════════════════════════════╝


-- =================================================================
-- 6. Entwicklung des Energieverbrauchs im Zeitverlauf
-- Zweck:
-- Untersuchung der täglichen Entwicklung des durchschnittlichen
-- Energieverbrauchs über den gesamten Analysezeitraum.
-- =================================================================

SELECT
    DATE(`timestamp`) AS datum,
    ROUND(AVG(meter_reading), 2) AS durchschnittlicher_verbrauch
FROM ashrae_energy.train_full
GROUP BY DATE(`timestamp`)
ORDER BY datum;


-- =================================================================
-- 7. Zusammenhang zwischen Außentemperatur und Energieverbrauch
-- Zweck:
-- Untersuchung des Zusammenhangs zwischen Außentemperatur
-- und durchschnittlichem Energieverbrauch.
-- =================================================================

SELECT
    ROUND(air_temperature, 0) AS temperatur,
    COUNT(*) AS anzahl_messungen,
    ROUND(AVG(meter_reading), 2) AS durchschnittlicher_verbrauch
FROM ashrae_energy.train_full
WHERE air_temperature IS NOT NULL
GROUP BY ROUND(air_temperature, 0)
ORDER BY temperatur;


-- =================================================================
-- 8. Energieverbrauch nach Zählertyp
-- Zweck:
-- Vergleich der Messungen und des durchschnittlichen Verbrauchs
-- nach Zählertyp.
--
-- Meter:
-- 0 = Electricity
-- 1 = ChilledWater
-- 2 = Steam
-- 3 = HotWater
-- =================================================================

SELECT
    meter,
    COUNT(*) AS anzahl_messungen,
    ROUND(AVG(meter_reading), 2) AS durchschnittlicher_verbrauch
FROM ashrae_energy.train_full
GROUP BY meter
ORDER BY durchschnittlicher_verbrauch DESC;






