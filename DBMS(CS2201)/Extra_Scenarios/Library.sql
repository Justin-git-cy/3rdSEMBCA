CREATE DATABASE lib;
Use lib;

CREATE TABLE Author (
  author_id INT PRIMARY KEY,
  author_name VARCHAR(50)
);

CREATE TABLE Publisher (
  publisher_id INT PRIMARY KEY,
  publisher_name VARCHAR(50)
);

CREATE TABLE Book (
  book_id INT PRIMARY KEY,
  title VARCHAR(100),
  author_id INT,
  publisher_id INT,
  price DECIMAL(8,2),
  FOREIGN KEY (author_id) REFERENCES Author(author_id),
  FOREIGN KEY (publisher_id) REFERENCES Publisher(publisher_id)
);

CREATE TABLE Member (
  member_id INT PRIMARY KEY,
  member_name VARCHAR(50)
);

CREATE TABLE Issue (
  issue_id INT PRIMARY KEY,
  book_id INT,
  member_id INT,
  FOREIGN KEY (book_id) REFERENCES Book(book_id),
  FOREIGN KEY (member_id) REFERENCES Member(member_id)
);


INSERT INTO Author VALUES (1,'J.K. Rowling'),(2,'Dan Brown'),(3,'George Orwell');
INSERT INTO Publisher VALUES (1,'Bloomsbury'),(2,'Penguin'),(3,'HarperCollins');
INSERT INTO Book VALUES (1,'Harry Potter',1,1,499.00),(2,'Inferno',2,2,399.00),(3,'1984',3,3,299.00);
INSERT INTO Member VALUES (1,'Alice'),(2,'Bob'),(3,'Charlie');
INSERT INTO Issue VALUES (1,1,1),(2,2,2),(3,3,1);

 SELECT b.title, a.author_name, p.publisher_name
   FROM Book b
   INNER JOIN Author a ON b.author_id = a.author_id
   INNER JOIN Publisher p ON b.publisher_id = p.publisher_id;

 SELECT p.publisher_name, b.title
   FROM Publisher p
   LEFT OUTER JOIN Book b ON p.publisher_id = b.publisher_id;

 SELECT m.member_name, COUNT(i.book_id) AS total_books_issued
   FROM Issue i
   INNER JOIN Member m ON i.member_id = m.member_id
   GROUP BY m.member_name;

 SELECT AVG(price) AS avg_book_price FROM Book;

 SELECT COUNT(*) AS total_books_issued FROM Issue;
