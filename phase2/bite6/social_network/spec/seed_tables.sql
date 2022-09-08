-- user
-- id SERIAL,
-- name text,
-- email text

-- post
-- id SERIAL,
-- author int,
-- title text,
-- content text,
-- views int

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name text,
  email text
);

CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title text,
  content text,
  views int,
  user_id int,
  constraint fk_user foreign key(user_id)
    references users(id)
    on delete cascade
);

-- backup code
-- ALTER TABLE users
-- ADD CONSTRAINT pk_users PRIMARY KEY(id);