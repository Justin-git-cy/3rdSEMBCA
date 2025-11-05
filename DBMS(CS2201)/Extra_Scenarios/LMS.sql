CREATE DATABASE Libra;
USE Libra;

CREATE TABLE Member (
  MemberID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(50)
);

CREATE TABLE Book (
  BookID INT PRIMARY KEY AUTO_INCREMENT,
  Title VARCHAR(100),
  Author VARCHAR(50)
);

CREATE TABLE IssueRecord (
  IssueID INT PRIMARY KEY AUTO_INCREMENT,
  BookID INT,
  MemberID INT,
  IssueDate DATE,
  ReturnDate DATE,
  FOREIGN KEY (BookID) REFERENCES Book(BookID),
  FOREIGN KEY (MemberID) REFERENCES Member(MemberID)
);

INSERT INTO Member (Name) VALUES ('Ravi'), ('Sneha');
INSERT INTO Book (Title, Author) VALUES ('C Programming', 'Dennis Ritchie'), ('DBMS Concepts', 'Korth');
INSERT INTO IssueRecord (BookID, MemberID, IssueDate, ReturnDate)
VALUES (1,1,'2025-11-01','2025-11-10'), (2,2,'2025-10-25','2025-11-03');

SELECT MemberID, COUNT(BookID) AS BooksIssued FROM IssueRecord GROUP BY MemberID;
SELECT * FROM IssueRecord WHERE ReturnDate < CURDATE();

DELIMITER //
CREATE PROCEDURE AddOrUpdateIssue(IN iid INT, IN bid INT, IN mid INT, IN idate DATE, IN rdate DATE)
BEGIN
  IF EXISTS (SELECT * FROM IssueRecord WHERE IssueID=iid) THEN
    UPDATE IssueRecord SET BookID=bid, MemberID=mid, IssueDate=idate, ReturnDate=rdate WHERE IssueID=iid;
  ELSE
    INSERT INTO IssueRecord(BookID,MemberID,IssueDate,ReturnDate) VALUES(bid,mid,idate,rdate);
  END IF;
END //
DELIMITER ;
