-- DataBase: MySQL 8.0.28 for macos12.0 on arm64
-- OS: macOS 12.1, Darwin Kernel Version 21.2.0 arm64
CREATE DATABASE IF NOT EXISTS CSCI585_HW2_Q5;
USE CSCI585_HW2_Q5;

DROP TABLE IF EXISTS RequiredSubjects;
DROP TABLE IF EXISTS CandidateInfo;
DROP TABLE IF EXISTS Teacher;
DROP TABLE IF EXISTS Subject;

CREATE TABLE Teacher
(
    TID         INTEGER  NOT NULL,
    TeacherName CHAR(10) NOT NULL,
    PRIMARY KEY (TID)
);

CREATE TABLE Subject
(
    SID         INTEGER  NOT NULL,
    SubjectName CHAR(20) NOT NULL,
    PRIMARY KEY (SID)
);

CREATE TABLE CandidateInfo
(
    TID INTEGER NOT NULL,
    SID INTEGER NOT NULL,
    PRIMARY KEY (TID, SID),
    FOREIGN KEY (TID) REFERENCES Teacher (TID) ON DELETE CASCADE,
    FOREIGN KEY (SID) REFERENCES Subject (SID) ON DELETE CASCADE
);

CREATE TABLE RequiredSubjects
(
    SID INTEGER NOT NULL,
    PRIMARY KEY (SID),
    FOREIGN KEY (SID) REFERENCES Subject (SID) ON DELETE CASCADE
);

INSERT INTO Teacher
VALUES (1, 'Aleph'),
       (2, 'Bit'),
       (3, 'CRC'),
       (4, 'Dat'),
       (5, 'Emscr');

INSERT INTO Subject
VALUES (1, 'Scratch'),
       (2, 'Java'),
       (3, 'Processing'),
       (4, 'JavaScript'),
       (5, 'Python');

INSERT INTO CandidateInfo
VALUES (1, 1),
       (1, 2),
       (1, 3),
       (2, 5),
       (2, 4),
       (2, 2),
       (3, 5),
       (3, 4),
       (4, 1),
       (4, 5),
       (4, 4),
       (5, 1),
       (5, 3),
       (5, 4),
       (5, 5);

INSERT INTO RequiredSubjects
VALUES (1),
       (4),
       (5);

-- Version 1.0
SELECT TeacherName
FROM (SELECT TeacherName, COUNT(CandidateInfo.SID)
      FROM CandidateInfo
               LEFT JOIN Teacher ON CandidateInfo.TID = Teacher.TID
               LEFT JOIN Subject ON CandidateInfo.SID = Subject.SID
      WHERE Subject.SID in (SELECT * FROM RequiredSubjects)
      GROUP BY Teacher.TID
      HAVING COUNT(Subject.SID) = (SELECT COUNT(*) FROM RequiredSubjects)) AS T1;

-- Explanation
-- Step 1: JOIN Table CandidateInfo, Table Teacher and Table Subject
-- Step 2: Filter out lines where the subject is not in required subjects
-- Step 3: Group lines by Teacher ID. So each group contains all required subjects
--         that the corresponding teacher can teach.
-- Step 4: Count the number of required subjects in each group
-- Step 5: Check if the number of subjects each group is equal to the total number of required subjects.
-- Step 6: Keep teachers that meet the requirements