USE sakila;
#Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

SELECT * 
FROM film;
SELECT * 
FROM inventory;
(SELECT film_id
FROM film
WHERE title = "Hunchback Impossible");

SELECT COUNT(i.film_id) as count_of_copies
FROM inventory i
WHERE i.film_id =(SELECT f.film_id
				FROM film f
                WHERE f.title = "Hunchback Impossible");
                
 #2 List all films whose length is longer than the average length of all the films in the Sakila database.  
SELECT *  
FROM sakila.film
WHERE length > (SELECT AVG(length)
                FROM sakila.film);		
 
 #Use a subquery to display all actors who appear in the film "Alone Trip".
SELECT film_id.film_id
FROM film f
WHERE f.title = "Alone Trip";

 SELECT * 
 FROM actor a
 WHERE actor_id IN(SELECT actor_id
 FROM film_actor fa
 WHERE fa.film_id = (SELECT f.film_id 
                     FROM film f
                     WHERE f.title = "Alone Trip"));
 
 #4 Sales have been lagging among young families, and you want to target family movies for a promotion. 
 #Identify all movies categorized as family films.
 SELECT*
 FROM category;
 SELECT *
 FROM sakila.film;
 
 SELECT *
 FROM film
 JOIN film_category on film.film_id = film_category.film_id 
 WHERE category_id = 
	(SELECT category_id FROM category WHERE name = "family");
    #OR
SELECT *
 FROM film
 JOIN film_category on film.film_id = film_category.film_id 
 WHERE category_id = 8;
 
#5 Retrieve the name and email of customers from Canada using both subqueries and joins. 
#To use joins, you will need to identify the relevant tables and their primary and foreign keys.
SELECT *
FROM customer;
SELECT *
FROM address;
SELECT *
FROM city;
SELECT*
FROM country;
SELECT customer.first_name, customer.last_name, customer.email,address.address_id, country.country_id
FROM customer
JOIN address using (address_id)
JOIN city using (city_id)
JOIN country using (country_id)
WHERE country_id = 20;
#OR
SELECT customer.first_name, customer.last_name, customer.email,address.address_id, country.country_id
FROM customer
JOIN address using (address_id)
JOIN city using (city_id)
JOIN country using (country_id)
WHERE country_id = (SELECT country_id FROM country WHERE country = "Canada");
SELECT *
FROM country;

#6
SELECT *
FROM actor;
SELECT *
FROM film_actor;
SELECT *
FROM film;

SELECT actor_id, COUNT(*) AS film_count
FROM film_actor
GROUP BY actor_id
ORDER BY film_count DESC;
SELECT *
FROM actor;

SELECT film.film_id, film.title, first_name, last_name
FROM film
JOIN film_actor using (film_id)
JOIN actor using (actor_id)
WHERE actor_id = 107;


SELECT film.film_id, film.title, first_name, last_name
FROM film
JOIN film_actor using (film_id)
JOIN actor using (actor_id)
WHERE actor_id = (SELECT actor_id FROM actor WHERE first_name = "GINA") AND last_name = "DEGENERES";