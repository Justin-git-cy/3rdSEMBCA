-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Lab Experiment 02: Program 02 - Implementation of DML Commands in SQL ( INSERT , SELECT, UPDATE and DELETE )
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- STUDENT NAME: Justin
-- USN: 1Rua24BCA0041
-- SECTION: -
-- -----------------------------------------------------------------------------------------------------------------------------------------
SELECT USER(), 
       @@hostname AS Host_Name, 
       VERSION() AS MySQL_Version, 
       NOW() AS Current_Date_Time;

-- Paste the Output below by execution of above command
-- 'root@localhost', 'DESKTOP-MOFLSB2', '8.4.6', '2025-09-01 11:28:13'


-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Scenario: You are managing a database for a library with two tables: Books and Members.
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Task 01: Create Tables [ Check the below mentioned Instructions:
-- Create the Books and Members tables with the specified structure.
-- Books Table and Member Table : 
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Write the SQL Query below for above mentioned task with the Instructed Column in the session 
Create database library;
use library;

CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    published_year INT,
    available_copies INT,
    total_copies INT
);

CREATE TABLE Members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    membership_type VARCHAR(50),
    join_date DATE
);

DESC Books;
DESC Members;


-- Paste the Output below for the given command ( DESC TableName;) 
-- book_id	int	NO	PRI		auto_increment
-- title	varchar(255)	NO			
-- author	varchar(255)	NO			
-- published_year	int	YES			
-- available_copies	int	YES			
-- total_copies	int	YES			

-- 'member_id', 'int', 'NO', 'PRI', NULL, 'auto_increment'
-- 'name', 'varchar(255)', 'NO', '', NULL, ''
-- 'membership_type', 'varchar(50)', 'YES', '', NULL, ''
-- 'join_date', 'date', 'YES', '', NULL, ''

-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Task 02: Insert a New Book
-- Instructions: Insert a book titled "1984_The Black Swan" by George Orwell (published in 1949) with 04 available copies and 10 Total copies. 
-- Populate other fields as needed.
-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Write the SQL Query below for above mentioned task.
INSERT INTO Books (title, author, published_year, available_copies, total_copies)
VALUES ('1984_The Black Swan', 'George Orwell', 1949, 4, 10);

SELECT * FROM Books;


-- Paste the Output below for the given command ( SELECT * FROM TABLE_NAME ).

-- '1', '1984_The Black Swan', 'George Orwell', '1949', '4', '10'


-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Task 03: Add New Members
-- Instructions: Insert two members: David Lee (Platinum, joined 2024-04-15) and Emma Wilson (Silver, joined 2024-05-22).
-- Populate other fields as needed.
-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Write the SQL Query below for above mentioned task.

INSERT INTO Members (name, membership_type, join_date)
VALUES ('Emma', 'Platinum', '2024-04-15'),
       ('Ashlyn', 'Silver', '2024-05-22');

SELECT * FROM Members;





-- Paste the Output below for the given command ( SELECT * FROM TABLE_NAME ).
-- '1', 'Emma', 'Platinum', '2024-04-15'
-- '2', 'Ashlyn', 'Silver', '2024-05-22'


-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Task 04: Update Book Details 
-- Instructions: The library acquired 2 additional copies of "1984_The Black Swan". Update the Books table.
-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Write the SQL Query below for above mentioned task.

UPDATE Books 
SET available_copies = available_copies + 2, 
    total_copies = total_copies + 2 
WHERE book_id = 1; 

SELECT * FROM Books;

-- Paste the Output below for the given command ( SELECT * FROM TABLE_NAME ).
-- '1', '1984_The Black Swan', 'George Orwell', '1949', '6', '12'

-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Task 05: Modify a Member's Information
-- Instructions: Update a member's membership type. Emma Wilson has upgraded her membership from 'Silver' to 'Gold'.
-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Write the SQL Query below for above mentioned task.
UPDATE Members
SET membership_type = 'Gold'
WHERE member_id = 2;  

select * FROM MEMBERS;

-- Paste the Output below for the given command ( SELECT * FROM TABLE_NAME ).

-- '1', 'Emma', 'Platinum', '2024-04-15'
-- '2', 'Ashlyn', 'Gold', '2024-05-22'


-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Task 06: Remove a Member
-- Instructions: Delete David Lee’s record from the Members table.
-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Write the SQL Query below for above mentioned task.

DELETE FROM Members
WHERE member_id = 2; 

SELECT * FROM Members;

-- Paste the Output below for the given command ( SELECT * FROM TABLE_NAME ).

-- '1', 'Emma', 'Platinum', '2024-04-15'

-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Task 09: Borrowing Table 
-- Instructions: Create a Borrowing table with foreign keys referencing Books and Members.
-- Subtask 1: Borrow a Book
-- Scenario:Emma Wilson (member_id = 2) borrows the book "The Catcher in the Rye" (book_id = 102) on 2024-06-01. Insert this record into the Borrowing table.
-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Write the SQL Query below for above mentioned task.

CREATE TABLE Borrowing (
    borrow_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT,
    book_id INT,
    borrow_date DATE,
    return_date DATE,
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

INSERT INTO Members (member_id, name, membership_type, join_date)
VALUES (2, 'Emma Wilson', 'Gold', '2024-05-22');

INSERT INTO Books (book_id, title, author, published_year, available_copies, total_copies)
VALUES (102, 'The Catcher in the Rye', 'J.D. Salinger', 1951, 5, 10);

INSERT INTO Borrowing (member_id, book_id, borrow_date)
VALUES (2, 102, '2024-06-01');


SELECT * FROM Borrowing;






-- Paste the Output below for the given command ( SELECT * FROM TABLE_NAME ).

-- '4', '2', '102', '2024-06-01', NULL


-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Task 10: Find the name of Borrower who book = 102 [ Advance and Optional ]
-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Write the SQL Query below for above mentioned task.

SELECT M.name
FROM Borrowing B
JOIN Members M ON B.member_id = M.member_id
WHERE B.book_id = 102;

select *from Borrowing;





-- Paste the Output below for the given command ( SELECT * FROM TABLE_NAME ).
-- 'Emma Wilson'




-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Final Task 00: ER Diagram - Instructions:
-- Draw an ER diagram for the library database. Additional Upload the scanned copy of the created ER Daigram in the Google Classroom.



-- END of the Task -- 