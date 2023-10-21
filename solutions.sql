/* Név: Jakobszen Gábor*/

-- FORDÍTÓIRODA FELADAT --

/* 1. Lekérdezés */

SELECT
	name
FROM
	people
WHERE
	available = true
ORDER BY
	name;
	

/* 2. Lekérdezés */

SELECT
	field,
	SUM(length) AS sum_length
FROM
	docs
WHERE
	field = 'marketing'
GROUP BY
	field;

	

/* 3. Lekérdezés */
SELECT
	source_lang,
	COUNT(*) AS qty_of_Slovakian_docs
FROM
	docs
INNER JOIN
	languages
ON
	docs.language_id = languages.id
WHERE
	source_lang = 'Slovakian'
GROUP BY
	source_lang;


/* 4. Lekérdezés */
SELECT
	COUNT(*) AS below_5000,
	SUM(unit_price)
FROM
	docs
INNER JOIN
	languages
ON
	docs.language_id = languages.id
WHERE
	docs.length <= 5000;
	
/* 5. Lekérdezés */
SELECT
	length,
	field
FROM
	docs
INNER JOIN
	languages
ON
	docs.language_id = languages.id
WHERE
	source_lang = 'English'
	AND
	target_lang = 'Hungarian'
ORDER BY
	length DESC;


/* 6. Lekérdezés */
SELECT
	field,
	source_lang,
	target_lang
FROM
	docs
INNER JOIN
	languages
ON
	docs.language_id = languages.id
WHERE
	worktime BETWEEN 7 AND 9
ORDER BY
	source_lang;
	
/* 7. Lekérdezés */

SELECT 
	name,
	COUNT(DISTINCT target_lang)
FROM
	docs
INNER JOIN
	languages
ON
	docs.language_id = languages.id
INNER JOIN
	translators
ON
	translators.language_id = languages.id
INNER JOIN
	people
ON
	translators.person_id = people.id
WHERE
	source_lang = 'Hungarian'
GROUP BY
	name
ORDER BY
	count DESC
LIMIT
	1;

/* 8. Lekérdezés */

SELECT 
	name
FROM
	docs
INNER JOIN
	languages
ON
	docs.language_id = languages.id
INNER JOIN
	translators
ON
	translators.language_id = languages.id
INNER JOIN
	people
ON
	translators.person_id = people.id
WHERE
	(available = 'true' AND source_lang = 'Hungarian') AND (target_lang = 'English' OR target_lang = 'Russian')
GROUP BY
	name
HAVING
	COUNT(DISTINCT target_lang) = 2;


/* 9. Lekérdezés */

SELECT DISTINCT
	field,
	source_lang,
    target_lang
FROM
	docs
INNER JOIN
	languages
ON
	languages.id = docs.language_id
ORDER BY
	field,
	source_lang;





-- BÚTOROS FELADAT --

/* 1. Feladat */
CREATE TABLE  IF NOT EXISTS furnitures(
	id SERIAL PRIMARY KEY,
	type VARCHAR(255) NOT NULL,
	color VARCHAR(50) NOT NULL,
	price INTEGER CHECK(price > 0)
);

CREATE TABLE IF NOT EXISTS carts (
	id SERIAL PRIMARY KEY,
	furniture_id INTEGER REFERENCES furnitures(id) NOT NULL,
	quantity INTEGER CHECK(quantity > 0) NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

/* 2. Feladat */
INSERT INTO furnitures (
	type,
	color,
	price
)VALUES
('asztal', 'fekete', 19990),
('kerek asztal', 'barna', 20000),
('szék', 'fekete', 8900),
('forgó szék', 'fekete', 114490),
('éjeli szekrény', 'piros', 39900);

INSERT INTO carts (
	furniture_id,
	quantity
) VALUES
	(1, 1),
	(2, 1),
	(3, 6),
	(4, 2),
	(5, 2);

/* 3. Feladat */

UPDATE furnitures
	SET price = 10000
	WHERE type LIKE '%asztal%';

/* 4. Feladat */

DELETE FROM 
	carts
WHERE
	furniture_id IN (SELECT id FROM furnitures WHERE color = 'piros');

DELETE FROM 
	furnitures
WHERE
	color = 'piros';

-- FELADATLAP VÉGE --
