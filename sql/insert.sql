
-- Re-create the cats table (I dropped it in a previous video)



CREATE TABLE cats (
    name VARCHAR(50),
    age INT
);


Insert a cat:

INSERT INTO cats (name, age) 
VALUES ('Blue Steele', 5);
And another:

INSERT INTO cats (name, age) 
VALUES ('Jenkins', 7);


CODE: Multi-inserts
-- Single insert (switching order of name and age)

INSERT INTO cats (age, name) 
VALUES 
  (2, 'Beth');


-- Multiple Insert:

INSERT INTO cats (name, age) 
VALUES 
  ('Meatball', 5), 
  ('Turkey', 1), 
  ('Potato Face', 15);


-- INSERT Challenge Solution Code

CREATE TABLE people
  (
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    age INT
  );


INSERT INTO people(first_name, last_name, age)
VALUES ('Tina', 'Belcher', 13);


INSERT INTO people(age, last_name, first_name)
VALUES (42, 'Belcher', 'Bob');


INSERT INTO people(first_name, last_name, age)
VALUES
    ('Linda', 'Belcher', 45),
    ('Phillip', 'Frond', 38),
    ('Calvin', 'Fischoeder', 70);
   

DROP TABLE people;



SELECT * FROM people;



SHOW TABLES;

Using NOT NULL:

CREATE TABLE cats2 (
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL
);

/**/
-- escape 
'mario\'s pizza'


/*

CODE: Adding DEFAULT Values
Define a table with a DEFAULT name specified:
*/
CREATE TABLE cats3  (    
    name VARCHAR(20) DEFAULT 'no name provided',    
    age INT DEFAULT 99  
);
Notice the change when you describe the table:

DESC cats3;

Insert a cat without a name:

INSERT INTO cats3(age) VALUES(13);

Or a nameless, ageless cat:

INSERT INTO cats3() VALUES();

Combine NOT NULL and DEFAULT:

CREATE TABLE cats4  (    
    name VARCHAR(20) NOT NULL DEFAULT 'unnamed',    
    age INT NOT NULL DEFAULT 99 
);

/*
CODE: Introducing Primary Keys
-- One way of specifying a PRIMARY KEY
/
CREATE TABLE unique_cats (
	cat_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL
);


-- Another option:


CREATE TABLE unique_cats2 (
	cat_id INT,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    PRIMARY KEY (cat_id)
);


/*CODE: Working With AUTO_INCREMENT
--  AUTO_INCREMENT

*/

CREATE TABLE unique_cats3 (
    cat_id INT AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    PRIMARY KEY (cat_id)
);


-- Defining employees table

CREATE TABLE employees (
    id INT AUTO_INCREMENT,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    middle_name VARCHAR(255),
    age INT NOT NULL,
    current_status VARCHAR(255) NOT NULL DEFAULT 'employed',
    PRIMARY KEY(id)
);
-- Another way of defining the primary key:



CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    middle_name VARCHAR(255),
    age INT NOT NULL,
    current_status VARCHAR(255) NOT NULL DEFAULT 'employed'
);
-- A test INSERT:



INSERT INTO employees(first_name, last_name, age) VALUES
('Dora', 'Smith', 58);
