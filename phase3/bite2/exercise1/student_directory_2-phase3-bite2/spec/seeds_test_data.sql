TRUNCATE TABLE cohorts, students RESTART IDENTITY;

INSERT INTO cohorts (name, starting_date) VALUES ('Sep', '2022-09-01');
INSERT INTO cohorts (name, starting_date) VALUES ('Oct', '2022-10-01');

INSERT INTO students (name, cohort_id) VALUES ('Wendy', 1);
INSERT INTO students (name, cohort_id) VALUES ('Jovi', 2);