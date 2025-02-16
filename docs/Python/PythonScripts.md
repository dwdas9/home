---
layout: default
title: Python Sample Scripts
parent: Python Ecosystem
nav_order: 1
has_children: true
---

# Csv files creator with random data

## Employee CSV creator
Here's a Python script to create CSV files with random values for specific fields. You can decide how many files to create and how many rows each file should have. This script uses the `Faker` library to generate realistic random data.

> So, before running the script, you must install `Faker`, or you will get `ModuleNotFoundError: No module named 'faker'`.

```bash
pip install faker
```

Then, run the script from Jupyter notebook or save it as a .py file and run it from the terminal:

```python
import csv
import os
from faker import Faker

# Initialize Faker. This is the non-sense value creator. Haha
fake = Faker()

def generate_random_data(num_rows):
    data = []
    for _ in range(num_rows):
        row = {
            'id': fake.unique.random_int(min=1, max=1000000),
            'first_name': fake.first_name(),
            'last_name': fake.last_name(),
            'passport_number': fake.unique.bothify(text='???########'),
            'country': fake.country(),
            'date_of_birth': fake.date_of_birth(minimum_age=18, maximum_age=80),
            'profession': fake.job()
        }
        data.append(row)
    return data

def create_csv_file(file_name, num_rows):
    data = generate_random_data(num_rows)
    with open(file_name, mode='w', newline='') as file:
        writer = csv.DictWriter(file, fieldnames=data[0].keys())
        writer.writeheader()
        writer.writerows(data)

def create_multiple_files(num_files, num_rows):
    for i in range(num_files):
        file_name = f'file_{i+1}.csv'
        create_csv_file(file_name, num_rows)
        print(f'Created {file_name}')

# Provide the number of files and no of rows per file
num_files = 5  # Change this to the number of files you want to create
num_rows = 100  # Change this to the number of rows per file

create_multiple_files(num_files, num_rows)
```

> Note: The files are outputted to the current working directory. To know use this command:
> ```python 
> import os
> os.getcwd()
> ```

### Output Information

The script creates CSV files with the following columns:
- `id`: A unique identifier for each row
- `first_name`: A randomly generated first name
- `last_name`: A randomly generated last name
- `passport_number`: A randomly generated passport number
- `country`: A randomly generated country name
- `date_of_birth`: A randomly generated date of birth
- `profession`: A randomly generated profession

### Sample Row

Here is an example of what a row in the CSV file might look like:
```
id,first_name,last_name,passport_number,country,date_of_birth,profession
123456,John,Doe,ABC123456789,United States,1980-05-15,Software Developer
```

### Customization

To change the number of files created, modify the `num_files` variable. To change the number of rows in each file, modify the `num_rows` variable. For example, to create 10 files with 50 rows each, set:

```python
num_files = 10
num_rows = 50
```

Then, run the script, and it will generate the specified number of CSV files with the desired number of rows.

## Insurance - Policy Issuance Process

Python script to generate CSV files specifically for the Policy Issuance Process. 

```python
import csv
import os
from faker import Faker
from datetime import datetime

# Initialize Faker
fake = Faker()

def generate_random_data(num_rows, start_index):
    data = []
    for i in range(num_rows):
        # Use timestamp and start_index to generate a unique policy number
        policy_number = f'{start_index + i}_{int(datetime.now().timestamp() * 1000)}'
        
        row = {
            'policy_number': policy_number,
            'policyholder_name': fake.name(),
            'insured_name': fake.name(),
            'policy_type': fake.random_element(elements=('Life', 'Health', 'Auto', 'Home')),
            'effective_date': fake.date_this_decade(),
            'expiration_date': fake.date_this_decade(),
            'premium_amount': round(fake.random_number(digits=5), 2),
            'beneficiary_name': fake.name(),
            'beneficiary_contact': fake.phone_number(),
            'agent_name': fake.name(),
            'agent_contact': fake.phone_number(),
            'coverage_details': fake.sentence(nb_words=6),
            'endorsements_riders': fake.sentence(nb_words=4),
            'underwriter_name': fake.name()
        }
        data.append(row)
    return data

def create_csv_file(file_name, num_rows, start_index):
    data = generate_random_data(num_rows, start_index)
    with open(file_name, mode='w', newline='') as file:
        writer = csv.DictWriter(file, fieldnames=data[0].keys())
        writer.writeheader()
        writer.writerows(data)

def create_multiple_files(num_files, num_rows):
    for i in range(num_files):
        file_name = f'policy_issuance_file_{i+1}.csv'
        create_csv_file(file_name, num_rows, i * num_rows)
        print(f'Created {file_name}')

# Specify the number of files and rows per file
num_files = 5  # Change this to the number of files you want to create
num_rows = 100  # Change this to the number of rows per file

create_multiple_files(num_files, num_rows)

```

### Explanation:

1. **Fields**:
    - `policy_number`: A unique identifier for the policy.
    - `policyholder_name`: The name of the person holding the policy.
    - `insured_name`: The name of the person covered by the policy.
    - `policy_type`: The type of insurance (e.g., Life, Health, Auto, Home).
    - `effective_date`: The start date of the policy.
    - `expiration_date`: The end date of the policy.
    - `premium_amount`: The cost of the policy.
    - `beneficiary_name`: The name of the beneficiary.
    - `beneficiary_contact`: The contact details of the beneficiary.
    - `agent_name`: The name of the agent.
    - `agent_contact`: The contact details of the agent.
    - `coverage_details`: The specific coverage information.
    - `endorsements_riders`: Any additional terms or coverage.
    - `underwriter_name`: The name of the underwriter.

2. **generate_random_data(num_rows)**: Generates a list of dictionaries with random data for the specified number of rows.

3. **create_csv_file(file_name, num_rows)**: Creates a CSV file with the given file name and writes the generated random data into it.

4. **create_multiple_files(num_files, num_rows)**: Creates the specified number of CSV files, each with the specified number of rows.

To customize, you can change `num_files` to the number of files you want to create and `num_rows` to the number of rows per file. Save this script as `generate_policy_issuance_csv.py` and run it to generate your files.