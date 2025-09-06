
-- Create the database
CREATE DATABASE IF NOT EXISTS quizverse_db;
USE quizverse_db;

-- 1. Users Table
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user VARCHAR(100) NOT NULL
);

-- Drop tables if they already exist
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS difficulties;
DROP TABLE IF EXISTS leaderboard;
DROP TABLE IF EXISTS scores;
DROP TABLE IF EXISTS admin_action;

-- 2. Create categories table
CREATE TABLE categories (
  id INT NOT NULL AUTO_INCREMENT,
  category_name VARCHAR(100) NOT NULL UNIQUE,
  PRIMARY KEY (id)
);

INSERT  INTO categories (category_name) VALUES
('general'),
('science'),
('history');


--3. Create difficulties table
CREATE TABLE difficulties (
  id INT NOT NULL AUTO_INCREMENT,
  difficulty_level VARCHAR(50) NOT NULL UNIQUE,
  PRIMARY KEY (id)
);

INSERT  INTO difficulties (difficulty_level) VALUES
('easy'),
('medium'),
('difficult');


-- 4. Create questions table
CREATE TABLE questions (
  id INT NOT NULL AUTO_INCREMENT,
  question_text TEXT NOT NULL,
  option1 TEXT NOT NULL,
  option2 TEXT NOT NULL,
  option3 TEXT NOT NULL,
  option4 TEXT NOT NULL,
  correct_option INT NOT NULL, --(0,1,2,3)
  category_id INT,
  difficulty_id INT,
  PRIMARY KEY (id),
  FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE,
  FOREIGN KEY (difficulty_id) REFERENCES difficulties(id) ON DELETE CASCADE
);


