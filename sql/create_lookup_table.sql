USE taxi_project;

DROP TABLE IF EXISTS taxi_zones_clean;

CREATE EXTERNAL TABLE taxi_zones_clean (
    location_id INT,
    zone STRING,
    borough STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
    "separatorChar" = ",",
    "quoteChar" = "\""
)
STORED AS TEXTFILE
LOCATION '/user/mohamed/taxi/lookup_clean';