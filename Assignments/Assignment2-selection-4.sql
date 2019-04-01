#1 Find all films with maximum length or minimum rental duration (compared to all other films). 
#In other words let L be the maximum film length, and let R be the minimum rental duration in the table film. You need to find all films that have length L or duration R or both length L and duration R.
#You just need to return attribute film id for this query. 
SELECT title FROM film
WHERE 
	length=(SELECT MAX(length) FROM film) 
OR 
	rental_duration=(SELECT MIN(rental_duration) FROM film);

#2 We want to find out how many of each category of film ED CHASE has started in so return a table with category.name and the count
#of the number of films that ED was in which were in that category order by the category name ascending (Your query should return every category even if ED has been in no films in that category).

SELECT category.name, COUNT(D.f) from category
INNER JOIN film_category fc ON fc.category_id = category.category_id
LEFT JOIN (SELECT catgr.name AS n, film.film_id AS f from film
INNER JOIN film_actor fa ON fa.film_id = film.film_id
INNER JOIN actor ON actor.actor_id = fa.actor_id
INNER JOIN film_category fc ON fc.film_id = film.film_id
INNER JOIN category catgr ON catgr.category_id = fc.category_id
WHERE actor.first_name = "ED" AND actor.last_name = "CHASE") AS D
ON  D.f = fc.film_id
GROUP BY category.name;

#3 Find the first name, last name and total combined film length of Sci-Fi films for every actor
#That is the result should list the names of all of the actors(even if an actor has not been in any Sci-Fi films)and the total length of Sci-Fi films they have been in.
SELECT ea.first_name AS FirstName, ea.last_name AS LastName, t.total AS Total
FROM (
   SELECT a.first_name, a.last_name, a.actor_id
   FROM actor a
) AS ea
LEFT JOIN (
   SELECT a.first_name, a.last_name, a.actor_id, SUM(f.length) AS total, c.name
   FROM category c
   INNER JOIN film_category fc ON c.category_id = fc.category_id
   INNER JOIN film f ON fc.film_id = f.film_id
   INNER JOIN film_actor fa ON f.film_id = fa.film_id
   INNER JOIN actor a ON fa.actor_id = a.actor_id
   WHERE c.name = 'Sci-Fi'
   GROUP BY a.actor_id
) AS t ON ea.actor_id = t.actor_id;


#4 Find the first name and last name of all actors who have never been in a Sci-Fi film

SELECT a.first_name AS FirstName, a.last_name AS LastName
FROM actor a
WHERE a.actor_id NOT
IN (
    SELECT a.actor_id
    FROM film f
    INNER JOIN film_category fc ON f.film_id = fc.film_id
    INNER JOIN category c ON fc.category_id = c.category_id
    INNER JOIN film_actor fa ON f.film_id = fa.film_id
    INNER JOIN actor a ON fa.actor_id = a.actor_id
    WHERE c.name = 'Sci-Fi'
);



#5 Find the film title of all films which feature both KIRSTEN PALTROW and WARREN NOLTE
#Order the results by title, descending (use ORDER BY title DESC at the end of the query)
#Warning, this is a tricky one and while the syntax is all things you know, you have to think oustide
#the box a bit to figure out how to get a table that shows pairs of actors in movies



SELECT fi.title from film fi
INNER JOIN film_actor fa ON fa.film_id = fi.film_id
INNER JOIN actor a ON a.actor_id = fa.actor_id
WHERE a.first_name = "KIRSTEN" AND a.last_name = "PALTROW"
AND fi.film_id IN
(SELECT fi.film_id from film fi
INNER JOIN film_actor fa ON fa.film_id = fi.film_id
INNER JOIN actor a ON a.actor_id = fa.actor_id
WHERE a.first_name = "WARREN" AND a.last_name = "NOLTE")
ORDER BY fi.title DESC;