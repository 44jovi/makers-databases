TRUNCATE TABLE posts, comments RESTART IDENTITY;

INSERT INTO posts (title, content, author) VALUES ('Day 1', 'Awesome', 'Rita');
INSERT INTO posts (title, content, author) VALUES ('Day 2', 'Amazing', 'Serena');

INSERT INTO comments (content, author, post_id) VALUES ('Agreed', 'Nadal', 1);
INSERT INTO comments (content, author, post_id) VALUES ('100%', 'Tomljanovic', 1);
INSERT INTO comments (content, author, post_id) VALUES ('Agreed', 'Alcaraz', 2);
INSERT INTO comments (content, author, post_id) VALUES ('Sure', 'Tiafoe', 2);