INSERT INTO questions (question_text, option1, option2, option3, option4, correct_option, category_id, difficulty_id) VALUES
('What is the capital of France?', 'Paris', 'London', 'Berlin', 'Madrid', 0, 1, 1),
('What is 2 + 2?', '3', '4', '5', '6', 1, 1, 1),
('Which color is the sky on a clear day?', 'Red', 'Blue', 'Green', 'Yellow', 1, 1, 1),
('What is the largest planet in our solar system?', 'Earth', 'Mars', 'Jupiter', 'Saturn', 2, 1, 1),
('Which continent is Australia located on?', 'Asia', 'Europe', 'Africa', 'Australia', 3, 1, 1),
('What is the freezing point of water?', '0°C', '32°F', '100°C', '212°F',0, 1, 2),
('How many hours are there in a day?', '24', '12', '36', '48', 0, 1, 2),
('Which planet is known as the Red Planet?', 'Earth', 'Venus', 'Mars', 'Saturn', 2, 1, 2),
('Who invented the telephone?', 'Thomas Edison', 'Nikola Tesla', 'Alexander Graham Bell', 'Albert Einstein', 2, 1, 2),
('Which country is known as the Land of the Rising Sun?', 'China', 'Japan', 'India', 'South Korea', 1, 1, 2),
('What is the chemical symbol for water?', 'H2O', 'CO2', 'O2', 'CH4', 0, 1, 3),
('Who was the first President of the United States?', 'Abraham Lincoln', 'George Washington', 'Thomas Jefferson', 'John Adams', 1, 1, 3),
('Which country is the largest by land area?', 'Canada', 'Russia', 'United States', 'China',1, 1, 3),
('What is the square root of 144?', '10', '12', '14', '16', 1, 1, 3),
('Who painted the Mona Lisa?', 'Vincent van Gogh', 'Pablo Picasso', 'Leonardo da Vinci', 'Claude Monet', 2, 1, 3),
('What is the chemical symbol for oxygen?', 'O', 'O2', 'H', 'H2O', 0, 2, 1),
('How many planets are in our solar system?', '7', '8', '9', '10', 1, 2, 1),
('What is the smallest bone in the human body?', 'Stapes', 'Femur', 'Tibia', 'Humerus',0, 2, 1),
('What is the boiling point of water?', '90°C', '100°C', '110°C', '150°C', 1, 2, 1),
('What gas do plants absorb for photosynthesis?', 'Oxygen', 'Carbon Dioxide', 'Nitrogen', 'Hydrogen', 1, 2, 1),
('What is the chemical formula for salt?', 'NaCl', 'NaOH', 'HCl', 'H2SO4',0, 2, 2),
('Which organ in the human body pumps blood?', 'Liver', 'Brain', 'Heart', 'Lungs', 2, 2, 2),
('How many bones are in the adult human body?', '206', '201', '215', '300', 0, 2, 2),
('Which planet is closest to the Sun?', 'Earth', 'Venus', 'Mercury', 'Mars', 2, 2, 2),
('Which element has the chemical symbol H?', 'Helium', 'Hydrogen', 'Hafnium', 'Holmium', 1, 2, 2),
('What is the atomic number of Carbon?', '6', '12', '8', '14', 0, 2, 3),
('What is the chemical formula for methane?', 'CH4', 'C2H6', 'C3H8', 'C4H10', 0, 2, 3),
('What is the most common gas in Earths atmosphere?', 'Oxygen', 'Carbon Dioxide', 'Nitrogen', 'Hydrogen', 2, 2, 3),
('What is the hardest naturally occurring mineral?', 'Gold', 'Iron', 'Diamond', 'Platinum', 2, 2, 3),
('What is the longest bone in the human body?', 'Femur', 'Humerus', 'Tibia', 'Radius', 0, 2, 3),
('Who was the first man to step on the Moon?', 'Neil Armstrong', 'Buzz Aldrin', 'Yuri Gagarin', 'John Glenn', 0, 3, 1),
('Who was the first President of the United States?', 'Abraham Lincoln', 'George Washington', 'Thomas Jefferson', 'John Adams', 1, 3, 1),
('In which year did World War II end?', '1940', '1945', '1950', '1960', 1, 3, 1),
('Who is known as the father of modern physics?', 'Isaac Newton', 'Albert Einstein', 'Galileo Galilei', 'Niels Bohr', 1, 3, 1),
('Where was the first Olympic Games held?', 'Paris', 'Athens', 'Rome', 'London', 1, 3, 1),
('In which year did the Titanic sink?', '1912', '1905', '1915', '1920',0, 3, 2),
('Who discovered America?', 'Christopher Columbus', 'Leif Erikson', 'Marco Polo', 'Ferdinand Magellan', 0, 3, 2),
('Who was the first emperor of China?', 'Qin Shi Huang', 'Kublai Khan', 'Sun Tzu', 'Genghis Khan', 0, 3, 2),
('Who was the first woman to fly solo across the Atlantic Ocean?', 'Amelia Earhart', 'Harriet Quimby', 'Bessie Coleman', 'Jacqueline Cochran',0, 3, 2),
('Who was the last emperor of the Roman Empire?', 'Julius Caesar', 'Augustus', 'Romulus Augustulus', 'Nero', 2, 3, 2),
('Who wrote the Divine Comedy?', 'William Shakespeare', 'Dante Alighieri', 'Homer', 'John Milton', 1, 3, 3),
('In which battle did Napoleon Bonaparte lose to the British?', 'Battle of Waterloo', 'Battle of Austerlitz', 'Battle of Leipzig', 'Battle of Trafalgar', 0, 3, 3),
('Who was the first woman to receive a Nobel Prize?', 'Marie Curie', 'Rosalind Franklin', 'Lise Meitner', 'Dorothy Hodgkin', 0, 3, 3),
('In which year did the French Revolution begin?', '1776', '1789', '1799', '1804',1, 3, 3),
('Who was the first king of England?', 'King Henry VIII', 'King Alfred the Great', 'King Arthur', 'King Richard I', 1, 3, 3);

-- 5. Leaderboard Table
CREATE TABLE leaderboard (
  id INT AUTO_INCREMENT PRIMARY KEY,
  player_name VARCHAR(100) NOT NULL,
  score INT NOT NULL
);

-- 6. Scores Table
CREATE TABLE scores (
  id INT NOT NULL AUTO_INCREMENT,
  player_name VARCHAR(100) NOT NULL,
  score INT NOT NULL,
  total_questions INT NOT NULL,
  submitted_at DATETIME NOT NULL,
  PRIMARY KEY (id)
  FOREIGN KEY (player_name) REFERENCES leaderboard(name),
  FOREIGN KEY (score) REFERENCES leaderboard(score)
);

