USE sakila;

-- LAB 2.7
-- 1. How many films are there for each of the categories in the category table. Use appropriate join to write this query.
SELECT c.name AS category_name, COUNT(fc.film_id) AS film_count
FROM category c
JOIN film_category fc
ON fc.category_id = c.category_id
GROUP BY c.name;

-- 2. Display the total amount rung up by each staff member in August of 2005.
SELECT SUM(p.amount) as total_money, s.staff_id AS staff_member
FROM payment p
JOIN staff s
ON s.staff_id = p.staff_id
WHERE p.payment_date LIKE '2005-08%'
GROUP BY s.staff_id;

-- 3. Which actor has appeared in the most films?
SELECT COUNT(fa.film_id) AS amount_of_films, CONCAT(a.first_name, ' ', a.last_name) AS actor_name
FROM film_actor fa
JOIN actor a
ON fa.actor_id = a.actor_id
GROUP BY actor_name
ORDER BY amount_of_films DESC
LIMIT 1;

-- 4. Most active customer (the customer that has rented the most number of films)
-- c.active is a boolean (1 is true, 0 is false)
SELECT CONCAT(c.first_name, ' ', c.last_name) AS top_customer, COUNT(r.rental_id) AS rental_amount
FROM customer c
JOIN rental r
ON r.customer_id = c.customer_id
WHERE c.active
GROUP BY c.customer_id 
ORDER BY rental_amount DESC
LIMIT 1;

-- 5. Display the first and last names, as well as the address, of each staff member.
SELECT s.staff_id AS id, CONCAT(s.first_name, ' ', s.last_name) AS staff_name, a.address AS address
FROM staff s
JOIN address a
ON a.address_id = s.address_id
GROUP BY s.staff_id;

-- 6. List each film and the number of actors who are listed for that film.
SELECT f.title, COUNT(fa.actor_id) AS number_of_actors
FROM film f
JOIN film_actor fa
ON f.film_id = fa.film_id
GROUP BY f.title;

-- 7. Using the tables payment and customer and the JOIN command, list the total paid by each customer. 
-- List the customers alphabetically by last name.
SELECT CONCAT(c.first_name, ' ', c.last_name) AS customer_name, SUM(p.amount) AS total_amount_paid
FROM payment p
JOIN customer c
ON p.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY c.last_name ASC;

-- 8. List the titles of films per category.
-- double join to get the titles
SELECT DISTINCT f.title as movie_title, c.name as movie_category
FROM film f
JOIN film_category fc USING(film_id)
JOIN category as c
ON c.category_id = fc.category_id
ORDER BY c.name;

-- ALT: grouping to get number of movies per category (previous iteration)
-- SELECT c.name as movie_category, COUNT(f.title) as movie_title
-- FROM film f
-- JOIN film_category fc USING(film_id)
-- JOIN category as c
-- ON c.category_id = fc.category_id
-- GROUP BY c.name;