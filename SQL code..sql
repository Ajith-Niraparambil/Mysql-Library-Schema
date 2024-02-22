-- Create a Database name Library;
CREATE DATABASE Library;
USE Library;

-- Create branch table
CREATE TABLE New_Branch(
Branch_no INT PRIMARY KEY,
Manager_id INT,
Branch_address VARCHAR(100),
Contact_no VARCHAR(20)
);
-- Insert sample data into the Branch table
INSERT INTO New_Branch(Branch_no,Manager_id,Branch_address,Contact_no)
VALUES (1,301,'001sec.4','0042451265'),
       (2,302,'002sec.5','0042457896'),
       (3,303,'003sec.6','0042453245');
       
-- Create employee table
CREATE TABLE Employee (
Emp_id INT PRIMARY KEY,
Employee_name VARCHAR(50),
Position VARCHAR (20),
Salary DECIMAL (10,2),
Branch_no INT ,
FOREIGN KEY (Branch_no) REFERENCES New_Branch(Branch_no)
);
-- Insert data into the Employee table
INSERT INTO Employee (Emp_id,Employee_name,Position,Salary,Branch_no)
VALUES (010,'D.lawrence','Special assistant',48000.00,2),
       (011,'M.wade','Library associate',30000.00,1),
       (012,'T.david','Service specialist',40000.00,2);  

-- Create Customer table
CREATE TABLE Customer (
Customer_id INT PRIMARY KEY,
Customer_name VARCHAR(50),
Customer_address VARCHAR(100),
Reg_date DATE 
);
-- Insert data into the Customer table
INSERT INTO Customer (Customer_id,Customer_name,Customer_address,Reg_date)
VALUES (701,'McAndrew','Man srt7','2022-07-25'),
       (702,'Steven Smith','Aus srt4','2022-12-4'),
       (703,'James Vince','New srt9','2023-01-12');

-- Create Books table
CREATE TABLE Books (
ISBN VARCHAR(20) PRIMARY KEY,
Book_title VARCHAR(100),
Category VARCHAR(100),
Rental_price DECIMAL(10,2),
Status ENUM('yes','no'),
Author VARCHAR(50),
Publisher VARCHAR(50)
);
-- Insert data into the Books table
INSERT INTO Books (ISBN,Book_title,Category,Rental_price,Status,Author,Publisher)
VALUES ('ISBN012','Book1','Horror',20.90,'yes','David Fincher','Yellow Publisher'),
       ('ISBN013','Book2','Romance',25.50,'no','Woody Allen','Green Publisher'),
       ('ISBN014','Book3','Fantasy',27.60,'no','James Cameron','Red Publisher'),
       ('ISBN015','Book4','Thriller',35.80,'yes','Christopher Nolan','Blue Publisher');
       
-- Create Issue Status table
CREATE TABLE IssueStatus (
Issued_id INT PRIMARY KEY,
Issued_cust INT,
Issued_book_name VARCHAR(100),
Issue_date DATE,
isbn_book VARCHAR(100),
FOREIGN KEY (Issued_cust) REFERENCES Customer (Customer_id),
FOREIGN KEY (isbn_book) REFERENCES Books(ISBN)
);

-- Create ReturnStatus table
CREATE TABLE ReturnStatus (
Return_id INT PRIMARY KEY,
Return_cust INT,
Return_book_name VARCHAR(100),
Return_date DATE,
isbn_book2 VARCHAR(100),
FOREIGN KEY (isbn_book2) REFERENCES Books(ISBN)
);


-- 1. Retrieve the book title, category, and rental price of all available books
SELECT Book_title, Category, Rental_price
FROM Books WHERE Status = 'yes';

-- 2. List the employee names and their respective salaries in descending order of salary.
SELECT Employee_name, Salary
FROM Employee
ORDER BY Salary DESC;

-- 3. Retrieve the book titles and the corresponding customers who have issued those books.
SELECT b.Book_title, c.Customer_name
FROM IssueStatus i
JOIN Books b ON i.Isbn_book = b.ISBN
JOIN Customer c ON i.Issued_cust = c.Customer_Id;

-- 4. Display the total count of books in each category.
SELECT Category, COUNT(*) AS Total_Count
FROM Books
GROUP BY Category;

-- 5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.
SELECT Employee_name, Position
FROM Employee
WHERE Salary > 45000;

-- 6. List the customer names who registered before 2022-01-01 and have not issued any books yet.
SELECT Customer_name
FROM Customer
WHERE Reg_date < '2022-08-01'
AND Customer_Id NOT IN (SELECT Issued_cust FROM IssueStatus);

-- 7. Display the branch numbers and the total count of employees in each branch.
SELECT e.Branch_no, COUNT(*) AS Total_Employees
FROM Employee e
GROUP BY e.Branch_no;

-- 8. Display the names of customers who have issued books in the month of June 2023.
SELECT DISTINCT c.Customer_name
FROM IssueStatus i
JOIN Customer c ON i.Issued_cust = c.Customer_Id
WHERE MONTH(i.Issue_date) = 6 AND YEAR(i.Issue_date) = 2023;

-- 9. Retrieve book_title from book table containing horror.
SELECT Book_title
FROM Books
WHERE Category = 'Horror';

-- 10.Retrieve the branch numbers along with the count of employees forbranches having more than 5 employees.
SELECT e.Branch_no, COUNT(*) AS Total_Employees
FROM Employee e
GROUP BY e.Branch_no
HAVING Total_Employees > 5;























       
       