-- 7. Admin Action Table
CREATE TABLE admin_action (
  id INT AUTO_INCREMENT PRIMARY KEY,
  action TEXT,
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO admin_action (action) VALUES
('Admin added a new question.'),
('Admin deleted a question.');



-- JOINS
-- 1. Join Query: Detailed Questions with Category and Difficulty
SELECT 
  q.id,
  q.question_text,
  q.option1,
  q.option2,
  q.option3,
  q.option4,
  q.correct_option,
  c.category_name,
  d.difficulty_level
FROM 
  questions q
JOIN 
  categories c ON q.category_id = c.id
JOIN 
  difficulties d ON q.difficulty_id = d.id;


-- 2. Join Query: Leaderboard with User Details
SELECT 
    l.id,
    u.user,
    l.score
FROM leaderboard l
JOIN users u ON l.id = u.id
ORDER BY l.score DESC;



-- TRIGGERS
-- 1. log new question insertion procedure
DELIMITER $$
CREATE PROCEDURE log_question_insert(IN question_id INT)
BEGIN
  INSERT INTO admin_action (action) 
  VALUES (CONCAT('New question added with ID: ', question_id));
END$$
DELIMITER ;

-- Trigger: Log New Question Insertion
DELIMITER $$

CREATE TRIGGER after_question_insert
AFTER INSERT ON questions
FOR EACH ROW
BEGIN
  INSERT INTO admin_action (action) VALUES (CONCAT('Question Added: ', NEW.question_text));
END $$

DELIMITER ;




-- 2. log question deletion procedure
DELIMITER $$
CREATE PROCEDURE log_question_delete(IN question_id INT)
BEGIN
  INSERT INTO admin_action (action) 
  VALUES (CONCAT('Question deleted with ID: ', question_id));
END$$
DELIMITER ;

-- Trigger: Log Question Deletion
DELIMITER $$

CREATE TRIGGER after_question_delete
AFTER DELETE ON questions
FOR EACH ROW
BEGIN
  INSERT INTO admin_action (action) VALUES (CONCAT('Question Deleted: ', OLD.question_text));
END $$

DELIMITER ;


-- 3.prevent duplicate username procedure
DELIMITER $$
CREATE PROCEDURE check_duplicate_username(IN new_username VARCHAR(100))
BEGIN
  IF EXISTS (
    SELECT 1 FROM users WHERE username = new_username
  ) THEN
    SIGNAL SQLSTATE '45000' 
    SET MESSAGE_TEXT = 'Username already exists!';
  END IF;
END$$
DELIMITER ;

--  Trigger to prevent duplicate usernames
DELIMITER //
CREATE TRIGGER prevent_duplicate_usernames
BEFORE INSERT ON users
FOR EACH ROW
BEGIN
  DECLARE user_exists INT;
  SELECT COUNT(*) INTO user_exists
  FROM users
  WHERE user = NEW.user;

  IF user_exists > 0 THEN
    SIGNAL SQLSTATE '45000' 
    SET MESSAGE_TEXT = 'Username already exists!';
  END IF;
END;
//
DELIMITER ;



-- (PROCEDURE update_leaderboard already exists)
-- 4. update leaderboardprocedure
-- DELIMITER $$
-- CREATE PROCEDURE update_leaderboard(IN user INT, IN new_score INT)
-- BEGIN
--   DECLARE existing_top INT;
--   SELECT top_score INTO existing_top
--   FROM leaderboard
--   WHERE user_id = user;
--   IF existing_top IS NULL THEN
--     INSERT INTO leaderboard (user_id, top_score)
--     VALUES (user, new_score);
--   ELSEIF new_score > existing_top THEN
--     UPDATE leaderboard
--     SET top_score = new_score
--     WHERE user_id = user;
--   END IF;
-- END$$
-- DELIMITER ;


-- Trigger: Update leaderboard When a New Score Is Higher
DELIMITER //
CREATE TRIGGER update_leaderboard_after_insert
AFTER INSERT ON score
FOR EACH ROW
BEGIN
  DECLARE existing_top INT;
  -- Try to get existing top score for the user
  SELECT score INTO existing_top
  FROM leaderboard
  WHERE id = NEW.id;
  -- If no record exists, insert one
  IF existing_top IS NULL THEN
    INSERT INTO leaderboard (id, score)
    VALUES (NEW.id, NEW.score);
  ELSEIF NEW.score > existing_top THEN
    -- If the new score is higher, update it
    UPDATE leaderboard
    SET score = NEW.score
    WHERE u.id = NEW.id;
  END IF;
END;
//
DELIMITER ;



