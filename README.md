**# 🏢 ASHRAE Energy Analysis**

**\*\*\\\*\\\*End-to-End Data-Analytics-Projekt\\\*\\\*\*\*** zur Analyse des Energieverbrauchs von Gebäuden – von der relationalen Datenbank über explorative & statistische Analyse bis hin zu Machine Learning und einer produktiven API.

![Python]\\(https\://img.shields.io/badge/Python-3.10-blue?logo=python&logoColor=white)

![MySQL]\\(https\://img.shields.io/badge/MySQL-Database-orange?logo=mysql&logoColor=white)

![FastAPI]\\(https\://img.shields.io/badge/FastAPI-API-teal?logo=fastapi&logoColor=white)

![scikit-learn]\\(https\://img.shields.io/badge/scikit--learn-ML-yellowgreen?logo=scikitlearn)

![License]\\(https\://img.shields.io/badge/License-MIT-lightgrey)

\`\`\`text

SQL / MySQL → Python → Statistik → Feature Engineering → Machine Learning → API

\`\`\`

\---

**## 👀 Auf einen Blick\*\***

\\\* **\*\*\\\*\\\*Was:\\\*\\\*\*\*** Analyse und Vorhersage des Stromverbrauchs von Gebäuden auf Basis des ASHRAE-Datensatzes

\\\* **\*\*\\\*\\\*Umfang:\\\*\\\*\*\*** über 20 Mio. Zeilen in MySQL, 500.000 Messungen für die Analyse und das Machine Learning

\\\* **\*\*\\\*\\\*Methoden:\\\*\\\*\*\*** SQL, EDA, Korrelation, ANOVA, Ausreißeranalyse, lineare Regression, Random Forest

\\\* **\*\*\\\*\\\*Ergebnis:\\\*\\\*\*\*** Random Forest mit R² = **\*\*\\\*\\\*0,9846\\\*\\\*\*\*** auf 100.000 Testdaten

\\\* **\*\*\\\*\\\*Bereitstellung:\\\*\\\*\*\*** FastAPI mit den Endpoints \`/predict\` und \`/weather\` sowie Swagger-Dokumentation

\\\* **\*\*\\\*\\\*Code & Doku:\\\*\\\*\*\*** vollständiger Workflow auf GitHub, inklusive Präsentation

\---

**## 🎯 Forschungsfrage\*\***

\\> Wie unterscheidet sich der Energieverbrauch nach Gebäudetyp, Zählertyp und Standort, und welche Zusammenhänge bestehen mit Gebäude- und Wetterinformationen?

\---

**## ✨ Projekt-Highlights\*\***

\| Kennzahl             | Ergebnis                                                                                  |

\| -------------------- | ----------------------------------------------------------------------------------------- |

\| 📊 Datenbasis        | > 20 Mio. Zeilen in \`train_full\`, davon 500.000 Messungen für das ML-Modell               |

\| 🧹 Datenvorbereitung | 500.000 Beobachtungen beibehalten, fehlende Feature-Werte per Median-Imputation behandelt |

\| 🤖 Random Forest     | R² = **\*\*\\\*\\\*0,9846\\\*\\\*\*\***, MAE = **\*\*\\\*\\\*16,12\\\*\\\*\*\***, RMSE = **\*\*\\\*\\\*48,62\\\*\\\*\*\***                |

\| 🌳 Modell            | RandomForestRegressor mit 100 Bäumen                                                      |

\| 🚀 Deployment        | FastAPI-Anwendung mit Swagger/OpenAPI                                                     |

\| 🔌 API-Test          | \`/predict\` erfolgreich mit **\*\*\\\*\\\*440,6812\\\*\\\*\*\*** getestet                                  |

Das finale Random-Forest-Modell wird für die Vorhersage des Energieverbrauchs verwendet und anschließend über eine FastAPI-Anwendung bereitgestellt.

\---

**## 🧠 Gezeigte Kompetenzen\*\***

\| Bereich            | Umsetzung im Projekt                                                         |

\| ------------------ | ---------------------------------------------------------------------------- |

\| Datenbanken        | MySQL-Aufbau, Import, Datenqualitätsprüfung, Joins, Indizes                  |

\| Datenanalyse       | EDA mit Python und Pandas, Visualisierung mit Matplotlib                     |

\| Statistik          | Deskriptive Statistik, Korrelation, ANOVA, IQR-Ausreißeranalyse              |

\| Machine Learning   | Feature Engineering, lineare Regression, Log-Transformation, Random Forest   |

\| Modellbewertung    | MAE, RMSE, R², Train-Test-Split, kritische Einordnung der Ergebnisse         |

\| Deployment         | FastAPI, Swagger/OpenAPI, Joblib-Pipeline, Anbindung der Open-Meteo-API      |

\| Dokumentation      | Strukturiertes GitHub-Repository, README, Präsentation                       |

\---

**## 🧩 Projektziele\*\***

\\\* Aufbau und Verwaltung einer relationalen Datenbank (MySQL)

\\\* Integration von Energie-, Gebäude- und Wetterdaten

\\\* Prüfung der Datenqualität

\\\* Explorative Datenanalyse (EDA)

\\\* Statistische Untersuchung des Energieverbrauchs (Korrelation, ANOVA, Ausreißeranalyse)

\\\* Visualisierung zentraler Ergebnisse

\\\* Feature Engineering für das Machine Learning

\\\* Entwicklung und Bewertung mehrerer ML-Modelle

\\\* Bereitstellung einer API für Vorhersage und Live-Wetterdaten

\\\* Dokumentation und Präsentation des Gesamtprojekts

\---

**## 🗂️ Daten\*\***

Verwendet wird der **\*\*\\\*\\\*ASHRAE Energy Prediction Datensatz\\\*\\\*\*\*** mit Energie-, Gebäude- und Wetterinformationen.

**\*\*\\\*\\\*Zentrale Tabellen:\\\*\\\*\*\*** \`train\`, \`building_metadata\`, \`weather_train\`, \`train_full\`

**\*\*\\\*\\\*Verknüpfungsschlüssel:\\\*\\\*\*\*** \`building_id\`, \`site_id\`, \`timestamp\`

Der konsolidierte Datensatz \`train_full\` verbindet Energieverbrauch, Gebäudeinformationen und Wetterdaten.

\\> ℹ️ Die originalen ASHRAE-Rohdaten werden aufgrund ihrer Dateigröße nicht im Repository gespeichert. Alle SQL-Skripte für Import, Aufbereitung und Analyse sind jedoch vollständig dokumentiert.

\---

## 🔄 Workflow

The project follows a complete end-to-end workflow, from the original ASHRAE dataset to data analysis, machine learning, API deployment, and final documentation.

```mermaid
flowchart TD

    %% =========================
    %% DATA
    %% =========================
    A["ASHRAE Energy Prediction Dataset"]

    subgraph DB["MySQL / Database"]
        B["Database Setup"]
        C["Data Import"]
        D["Data Quality"]
        E["train_full<br/>~20.2M rows"]
        F["SQL Analysis<br/>Joins / Aggregations / Indexes"]
    end

    A --> B
    B --> C
    C --> E
    E --> D
    E --> F

    %% =========================
    %% PYTHON / ANALYSIS
    %% =========================
    subgraph PY["Python / Data Analysis"]
        G["Data Exploration<br/>Pandas"]
        H["Statistics<br/>Descriptive Statistics"]
        I["Correlation / ANOVA"]
        J["IQR Outlier Analysis"]
        K["Visualizations<br/>Matplotlib"]
    end

    E --> G
    G --> H
    H --> I
    H --> J
    G --> K
    F --> G

    %% =========================
    %% FEATURE ENGINEERING
    %% =========================
    subgraph FE["Feature Engineering"]
        L["500,000 selected observations"]
        M["Timestamp Conversion"]
        N["Temporal Features<br/>hour / day_of_week / month / year"]
        O["Feature Selection<br/>10 final features"]
        P["Numeric Conversion"]
        Q["Median Imputation"]
    end

    G --> L
    L --> M
    M --> N
    N --> O
    O --> P
    P --> Q

    %% =========================
    %% MACHINE LEARNING
    %% =========================
    subgraph ML["Machine Learning"]
        R["Train / Test Split<br/>400,000 / 100,000"]
        S["Linear Regression"]
        T["Log-Transformed Linear Regression"]
        U["Random Forest Regression<br/>100 trees"]
        V["Model Evaluation<br/>MAE / RMSE / R²"]
        W["Building-Based Evaluation<br/>GroupShuffleSplit"]
    end

    Q --> R
    R --> S
    R --> T
    R --> U
    S --> V
    T --> V
    U --> V
    U --> W

    V --> X["Final Random Forest Pipeline"]
    Q --> X

    %% =========================
    %% MODEL
    %% =========================
    X --> Y["rf_pipeline.joblib<br/>Saved Model"]

    %% =========================
    %% API
    %% =========================
    subgraph API["FastAPI"]
        Z["FastAPI Application"]
        AA["POST /predict"]
        AB["GET /weather"]
        AC["Swagger / OpenAPI"]
    end

    Y --> Z
    Z --> AA
    Z --> AB
    Z --> AC

    AA --> AD["Energy Consumption Prediction"]
    AB --> AE["Live Weather Data<br/>Open-Meteo"]

    %% =========================
    %% RESULTS
    %% =========================
    subgraph RES["Results"]
        AF["Statistical Results"]
        AG["Visualizations"]
        AH["ML Results"]
        AI["API Results"]
    end

    H --> AF
    K --> AG
    V --> AH
    AD --> AI
    AE --> AI

    %% =========================
    %% DOCUMENTATION
    %% =========================
    subgraph DOC["Documentation & Presentation"]
        AJ["README.md"]
        AK["PowerPoint Presentation"]
        AL["results / figures"]
    end

    AF --> AL
    AG --> AL
    AH --> AL
    AI --> AL

    AL --> AJ
    AL --> AK

    %% =========================
    %% GITHUB
    %% =========================
    subgraph GH["GitHub Repository"]
        AM["ASHRAE-Energy-Analysis"]
    end

    AJ --> AM
    AK --> AM

    %% =========================
    %% GITINGEST
    %% =========================
    AN["GitIngest<br/>Repository Analysis / Documentation Aid"]

    AM -. "Analysis / Documentation" .-> AN

    %% =========================
    %% STYLES
    %% =========================
    classDef data fill:#e3f2fd,stroke:#1565c0,stroke-width:1px
    classDef analysis fill:#e8f5e9,stroke:#2e7d32,stroke-width:1px
    classDef ml fill:#fff3e0,stroke:#ef6c00,stroke-width:1px
    classDef api fill:#f3e5f5,stroke:#7b1fa2,stroke-width:1px
    classDef docs fill:#fce4ec,stroke:#c2185b,stroke-width:1px
    classDef tool fill:#eeeeee,stroke:#616161,stroke-width:1px

    class A,B,C,D,E,F data
    class G,H,I,J,K,L,M,N,O,P,Q analysis
    class R,S,T,U,V,W,X,Y ml
    class Z,AA,AB,AC,AD,AE api
    class AF,AG,AH,AI,AJ,AK,AL,AM docs
    class AN tool
```

### Workflow overview

The workflow is organized into several main stages:

1. **Data & MySQL** – Import and structure the ASHRAE data, create `train_full`, perform data quality checks, SQL analysis, joins, aggregations, and indexing.
2. **Python & Statistics** – Explore the data with Pandas, perform descriptive statistics, correlation analysis, ANOVA, outlier analysis, and create visualizations.
3. **Feature Engineering** – Select 500,000 observations, extract temporal features from the timestamp, select the final 10 features, convert numeric variables, and handle missing values through median imputation.
4. **Machine Learning** – Train and compare Linear Regression, Log-Transformed Linear Regression, and Random Forest Regression. Evaluate the models using MAE, RMSE, and R², including a building-based evaluation with `GroupShuffleSplit`.
5. **API** – Save the final Random Forest pipeline and integrate it into FastAPI with `/predict` and `/weather` endpoints, documented through Swagger/OpenAPI.
6. **Results & Documentation** – Collect statistical, visualization, ML, and API results for the `results/figures` folder, README, and PowerPoint presentation.
7. **GitHub & GitIngest** – Publish the project on GitHub. GitIngest is used only as a complementary repository analysis and documentation tool and is not part of the execution pipeline.


\---

**## 🗄️ SQL / MySQL\*\***

Grundlage der Datenverarbeitung: Datenbank- und Tabellenaufbau, Import der Rohdaten, Qualitäts- und Schlüsselprüfung, Verknüpfung der Tabellen sowie erste Analysen.

\`\`\`text

01_SQL_MySQL/

├── 01_database_setup.sql

├── 02_data_import.sql

├── 03_data_quality.sql

├── 04_train_full.sql

├── 05_analysis.sql

├── 06_indexes.sql

├── joins.sql

└── README.md

\`\`\`

**### Optimierung der Abfragen\*\***

Es wurden Indizes auf zentralen Verknüpfungs- und Analysefeldern angelegt, um die Performance der SQL-Abfragen zu verbessern.

Dazu gehören unter anderem `building_id`, `timestamp`, `(site_id, timestamp)` und `primary_use`.

<details>
<summary>📋 Übersicht der Indizes anzeigen</summary>

```text
+-------------------+----------------------------+------------------+
| TABLE_NAME        | INDEX_NAME                 | COLUMN_NAME      |
+-------------------+----------------------------+------------------+
| building_metadata | idx_building_id            | building_id      |
| train             | idx_train_building         | building_id      |
| train              | idx_train_timestamp        | timestamp        |
| weather_train     | idx_weather_site_time      | site_id          |
| weather_train     | idx_weather_site_time      | timestamp        |
| train_full        | idx_train_full_primary_use | primary_use      |
+-------------------+----------------------------+------------------+
````

</details>

Für die Analyse nach `primary_use` wurde ein B-Tree-Index erstellt:

```sql
CREATE INDEX idx_train_full_primary_use
ON ashrae_energy.train_full (primary_use);
```

Mit `EXPLAIN` wurde bestätigt, dass MySQL diesen Index für die `GROUP BY primary_use`-Abfrage verwendet:

```text
Index scan on train_full using idx_train_full_primary_use
```

Bei einem gemessenen Testlauf reduzierte sich die Ausführungszeit von **24:40 Minuten auf 19:53 Minuten**, entsprechend einer beobachteten Verbesserung von **ca. 19,4 %**.

> Hinweis: Die Messung basiert auf einem einzelnen Testlauf. Für eine belastbare Performance-Bewertung sind mehrere kontrollierte Testläufe erforderlich.

```

### Warum diese Version besser ist

Du hast damit **keine neue Struktur** in deinem README. Alles bleibt unter:

> `### Optimierung der Abfragen`

Und der neue Index wird logisch ergänzt:

**bestehende Indizes → `primary_use` → EXPLAIN → gemessener Performance-Effekt**

Das ist für einen Recruiter besonders gut, weil man in wenigen Sekunden sieht:

**Index erstellt → Nutzung verifiziert → Performance gemessen.**
```

\---

**### Data Quality and Consumption Distribution\*\***

The SQL analysis was performed on the consolidated `train_full` table containing the energy consumption, building and weather information.

**#### Data Quality\*\***

| Indicator | Result |
| --------- | -----: |
| Total measurements | 20,216,100 |
| Distinct buildings | 1,449 |
| `meter_reading` NULL values | 0 |
| Negative `meter_reading` values | 0 |
| Zero `meter_reading` values | 1,873,976 (9.27 %) |
| Positive `meter_reading` values | 18,342,124 (90.73 %) |

No missing or negative values were detected in `meter_reading`. Zero values represent 9.27 % of all measurements.

**#### Zero Values by Meter\*\***

| Meter | Measurements | Zero values | Zero share |
| ----: | -----------: | ----------: | ---------: |
| 0 | 12,060,910 | 530,169 | 4.40 % |
| 1 | 4,182,440 | 656,504 | 15.70 % |
| 2 | 2,708,713 | 346,960 | 12.81 % |
| 3 | 1,264,037 | 340,343 | 26.93 % |

The proportion of zero values differs considerably between the four meter types.

**#### Average Consumption by Building Use\*\***

The average `meter_reading` was calculated for each `primary_use` category.

| Building use | Average `meter_reading` |
| ------------ | ----------------------: |
| Education | 4,585.09 |
| Services | 4,113.47 |
| Healthcare | 738.60 |
| Office | 526.50 |
| Utility | 512.74 |
| Entertainment/public assembly | 473.88 |
| Food sales and service | 304.91 |
| Public services | 288.24 |
| Manufacturing/industrial | 285.90 |
| Lodging/residential | 279.71 |
| Parking | 169.39 |
| Retail | 139.78 |
| Other | 138.70 |
| Technology/science | 138.20 |
| Warehouse/storage | 54.36 |
| Religious worship | 5.38 |

These values are averages of individual measurements grouped by `primary_use` and should not be interpreted as average total consumption per building.

**### Temporal Analysis – Building 1017\*\***

A separate analysis was performed for building `1017` in 2016, comparing meters `1` and `3`.

| Month | Meter 1 | Meter 3 |
| ----- | -------: | -------: |
| January | 0.00 | 955,325.16 |
| February | 0.00 | 604,255.30 |
| March | 879.16 | 346,417.75 |
| April | 25,409.27 | 89,214.69 |
| May | 38,157.70 | 140.89 |
| June | 99,322.18 | 4.78 |
| July | 144,132.27 | 20.30 |
| August | 136,423.92 | 44.18 |
| September | 68,931.05 | 15,193.65 |
| October | 37,425.42 | 118,803.04 |
| November | 26,468.86 | 309,904.45 |
| December | 0.00 | 191,313.91 |

The two meters show different temporal consumption patterns. Meter 1 reaches its highest monthly value in July, while meter 3 records its highest values at the beginning and end of the year. The exact function of the meters was not confirmed, so the causes of these differences cannot be determined from this analysis alone.

**### SQL Performance and Indexing\*\***

An index was created on `primary_use` to evaluate the performance of the grouped analysis.

| Test | Execution time |
| ---- | --------------: |
| Before index | 24 min 40.268 sec |
| After index | 19 min 52.955 sec |
| Observed reduction | 19.4 % |

The tested query was approximately 19.4 % faster after adding the index. This result is an observed comparison for the tested query; repeated controlled measurements would be required for a more robust performance evaluation.

**### Main SQL Findings\*\***

1. No `NULL` or negative `meter_reading` values were detected.
2. Zero consumption represents **9.27 %** of all measurements and varies by meter type.
3. Average `meter_reading` values differ considerably between `primary_use` categories.
4. Building 1017 shows different temporal patterns between meters 1 and 3.
5. The tested `primary_use` index reduced the observed execution time by **19.4 %**.

\---


**## 🐍 Python\*\***

Datenexploration, Datenaufbereitung, statistische Auswertung, Visualisierung und Vorbereitung der ML-Daten.

\`\`\`text

02_Python/

├── data_exploration.ipynb

├── statistics.ipynb

└── visualizations.ipynb

\`\`\`

\---

**## 📈 Statistik\*\***

Durchgeführte Analysen: deskriptive Statistik, Verteilungsanalyse, Vergleich von Gebäude- und Zählertypen, Korrelationsanalyse, ANOVA sowie Ausreißeranalyse mittels IQR-Methode.

\`\`\`text

03_Statistics/

└── statistical_analysis.ipynb

\`\`\`

**### Verteilung des Energieverbrauchs (n = 500.000)\*\***

\| Kennzahl                |                        Wert |

\| ----------------------- | --------------------------: |

\| Mittelwert              |                      245,89 |

\| Median                  |                       83,14 |

\| Standardabweichung      |                      392,85 |

\| Ausreißer (IQR-Methode) | 36.833 von 500.000 (7,37 %) |

\---

**## 🛠️ Feature Engineering\*\***

Für das Machine Learning wurden zusätzliche zeitliche und analytische Merkmale erzeugt.

**### Features\*\***

Das finale Modell verwendet die folgenden **\*\*\\\*\\\*10 Features\\\*\\\*\*\***:

\`\`\`text

square_feet

year_built

air_temperature

dew_temperature

wind_speed

sea_level_pressure

hour

day_of_week

month

year

\`\`\`

Die Variable \`meter_reading\` dient als Zielvariable.

**### Zeitliche Features\*\***

Die zeitbezogenen Merkmale \`hour\`, \`day_of_week\`, \`month\` und \`year\` werden aus der Spalte \`timestamp\` abgeleitet:

\`\`\`python

df["hour"] = df["timestamp"].dt.hour

df["day_of_week"] = df["timestamp"].dt.dayofweek

df["month"] = df["timestamp"].dt.month

df["year"] = df["timestamp"].dt.year

\`\`\`

Dadurch kann das Modell zeitliche Schwankungen des Energieverbrauchs berücksichtigen.

**### Datenvorbereitung\*\***

Die verwendeten Features werden in numerische Werte konvertiert.

Die **\*\*\\\*\\\*500.000 ausgewählten Beobachtungen bleiben erhalten\\\*\\\*\*\***. Fehlende Werte in den numerischen Features werden nicht durch das Löschen von Zeilen behandelt, sondern innerhalb der Machine-Learning-Pipeline durch eine Median-Imputation ersetzt:

\`\`\`python

SimpleImputer(strategy="median")

\`\`\`

Dadurch bleiben die verfügbaren Beobachtungen erhalten und fehlende Feature-Werte werden anhand des Medians der Trainingsdaten ersetzt.

Die Zielvariable \`meter_reading\` wird für die Modellierung verwendet.

**### Train-Test-Split\*\***

Die Daten werden in einen Trainings- und einen Testdatensatz aufgeteilt:

\| Datensatz   |  Anzahl |

\| ----------- | ------: |

\| Gesamtdaten | 500.000 |

\| Training    | 400.000 |

\| Test        | 100.000 |

Es wird ein **\*\*\\\*\\\*80/20-Split\\\*\\\*\*\*** mit \`random_state=42\` verwendet.

**### Finaler Feature-Engineering-Prozess\*\***

\`\`\`text

Rohdaten

   ↓

Konvertierung von timestamp

   ↓

Erstellung zeitlicher Features

   ↓

Auswahl der 10 Features

   ↓

Numerische Konvertierung

   ↓

Median-Imputation (in der Pipeline)

   ↓

Random Forest

   ↓

Vorhersage von meter_reading

\`\`\`

\---

**## 🤖 Machine Learning\*\***

Untersuchte Modelle:

1\. Lineare Regression

2\. Log-transformierte lineare Regression

3\. **\*\*\\\*\\\*Random Forest Regression\\\*\\\*\*\***

Bewertung anhand von **\*\*\\\*\\\*MAE\\\*\\\*\*\***, **\*\*\\\*\\\*RMSE\\\*\\\*\*\*** und **\*\*\\\*\\\*R²\\\*\\\*\*\***.

\`\`\`text

04_Machine_Learning/

└── ml_model.ipynb

\`\`\`

**## 🔍 3. Generalisierung auf unbekannte Gebäude\*\***

Mit \`GroupShuffleSplit\` wurde geprüft, wie gut das Modell auf Gebäuden funktioniert, die im Training nicht vorkamen.

Dabei wurden 40 Gebäude für das Training und 10 Gebäude für den Test verwendet. Kein Gebäude kommt in beiden Datensätzen vor.

\| Evaluationsstrategie   |    MAE |   RMSE |     R² |

\| ---------------------- | -----: | -----: | -----: |

\| Zufälliger Split       |  16,12 |  48,62 | 0,9846 |

\| Gebäudebasierter Split | 472,05 | 932,92 | 0,1945 |

**### 📊 Zusammenfassung der Modellleistung\*\***

Bei der klassischen Evaluation erreicht das Modell ein sehr hohes R² von 0,9846. Bei der Evaluation auf unbekannten Gebäuden sinkt dieser Wert auf 0,1945.

Die Ergebnisse zeigen, dass das Modell Schwierigkeiten hat, den Energieverbrauch neuer Gebäude zuverlässig vorherzusagen. Außerdem unterscheiden sich die Vorhersagefehler deutlich zwischen den einzelnen Gebäuden.

**\*\*\\\*\\\*Fazit:\\\*\\\*\*\*** Eine zufällige Aufteilung der Daten kann die Modellleistung überschätzen, wenn Daten desselben Gebäudes im Trainings- und Testdatensatz vorkommen. Die gebäudebasierte Evaluation zeigt, wie gut das Modell auf bisher unbekannte Gebäude generalisiert.

**## ⚠️ 4. Grenzen und Ausblick\*\***

Die gebäudebasierte Evaluation basiert auf einer einzigen Datenaufteilung mit zehn Testgebäuden. Eine Kreuzvalidierung mit \`GroupKFold\` könnte die Stabilität der Ergebnisse überprüfen.

Vor einem direkten Vergleich sollten außerdem die Datenfilter und die Vorverarbeitung beider Evaluationen auf Übereinstimmung geprüft werden. Eine zusätzliche Residuenanalyse kann helfen, systematische Vorhersagefehler zu erkennen.

**### Gespeichertes Random-Forest-Modell\*\***

Die Random-Forest-Pipeline wurde erfolgreich gespeichert.

\\\* **\*\*\\\*\\\*Datei:\\\*\\\*\*\*** \`05_API/rf_pipeline.joblib\`

\\\* **\*\*\\\*\\\*Format:\\\*\\\*\*\*** Joblib

\\\* **\*\*\\\*\\\*Größe:\\\*\\\*\*\*** ca. 2,19 GB

\\\* **\*\*\\\*\\\*Status:\\\*\\\*\*\*** Erfolgreich gespeichert

**### Finales Modell für die API\*\***

Das finale Modell für die API ist ein:

\`\`\`text

RandomForestRegressor

\`\`\`

Das Modell ist in eine Pipeline integriert:

\`\`\`text

SimpleImputer(strategy="median")

        ↓

RandomForestRegressor

\`\`\`

mit folgenden Parametern:

\`\`\`python

RandomForestRegressor(

    n_estimators=100,

    random_state=42,

    n_jobs=-1

)

\`\`\`

Das trainierte Pipeline-Modell wird gespeichert als:

\`\`\`text

05_API/rf_pipeline.joblib

\`\`\`

Das für die API gespeicherte Modell (\`rf_pipeline.joblib\`) wurde auf den 400.000 Trainingsdaten trainiert und auf den 100.000 Testdaten evaluiert.

**### Interpretation der Ergebnisse\*\***

Die Verbrauchsdaten weisen eine **\*\*\\\*\\\*asymmetrische Verteilung\\\*\\\*\*\*** auf. Deshalb wurde zusätzlich eine Log-Transformation getestet. Diese führte jedoch zu keiner Verbesserung des RMSE.

Der Random Forest verwendet zehn Gebäude-, Wetter- und Zeitmerkmale:

\`square_feet\`, \`year_built\`, \`air_temperature\`, \`dew_temperature\`, \`wind_speed\`, \`sea_level_pressure\`, \`hour\`, \`day_of_week\`, \`month\` und \`year\`.

Durch die Verwendung eines Random Forest können auch **\*\*\\\*\\\*nichtlineare Zusammenhänge und Interaktionen zwischen den Merkmalen\\\*\\\*\*\*** berücksichtigt werden.

Mit einem **\*\*\\\*\\\*R² von 0,9846\\\*\\\*\*\***, einem **\*\*\\\*\\\*MAE von 16,12\\\*\\\*\*\*** und einem **\*\*\\\*\\\*RMSE von 48,62\\\*\\\*\*\*** zeigt das finale Modell eine hohe Vorhersageleistung auf dem verwendeten Testdatensatz.

\\> **\*\*\\\*\\\*Hinweis zur Aussagekraft:\\\*\\\*\*\*** Der Train-Test-Split erfolgt zufällig. Da Gebäude in stündlichen Messreihen sowohl in den Trainings- als auch in den Testdaten vorkommen, kann die Vorhersagequalität für vollständig unbekannte Gebäude geringer ausfallen. Eine Validierung mit gebäudebasierter Trennung wäre ein sinnvoller nächster Schritt.

\---

**## 🌐 API\*\***

Das Projekt enthält eine **\*\*\\\*\\\*FastAPI\\\*\\\*\*\***-Anwendung für Vorhersage und Live-Wetterdaten.

**### Architektur\*\***

\`\`\`text

ASHRAE-Daten → SQL/MySQL → Python/EDA → Statistik → Feature Engineering

                                                          ↓

                                               Linear · Log · Random Forest

                                                          ↓

                                                       FastAPI

                                                      ┌────┴────┐

                                                 /predict    /weather

\`\`\`

**### API-Struktur\*\***

\`\`\`text

05_API/

├── prediction_api.py

├── weather_api.py

├── rf_pipeline.joblib

├── requirements.txt

└── README.md

\`\`\`

**### Modelldatei\*\***

Die Datei \`rf_pipeline.joblib\` enthält die Random-Forest-Pipeline, die von der API verwendet wird.

\| Eigenschaft | Wert                              |

\| ----------- | --------------------------------- |

\| Datei       | \`05_API/rf_pipeline.joblib\`     |

\| Größe       | ca. 2,19 GB (2.191.874.817 Bytes) |

\| Format      | Joblib                            |

Aufgrund ihrer Größe ist die Modelldatei nicht im GitHub-Repository enthalten. Um die API lokal auszuführen, muss die Datei im Ordner \`05_API/\` liegen. Die Datei kann mit dem Notebook \`04_Machine_Learning/ml_model.ipynb\` erzeugt werden. Die API lädt die Pipeline beim Start automatisch.

**### Endpoints\*\***

\| Methode | Endpoint   | Beschreibung                     |

\| ------- | ---------- | -------------------------------- |

\| \`GET\`   | \`/\`        | Prüft, ob die API aktiv ist      |

\| \`POST\`  | \`/predict\` | Vorhersage des Energieverbrauchs |

\| \`GET\`   | \`/weather\` | Abruf aktueller Wetterdaten      |

**### Beispiel-Response \`/\`\*\***

\`\`\`json

{

  "message": "ASHRAE Energy Prediction API is running",

  "model": "Random Forest",

  "version": "1.0.0",

  "features": 10

}

\`\`\`

**### Beispiel-Request \`/predict\`\*\***

\`\`\`json

{

  "square_feet": 50000,

  "year_built": 2008,

  "air_temperature": 18.0,

  "dew_temperature": 12.0,

  "wind_speed": 3.0,

  "sea_level_pressure": 1015.0,

  "hour": 12,

  "day_of_week": 2,

  "month": 6,

  "year": 2026

}

\`\`\`

**### Beispiel-Response \`/predict\`\*\***

\`\`\`json

{

  "predicted_energy_consumption": 440.6812

}

\`\`\`

Die Vorhersage wurde mit denselben Eingabewerten sowohl im Notebook als auch über die API getestet.

\`\`\`text

Notebook : 440.6812

API      : 440.6812

\`\`\`

Damit liefern Notebook und API für dieselben Eingabedaten dieselbe Vorhersage.

**### Endpoint \`/weather\`\*\***

Der Endpoint \`/weather\` ermöglicht den Abruf aktueller Wetterdaten anhand geografischer Koordinaten.

**\*\*\\\*\\\*Parameter:\\\*\\\*\*\***

\| Parameter   | Typ    | Beschreibung        |

\| ----------- | ------ | ------------------- |

\| \`latitude\`  | number | Geografische Breite |

\| \`longitude\` | number | Geografische Länge  |

**\*\*\\\*\\\*Beispiel-Request:\\\*\\\*\*\***

\`\`\`text

GET /weather?latitude=51.2277&longitude=6.7735

\`\`\`

Der Endpoint wurde erfolgreich mit HTTP-Statuscode \`200\` getestet.

**\*\*\\\*\\\*Beispiel-Response:\\\*\\\*\*\***

\`\`\`json

{

  "latitude": 51.2277,

  "longitude": 6.7735,

  "temperature": 28.5,

  "wind_speed": 10.4

}

\`\`\`

\\> Die Werte sind Live-Daten (Open-Meteo) und ändern sich bei jedem Abruf.

**### Swagger / OpenAPI\*\***

Die API stellt eine interaktive Swagger/OpenAPI-Dokumentation bereit.

Nach dem Start des Servers ist die Dokumentation erreichbar unter:

\`\`\`text

http\://127.0.0.1:8002/docs

\`\`\`

Über Swagger können die Endpoints \`/\`, \`/predict\` und \`/weather\` direkt getestet werden.

**### API-Status\*\***

\| Endpoint   | Methode | Status |

\| ---------- | ------- | ------ |

\| \`/\`        | GET     | 200 ✅  |

\| \`/predict\` | POST    | 200 ✅  |

\| \`/weather\` | GET     | 200 ✅  |

\\> Die trainierten Modelle (\`\\\*.joblib\`) werden lokal genutzt und sind aufgrund ihrer Größe via \`.gitignore\` von Git ausgeschlossen.

\---

**## ✅ Datenqualität\*\***

Die zentralen Energieverbrauchsdaten sind **\*\*\\\*\\\*vollständig\\\*\\\*\*\***; fehlende Werte betreffen vor allem ergänzende Gebäude- und Wetterinformationen.

Geprüft wurden: fehlende Werte, Duplikate, Datensatzgrößen, Schlüssel, Verknüpfungen sowie die Vollständigkeit zentraler Messdaten.

\---

**## 🧰 Technologien\*\***

\| Bereich           | Technologie                               |

\| ----------------- | ----------------------------------------- |

\| Datenbank         | MySQL                                     |

\| Abfragesprache    | SQL                                       |

\| Programmierung    | Python                                    |

\| Datenanalyse      | Pandas                                    |

\| Visualisierung    | Matplotlib                                |

\| Statistik         | Deskriptive Statistik, ANOVA, Korrelation |

\| Machine Learning  | Scikit-learn                              |

\| API               | FastAPI, Uvicorn                          |

\| Wetterdaten       | Open-Meteo API                            |

\| Modellspeicherung | Joblib                                    |

\| Dokumentation     | GitHub                                    |

\| Präsentation      | PowerPoint                                |

\---

**## 📁 Projektstruktur\*\***

\`\`\`text

ASHRAE-Energy-Analysis/

│

├── 01_SQL_MySQL/

│   ├── 01_database_setup.sql

│   ├── 02_data_import.sql

│   ├── 03_data_quality.sql

│   ├── 04_train_full.sql

│   ├── 05_analysis.sql

│   ├── joins.sql

│   └── README.md

│

├── 02_Python/

│   ├── data_exploration.ipynb

│   ├── statistics.ipynb

│   └── visualizations.ipynb

│

├── 03_Statistics/

│   └── statistical_analysis.ipynb

│

├── 04_Machine_Learning/

│   └── ml_model.ipynb

│

├── 05_API/

│   ├── prediction_api.py

│   ├── weather_api.py

│   ├── rf_pipeline.joblib

│   ├── requirements.txt

│   └── README.md

│

├── results/

│   └── figures/

│

├── assets/

│   └── qr_code.png

│

├── presentation/

│   └── ASHRAE_Presentation.pptx

│

├── requirements.txt

├── create_qr.py

├── LICENSE

└── README.md

\`\`\`

**## ⚙️ Installation\*\***

\`\`\`bash

\\# Repository klonen

git clone https\://github.com/Dian026/ASHRAE-Energy-Analysis.git

cd ASHRAE-Energy-Analysis

\\# Python-Abhängigkeiten installieren

pip install -r requirements.txt

\`\`\`

Die Notebooks unter \`02_Python/\`, \`03_Statistics/\` und \`04_Machine_Learning/\` können anschließend in Jupyter geöffnet und ausgeführt werden.

Für den SQL-Teil wird eine lokale MySQL-Instanz benötigt. Die originalen ASHRAE-Datendateien werden separat lokal bereitgestellt und sind nicht Bestandteil des Repositories.

**\*\*\\\*\\\*API starten:\\\*\\\*\*\***

\`\`\`bash

pip install -r 05_API/requirements.txt

python -m uvicorn prediction_api\:app --app-dir 05_API --port 8002

\`\`\`

\---

**## 🎤 Präsentation\*\***

Die vollständige Projektpräsentation befindet sich unter [\`presentation/ASHRAE_Presentation.pptx\`]\\(presentation/ASHRAE_Presentation.pptx).

\---

**## 🔗 GitHub\*\***

**\*\*\\\*\\\*Repository:\\\*\\\*\*\*** [github.com/Dian026/ASHRAE-Energy-Analysis]\\(https\://github.com/Dian026/ASHRAE-Energy-Analysis)

Enthält den vollständigen Workflow von SQL und Python über Statistik und Machine Learning bis hin zur FastAPI-Anwendung.

Der folgende QR-Code verweist direkt auf das Repository:

\\\<p align="center">

  \\\<img src="assets/qr_code.png" alt="QR-Code zum GitHub-Repository" width="180">

\\\</p>

Der QR-Code kann mit \`create_qr.py\` neu erzeugt werden:

\`\`\`bash

python create_qr.py

\`\`\`

**## 🏁 Fazit\*\***

Dieses Projekt demonstriert einen **\*\*\\\*\\\*vollständigen Data-Analytics-Workflow\\\*\\\*\*\*** – von der Datenbank über SQL, Python und Statistik bis hin zu Machine Learning und API-Entwicklung.

Im Mittelpunkt stehen:

\\\* strukturierte Datenverarbeitung

\\\* nachvollziehbare statistische Analysen

\\\* durchdachtes Feature Engineering

\\\* Modellierung und Bewertung

\\\* produktionsnahe API-Bereitstellung

\\\* professionelle Dokumentation und Präsentation

\---

**## 📄 Lizenz\*\***

Dieses Projekt steht unter der [MIT-Lizenz]\\(LICENSE).

**## 👤 Autor\*\***

**\*\*\\\*\\\*Mamadou Dian Diallo\\\*\\\*\*\***

GitHub: [@Dian026]\\(https\://github.com/Dian026)