-- ============================================================
-- ASHRAE Energy Analysis
-- SQL-Indizierung & Performance-Optimierung
-- ============================================================

USE ashrae_energy;

-- ============================================================
-- 1. Index auf primary_use erstellen
-- ============================================================
-- Dieser Index verbessert Abfragen, die nach dem
-- Gebäudenutzungstyp filtern oder gruppieren.

CREATE INDEX idx_train_full_primary_use
ON train_full (primary_use);


-- ============================================================
-- 2. Index überprüfen
-- ============================================================

SHOW INDEX FROM train_full;


-- ============================================================
-- 3. Beispielabfrage zur Nutzung des Index
-- ============================================================

SELECT
    primary_use,
    COUNT(*) AS anzahl_zeilen,
    AVG(meter_reading) AS durchschnittlicher_verbrauch
FROM train_full
GROUP BY primary_use
ORDER BY durchschnittlicher_verbrauch DESC;

