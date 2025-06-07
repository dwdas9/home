## Build an MSSQL table from CSV schema, split large CSVs, and populate rows using Pandas.

How to use python to create a MSSQL table from the schema of a csv file. Split the large csv file into manageable smaller chunks and upload the data from these segments into the SQL server table.
The code is divided into three main parts:

### Part 1: Creating an MSSQL Table from a CSV Schema
1.    Establish a connection to an MSSQL Server using specified connection details.
2.    Read a large CSV file into a pandas DataFrame.
3.    Define a mapping of pandas data types to SQL Server data types.
4.    Create a list of column definitions with data types based on DataFrame's columns.
5.    Generate an SQL statement to create a new table in the MSSQL database using the column definitions.
6.    Execute the SQL statement to create the table.

```Python
# Import necessary libraries
import pyodbc
import pandas as pd

# Establish a connection to the SQL Server (replace placeholders with your server details)
conn = pyodbc.connect('DRIVER={Your_ODBC_Driver};SERVER=Your_Server;DATABASE=Your_Database;UID=Your_Username;PWD=Your_Password')

#Example: conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER=localhost;DATABASE=Nyctaxi;UID=sa;PWD=Passw_r123')

# Specify the path to your large CSV file
large_csv_file = 'path_to_your_large_csv_file.csv'

# Read the CSV file into a pandas DataFrame
df = pd.read_csv(large_csv_file)

# Define a mapping of pandas data types to SQL Server data types
data_type_mapping = {
    'int64': 'BIGINT',
    'float64': 'FLOAT',
    'object': 'VARCHAR(MAX)',  # Use VARCHAR(MAX) for string data
    # Add more mappings as needed for other data types
}

# Create a list of column definitions with data types
column_definitions = [f'{col} {data_type_mapping[str(df[col].dtype)]}' for col in df.columns]

# Create a SQL statement to create the table
create_table_sql = f'''
    CREATE TABLE YourTableName (
        {', '.join(column_definitions)}
    )
'''

# Execute the SQL statement to create the table
cursor = conn.cursor()
cursor.execute(create_table_sql)
cursor.commit()

# Close the database connection
conn.close()
```

### Part 2: Splitting the Large CSV into Smaller Chunks
 
1.    Define the desired number of rows per chunk to manage data processing.
2.    Read the large CSV file in chunks of the specified size.
3.    Specify a directory to save the CSV chunks.
4.    Iterate through the chunks and save them as separate CSV files in the directory.

```python

# Define the desired number of rows per chunk
rows_per_chunk = 10000  # Adjust this number as needed

# Read the large CSV file in chunks
chunk_size = rows_per_chunk
chunks = pd.read_csv(large_csv_file, chunksize=chunk_size)

# Directory to save the CSV chunks
csv_chunks_directory = 'Path to the folder where split files will be placed'

#Remember, for windows use C:/Users/rocky [forward slash] or C:\\Users\\rocky [double back slash]

# Iterate through the chunks and save them as separate CSV files
chunk_number = 0
for chunk in chunks:
    chunk_number += 1
    chunk.to_csv(f'{csv_chunks_directory}/chunk_{chunk_number}.csv', index=False)

print(f'Split into {chunk_number} chunks.')
```

### Part 3: Importing Data from Split Files with Error Handling
1.    Initialize a new database connection (separate from Part 1) as we have closed the previous connection.
2.    Define the directory where CSV chunks from Part 2 are located.
3.    Define a file to log rows with errors.
4.    Iterate through the CSV chunks in the directory.
5.    Read CSV data into a pandas DataFrame for each chunk.
6.    Prepare an SQL INSERT statement for the database table created in Part 1.
7.    Create a cursor for database operations.
8.    Iterate through the rows in the DataFrame and attempt to insert each row into the SQL Server table.
9.    Incorporate error handling to log errors during insertion and continue with the next row.
10. Commit the transaction after processing each chunk of data.
11. Close the error log file and the database connection.

```python

import os
import pandas as pd
import pyodbc

# Initialize your database connection. Refer to part one for details.
conn = pyodbc.connect("your_connection_string_here")

#Example, #Example: conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER=localhost;DATABASE=Nyctaxi;UID=sa;PWD=Passw_r123')

# Define the directory where CSV chunks are located
csv_chunks_directory = "your_csv_directory_here"

# Define a file to log rows with errors
error_log_file = "error_log.txt"

# Open the error log file in append mode
with open(error_log_file, 'a') as error_log:
    # Iterate through the CSV chunks and load them into the SQL Server table
    for filename in os.listdir(csv_chunks_directory):
        if filename.endswith(".csv"):
            csv_file_path = os.path.join(csv_chunks_directory, filename)
            
            # Read the CSV chunk into a pandas DataFrame
            df = pd.read_csv(csv_file_path)
            
            # Prepare an SQL INSERT statement
            insert_sql = f"INSERT INTO dbo.yellowtaxitrips ({', '.join(df.columns)}) VALUES ({', '.join(['?']*len(df.columns))})"
            
            # Create a cursor
            cursor = conn.cursor()
            
            # Iterate through the rows and insert them into the SQL Server table
            for _, row in df.iterrows():
                try:
                    cursor.execute(insert_sql, tuple(row))
                except pyodbc.Error as e:
                    # Log the error and the problematic row to the error log file
                    error_log.write(f"Error: {e}\n")
                    error_log.write(f"Problematic Row: {row}\n")
                    error_log.write("\n")  # Add a separator for readability
                    continue  # Skip this row and continue with the next one
            
            # Commit the transaction
            conn.commit()
    
    # Close the error log file
    error_log.close()

# Close the database connection
conn.close()
```

### Conclusion

The script is effective for analyzing large datasets and predicting column types. However, for large files, it's not recommended to use it for splitting and importing. Instead, SSIS would be a better choice. SQL Server Bulk Import is the fastest method for well-defined files. Although SSIS is notably fast, the SQL Server Import and Export Data Wizard (an SSIS tool) crashes with large csv files(1 GB). It's advisable to use the SSIS studio in Visual Studio with the mainstream version.