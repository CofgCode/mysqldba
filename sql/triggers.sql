The Syntax
CREATE TRIGGER trigger_name 
    trigger_time trigger_event ON table_name FOR EACH ROW
    BEGIN
    ...
    END;
	
	
---trigger_time     
BEFORE

AFTER

--- trigger_event 
INSERT

UPDATE

DELETE

 ---ON     table_name  
 
 
photos

users

	
	
xample 1
A Simple Validation

DELIMITER $$

CREATE TRIGGER must_be_adult
     BEFORE INSERT ON users FOR EACH ROW
     BEGIN
          IF NEW.age < 18
          THEN
              SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'Must be an adult!';
          END IF;
     END;
$$

DELIMITER ;


---Refers to data that is about to be inserted

DELIMITER $$

CREATE TRIGGER must_be_adult
     BEFORE INSERT ON people FOR EACH ROW
     BEGIN
          IF NEW.age < 18
          THEN
              SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'Must be an adult!';
          END IF;
     END;
$$

DELIMITER ;


---It's a long story....
DELIMITER $$

CREATE TRIGGER must_be_adult
     BEFORE INSERT ON people FOR EACH ROW
     BEGIN
          IF NEW.age < 18
          THEN
              SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'Must be an adult!';
          END IF;
     END;
$$

DELIMITER ;

/*

A numeric error code (1146). This number is MySQL-specific

A five-character SQLSTATE value ('42S02'). 
The values are taken from ANSI SQL and ODBC and are more standardized.

A message string - textual description of the error

*/


45000
A generic state representing "unhandled user-defined exception"

DELIMITER $$

CREATE TRIGGER must_be_adult
     BEFORE INSERT ON people FOR EACH ROW
     BEGIN
          IF NEW.age < 18
          THEN
              SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'Must be an adult!';
          END IF;
     END;
$$

DELIMITER ;


WHAT IS THIS?!   ===>$$$$

DELIMITER $$

CREATE TRIGGER must_be_adult
     BEFORE INSERT ON people FOR EACH ROW
     BEGIN
          IF NEW.age < 18
          THEN
              SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'Must be an adult!';
          END IF;
     END;
$$

DELIMITER ;

