---
layout: default
title: Python dummy data inserter
parent: Languages
---

## Python Script to Populate SQL Server Database Table with Randomized Data

This Python script populates a SQL Server database table, `dbo.student`, with random data. The `dbo.student` table should have:

- **id** (integer): A unique identifier for each student.
- **Name** (varchar): A randomly generated student's first name.
- **Age** (integer): A randomly generated age between 18 and 30.

Here's a step-by-step breakdown:

1. **Database Connection**: Connects to the `Oxford` SQL Server database using Windows Authentication (`Trusted_Connection=yes`).
2. **Row Count**: The `num_rows` variable determines how many rows of data to insert. Adjust this to change the number of rows added.
3. **Random Data with Faker**: Uses the `Faker` library to produce random student names.
4. **Get Last ID Value**: Checks the highest `id` in `dbo.student` to determine the next available ID. If no records are present, it starts from 0.
5. **Create INSERT Commands**: The script creates individual `INSERT` commands for each new student record.
6. **Run INSERT Commands**: Executes each `INSERT` command to add new rows to `dbo.student`.
7. **Commit and Disconnect**: Saves the changes and ends the database connection.

For the script to work, ensure the table exists. It's optimal to execute the script from Azure Data Studio on the server itself. Modify connection details if running from a different location.

---
```python
# Faker was not found hence we installed the faker library using pip. Alternatively you can  the command in terminal(mac) or command prompt(windows)
# Dont run it if faker already installed
pip install faker

```
```python
import pyodbc
from faker import Faker
import random

# Establish a connection to your SQL Server
conn = pyodbc.connect('Driver={SQL Server};'
                      'Server=.;'
                      'Database=Oxford;'
                      'Trusted_Connection=yes;')

# Define the number of rows to insert
num_rows = 1000  # Change this to the desired number of rows

# Create a Faker instance for generating random names
fake = Faker()

# Get the last primary key value in the table
cursor = conn.cursor()
cursor.execute("SELECT MAX(id) FROM dbo.student")
last_id = cursor.fetchone()[0]
if last_id is None:
    last_id = 0

# Generate and execute the INSERT statements
for i in range(1, num_rows + 1):
    last_id += 1  # Increment the primary key value
    student_name = fake.first_name()  # Generate a random first name
    student_age = random.randint(18, 30)  # Generate a random age between 18 and 30
    sql = f"INSERT INTO dbo.student VALUES ({last_id}, '{student_name}', {student_age})"
    cursor.execute(sql)

print("Executed succesfully. Rows updated: " + str(i))
# Commit the changes and close the connection
conn.commit()
conn.close()

```