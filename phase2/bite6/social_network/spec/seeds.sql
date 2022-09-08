TRUNCATE TABLE posts, users RESTART IDENTITY;
-- TRUNCATE TABLE users RESTART IDENTITY;

INSERT INTO users (name, email) 
VALUES ('Jovi', 'jovi@jovi.com');

INSERT INTO users (name, email) 
VALUES ('Rita', 'rita@rita.com');

INSERT INTO posts (title, content, views, user_id) 
VALUES ('Hello', 'How are you?', 5, 1);

INSERT INTO posts (title, content, views, user_id) 
VALUES ('Rubberducks', 'We debug', 10, 2);

-- original

-- TRUNCATE TABLE users RESTART IDENTITY; 
-- TRUNCATE TABLE posts RESTART IDENTITY; 

-- INSERT INTO users (name, email) 
-- VALUES ('Jovi', 'jovi@jovi.com');

-- INSERT INTO users (name, email) 
-- VALUES ('Rita', 'rita@rita.com');

-- INSERT INTO posts (title, content, views, user_id) 
-- VALUES ('Hello', 'How are you?', 5, 1);

-- INSERT INTO posts (title, content, views, user_id) 
-- VALUES ('Rubberducks', 'We debug', 10, 2);
