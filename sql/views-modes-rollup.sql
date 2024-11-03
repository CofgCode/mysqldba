-- INSTEAD OF TYPING THIS QUERY ALL THE TIME...
SELECT 
    title, released_year, genre, rating, first_name, last_name
FROM
    reviews
        JOIN
    series ON series.id = reviews.series_id
        JOIN
    reviewers ON reviewers.id = reviews.reviewer_id;
 
-- WE CAN CREATE A VIEW:
CREATE VIEW full_reviews AS
SELECT title, released_year, genre, rating, first_name, last_name FROM reviews
JOIN series ON series.id = reviews.series_id
JOIN reviewers ON reviewers.id = reviews.reviewer_id;
 
-- NOW WE CAN TREAT THAT VIEW AS A VIRTUAL TABLE 
-- (AT LEAST WHEN IT COMES TO SELECTING)
SELECT * FROM full_reviews;

-- solo algunas vistas se pueden update DELETE
--NO SE PUEDE  JOIN, DISTINCT, GROUPS HAVING UNION,

CREATE VIEW ordered_series AS
SELECT * FROM series ORDER BY released_year;
 
CREATE OR REPLACE VIEW ordered_series AS
SELECT * FROM series ORDER BY released_year DESC;
 
ALTER VIEW ordered_series AS
SELECT * FROM series ORDER BY released_year;
 
DROP VIEW ordered_series;


------


SELECT 
    title, 
    AVG(rating),
    COUNT(rating) AS review_count
FROM full_reviews 
GROUP BY title HAVING COUNT(rating) > 1;

/**********************/
--- ROLLUP

-- SOLO FUNCIONA CON GROUP BY---
-- GENERA UN SUBTOTAL GENERAL O POR DATOS QUE SE AGRUPEN 

SELECT     title, AVG(rating)
FROM    full_reviews
GROUP BY title WITH ROLLUP;
 
 
SELECT     title, COUNT(rating)
FROM    full_reviews
GROUP BY title WITH ROLLUP;
 
 
SELECT     first_name, released_year, genre, AVG(rating)
FROM    full_reviews
GROUP BY released_year , genre , first_name WITH ROLLUP;


--- SQL MODES 

-- To View Modes:
SELECT @@GLOBAL.sql_mode;
SELECT @@SESSION.sql_mode;
 
-- To Set Them:
SET GLOBAL sql_mode = 'modes';
SET SESSION sql_mode = 'modes';


SHOW WARNINGS;

DEFAULT IN SQL8.0*
SET SESSION sql_mode = 'STRICT_TRANS_TABLES';
SET SESSION sql_mode = 'ONLY_FULL_GROUP_BY';




