-- DataBase: MySQL 8.0.28 for macos12.0 on arm64
-- OS: macOS 12.1, Darwin Kernel Version 21.2.0 arm64
CREATE DATABASE IF NOT EXISTS CSCI585_HW2_Q1;
USE CSCI585_HW2_Q1;
DROP TABLE IF EXISTS ProjectRoomBookings;

-- Create the table ProjectRoomBookings
CREATE TABLE ProjectRoomBookings
(
    roomNum   INTEGER  NOT NULL,
    startTime INTEGER  NOT NULL,
    endTime   INTEGER  NOT NULL,
    groupName CHAR(10) NOT NULL,
    seven     BOOLEAN AS (IF(startTime <= 7 and 7 <= endTime, TRUE, null)),
    eight     BOOLEAN AS (IF(startTime <= 8 and 8 <= endTime, TRUE, null)),
    nine      BOOLEAN AS (IF(startTime <= 9 and 9 <= endTime, TRUE, null)),
    ten       BOOLEAN AS (IF(startTime <= 10 and 10 <= endTime, TRUE, null)),
    eleven    BOOLEAN AS (IF(startTime <= 11 and 11 <= endTime, TRUE, null)),
    twelve    BOOLEAN AS (IF(startTime <= 12 and 12 <= endTime, TRUE, null)),
    thirteen  BOOLEAN AS (IF(startTime <= 13 and 13 <= endTime, TRUE, null)),
    fourteen  BOOLEAN AS (IF(startTime <= 14 and 14 <= endTime, TRUE, null)),
    fifteen   BOOLEAN AS (IF(startTime <= 15 and 15 <= endTime, TRUE, null)),
    sixteen   BOOLEAN AS (IF(startTime <= 16 and 16 <= endTime, TRUE, null)),
    seventeen BOOLEAN AS (IF(startTime <= 17 and 17 <= endTime, TRUE, null)),
    eighteen  BOOLEAN AS (IF(startTime <= 18 and 18 <= endTime, TRUE, null)),
    PRIMARY KEY (roomNum, startTime),
    CONSTRAINT `Legal TimeSpan` CHECK (startTime < endTime and 7 <= startTime and endTime <= 18),
    CONSTRAINT `Check 7` UNIQUE (roomNum, seven),
    CONSTRAINT `Check 8` UNIQUE (roomNum, eight),
    CONSTRAINT `Check 9` UNIQUE (roomNum, nine),
    CONSTRAINT `Check 10` UNIQUE (roomNum, ten),
    CONSTRAINT `Check 11` UNIQUE (roomNum, eleven),
    CONSTRAINT `Check 12` UNIQUE (roomNum, twelve),
    CONSTRAINT `Check 13` UNIQUE (roomNum, thirteen),
    CONSTRAINT `Check 14` UNIQUE (roomNum, fourteen),
    CONSTRAINT `Check 15` UNIQUE (roomNum, fifteen),
    CONSTRAINT `Check 16` UNIQUE (roomNum, sixteen),
    CONSTRAINT `Check 17` UNIQUE (roomNum, seventeen),
    CONSTRAINT `Check 18` UNIQUE (roomNum, eighteen)
);

-- show content of table ProjectRoomBookings
SELECT *
FROM ProjectRoomBookings;

-- Please comment out the following lines to test
-- regular insertion
INSERT INTO ProjectRoomBookings(roomNum, startTime, endTime, groupName) VALUE (1, 7, 9, 'GROUP_A');
-- illegal time span
-- INSERT INTO ProjectRoomBookings(roomNum, startTime, endTime, groupName) VALUE (1, 1, 2, 'GROUP_B');
-- illegal time span
-- INSERT INTO ProjectRoomBookings(roomNum, startTime, endTime, groupName) VALUE (1, 9, 7, 'GROUP_C');
-- overlapped time span
-- INSERT INTO ProjectRoomBookings(roomNum, startTime, endTime, groupName) VALUE (1, 8, 9, 'GROUP_D');