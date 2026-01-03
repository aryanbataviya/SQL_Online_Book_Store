-- ONLINE BOOK STORE

CREATE TABLE BOOKS(
  Book_ID INT PRIMARY KEY,
  Title VARCHAR(255),
  Author VARCHAR(255),
  Genre VARCHAR(100),
  Price DECIMAL(5,2),
  Stock INT,
  Published_Year INT
);


CREATE TABLE Customers(
  Customer_ID INT PRIMARY KEY,
  Customer_Name VARCHAR(255),
  Country VARCHAR(100),
  City VARCHAR(100)
);


CREATE TABLE Orders(
  Order_ID INT PRIMARY KEY,
  Customer_ID INT,
  Book_ID INT,
  Order_Date DATE,
  Quantity INT,
  Total_Amount DECIMAL(6,2),
  FOREIGN KEY(BOOK_ID) REFERENCES BOOKS(BOOK_ID),
  FOREIGN KEY(CUSTOMER_ID) REFERENCES CUSTOMERS(CUSTOMER_ID)
);



-- 1.Retrieve all books in the "Fiction" genre.
SELECT * FROM BOOKS
WHERE GENRE = "Fiction";

-- 2.Find books published after 1950
SELECT * FROM BOOKS
WHERE PUBLISHED_YEAR > 1950;

-- 3.List all customers from Canada
SELECT * FROM CUSTOMERS
WHERE COUNTRY = "CANADA";

-- 4.Show orders placed in November 2023
SELECT * FROM ORDERS
WHERE ORDER_DATE BETWEEN "2023-11-01" AND "2023-11-30";

-- 5.Retrieve total stock of books available
SELECT SUM(STOCK) FROM BOOKS;

-- 6.Find details of the most expensive book
SELECT * FROM BOOKS
WHERE PRICE = (SELECT MAX(PRICE) FROM BOOKS);

SELECT * FROM Books
ORDER BY Price DESC
LIMIT 1;

-- 7.Customers who ordered more than 1 quantity
SELECT DISTINCT Customer_ID
FROM Orders
WHERE Quantity > 1;

-- 8.Orders where total amount exceeds $20
SELECT * FROM Orders
WHERE Total_Amount > 20;

-- 9.List all genres available
SELECT DISTINCT GENRE FROM BOOKS;

-- 10.Find the book with lowest stock
SELECT * FROM Books
ORDER BY Stock ASC
LIMIT 1;

-- 11.Total revenue from all orders
SELECT SUM(Total_Amount) AS Total_Revenue
FROM Orders;

-- 12.Total books sold for each genre
SELECT b.Genre, SUM(o.Quantity) AS Total_Sold
FROM Orders o
JOIN Books b ON o.Book_ID = b.Book_ID
GROUP BY b.Genre;

-- 13.Average price of Fantasy books
SELECT AVG(Price) AS Avg_Price
FROM Books
WHERE Genre = 'Fantasy';

-- 14.Customers with at least 2 orders
SELECT Customer_ID
FROM Orders
GROUP BY Customer_ID
HAVING COUNT(Order_ID) >= 2;

-- 15.Most frequently ordered book
SELECT Book_ID, COUNT(*) AS Order_Count
FROM Orders
GROUP BY Book_ID
ORDER BY Order_Count DESC
LIMIT 1;

-- 16.Top 3 most expensive Fantasy books
SELECT * FROM Books
WHERE Genre = 'Fantasy'
ORDER BY Price DESC
LIMIT 3;

-- 17.Total quantity sold by each author
SELECT b.Author, SUM(o.Quantity) AS Total_Sold
FROM Orders o
JOIN Books b ON o.Book_ID = b.Book_ID
GROUP BY b.Author;

-- 18.Cities of customers who spent over $30
SELECT DISTINCT c.City
FROM Customers c
JOIN Orders o ON c.Customer_ID = o.Customer_ID
WHERE o.Total_Amount > 30;

-- 19.Customer who spent the most
SELECT c.Customer_Name, SUM(o.Total_Amount) AS Total_Spent
FROM Customers c
JOIN Orders o ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_Name
ORDER BY Total_Spent DESC
LIMIT 1;

-- 20.Stock remaining after fulfilling all orders
SELECT 
  b.Book_ID,
  b.Title,
  b.Stock - IFNULL(SUM(o.Quantity),0) AS Remaining_Stock
FROM Books b
LEFT JOIN Orders o ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Stock;















