
TRUNCATE TABLE posts, tags, posts_tags RESTART IDENTITY;

INSERT INTO posts (title) VALUES ('Title 1'); -- id 1
INSERT INTO posts (title) VALUES ('Title 2'); -- id 2
INSERT INTO posts (title) VALUES ('Title One'); -- id 3
INSERT INTO posts (title) VALUES ('Title Two'); -- id 4

INSERT INTO tags (name) VALUES ('tag1'); -- id 1
INSERT INTO tags (name) VALUES ('tag2'); -- id 2
INSERT INTO tags (name) VALUES ('tag1'); -- id 3
INSERT INTO tags (name) VALUES ('tag2'); -- id 4

INSERT INTO posts_tags (post_id, tag_id) VALUES (1, 1);
INSERT INTO posts_tags (post_id, tag_id) VALUES (2, 2);
INSERT INTO posts_tags (post_id, tag_id) VALUES (3, 1);
INSERT INTO posts_tags (post_id, tag_id) VALUES (4, 2);


-- # original seeds for previous 'blog' exercise
-- TRUNCATE TABLE posts, comments RESTART IDENTITY;

-- INSERT INTO posts (title, content, author) VALUES ('Day 1', 'Awesome', 'Rita');
-- INSERT INTO posts (title, content, author) VALUES ('Day 2', 'Amazing', 'Serena');

-- INSERT INTO comments (content, author, post_id) VALUES ('Agreed', 'Nadal', 1);
-- INSERT INTO comments (content, author, post_id) VALUES ('100%', 'Tomljanovic', 1);
-- INSERT INTO comments (content, author, post_id) VALUES ('Agreed', 'Alcaraz', 2);
-- INSERT INTO comments (content, author, post_id) VALUES ('Sure', 'Tiafoe', 2);