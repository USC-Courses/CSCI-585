-- DataBase: MySQL 8.0.28 for macos12.0 on arm64
-- OS: macOS 12.1, Darwin Kernel Version 21.2.0 arm64
CREATE DATABASE IF NOT EXISTS CSCI585_HW2_Q2;
USE CSCI585_HW2_Q2;
DROP TABLE IF EXISTS Enrollment;

-- Create a table for storing enrollment info
CREATE TABLE Enrollment
(
    SID       INTEGER                                NOT NULL,
    ClassName CHAR(10)                               NOT NULL,
    GRADE     ENUM ('A','B','C','D','E') DEFAULT 'A' NOT NULL,
    PRIMARY KEY (SID, ClassName)
);

-- Insert data into table Enrollment
INSERT INTO Enrollment
VALUES (123, 'Processing', 'A'),
       (123, 'Python', 'B'),
       (123, 'Scratch', 'B'),
       (662, 'Java', 'B'),
       (662, 'Python', 'A'),
       (662, 'JavaScript', 'A'),
       (662, 'Scratch', 'B'),
       (345, 'Scratch', 'A'),
       (345, 'JavaScript', 'B'),
       (345, 'Python', 'A'),
       (555, 'Python', 'B'),
       (555, 'JavaScript', 'B'),
       (213, 'JavaScript', 'A');

-- Show the number of students enrolled by each class in decreasing order
SELECT ClassName, COUNT(*)
FROM Enrollment
GROUP BY ClassName
ORDER BY COUNT(*) DESC;