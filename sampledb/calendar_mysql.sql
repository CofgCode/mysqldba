/*
MySQL
Create the days table
*/
DROP TABLE calendar_days;


CREATE TABLE calendar_days (
  day_id INT,
  calendar_date DATE,
  calendar_year SMALLINT,
  calendar_quarter SMALLINT,
  calendar_quarter_name VARCHAR(10),
  calendar_month SMALLINT,
  calendar_month_longname VARCHAR(20),
  calendar_month_shortname VARCHAR(5),
  calendar_week_of_year SMALLINT,
  calendar_week_of_month SMALLINT,
  calendar_day_of_week SMALLINT,
  calendar_day_of_year SMALLINT,
  calendar_day_of_month SMALLINT,
  calendar_day_longname VARCHAR(20),
  calendar_day_shortname VARCHAR(5),
  is_weekend SMALLINT,
  is_holiday SMALLINT,
  is_workday SMALLINT,
  holiday_description VARCHAR(100),
  CONSTRAINT pk_calendar PRIMARY KEY (day_id)
);

DELETE FROM calendar_days;


/*
Note: you may get this error:
Error Code: 3636. Recursive query aborted after 1001 iterations. Try increasing @@cte_max_recursion_depth to a larger value.
The default value is 1000.
If so, run this command, and try the recursive query again.
*/

SET SESSION cte_max_recursion_depth = 1000000;

/*
Populate the table just with the IDs
*/
INSERT INTO calendar_days (day_id)
WITH RECURSIVE nrows(idnum) AS (
  SELECT 1
  UNION ALL 
  SELECT idnum + 1
  FROM nrows
  WHERE  idnum <= DATEDIFF('2030-12-31', '2000-01-01')
)
SELECT idnum FROM nrows;


/*
Update using the day_id as an increment for the date
Note: the specified calendar date is the day BEFORE the first record to be added
*/

UPDATE calendar_days
SET calendar_date = DATE_ADD('1999-12-31', INTERVAL day_id DAY);



/*
Calculate and update other fields
*/

UPDATE calendar_days
SET calendar_year = YEAR(calendar_date),
calendar_quarter = QUARTER(calendar_date),
calendar_month = MONTH(calendar_date),
calendar_day_of_year = DAYOFYEAR(calendar_date),
calendar_day_of_week = WEEKDAY(calendar_date), -- From 0 (Monday) to 6 (Sunday),
calendar_day_of_month = DAYOFMONTH(calendar_date),
calendar_day_longname = DAYNAME(calendar_date),
calendar_day_shortname = DATE_FORMAT(calendar_date, '%a'),
calendar_week_of_year = WEEKOFYEAR(calendar_date),
calendar_month_longname = MONTHNAME(calendar_date),
calendar_month_shortname = DATE_FORMAT(calendar_date, '%b')
WHERE 1=1;

/*
Update table based on previously-calculated columns
*/
UPDATE calendar_days
SET is_weekend = CASE
	WHEN calendar_day_of_week = 5 THEN 1
	WHEN calendar_day_of_week = 6 THEN 1
	ELSE 0
	END,
calendar_week_of_month = CASE
	WHEN calendar_day_of_month BETWEEN 1 AND 7 THEN 1
	WHEN calendar_day_of_month BETWEEN 8 AND 14 THEN 2
	WHEN calendar_day_of_month BETWEEN 15 AND 21 THEN 3
	WHEN calendar_day_of_month BETWEEN 22 AND 28 THEN 4
	ELSE 5
END,
calendar_quarter_name = CONCAT('Q',calendar_quarter, ' ', calendar_year)
WHERE 1=1;
	
	
/*
Add holidays that are on the same day every year
Examples are for USA
Not a complete list!
*/

/* MLK Birthday = 3rd Monday in January */
UPDATE calendar_days
SET is_holiday = 1,
holiday_description = 'Martin Luther King Jr. birthday'
WHERE calendar_month = 1
AND calendar_day_of_week = 0
AND calendar_week_of_month = 3;

/* President's Day = 3rd Monday in February */
UPDATE calendar_days
SET is_holiday = 1,
holiday_description = 'President''s Day'
WHERE calendar_month = 2
AND calendar_day_of_week = 0
AND calendar_week_of_month = 3;

/* Thanksgiving = 4th Thursday in November */
UPDATE calendar_days
SET is_holiday = 1,
holiday_description = 'Thanksgiving'
WHERE calendar_month = 11
AND calendar_day_of_week = 4
AND calendar_week_of_month = 4;

/*
Add holidays where the day may change each year,
for example if it falls on a weekend
*/

/* New Years Day, if it is on a Mon-Fri */
UPDATE calendar_days
SET is_holiday = 1,
holiday_description = 'New Year''s Day'
WHERE calendar_month = 1
AND calendar_day_of_month = 1
AND is_weekend = 0;

/* New Year's Day, if it is on a Sat or Sun, then it is on the next Monday */
UPDATE calendar_days
SET is_holiday = 1,
holiday_description = 'New Year''s Day holiday'
WHERE (calendar_month = 1 AND calendar_day_of_month = 2 AND calendar_day_of_week = 0) -- falls on a Sun, so it is Mon the 2nd
OR (calendar_month = 1 AND calendar_day_of_month = 3 AND calendar_day_of_week = 0); -- Sat, so it is Mon the 3rd


/*
 * Set is_holiday for all other dates
 */
UPDATE calendar_days
SET is_holiday = 0
WHERE is_holiday IS NULL;


/*
 * Set is_workday for non-weekends and non-holidays
 */
UPDATE calendar_days
SET is_workday = CASE
	WHEN is_weekend = 1 OR is_holiday = 1 THEN 0
	ELSE 1
END
WHERE 1=1;



/*
 * Query the table
 */
SELECT *
FROM calendar_days
ORDER BY calendar_date ASC;

/*
 *  Find all holidays
 */

SELECT *
FROM calendar_days 
WHERE is_holiday = 1
ORDER BY calendar_date ASC;


