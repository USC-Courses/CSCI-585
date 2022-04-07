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

-- Version 2.0
SELECT TeacherName
FROM (SELECT T1.TID AS TID, TeacherName
      FROM (SELECT Teacher.TID AS TID, TeacherName
            FROM CandidateInfo
                     LEFT JOIN Teacher ON CandidateInfo.TID = Teacher.TID
                     LEFT JOIN Subject ON CandidateInfo.SID = Subject.SID
            WHERE SubjectName = 'JavaScript') AS T1
               LEFT JOIN CandidateInfo ON CandidateInfo.TID = T1.TID
               LEFT JOIN Subject S on CandidateInfo.SID = S.SID
      WHERE SubjectName = 'Scratch') AS T2
         LEFT JOIN CandidateInfo ON CandidateInfo.TID = T2.TID
         LEFT JOIN Subject S on CandidateInfo.SID = S.SID
WHERE SubjectName = 'Python';

-- Explanation
-- Step 1: JOIN Table CandidateInfo, Table Teacher and Table Subject.
--         Filter out teachers that can't teach JavaScript.
--         We get a list(named T1) of teachers that can teach JavaScript.
-- Step 2: JOIN Table T1, Table CandidateInfo and Table Subject.
--         Filter out teachers that can't teach Scratch.
--         We get a list(named T2) of teachers that can teach JavaScript and Scratch.
-- Step 3: JOIN Table T2, Table CandidateInfo and Table Subject.
--         Filter out teachers that can't teach Python.
--         We get a list of teachers that can teach JavaScript, Scratch and Python.
-- Step 4: Return a list of the names of the teachers who can teach the three subjects.