-- ============================================
-- NYC Yellow Taxi - Data Analysis
-- Dataset: January 2025
-- ============================================

USE taxi_project;

SET hive.auto.convert.join=false;


-- ============================================
-- 1. Overall Trip Statistics
-- ============================================

SELECT
    COUNT(*) AS total_trips,
    ROUND(AVG(trip_distance), 2) AS avg_distance,
    ROUND(AVG(total_amount), 2) AS avg_trip_amount,
    ROUND(AVG(passenger_count), 2) AS avg_passengers
FROM yellow_taxi_cleaned;


-- ============================================
-- 2. Trips by Payment Type
-- ============================================

SELECT
    payment_type,
    COUNT(*) AS trip_count
FROM yellow_taxi_cleaned
GROUP BY payment_type
ORDER BY trip_count DESC;


-- ============================================
-- 3. Trips by Pickup Hour
-- ============================================

SELECT
    HOUR(tpep_pickup_datetime) AS pickup_hour,
    COUNT(*) AS trip_count
FROM yellow_taxi_cleaned
GROUP BY HOUR(tpep_pickup_datetime)
ORDER BY pickup_hour;


-- ============================================
-- 4. Top Pickup Zones
-- ============================================

SELECT
    z.location_id,
    z.zone,
    z.borough,
    COUNT(*) AS trip_count
FROM yellow_taxi_cleaned t
JOIN taxi_zones_clean z
    ON t.PULocationID = z.location_id
GROUP BY
    z.location_id,
    z.zone,
    z.borough
ORDER BY trip_count DESC
LIMIT 20;


-- ============================================
-- 5. Top Drop-off Zones
-- ============================================

SELECT
    z.location_id,
    z.zone,
    z.borough,
    COUNT(*) AS trip_count
FROM yellow_taxi_cleaned t
JOIN taxi_zones_clean z
    ON t.DOLocationID = z.location_id
GROUP BY
    z.location_id,
    z.zone,
    z.borough
ORDER BY trip_count DESC
LIMIT 20;


-- ============================================
-- 6. Trips by Borough
-- ============================================

SELECT
    z.borough,
    COUNT(*) AS trip_count
FROM yellow_taxi_cleaned t
JOIN taxi_zones_clean z
    ON t.PULocationID = z.location_id
GROUP BY z.borough
ORDER BY trip_count DESC;


-- ============================================
-- 7. Top Pickup-to-Drop-off Routes
-- ============================================

SELECT
    pu.zone AS pickup_zone,
    do.zone AS dropoff_zone,
    COUNT(*) AS trip_count
FROM yellow_taxi_cleaned t
JOIN taxi_zones_clean pu
    ON t.PULocationID = pu.location_id
JOIN taxi_zones_clean do
    ON t.DOLocationID = do.location_id
GROUP BY
    pu.zone,
    do.zone
ORDER BY trip_count DESC
LIMIT 20;


-- ============================================
-- 8. Amount and Distance by Borough
-- ============================================

SELECT
    z.borough,
    COUNT(*) AS trip_count,
    ROUND(AVG(t.trip_distance), 2) AS avg_distance,
    ROUND(AVG(t.total_amount), 2) AS avg_trip_amount,
    ROUND(SUM(t.total_amount), 2) AS total_amount
FROM yellow_taxi_cleaned t
JOIN taxi_zones_clean z
    ON t.PULocationID = z.location_id
GROUP BY z.borough
ORDER BY total_amount DESC;