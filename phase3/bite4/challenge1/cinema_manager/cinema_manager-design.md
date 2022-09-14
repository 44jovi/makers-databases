# Two Tables (Many-to-Many) Design Recipe Template

Challenge
Infer the table schema from these user stories.
Copy the Design Recipe template and use it to design the schema for the two tables and their join table.
Create the tables by loading the SQL file in psql.
## 1. Extract nouns from the user stories or specification

```
As a cinema company manager,
So I can keep track of movies being shown,
I want to keep a list of movies with their title and release date.

As a cinema company manager,
So I can keep track of movies being shown,
I want to keep a list of my cinemas with their city name (e.g 'London' or 'Manchester').

As a cinema company manager,
So I can keep track of movies being shown,
I want to be able to list which cinemas are showing a specific movie.

As a cinema company manager,
So I can keep track of movies being shown,
I want to be able to list which movies are being shown a specific cinema.
```

```
Nouns:

movie, title, release date
cinema, city
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties          |
| --------------------- | ------------------  |
| movies                | title, release_date |
| cinemas               | city                |

1. Name of the first table (always plural): `movies` 

    Column names: `title`, `release_date`

2. Name of the second table (always plural): `cinemas` 

    Column names: `name`

## 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```
# EXAMPLE:

Table: movies
id: SERIAL
title: text
release_date: date

Table: cinemas
id: SERIAL
name: text
```

## 4. Design the Many-to-Many relationship

Make sure you can answer YES to these two questions:

1. Can one [TABLE ONE] have many [TABLE TWO]? (Yes/No)
2. Can one [TABLE TWO] have many [TABLE ONE]? (Yes/No)

```
# EXAMPLE

1. Can one cinema have many movies? YES
2. Can one movie have many cinemas? YES
```

_If you would answer "No" to one of these questions, you'll probably have to implement a One-to-Many relationship, which is simpler. Use the relevant design recipe in that case._

## 5. Design the Join Table

The join table usually contains two columns, which are two foreign keys, each one linking to a record in the two other tables.

The naming convention is `table1_table2`.

```
# EXAMPLE

Join table for tables: movies and cinemas
Join table name: movies_cinemas
Columns: movie_id, cinema_id
```

## 4. Write the SQL.

```sql
-- EXAMPLE
-- file: movies_cinemas.sql

-- Replace the table name, columm names and types.

-- Create the first table.
CREATE TABLE movies (
  id SERIAL PRIMARY KEY,
  title text,
  release_date text
);

-- Create the second table.
CREATE TABLE cinemas (
  id SERIAL PRIMARY KEY,
  name text
);

-- Create the join table.
CREATE TABLE movies_cinemas (
  movie_id int,
  cinema_id int,
  constraint fk_movie foreign key(movie_id) references movies(id) on delete cascade,
  constraint fk_cinema foreign key(cinema_id) references cinemas(id) on delete cascade,
  PRIMARY KEY (movie_id, cinema_id)
);

```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 database_name < movies_cinemas.sql
```