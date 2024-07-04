---
layout: default
title: Python Snippets
parent: Languages
nav_order: 5
---

```python
import os
import getpass
print("Current user:", getpass.getuser())

# Directory to check
directory_to_check = "/data/spark-warehouse/test_db.db/films"

# Get the current user running the Spark application
current_user = getpass.getuser()
print(f"Current user: {current_user}")

# Check read, write, and execute permissions
has_read_permission = os.access(directory_to_check, os.R_OK)
has_write_permission = os.access(directory_to_check, os.W_OK)
has_execute_permission = os.access(directory_to_check, os.X_OK)

print(f"Read permission: {has_read_permission}")
print(f"Write permission: {has_write_permission}")
print(f"Execute permission: {has_execute_permission}")
```