# <span style="color: MediumOrchid; font-family: Segoe UI, sans-serif;">Connecting Databricks Community Edition with dbt on Your Windows Machine</span>

## <span style="color: #AD49B3; font-family: Segoe UI, sans-serif;">Introduction</span>

Connecting Databricks Community Edition with dbt (Data Build Tool) allows you to manage your data transformations effectively. This guide will walk you through the process of integrating Databricks with dbt on your Windows machine.

## <span style="color: #AD49B3; font-family: Segoe UI, sans-serif;">1. Setting Up Your dbt Profile</span>

### <span style="color: #963F9C; font-family: Segoe UI, sans-serif;">Step 1: Create the `profiles.yml` File</span>

1. Open your text editor (like Notepad or VS Code) and create a new file called `profiles.yml`.
2. Save this file in the `~/.dbt/` directory on your Windows machine. If the directory doesn’t exist, you can create it.

### <span style="color: #963F9C; font-family: Segoe UI, sans-serif;">Step 2: Configure Your Databricks Connection</span>

Add the following configuration to the `profiles.yml` file:

```yaml
databricks:
  target: dev
  outputs:
    dev:
      type: databricks
      schema: default
      host: https://<your-databricks-instance>.databricks.com
      http_path: /sql/1.0/endpoints/<your-http-path>
      token: <your-databricks-token>
      file_format: delta
```

- **`<your-databricks-instance>`**: Replace this with your Databricks workspace URL, such as `community.cloud.databricks.com`.
- **`<your-http-path>`**: Find this in Databricks under "Clusters > Advanced Options > JDBC/ODBC."
- **`<your-databricks-token>`**: Generate this token in Databricks under "User Settings > Access Tokens."

## <span style="color: #AD49B3; font-family: Segoe UI, sans-serif;">2. Initializing a dbt Project</span>

### <span style="color: #963F9C; font-family: Segoe UI, sans-serif;">Step 1: Create Your Project Directory</span>

In your Command Prompt, create a new directory for your dbt project:

```bash
mkdir dbt_project
cd dbt_project
```

### <span style="color: #963F9C; font-family: Segoe UI, sans-serif;">Step 2: Initialize the dbt Project</span>

Initialize a new dbt project by running:

```bash
dbt init my_dbt_project
```

This will create the necessary files and folders for your dbt project.

## <span style="color: #AD49B3; font-family: Segoe UI, sans-serif;">3. Running dbt Commands</span>

### <span style="color: #963F9C; font-family: Segoe UI, sans-serif;">Step 1: Test the Connection</span>

Ensure your dbt is connected to Databricks by running:

```bash
dbt debug
```

You should see a success message if the connection is correctly set up.

### <span style="color: #963F9C; font-family: Segoe UI, sans-serif;">Step 2: Run Your dbt Models</span>

Write your SQL models in the `models/` directory, then run:

```bash
dbt run
```

This command will execute your models on the Databricks cluster.

### <span style="color: #963F9C; font-family: Segoe UI, sans-serif;">Step 3: Test and Document</span>

Run tests on your models to ensure everything is working correctly:

```bash
dbt test
```

Generate documentation for your models and serve it locally:

```bash
dbt docs generate
dbt docs serve
```

## <span style="color: #AD49B3; font-family: Segoe UI, sans-serif;">Conclusion</span>

You’ve successfully connected Databricks Community Edition with dbt on your Windows machine. Now you can efficiently manage and execute your data transformations.

---

## <span style="color: #682A6E; font-family: Segoe UI, sans-serif;">Appendix</span>

### <span style="color: #7F3585; font-family: Segoe UI, sans-serif;">Setting Up Python and Pip on Your Windows Machine</span>

