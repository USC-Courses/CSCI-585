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
SELECT TeacherName, COUNT(Subject.SID)
FROM Teacher,
     Subject,
     CandidateInfo
WHERE Teacher.TID = CandidateInfo.TID
  and Subject.SID = CandidateInfo.SID
  and SubjectName in ('JavaScript', 'Scratch', 'Python')
GROUP BY Teacher.TID
HAVING COUNT(Subject.SID) = 3;

-- Version 3.0
SELECT DISTINCT TeacherName
FROM CandidateInfo
         LEFT JOIN Teacher ON CandidateInfo.TID = Teacher.TID
WHERE CandidateInfo.TID NOT IN (SELECT DISTINCT TID
                                FROM (SELECT TID, SID
                                      FROM (SELECT SID FROM RequiredSubjects) AS T1
                                               CROSS JOIN
                                               (SELECT DISTINCT TID FROM CandidateInfo) AS T2) AS T3
                                WHERE (T3.TID, T3.SID) NOT IN (SELECT TID, SID FROM CandidateInfo));

-- Explanation: from the inside out
-- Step 1: Let's consider two table from, one contains all required subjects,
--         the other contains all candidate teachers.
-- Step 2: Cross join them, we get a table that contains subjects that all candidate teachers should be able to teach
-- Step 3: Filter out lines that the corresponding teacher can teach.
--         Each remaining line indicates a required subject that a teacher can't teach
-- Step 4: Based on step 4, we get a list in which every teacher can't teach at least one lesson
-- Step 5: Filter out these teachers and we get the final result.
