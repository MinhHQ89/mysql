-- Slide 23 - 24: Create Database
CREATE DATABASE demo_mysql;
CREATE DATABASE demo_laravel;
USE demo_mysql;

-- Slide 25: Drop Database
DROP DATABASE demo_mysql;

-- Slide 42 - 44: Create Table
CREATE TABLE IF NOT EXISTS news (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,  -- ID：大きな整数、負の値なし、自動増加、主キー
    title VARCHAR(255) NOT NULL,                    -- タイトル、最大 255 文字の文字列、必須
    email VARCHAR(255),                             -- メールアドレス、最大 255 文字の文字列、null 可能
    description VARCHAR(255),                       -- 短い説明、最大 255 文字の文字列
    slug VARCHAR(255),                              -- スラグ（フレンドリーURL用）、最大255文字
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- レコード作成日時、現在時刻デフォルト
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP  -- 更新日時、現在時刻デフォルト
               ON UPDATE CURRENT_TIMESTAMP          -- レコードが変更されたときに自動的に更新
);

-- Slide 45: Drop Table
DROP TABLE IF EXISTS news;

-- Slide 62 - 63: Insert Data
INSERT INTO news (title, email, description, slug)
VALUES
('AI Technology Trends', 'admin1@example.com', 'An article about the latest AI trends', 'ai-technology-trends'),
('National Football League', 'sport@example.com', 'Match results from the national football league', 'national-football-league'),
('Global Economy 2025', 'finance@example.com', 'Analysis of the global economy in 2025', 'global-economy-2025'),
('Summer Travel Destinations', 'travel@example.com', 'Top summer travel destinations for 2025', 'summer-travel-destinations'),
('Electric Vehicle Technology', 'tech@example.com', 'The future of electric vehicles and clean energy', 'electric-vehicle-technology');

-- Slide 69: Select Data
SELECT * FROM news;
SELECT id, title, email FROM news;
SELECT id AS blog_code, title, email FROM news;

-- Slide 78 - 79: Where Clause
SELECT *
FROM news
WHERE id < 3;

SELECT *
FROM news
WHERE id < 3
AND title LIKE '%AI%';

-- Slide 81: OR Condition
SELECT *
FROM news
WHERE title LIKE '%AI%'
OR title LIKE '%tech%';

-- Slide 84: Update Data
UPDATE news SET email='admin@example.com'
WHERE id = 1;

-- Slide 88: Delete Data
DELETE FROM news WHERE id = 7;

-- Slide 91: Order By
SELECT * FROM news ORDER BY id DESC;

-- Slide 97 - 98: Alter Table
ALTER TABLE news
RENAME COLUMN email TO summary;

ALTER TABLE news
ADD category_id BIGINT UNSIGNED;

-- Slide 102 - 106: Join Tables
CREATE TABLE IF NOT EXISTS categories (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(255) UNIQUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO categories (name, slug, description)
VALUES
('Technology', 'technology', 'Articles about the latest technology'),
('Sports', 'sports', 'News about national and international sports'),
('Entertainment', 'entertainment', 'News about movies, music, and celebrities');

UPDATE news
SET category_id = 1
WHERE id < 3;

UPDATE news
SET category_id = 2
WHERE id >= 3;

SELECT news.id, news.title, categories.name AS category_name
FROM news
INNER JOIN categories ON news.category_id = categories.id
WHERE categories.name = 'Technology';

SELECT n.id, n.title, c.name AS category_name
FROM news n
INNER JOIN categories c ON n.category_id = c.id
WHERE c.name = 'Technology';

-- Slide 107 - 108: Limit and Offset
SELECT * FROM news LIMIT 5;
SELECT * FROM news
	LIMIT 2 OFFSET 0;

-- Slide 110: Group By
SELECT c.name AS category_name, count(n.id) AS total_news
FROM news n
INNER JOIN categories c ON n.category_id = c.id
GROUP BY c.name;

-- Slide 112: Having Clause
SELECT c.name AS category_name, COUNT(n.id) AS total_news
FROM news n
INNER JOIN categories c ON n.category_id = c.id
GROUP BY c.name
HAVING COUNT(n.id) >= 3;

-- Slide 113: Functions
SELECT COUNT(*) AS total_news FROM news;
SELECT MIN(id) AS min_id FROM news;

-- Slide 116: Subqueries
SELECT
    c.id,
    c.name,
    (
        SELECT COUNT(*)
        FROM news n
        WHERE n.category_id = c.id
    ) AS total_news
FROM categories c;