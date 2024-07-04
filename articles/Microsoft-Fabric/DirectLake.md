---
layout: default
title: DirectLake|Fabric|PowerBI
parent: MicrosoftFabric
nav_order: 2
---

# <span style="color:slateblue;">DirectLake Mode in Fabric</span>

![alt text](<1 (9).png>)

DirectLake is the **third** and **newest** **data handling technique** in **Microsoft Fabric** for Power BI. Before understanding DirectLake, let's first look at the other two modes:

Let's say you have <span style="color:teal;">10 GB of data</span> stored in a <span style="color:darkorange;">SQL Server</span> and you want to create a dashboard. Before DirectLake, you had two options to handle the data:

### <span style="color:Maroon;">Import Mode

In Import mode, <span style="color:indigo;">Power BI</span> reads the data from your SQL Server, compresses it (e.g., from 10 GB to 1 GB), and stores it as columns in `*.pbix` files (Power BI Desktop) or `*.idf` files (Power BI service).

When you create a report and apply filters, sums, etc., Power BI will smartly load only the required data into RAM, perform the calculations, and generate the visuals. However, everything happens on the Power BI side, cutting you off from your original SQL Server. If your SQL Server has new data, you have two options: reload all the data (<span style="color:slateblue;">Full refresh</span>) or load only the new data (<span style="color:goldenrod;">Incremental refresh</span>, available in Power BI Premium).

### <span style="color:Green;">DirectQuery Mode

If you always want the freshest data on your dashboard, you can use DirectQuery mode. In DirectQuery mode, Power BI doesn’t import the data but directly queries the SQL Server. Every Power BI report generates a DAX query, regardless of the mode. In DirectQuery mode, DAX queries are translated into SQL, sent to the SQL Server, executed there, and the results are returned.

This ensures you always see the <span style="color:goldenrod;">freshest data</span>. However, network bandwidth, large data volumes, and frequent interactions might result in slowness or out-of-memory issues.

**To summarize:**
- **Import Mode**: Compresses and stores data locally, making reports fast and interactive, but requires periodic refreshes to get new data.
- **DirectQuery Mode**: Provides always-fresh data by querying the live SQL Server directly, but may be slower and more resource-intensive.

### <span style="color:DarkCyan;">DirectLake Mode

DirectLake mode is similar to Import mode, but it uses .parquet files directly instead of .idf files. The key requirement is that the data **must** be in **OneLake** as **.parquet** files. This avoids the need to save data from SQL Server into new .idf files, preventing data duplication.

If you have 10GB of data for reporting, Import mode loads the entire dataset into memory (smartly), even if you don't need all the columns. In contrast, DirectLake mode only loads the data related to the columns used in your report, making it more efficient.

If the data size exceeds a certain limit, DirectLake mode automatically switches to DirectQuery mode.

**Regarding refresh:** Any changes in the Delta Lake files are automatically detected, and the report datasets are refreshed intelligently. Only the metadata is refreshed and synced, making DirectLake refreshes very quick, often taking less than 10 seconds. In Import mode, the refresh loads the data into memory, which takes longer.

## <span style="color:CornflowerBlue;">Pros and Cons of DirectLake - Personal Views

### <span style="color:DarkGoldenRod;">DirectLake Mode DOES NOT replace any mode

Fabric has Import Mode and DirectQuery Mode. DirectLake is just the third and newest option. It provides near-real-time reports like Import Mode but not real real-time like DirectQuery.

### <span style="color:Crimson;">It is not the best of both worlds

This mode is unique, but it’s not faster than Import mode and doesn’t replace DirectQuery's special features.

### <span style="color:BlueViolet;">DirectLake Vs Import Mode

DirectLake can be as good as Import mode but not better. It can sometimes be slower compared to Import mode.

Import mode and DirectLake take the same amount of memory. DirectLake uses the same 'Import Required Columns in Memory' approach like Import mode. So it’s not special.

The only difference is in Import Mode, when the memory is less, it gives an out-of-memory exception, and in DirectLake, it switches to DirectQuery. This happens if your data is around 300 GB.

### <span style="color:Olive;">Data Modeling has limitations in DirectLake

You cannot use calculated columns, calculated tables, and MDX user hierarchies in DirectLake. This impacts Excel’s user experience when consuming semantic models published on Power BI. Also, DirectLake models created in Fabric have case-sensitive collation.

### <span style="color:BurlyWood;">DirectLake requires real physical tables - no room for views

When you use views in DirectLake, the mode changes to DirectQuery. To use 100% DirectLake, all your tables must be real. This might require duplicating your data.

**Note:** We have option of creating shortcuts. Which comes as a relief.  But, I haven't tested the performance of shortcut data.

Hence, if you already use Import Mode or DirectQuery and everything works fine, there are no substantial benefits to moving to DirectLake.

## <span style="color:Navy;">Practical Scenario (DP-600 Question)

You have a Fabric tenant with a workspace named Workspace1, assigned to an F64 capacity, containing a lakehouse with one billion historical sales records, receiving up to 10,000 new or updated sales records every 15 minutes. You plan to build a custom Microsoft Power BI semantic model and reports from this data, requiring the best report performance and near-real-time data reporting.

**Which Power BI semantic model storage mode should you use?**

**Answer: DirectLake**

## <span style="color:Teal;">How Microsoft Advertises It

DirectLake storage mode offers near-real-time (NRT) access to data with performance close to Import storage mode, surpassing DirectQuery in terms of speed for large datasets. While DirectQuery provides NRT access, it can slow down with large datasets. Import Mode, though fast, requires data to be loaded into Power BI's memory, lacking NRT capabilities. Currently, DirectLake tables cannot be mixed with other table types (Import, DirectQuery, or Dual) within the same model, and composite models are not supported yet.

![MoveDataToOneLake](MoveDataToOneLake.png)

For further details, you can refer to the [Microsoft Fabric Direct Lake overview](https://learn.microsoft.com/en-us/fabric/get-started/direct-lake-overview).