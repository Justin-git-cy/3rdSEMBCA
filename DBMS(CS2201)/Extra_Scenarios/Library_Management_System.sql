CREATE DATABASE LibraryDB;
USE LibraryDB;

CREATE TABLE Books (
  book_id INT PRIMARY KEY,
  title VARCHAR(200),
  author VARCHAR(100),
  published_year INT,
  available_copies INT
);

CREATE TABLE Members (
  member_id INT PRIMARY KEY,
  member_name VARCHAR(100),
  join_date DATE,
  email VARCHAR(100)
);

CREATE TABLE Issues (
  issue_id INT PRIMARY KEY,
  book_id INT,
  member_id INT,
  issue_date DATE,
  return_date DATE,
  returned BOOLEAN DEFAULT FALSE,
  FOREIGN KEY (book_id) REFERENCES Books(book_id),
  FOREIGN KEY (member_id) REFERENCES Members(member_id)
);

INSERT INTO Books VALUES
(1,'Introducción a Bases de Datos','Diego López',2019,4),
(2,'Algorithms Unlocked','Thomas Cormen',2013,2),
(3,'Web Design Basics','Aiko Sato',2020,1),
(4,'Data Science for Everyone','Chen Wei',2021,3);

INSERT INTO Members VALUES
(11,'Sofia Martinez','2024-01-15','sofia.m@gmail.com'),
(12,'Arjun Verma','2023-09-20','arjun.v@gmail.com'),
(13,'Lucas Muller','2025-02-01','lucas.m@gmail.com'),
(14,'Maria Fernández','2024-05-10','maria.f@gmail.com');

INSERT INTO Issues VALUES
(201,1,11,'2025-10-01',NULL,FALSE),
(202,2,11,'2025-09-01','2025-09-21',TRUE),
(203,3,12,'2025-10-05',NULL,FALSE),
(204,4,13,'2025-10-10',NULL,FALSE);

SELECT m.member_id, m.member_name, COUNT(i.issue_id) AS total_issued
FROM Members m
LEFT JOIN Issues i ON m.member_id = i.member_id
GROUP BY m.member_id, m.member_name
ORDER BY total_issued DESC;

SELECT i.issue_id, m.member_name, b.title, i.issue_date, i.return_date,
       DATEDIFF(CURDATE(), i.issue_date) AS days_since_issue
FROM Issues i
JOIN Members m ON i.member_id = m.member_id
JOIN Books b ON i.book_id = b.book_id
WHERE i.returned = FALSE AND DATE_ADD(i.issue_date, INTERVAL 14 DAY) < CURDATE();

DELIMITER //
CREATE PROCEDURE UpdateBookAvailability(IN bid INT, IN delta INT)
BEGIN
  UPDATE Books SET available_copies = available_copies + delta WHERE book_id = bid;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE IssueBook(IN iid INT, IN bid INT, IN mid INT, IN idate DATE)
BEGIN
  DECLARE copies INT;
  SELECT available_copies INTO copies FROM Books WHERE book_id = bid;
  IF copies > 0 THEN
    INSERT INTO Issues VALUES (iid, bid, mid, idate, NULL, FALSE);
    UPDATE Books SET available_copies = available_copies - 1 WHERE book_id = bid;
  ELSE
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No copies available';
  END IF;
END //
DELIMITER ;
