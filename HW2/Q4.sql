-- DataBase: MySQL 8.0.28 for macos12.0 on arm64
-- OS: macOS 12.1, Darwin Kernel Version 21.2.0 arm64
CREATE DATABASE IF NOT EXISTS CSCI585_HW2_Q4;
USE CSCI585_HW2_Q4;
DROP TABLE IF EXISTS Enrollment;
DROP TABLE IF EXISTS Class;
DROP TABLE IF EXISTS HourlyRate;
DROP TABLE IF EXISTS Teacher;

-- Create a table for storing the hourly rate for different types of class
CREATE TABLE HourlyRate
(
    Type enum ('T', 'S') NOT NULL,
    Rate INTEGER         NOT NULL,
    PRIMARY KEY (Type)
);

-- Create the table to store Teacher info
CREATE TABLE Teacher
(
    TID         INTEGER  NOT NULL,
    TeacherName CHAR(10) NOT NULL,
    PRIMARY KEY (TID)
);

-- Create the table to store Class info
CREATE TABLE Class
(
    CID       INTEGER        NOT NULL,
    ClassName CHAR(50)       NOT NULL,
    TID       INTEGER        NOT NULL,
    Hours     INTEGER        NOT NULL,
    Type      ENUM ('T','S') NOT NULL,
    PRIMARY KEY (CID),
    FOREIGN KEY (TID) REFERENCES Teacher (TID) ON DELETE CASCADE,
    FOREIGN KEY (Type) REFERENCES HourlyRate (Type) ON DELETE CASCADE
);

-- Create the table to store Enrollment info
CREATE TABLE Enrollment
(
    SID   INTEGER                                NOT NULL,
    CID   INTEGER                                NOT NULL,
    GRADE ENUM ('A','B','C','D','E') DEFAULT 'A' NOT NULL,
    PRIMARY KEY (SID, CID),
    FOREIGN KEY (CID) REFERENCES Class (CID) ON DELETE CASCADE
);

-- Insert data into Table HourlyRate
INSERT INTO HourlyRate
VALUES ('T', 100),
       ('S', 50);

-- Insert data into Table Teacher
INSERT INTO Teacher
VALUES (1, 'Saty'),
       (2, 'Shahriar');

-- Insert data into Table Class
INSERT INTO Class
VALUES (1, 'Database Systems', 1, 50, 'T'),
       (2, 'Database Systems Projects', 1, 20, 'S'),
       (3, 'Analytics of Algorithms', 2, 40, 'T'),
       (4, 'Analytics of Algorithms Projects', 2, 10, 'S');

-- Insert data into Table Enrollment
INSERT INTO Enrollment
VALUES (1, 1, 'A'),
       (2, 1, 'A'),
       (3, 1, 'A'),
       (4, 1, 'A'),
       (5, 1, 'A'),
       (6, 1, 'A'),
       (7, 1, 'A'),
       (8, 1, 'A'),
       (9, 1, 'A'),
       (10, 1, 'A'),
       (11, 1, 'A'),
       (12, 1, 'A'),
       (13, 1, 'A'),
       (14, 1, 'A'),
       (15, 1, 'A'),
       (16, 1, 'A'),
       (17, 1, 'A'),
       (18, 1, 'A'),
       (19, 1, 'A'),
       (20, 1, 'A'),
       (1, 2, 'A'),
       (2, 2, 'A'),
       (3, 2, 'A'),
       (4, 2, 'A'),
       (5, 2, 'A'),
       (6, 2, 'A'),
       (7, 2, 'A'),
       (8, 2, 'A'),
       (9, 2, 'A'),
       (10, 2, 'A'),
       (11, 2, 'A'),
       (12, 2, 'A'),
       (13, 2, 'A'),
       (14, 2, 'A'),
       (15, 2, 'A'),
       (1, 3, 'A'),
       (2, 3, 'A'),
       (3, 3, 'A'),
       (4, 3, 'A'),
       (5, 3, 'A'),
       (6, 3, 'A'),
       (7, 3, 'A'),
       (8, 3, 'A'),
       (9, 3, 'A'),
       (10, 3, 'A'),
       (1, 4, 'A'),
       (2, 4, 'A'),
       (3, 4, 'A'),
       (4, 4, 'A'),
       (5, 4, 'A');

-- Output the highest bonus amount paid
SELECT MAX(BONUS)
FROM (SELECT SUM(Hours),
             SUM(Hours) * 0.1 * (SELECT Rate FROM HourlyRate WHERE Type = Class.Type) AS BONUS
      FROM Class
               LEFT JOIN Enrollment ON Class.CID = Enrollment.CID
               LEFT JOIN Teacher on Class.TID = Teacher.TID
      WHERE Type = 'T'
      GROUP BY Teacher.TID) AS T1;