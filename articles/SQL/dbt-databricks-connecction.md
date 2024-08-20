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
