-- DataBase: PostgreSQL 14.2 for macos12.0 on arm64
-- OS: macOS 12.1, Darwin Kernel Version 21.2.0 arm64
-- CREATE EXTENSION postgis;
DROP TABLE IF EXISTS PlaceMarks;
DROP TYPE IF EXISTS LocationType;

-- Create a new enum type for Fountain, Library and Home.
CREATE TYPE LocationType AS ENUM ('F', 'L', 'H');

-- Create a table for placemarks
CREATE TABLE PlaceMarks
(
    P_ID        SERIAL                                                                                                 NOT NULL,
    P_Name      CHAR(15)                                                                                               NOT NULL,
    P_Type      LocationType                                                                                           NOT NULL,
    P_Longitude NUMERIC                                                                                                NOT NULL,
    P_Latitude  NUMERIC                                                                                                NOT NULL,
    P_GEO       GEOMETRY(POINT, 4326) GENERATED ALWAYS AS (ST_SetSRID(ST_POINT(P_Longitude, P_Latitude), 4326)) STORED NOT NULL,
    PRIMARY KEY (P_ID)
);

-- Read data from csv
COPY PlaceMarks (P_Name, P_Type, P_Longitude, P_Latitude)
    FROM '/Users/xjdkc/Program/GitHub/USC-Courses/CSCI-585/HW3/Q5.sql'
    DELIMITER ',' CSV HEADER;

-- show the imported data
SELECT *
FROM PlaceMarks;

-- get the convex hull of those placemarks
SELECT ST_ASKML(ST_ConvexHull(ST_Collect(P_GEO)))
FROM PlaceMarks;

-- get the nearest home of my home
SELECT ST_ASKML(P_GEO), ST_Distance((SELECT P.P_GEO FROM PlaceMarks AS P WHERE P.P_Type = 'H'), P_GEO) AS Distance
FROM PlaceMarks
WHERE P_TYPE <> 'H'
ORDER BY Distance
LIMIT 1;
