# Architecture
Control Pane: Unity Catalog[Metastore, Access Control, Data Explorer] + Databricks web App, Cluster Manager, Workflow Manager, Jobs, Notebooks
Data Plane: Actual clusters(Compute resources) + Actual Data

Actual clusters - Data Plane
Cluster managers - Control pane
Data plane is where your data is processed. Where the cluseter mahcine stays.

3 Personas: Data Science and Engineering, Analyst, practitoner persona. It changes how your databricks will look.

# Notebook magic commands

%python, %sql
%sh(only master node)
%pip
%run execute a remote notebook from this notebook

# dbutils

dbutils.fs.ls()
dbutils.secrets.get()
dbutils.notebook.run()
dbutils.widget.text()
dbutils.jobs.taskValues.set()


