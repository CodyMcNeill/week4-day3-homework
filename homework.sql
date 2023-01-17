-- 1. List all customers who live in Texas (use 
-- JOINs) 
SELECT * FROM customer
INNER JOIN address
ON address.address_id = customer.address_id
WHERE address.district = 'Texas';

-- 2. Get all payments above $6.99 with the Customer's Full Name 
SELECT * FROM payment;

SELECT * FROM payment
RIGHT JOIN customer
ON payment.customer_id = customer.customer_id;

SELECT * FROM payment
RIGHT JOIN customer
ON payment.customer_id = customer.customer_id
WHERE payment.amount > 6.99;

-- 3. Show all customers names who have made payments over $175(use subqueries) 
SELECT * FROM customer;
SELECT * FROM payment WHERE amount > 175;

SELECT * FROM customer
WHERE customer_id IN (
    SELECT customer_id FROM payment
    WHERE amount > 175
);

-- 4. List all customers that live in Nepal (use the city 
-- table) 
SELECT * FROM city;
SELECT * FROM address;

SELECT * FROM customer
WHERE address_id IN (
    SELECT address_id from address
    WHERE city_id IN (
        SELECT city_id from city
        WHERE city = 'Nepal'
    )
);

-- 5. Which staff member had the most 
-- transactions? 
-- Staff with ID number 2, Jon

SELECT COUNT(payment_id) AS transactionNum, first_name FROM payment
LEFT JOIN staff
ON payment.staff_id = staff.staff_id
GROUP BY staff.first_name
ORDER BY 1 DESC;

-- 6. How many movies of each rating are 
-- there? 
-- 223 PG13, 209 NC17, 195 R, 194 PG, 178 G
SELECT rating FROM film;

SELECT COUNT(rating), rating FROM film
GROUP BY rating
ORDER BY 1 DESC;


-- 7.Show all customers who have made a single payment above $6.99 (Use Subqueries)

SELECT * FROM customer
WHERE customer_id IN (
    SELECT rental_id FROM rental);

SELECT * FROM payment;

SELECT * FROM customer
WHERE customer_id IN (
    SELECT COUNT(rental_id) FROM rental
    WHERE rental_id IN ( 
        SELECT amount FROM payment
        WHERE amount > 6.99
    )
);
-- This was insanely hard for me?


-- 8. How many free rentals did our stores give away?
-- 0 Rentals?

SELECT COUNT(rental_id) FROM rental;

SELECT * FROM payment
WHERE amount <= 0;

