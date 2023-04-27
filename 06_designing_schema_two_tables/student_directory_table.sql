CREATE TABLE cohort (
  id SERIAL PRIMARY KEY,
  name text,
  start_date text
);

CREATE TABLE student (
  id SERIAL PRIMARY KEY,
  name text,
  cohort_id int,
  constraint fk_cohort foreign key(cohort_id)
    references cohort(id)
    on delete cascade
);