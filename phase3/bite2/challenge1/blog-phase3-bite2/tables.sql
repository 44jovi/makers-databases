CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  content text,
  author text,
  title text
);

CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  content text,
  author text,
  post_id int,
  constraint fk_post foreign key(post_id)
    references posts(id)
    on delete cascade
);