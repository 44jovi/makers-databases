-- First create table without foreign key
CREATE TABLE cohorts (
  id SERIAL PRIMARY KEY,
  name text,
  starting_date date
);

-- Then create table with the foreign key
CREATE TABLE students (
  id SERIAL PRIMARY KEY,
  name text,
-- The foreign key name is always <other_table_singular>_id
  cohort_id int,
  constraint fk_cohort foreign key(cohort_id) references
  cohorts(id)
);