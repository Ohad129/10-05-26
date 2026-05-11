-- 1. Create a categories table: id PK AUTOINCREMENT, title TEXT UNIQUE NOT NULL.

CREATE TABLE categories(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	title TEXT UNIQUE NOT NULL
);

-- 2. Create a posts table: id PK AUTOINCREMENT, category_id FK (NOT NULL), title TEXT, views INTEGER DEFAULT 0. Use ON DELETE RESTRICT.

CREATE TABLE posts(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	category_id INTEGER NOT NULL,
	title TEXT,
	views INTEGER DEFAULT 0,
	FOREIGN KEY (category_id) REFERENCES categories(id)
		ON DELETE RESTRICT
);

-- 3. Insert 3 categories and at least 5 posts spread across the categories.

INSERT INTO categories (title)
VALUES ('Drama'), ('Kids'), ('Horror');

INSERT INTO posts (id, category_id, title, views)
VALUES
	(1, 1, 'Silent Growth Theory', 150),
	(2, 1, 'Predictable Human Errors', 1000),
	(3, 2, 'Digital Empire Blueprint', 2500),
	(4, 1, 'Tactical Dopamine Control', 350),
	(5, 2, 'Momentom Beats Motivation', 3000);

-- 4. Query: list all posts with their category title using INNER JOIN.
	
SELECT
	p.title as post_name,
	p.views,
	c.title as category
FROM categories c
INNER JOIN posts p ON c.id = p.category_id;

-- 5. Query: count posts per category, show categories with 0 posts too (use LEFT JOIN + GROUP BY).

SELECT
	c.title as category,
	count(p.category_id) as posts_in_cat
FROM categories c
LEFT JOIN posts p ON c.id = p.category_id
GROUP BY c.title
ORDER BY posts_in_cat DESC;

-- 6. Query: find the category with the highest total views using GROUP BY + ORDER BY + LIMIT 1.

SELECT
	c.title as category,
	sum(p.views) as views_in_cat
FROM categories c
INNER JOIN posts p ON c.id = p.category_id
GROUP BY c.title
ORDER BY views_in_cat DESC
LIMIT 1;
