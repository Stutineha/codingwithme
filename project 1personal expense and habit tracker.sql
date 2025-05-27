create database pizzashop;
use pizzashop;
drop database if exists pizzashop;
create database health;
use health;
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE
);
CREATE TABLE Expenses (
    expense_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    date DATE,
    amount DECIMAL(10, 2),
    category VARCHAR(50),
    payment_method VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
CREATE TABLE Habits (
    habit_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    habit_name VARCHAR(100),
    date DATE,
    status ENUM('done', 'missed'),
    notes TEXT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
CREATE TABLE Goals (
    goal_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    goal_type ENUM('savings', 'habit_streak'),
    description VARCHAR(255),
    target_value DECIMAL(10, 2),
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);-- Users
INSERT INTO Users (name, email)
VALUES ('Alice Sharma', 'alice@example.com'),
       ('Ravi Kumar', 'ravi@example.com');

-- Expenses
INSERT INTO Expenses (user_id, date, amount, category, payment_method)
VALUES 
(1, '2025-05-01', 200.00, 'Food', 'Cash'),
(1, '2025-05-03', 100.00, 'Transport', 'Card'),
(1, '2025-05-05', 300.00, 'Entertainment', 'Card'),
(2, '2025-05-02', 150.00, 'Food', 'Cash');

-- Habits
INSERT INTO Habits (user_id, habit_name, date, status, notes)
VALUES 
(1, 'Exercise', '2025-05-01', 'done', 'Jogged 2 km'),
(1, 'Exercise', '2025-05-02', 'missed', 'Busy day'),
(1, 'Reading', '2025-05-02', 'done', 'Read 10 pages'),
(2, 'Meditation', '2025-05-03', 'done', '5 minutes');

-- Goals
INSERT INTO Goals (user_id, goal_type, description, target_value, start_date, end_date)
VALUES 
(1, 'savings', 'Save at least ₹2000 this month', 2000.00, '2025-05-01', '2025-05-31'),
(1, 'habit_streak', 'Exercise daily for a week', 7, '2025-05-01', '2025-05-07');

select*from habits;
select*from goals;
select*from expenses;

SELECT category, SUM(amount) AS total_spent
FROM Expenses
WHERE user_id = 1 AND MONTH(date) = MONTH(CURDATE())
GROUP BY category;

SELECT habit_name, COUNT(*) AS days_done
FROM Habits
WHERE user_id = 1 AND status = 'done'
GROUP BY habit_name;


SELECT habit_name, COUNT(*) AS streak
FROM Habits
WHERE user_id = 1 AND status = 'done'
GROUP BY habit_name
ORDER BY streak DESC
LIMIT 1;

CREATE VIEW Monthly_Expense_Report AS
SELECT user_id, category, SUM(amount) AS monthly_total
FROM Expenses
WHERE MONTH(date) = MONTH(CURDATE()) AND YEAR(date) = YEAR(CURDATE())
GROUP BY user_id, category;


SELECT category, SUM(amount) AS total_spent
FROM Expenses
WHERE user_id = 1 AND MONTH(date) = MONTH(CURDATE())
GROUP BY category;