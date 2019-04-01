  
USE sakila; 

-- Part 1 
SELECT first_name,last_name 
FROM actor; 

SELECT UPPER(CONCAT(first_name,' ',last_name)) AS 'Actor Name' 
FROM actor; 

-- Part 2 

SELECT actor_id, first_name, last_name 
FROM actor 
WHERE first_name='Joe';

SELECT actor_id, first_name, last_name 
FROM actor
WHERE last_name LIKE '%GEN%';

SELECT actor_id, first_name, last_name 
FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY last_name, first_name;

SELECT country_id, country
FROM country
WHERE country IN('Afghanistan', 'Bangladesh', 'China');

-- Part 3
ALTER TABLE actor
ADD COLUMN description BLOB AFTER last_update;

ALTER TABLE actor
DROP COLUMN description;

-- Part 4 
SELECT last_name, COUNT(*) as 'Last Name Count'   
FROM actor
GROUP BY last_name;

SELECT last_name, COUNT(*) as 'Last Name Count'   
FROM actor  
GROUP BY last_name
HAVING COUNT(*) >=2; 

-- PART 5 
SHOW CREATE TABLE address; 

-- PART 6

SELECT first_name, last_name, address    
FROM staff INNER JOIN address
ON staff.address_id = address.address_id;

SELECT first_name, last_name, SUM(amount) as 'Total Amount'
FROM staff INNER JOIN payment
ON staff.staff_id = payment.staff_id AND payment_date LIKE '2005-08%'
GROUP BY first_name, last_name;



-- Part 7 
SELECT title
FROM film
WHERE title 
LIKE 'K%' OR title LIKE 'Q%' 
AND title IN
	(
	SELECT title
	FROM film
	WHERE language_id IN
		(
		SELECT language_id 
		FROM language
		WHERE name ='English'
		)language
	); 

SELECT first_name, last_name
FROM actor
WHERE actor_id IN
	(
	SELECT actor_id
	FROM film_actor
	WHERE film_id IN
		(
		SELECT film_id
		FROM film
		WHERE title = 'Alone Trip'
		)
    );
	
SELECT first_name, last_name, email 
FROM customer 
JOIN address 
ON (customer.address_id = address.address_id)
JOIN city 
ON (city.city_id = address.city_id)
JOIN country
ON (country.country_id = city.country_id)
WHERE country.country= 'Canada';

SELECT title 
FROM film 
WHERE film_id IN 
	(
    SELECT film_id 
	FROM film_category 
    WHERE category_id IN 
		(
		SELECT category_id 
        FROM category 
        WHERE name='Family'
        )
    );

-- 7e. Display the most frequently rented movies in descending order.
SELECT title, COUNT(rental_id) as 'Rental Count'
FROM rental 
JOIN inventory
ON (rental.inventory_id = inventory.inventory_id)
JOIN film 
ON (inventory.film_id = film.film_id)
GROUP BY film.title

-- 7f. Write a query to display how much business, in dollars, each store brought in.
SELECT store.store_id, SUM(amount)
FROM store
INNER JOIN staff
ON store.store_id = staff.store_id
INNER JOIN payment 
ON payment.staff_id = staff.staff_id
GROUP BY store.store_id;

-- 7g. Write a query to display for each store its store ID, city, and country.
SELECT store_id, city, country
FROM store 
INNER JOIN address
ON store.address_id = address.address_id
INNER JOIN city
ON city.city_id = address.city_id
INNER JOIN country
ON country.country_id = city.country_id;


