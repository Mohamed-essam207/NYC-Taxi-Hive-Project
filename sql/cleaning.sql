USE taxi_project;

DROP TABLE IF EXISTS yellow_taxi_cleaned;

CREATE TABLE yellow_taxi_cleaned
STORED AS PARQUET
AS
SELECT
    VendorID,
    tpep_pickup_datetime,
    tpep_dropoff_datetime,
    passenger_count,
    trip_distance,
    RatecodeID,
    store_and_fwd_flag,
    PULocationID,
    DOLocationID,
    payment_type,
    fare_amount,
    extra,
    mta_tax,
    tip_amount,
    tolls_amount,
    improvement_surcharge,
    total_amount,
    congestion_surcharge,
    Airport_fee,
    cbd_congestion_fee
FROM yellow_taxi
WHERE trip_distance > 0
  AND total_amount > 0
  AND tpep_dropoff_datetime >= tpep_pickup_datetime;