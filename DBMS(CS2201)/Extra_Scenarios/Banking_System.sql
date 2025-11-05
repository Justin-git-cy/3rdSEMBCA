CREATE DATABASE BankingDB;
USE BankingDB;

CREATE TABLE Customers (
  customer_id INT PRIMARY KEY,
  customer_name VARCHAR(100),
  phone VARCHAR(20),
  city VARCHAR(50)
);

CREATE TABLE Accounts (
  account_id INT PRIMARY KEY,
  customer_id INT,
  account_type VARCHAR(30), -- Savings, Current
  balance DECIMAL(14,2),
  opened_date DATE,
  FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Transactions (
  txn_id INT PRIMARY KEY,
  account_id INT,
  txn_date DATETIME,
  amount DECIMAL(12,2),
  txn_type VARCHAR(10), -- Debit/Credit
  description VARCHAR(255),
  FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);

INSERT INTO Customers VALUES
(1,'Manoj Kumar','+91-9999000001','Bangalore'),
(2,'Sara Ali','+91-9999000002','Saudi Arabia'),
(3,'Miguel Sanchez','+34-600000003','Barcelona');

INSERT INTO Accounts VALUES
(7001,1,'Savings',50000.00,'2022-05-20'),
(7002,2,'Savings',75000.00,'2023-02-10'),
(7003,3,'Current',120000.00,'2021-12-01');

INSERT INTO Transactions VALUES
(8001,7001,'2025-10-01 10:00:00',5000.00,'Credit','Salary'),
(8002,7001,'2025-10-05 15:30:00',2000.00,'Debit','ATM Withdrawal'),
(8003,7003,'2025-09-20 09:00:00',10000.00,'Credit','Invoice Payment'),
(8004,7002,'2025-10-02 12:00:00',1500.00,'Debit','POS Purchase');

-- Sum of transactions for an account (period)
SELECT account_id, SUM(CASE WHEN txn_type='Credit' THEN amount ELSE 0 END) AS total_credit,
       SUM(CASE WHEN txn_type='Debit' THEN amount ELSE 0 END) AS total_debit
FROM Transactions
WHERE txn_date BETWEEN '2025-10-01' AND '2025-10-31'
GROUP BY account_id;

-- Max, Min transaction amounts
SELECT MAX(amount) AS max_txn, MIN(amount) AS min_txn FROM Transactions;

-- Join customers and accounts
SELECT c.customer_name, a.account_id, a.account_type, a.balance
FROM Customers c
JOIN Accounts a ON c.customer_id = a.customer_id;

-- Procedure to insert transaction and update account balance
DELIMITER //
CREATE PROCEDURE InsertTransaction(
  IN tid INT, IN aid INT, IN tdate DATETIME, IN amt DECIMAL(12,2), IN ttype VARCHAR(10), IN descp VARCHAR(255)
)
BEGIN
  INSERT INTO Transactions VALUES (tid, aid, tdate, amt, ttype, descp);
  IF ttype = 'Credit' THEN
    UPDATE Accounts SET balance = balance + amt WHERE account_id = aid;
  ELSEIF ttype = 'Debit' THEN
    UPDATE Accounts SET balance = balance - amt WHERE account_id = aid;
  END IF;
END //
DELIMITER ;

-- Procedure to transfer between accounts (simple, no rollback shown)
DELIMITER //
CREATE PROCEDURE TransferFunds(IN from_a INT, IN to_a INT, IN amt DECIMAL(12,2))
BEGIN
  -- create debit txn
  INSERT INTO Transactions VALUES (NULL, from_a, NOW(), amt, 'Debit', CONCAT('Transfer to ', to_a));
  UPDATE Accounts SET balance = balance - amt WHERE account_id = from_a;
  -- create credit txn
  INSERT INTO Transactions VALUES (NULL, to_a, NOW(), amt, 'Credit', CONCAT('Transfer from ', from_a));
  UPDATE Accounts SET balance = balance + amt WHERE account_id = to_a;
END //
DELIMITER ;