1. Download Python from [python.org](https://www.python.org/downloads/) and install it. Ensure you check the box “Add Python to PATH” during installation.
2. Verify the installation by opening Command Prompt and typing:

   ```bash
   python --version
   ```

   ```bash
   pip --version
   ```

### <span style="color: #7F3585; font-family: Segoe UI, sans-serif;">Setting Up Databricks Community Edition</span>

1. Sign up for Databricks Community Edition at [Databricks Community Edition](https://community.cloud.databricks.com/) or log in if you already have an account.
2. Create a new cluster by navigating to "Clusters" and clicking "Create Cluster."
3. After the cluster is created, note down the Cluster ID, which you will need later.

---

# <span style="color: #7A3DAA; font-family: Segoe UI, sans-serif;">Connect dbt with Microsoft SQL Server on Your Windows Machine</span>

In this article, we will guide you through the simple steps to connect dbt (Data Build Tool) with Microsoft SQL Server (MSSQL) on your Windows machine. This connection allows you to manage and transform your data stored in MSSQL using dbt.

### <span style="color: #653090; font-family: Segoe UI, sans-serif;">1. Install dbt-SQLServer Adapter</span>

To begin, you need to install the `dbt-sqlserver` adapter, which allows dbt to communicate with MSSQL.

1. Open the Command Prompt on your Windows machine.
2. Run the following command to install the adapter:

   ```bash
   pip install dbt-sqlserver
   ```

### <span style="color: #653090; font-family: Segoe UI, sans-serif;">2. Set Up the dbt Profile for MSSQL</span>

Next, you need to set up a profile in dbt that contains the connection details for your MSSQL Server.

#### <span style="color: #502276; font-family: Segoe UI, sans-serif;">Step 1: Locate or Create the `profiles.yml` File</span>

- On your Windows machine, locate the `~/.dbt/` directory. If this directory doesn’t exist, you can create it.
- Inside this directory, create a file called `profiles.yml`.

#### <span style="color: #502276; font-family: Segoe UI, sans-serif;">Step 2: Add Your MSSQL Configuration</span>

Open the `profiles.yml` file in a text editor and add the following configuration:

```yaml
mssql_server:
  target: dev
  outputs:
    dev:
      type: sqlserver
      driver: 'ODBC Driver 17 for SQL Server'
      server: '<your_server_name>'
      port: 1433
      database: '<your_database_name>'
      schema: 'dbo'
      user: '<your_username>'
      password: '<your_password>'
      trusted_connection: 'no'
```

- Replace `<your_server_name>` with the name or IP address of your MSSQL Server.
- Replace `<your_database_name>` with the name of your database.
- Replace `<your_username>` and `<your_password>` with your SQL Server login credentials.

### <span style="color: #653090; font-family: Segoe UI, sans-serif;">3. Test the Connection</span>

Once the profile is set up, it’s important to test the connection to make sure everything is configured correctly.

1. Open the Command Prompt.
2. Navigate to your dbt project directory.
3. Run the following command:

   ```bash
   dbt debug
   ```

If everything is correct, dbt will connect to your MSSQL Server and show a success message.

### <span style="color: #653090; font-family: Segoe UI, sans-serif;">4. Use dbt with MSSQL</span>

Now that your connection is set up, you can start using dbt to manage your data in MSSQL.

#### <span style="color: #502276; font-family: Segoe UI, sans-serif;">Step 1: Initialize a dbt Project</span>

If you don’t already have a dbt project, you can create one with the following command:

```bash
dbt init my_mssql_project
```

This will set up a new dbt project with the necessary files and folders.

#### <span style="color: #502276; font-family: Segoe UI, sans-serif;">Step 2: Create and Run Models</span>

1. In the `models/` directory of your dbt project, create a new SQL file, such as `my_model.sql`.
2. Write your SQL queries in this file.

For example:

```sql
SELECT *
FROM <your_table_name>
```

3. Run your models using the following command:

   ```bash
   dbt run
   ```

This will execute the SQL queries on your MSSQL Server.

### <span style="color: #653090; font-family: Segoe UI, sans-serif;">5. Optional: Using Windows Authentication</span>

If your MSSQL Server uses Windows Authentication, modify the `profiles.yml` file like this:

```yaml
mssql_server:
  target: dev
  outputs:
    dev:
      type: sqlserver
      driver: 'ODBC Driver 17 for SQL Server'
      server: '<your_server_name>'
      port: 1433
      database: '<your_database_name>'
      schema: 'dbo'
      trusted_connection: 'yes'
```

With this configuration, you don’t need to specify a username or password.

### <span style="color: #653090; font-family: Segoe UI, sans-serif;">Conclusion</span>

You’ve now successfully connected dbt to your Microsoft SQL Server on a Windows machine. With this setup, you can efficiently manage and transform your data stored in MSSQL using dbt.

---