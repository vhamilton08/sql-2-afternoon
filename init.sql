-- sql-afternoon-2
-- practice joins

--#1
SELECT * FROM invoice i
JOIN invoice_line il ON il.invoice_id =i.invoice_id
WHERE il.unit_price > 0.99;
--#2
SELECT invoice_date, first_name, last_name, total FROM invoice
JOIN customer ON invoice.customer_id = customer.customer_id;
--#3
SELECT c.first_name, c.last_name, e.first_name, e.last_name 
FROM customer c
JOIN employee e ON c.support_rep_id = e.employee_id;
--#4
SELECT a.title, ar.name
FROM album a
JOIN artist ar
ON a.artist_id = ar.artist_id;
--#5
SELECT pt.track_id 
FROM playlist_track pt
JOIN playlist p
ON p.playlist_id = pt.playlist_id
WHERE p.name = 'Music';
--#6
SELECT t.name 
FROM track t
JOIN playlist_track p
ON p.track_id = t.track_id
WHERE p.playlist_id = 5;
--#7
SELECT t.name, p.name
FROM track t
JOIN playlist_track pt 
ON t.track_id = pt.track_id
JOIN playlist p
ON pt.playlist_id = p.playlist_id;
--#8
SELECT t.name, a.title
FROM track t
JOIN genre g
ON t.genre_id = g.genre_id
JOIN album a 
ON a.album_id = t.album_id
WHERE g.name = 'Alternative & Punk';
--Practice nested queries
--#1
SELECT *
FROM invoice
WHERE invoice_id IN (SELECT invoice_id
FROM invoice_line                   
WHERE unit_price > 0.99);
--#2
SELECT * 
FROM playlist_track
WHERE playlist_id IN (SELECT playlist_id
FROM playlist
WHERE name = 'Music');
--#3
SELECT name
FROM track
WHERE track_id In (SELECT track_id
FROM playlist_track
WHERE playlist_id = 5);
--4
SELECT *
FROM track 
WHERE genre_id IN (SELECT genre_id
FROM genre WHERE name = 'Comedy');
--#5
SELECT * 
FROM track 
WHERE album_id IN (SELECT album_id
FROM album
WHERE title = 'Fireball');
--#6
   SELECT * 
FROM track
WHERE album_id IN (SELECT album_id
FROM album WHERE artist_id IN (SELECT
artist_id FROM artist 
WHERE name = 'Queen'));
--Practice updating Rows
--#1
UPDATE customer
SET fax = null        
WHERE fax IS NOT NULL;
--#2
UPDATE customer
SET company = 'Self'
WHERE company IS null;
--#3
UPDATE customer
SET last_name = 'Thompson'
WHERE first_name = 'Julia' AND last_name = 'barnett'; 
--#4
UPDATE customer 
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl';
--#5
UPDATE track
SET composer = 'The darkness around us'
WHERE genre_id = (SELECT genre_id
FROM genre WHERE name = 'Metal')
AND composer IS null;
--Group by
--#1
SELECT COUNT(*), g.name
FROM track t
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY g.name;
--#2
SELECT COUNT(*), g.name
FROM track t
JOIN genre g ON g.genre_id = t.genre_id
WHERE g.name = 'Pop' OR g.name = 'Rock'
GROUP BY g.name
--#3
SELECT a.name, COUNT(*) 
FROM album al
JOIN artist a ON al.artist_id = a.artist_id
GROUP BY a.name;
--USE Distinct
--#1
SELECT DISTINCT composer
FROM track;
--#2
SELECT DISTINCT billing_postal_code
FROM invoice;
--#3
SELECT DISTINCT company
FROM customer;
--Delete Rows
--#2
DELETE FROM practice_delete
WHERE type = 'bronze';
--#3
DELETE FROM practice_delete
WHERE type = 'silver';
--#4
DELETE FROM practice_delete
WHERE value = 150;
--ecommerce simulation
CREATE TABLE users(
user_id SERIAL PRIMARY KEY,
name VARCHAR(50),
email VARCHAR(55))

 INSERT INTO users (name, email)
 VALUES
('Bob', 'bob@yelo.com'),
('Joe', 'joebob@skerp.co'),
('Cortana', 'cool@asdf.tv');


CREATE TABLE products(
  product_id SERIAL PRIMARY KEY,
  name VARCHAR(40),
  price INTEGER)

INSERT INTO products (name, price)
  VALUES
  ('hotdog', 3),
  ('apple', 10),
  ('tea', 100)

  CREATE TABLE orders(
  order_id SERIAL PRIMARY KEY,
  product_id INT REFERENCES products(product_id));

  INSERT INTO orders (product_id)
VALUES
(1, 2),
(3),
(2)

--products from 1st order
SELECT *
FROM orders
JOIN products 
ON orders.product_id = 1 AND products.product_id = 1
--get all orders
SELECT * FROM orders
--total cost of an order
--add a foreign key reference
ALTER TABLE orders 
ADD COLUMN user_id INT REFERENCES users(user_id)
--update orders table to link a user to each order
SELECT * FROM orders 
JOIN users ON orders.user_id = users.user_id
--get all orders for a user
SELECT * FROM orders
WHERE user_id IN (SELECT user_id
FROM users WHERE user_id = 2)
--get how many orders each user has
COUNT(*), orders 
WHERE user_id IN (SELECT user_id
FROM users WHERE orders.user_id = user.user_id)
