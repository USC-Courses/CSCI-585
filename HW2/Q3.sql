-- DataBase: MySQL 8.0.28 for macos12.0 on arm64
-- OS: macOS 12.1, Darwin Kernel Version 21.2.0 arm64
CREATE DATABASE IF NOT EXISTS CSCI585_HW2_Q3;
USE CSCI585_HW2_Q3;
DROP TABLE IF EXISTS ProjectStatus;

CREATE TABLE ProjectStatus
(
    PID    CHAR(10)                    NOT NULL,
    Step   INTEGER                     NOT NULL,
    Status ENUM ('C', 'W') DEFAULT 'W' NOT NULL,
    PRIMARY KEY (PID, Step)
);

INSERT INTO ProjectStatus
VALUES ('P100', 0, 'C'),
       ('P100', 1, 'W'),
       ('P100', 2, 'W'),
       ('P201', 0, 'C'),
       ('P201', 1, 'C'),
       ('P333', 0, 'W'),
       ('P333', 1, 'W'),
       ('P333', 2, 'W'),
       ('P333', 3, 'W');

SELECT PID
FROM (SELECT PID, MAX(Step)
      FROM ProjectStatus
      WHERE Status = 'C'
      GROUP BY PID
      HAVING MAX(Step) = 0) AS T;
