### 1. **Normalization and Denormalization**
   - **Normalization** is the process of organizing data to reduce redundancy and improve integrity. It involves dividing large tables into smaller, manageable ones and using foreign keys to link them.
     - **First Normal Form (1NF)**: Each column contains atomic (indivisible) values, and each record is unique.
     - **Second Normal Form (2NF)**: Achieved by removing partial dependency, i.e., all non-key attributes must be fully dependent on the primary key.
     - **Third Normal Form (3NF)**: No transitive dependency, meaning non-key attributes cannot depend on other non-key attributes.
   - **Denormalization**: This involves combining tables to reduce the need for complex joins, improving query performance at the expense of redundancy.

### 2. **Joins**
   - **Inner Join**: Returns only rows where there is a match in both tables.
   - **Left Join (or Left Outer Join)**: Returns all rows from the left table, and matched rows from the right table; if no match, NULL values are returned.
   - **Right Join (or Right Outer Join)**: Similar to Left Join but returns all rows from the right table.
   - **Full Outer Join**: Returns rows when there is a match in one of the tables.
   - **Cross Join**: Returns the Cartesian product of the two tables, i.e., all combinations of rows.
   - **Self Join**: A table is joined with itself, often using aliases.

### 3. **Subqueries**
   - **Scalar Subquery**: Returns a single value, and is often used in `SELECT`, `WHERE`, or `HAVING` clauses.
     ```sql
     SELECT name
     FROM employees
     WHERE salary > (SELECT AVG(salary) FROM employees);
     ```
   - **Correlated Subquery**: A subquery that refers to columns from the outer query.
     ```sql
     SELECT e.name
     FROM employees e
     WHERE e.salary > (SELECT AVG(salary) FROM employees WHERE department_id = e.department_id);
     ```
   - **IN vs. EXISTS**:
     - `IN` is used for checking if a value is in a set.
     - `EXISTS` is used when the query checks for the presence of rows.

### 4. **Indexes**
   - **Clustered Index**: This type of index determines the physical order of data rows in the table. A table can have only one clustered index.
   - **Non-Clustered Index**: This does not change the physical order of data. It creates a separate structure to speed up retrieval.
   - **Composite Index**: Involves multiple columns. It can be used when queries commonly filter by more than one column.

### 5. **Transactions**
   - **ACID Properties**: Ensures the database transactions are processed reliably.
     - **Atomicity**: A transaction is either fully completed or not executed at all.
     - **Consistency**: The database remains in a valid state before and after the transaction.
     - **Isolation**: Transactions are isolated from each other.
     - **Durability**: Once a transaction is committed, it is permanent.
   - **Transaction Control**: 
     - `BEGIN TRANSACTION`: Starts a transaction.
     - `COMMIT`: Saves the changes.
     - `ROLLBACK`: Reverts the changes if there is an error.

### 6. **Window Functions**
   - **ROW_NUMBER()**: Assigns a unique row number to each row in a result set.
     ```sql
     SELECT name, ROW_NUMBER() OVER (ORDER BY salary DESC) AS rank
     FROM employees;
     ```
   - **RANK()** and **DENSE_RANK()**: Similar to `ROW_NUMBER()`, but handles ties differently.
   - **PARTITION BY**: Divides the result set into partitions and performs operations on each partition.

### 7. **Triggers and Stored Procedures**
   - **Triggers**: Automatically executed or fired when certain events occur on a table or view (e.g., `INSERT`, `UPDATE`, `DELETE`).
     ```sql
     CREATE TRIGGER update_salary
     AFTER UPDATE ON employees
     FOR EACH ROW
     BEGIN
        -- trigger logic here
     END;
     ```
   - **Stored Procedures**: A set of SQL statements stored in the database that can be executed as a program.
     ```sql
     CREATE PROCEDURE GetEmployeeSalary(IN emp_id INT)
     BEGIN
        SELECT salary FROM employees WHERE employee_id = emp_id;
     END;
     ```
   - **Functions**: Similar to stored procedures, but typically return a value.

### 8. **Partitioning**
   - **Range Partitioning**: Dividing a table into partitions based on a range of values (e.g., dates).
   - **List Partitioning**: Dividing a table into partitions based on a list of values.
   - **Hash Partitioning**: Dividing the data into partitions based on a hash function.

### 9. **Advanced SQL Clauses**
   - **WITH Clause (Common Table Expressions or CTEs)**: Makes a subquery easier to reference.
     ```sql
     WITH DepartmentAvgSalary AS (
        SELECT department_id, AVG(salary) AS avg_salary
        FROM employees
        GROUP BY department_id
     )
     SELECT e.name, e.salary
     FROM employees e
     JOIN DepartmentAvgSalary das ON e.department_id = das.department_id
     WHERE e.salary > das.avg_salary;
     ```
   - **GROUP BY ROLLUP and CUBE**: Useful for generating subtotals and grand totals.
     ```sql
     SELECT department, SUM(salary)
     FROM employees
     GROUP BY ROLLUP (department);
     ```

### 10. **Data Warehousing Concepts**
   - **Star Schema**: A central fact table surrounded by dimension tables.
   - **Snowflake Schema**: A more normalized form of the star schema, where dimension tables are further split into related tables.
   - **Fact Tables and Dimension Tables**: Fact tables hold quantitative data, while dimension tables contain descriptive data (e.g., `products`, `dates`).
   - **ETL Process**: Extract, Transform, Load; used for moving data from operational databases to a data warehouse.

### 11. **NoSQL Databases**
   - For databases like MongoDB, Cassandra, or Redis, understanding data models (document, key-value, column-family) and how they differ from relational databases is important.
   - **Aggregation Pipeline (MongoDB)**: A framework for performing data transformations within MongoDB.
   - **Cassandra Queries**: Using CQL (Cassandra Query Language) for column-family based databases.

### 12. **Optimizing Queries**
   - **EXPLAIN Plan**: Analyzing the execution plan of a query can help identify bottlenecks.
   - **Query Hints**: Directing the query optimizer to use specific indexes or join strategies.
   - **Materialized Views**: Precomputed results that can be used for complex queries to improve performance.
   - **Partition Pruning**: Ensuring that only relevant partitions are scanned to improve performance.
