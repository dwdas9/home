# [CREATE TABLE USING](https://docs.databricks.com/en/sql/language-manual/sql-ref-syntax-ddl-create-table-using.html)

Using this SQL technique, you define the table schema, and create the table directly from the CSV file without switching to PySpark for initial data loading and df creation etc.

```sql
-- Drop the table if it exists
DROP TABLE IF EXISTS hollywood;

-- Create an external table from the CSV file
CREATE TABLE hollywood (
  movieName STRING,
  actor STRING
)
USING CSV
OPTIONS (
  path '/mnt/movies.csv',
  header 'true',
  inferSchema 'true'
);
```