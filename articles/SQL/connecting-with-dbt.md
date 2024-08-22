# <span style="color: MediumOrchid; font-family: Segoe UI, sans-serif;">Connect Local dbt Setup with Databricks</span>

## <span style="color: #AD49B3; font-family: Segoe UI, sans-serif;">Introduction</span>

In this article I will show you how to connect your local dbt enviornment with Databricks. Follow the steps below to get started:

## <span style="color: #AD49B3; font-family: Segoe UI, sans-serif;">Steps to perform</span>

### <span style="color: #963F9C; font-family: Segoe UI, sans-serif;">Pip Install `dbt-SQLServer` Adapter</span>

To begin, you need to install the `dbt-sqlserver` adapter, which allows dbt to communicate with MSSQL.

Open the Command Prompt on your Windows machine and Run:

   ```bash
   pip install dbt-sqlserver
   ```


### <span style="color: #963F9C; font-family: Segoe UI, sans-serif;">Set Your dbt Profile Using `profiles.yml`</span>


Create `C:\Users\<your_user_name>\.dbt\profiles.yml` with the contents below:

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

- **`<your-databricks-instance>`**: Replace this with your Databricks workspace URL, such as `cloud.databricks.com`.
- **`<your-http-path>`**: Find this in Databricks under "Clusters > Advanced Options > JDBC/ODBC."
- **`<your-databricks-token>`**: Generate this token in Databricks under "User Settings > Access Tokens."

### <span style="color: #963F9C; font-family: Segoe UI, sans-serif;">Create Your Project Folder And Initialize It</span>

In your Command Prompt, create a new directory for your dbt project:

```bash
mkdir dbt_project
cd dbt_project
```

Initialize a new dbt project by running:

```bash
dbt init my_dbt_project
```
This will create the necessary files and folders for your dbt project.

### <span style="color: #963F9C; font-family: Segoe UI, sans-serif;">Test the Connection</span>

Ensure your dbt is connected to Databricks by running:

```bash
dbt debug
```

You should see a success message if the connection is correctly set up.

### <span style="color: #963F9C; font-family: Segoe UI, sans-serif;">Run Your dbt Models</span>

Write your SQL models in the `models/` directory, then run:

```bash
dbt run
```

This command will execute your models on the Databricks cluster.

### <span style="color: #963F9C; font-family: Segoe UI, sans-serif;">Test and Document</span>

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


## <span style="color: #AD49B3; font-family: Segoe UI, sans-serif;">Appendix</span>

### <span style="color: #7F3585; font-family: Segoe UI, sans-serif;">Setting Up Python and Pip on Your Windows Machine</span>

1. Download Python from [python.org](https://www.python.org/downloads/) and install it. Ensure you check the box “Add Python to PATH” during installation.
2. Verify the installation by opening Command Prompt and typing:

   ```bash
   python --version
   ```

   ```bash
   pip --version
   ```

### <span style="color: #7F3585; font-family: Segoe UI, sans-serif;">Setting Up Databricks</span>

You won't be able to connect dbt with Databricks community edition. You will need 'proper' Databricks for dbt.

---

# <span style="color: #7A3DAA; font-family: Segoe UI, sans-serif;">Connect Local dbt Setup with MSSQL</span>

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
# Das: This profiles.yml configuration is tested for:
# - SQL Server 2022 build 16.0.1121.4
# - Python 3.12.3
# - Registered adapter: sqlserver=1.7.4
# - dbt version: 1.7.18
# - Authentication: Windows Login

# Profile name should match what's in your dbt_project.yml
hello_mssql:

  # 'target' specifies the environment (e.g., dev, prod)
  target: dev

  # 'outputs' define configurations for environments
  outputs:

    # Configuration for the 'dev' environment
    dev:

      # Database type
      type: sqlserver

      # ODBC driver for SQL Server
      driver: 'ODBC Driver 17 for SQL Server'

      # SQL Server name or IP
      server: 'MOMO'

      # Default port for SQL Server
      port: 1433

      database: 'InsuranceDB'
      schema: 'dbo'

      # Use Windows login credentials
      trusted_connection: true

      # Enable encryption for data transmission
      encrypt: true

      # Trust the server's SSL certificate (useful for self-signed certificates)
      trust_cert: true
```

With this configuration, you don’t need to specify a username or password.

### <span style="color: #653090; font-family: Segoe UI, sans-serif;">Conclusion</span>

You’ve now successfully connected dbt to your Microsoft SQL Server on a Windows machine. With this setup, you can efficiently manage and transform your data stored in MSSQL using dbt.

---

## <span style="color: MediumOrchid; font-family: Segoe UI, sans-serif;">Errors</span>

### <span style="color: #AD49B3; font-family: Segoe UI, sans-serif;">1. Profiles.yml File is Invalid</span>

#### <span style="color: #963F9C; font-family: Segoe UI, sans-serif;">Error:</span>
When running `dbt debug`, an error appeared saying the `profiles.yml` file was invalid, with the message: `'yes' is not valid under any of the given schemas`.

#### <span style="color: #7F3585; font-family: Segoe UI, sans-serif;">Resolution:</span>
Change the value of `trusted_connection` from `'yes'` to `true` (without quotes) in the `profiles.yml` file. This ensures dbt correctly recognizes the trusted connection setting.

### <span style="color: #AD49B3; font-family: Segoe UI, sans-serif;">2. dbt_project.yml File Not Found</span>

#### <span style="color: #963F9C; font-family: Segoe UI, sans-serif;">Error:</span>
The `dbt debug` command failed because the `dbt_project.yml` file was not found in the project directory.

#### <span style="color: #7F3585; font-family: Segoe UI, sans-serif;">Resolution:</span>
Create a `dbt_project.yml` file in the project directory and ensure it correctly references the profile name used in the `profiles.yml` file.


### <span style="color: #AD49B3; font-family: Segoe UI, sans-serif;">3. Could Not Find Profile Named 'hello_mssql'</span>

#### <span style="color: #963F9C; font-family: Segoe UI, sans-serif;">Error:</span>
An error occurred because dbt couldn't find a profile named `hello_mssql`, even though the profile was set up in the `profiles.yml`.

#### <span style="color: #7F3585; font-family: Segoe UI, sans-serif;">Resolution:</span>
Ensure that the `profile` in `dbt_project.yml` matches the profile name in `profiles.yml`. For example, if the profile name is `mssql_server` in `profiles.yml`, make sure `dbt_project.yml` references `mssql_server`.

### <span style="color: #AD49B3; font-family: Segoe UI, sans-serif;">4. SSL Certificate Not Trusted</span>

#### <span style="color: #963F9C; font-family: Segoe UI, sans-serif;">Error:</span>
The connection to SQL Server failed with the error: `The certificate chain was issued by an authority that is not trusted`.

#### <span style="color: #7F3585; font-family: Segoe UI, sans-serif;">Resolution:</span>
To resolve this, add `trust_cert: true` to your `profiles.yml` file. This will bypass the SSL certificate validation error and allow dbt to connect to SQL Server.

