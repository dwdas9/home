## Background

Synapse Real-Time Analytics in Fabric uses a KQL Database. In Fabric, you only need a source and a Kusto database to start streaming data in and out of Fabric and writing your queries using KQL. Microsoft Fabric also provides KQL Querysets that can be shared within the tenant and Power BI using what's known as quick create.

###  Synapse Real-Time Analytics - Let's get started

![alt text](images\realtimeint.png)

![alt text](images\fabricstartscreen.png)

Create a Eventhouse first - Eventhouses are groups of Databases.

When you create a Eventhouse Fabric will create a KQL Databse with the same name inside it.

![alt text](images\eventhouse.png)

![alt text](images\ingestsomedata.png)

Now save this csv table to dekstop and ingest this data into the KQL datbase:
https://raw.githubusercontent.com/MicrosoftLearning/dp-data/main/sales.csv

The data ingestion is pretty straightforward. Once you ingest you can see the table you created to ingest the data with the required columns:

![alt text](image-7.png)

### KQL - its so easy to learn


**Select where**

```kql
sales
| where Country == 'Peru'
```

**Select where multiple clause**
```kql
sales
| where Name == 'Tom'
| where Place == 'USA'
```

**Little more complex**

![alt text](images\littlemorecomplex.png)

### Create a Power BI report from KQL Queryset

Click on the 3 dots next to the table. Select Show any 100 records. It will open the KQL editor. Create your custom KQL query. You can either save it or create the Power BI report right from the editor.

![alt text](images\powerbikql.png)

## KQL Cheatsheet

Sure, here's the table without the "Learn more" column and with color coding for better readability:

| <span style="color: blue;">Category</span>                    | <span style="color: green;">SQL Query</span>                               | <span style="color: red;">Kusto Query</span>                                         |
|-----------------------------|----------------------------------------------|---------------------------------------------------|
| Select data from table      | SELECT * FROM Mango                          | Mango                                            |
|                             | SELECT name, resultCode FROM Mango           | Mango \| project name, resultCode                 |
|                             | SELECT TOP 100 * FROM Mango                  | Mango \| take 100                                 |
| Null evaluation             | SELECT * FROM Mango WHERE resultCode IS NOT NULL | Mango \| where isnotnull(resultCode)              |
| Comparison operators (date) | SELECT * FROM Mango WHERE timestamp > getdate()-1 | Mango \| where timestamp > ago(1d)                |
|                             | SELECT * FROM Mango WHERE timestamp BETWEEN ... AND ... | Mango \| where timestamp between (datetime(2020-01-01) .. datetime(2020-12-31)) |
| Comparison operators (string) | SELECT * FROM Mango WHERE type = "Apple"   | Mango \| where type == "Apple"                    |
|                             | SELECT * FROM Mango WHERE type like "%Apple%" | Mango \| where type has "Apple"                   |
|                             | SELECT * FROM Mango WHERE type like "Apple%" | Mango \| where type startswith "Apple" \| or \| Mango \| where type matches regex "^Apple.*" |
| Comparison (boolean)        | SELECT * FROM Mango WHERE !(success)         | Mango \| where success == False                   |
| Grouping, Aggregation       | SELECT name, AVG(duration) FROM Mango GROUP BY name | Mango \| summarize avg(duration) by name          |
| Distinct                    | SELECT DISTINCT name, type FROM Mango        | Mango \| summarize by name, type                  |
|                             | SELECT name, COUNT(DISTINCT type) FROM Mango GROUP BY name | Mango \| summarize by name, type \| summarize count() by name \| or \| Mango \| summarize dcount(type) by name |
| Column aliases, Extending   | SELECT operationName as Name, AVG(duration) as AvgD FROM Mango GROUP BY name | Mango \| summarize AvgD = avg(duration) by Name=operationName |
|                             | SELECT conference, CONCAT(sessionid, ' ', session_title) AS session FROM ConferenceSessions | ConferenceSessions \| extend session=strcat(sessionid, " ", session_title) \| project conference, session |
| Ordering                    | SELECT name, timestamp FROM Mango ORDER BY timestamp ASC | Mango \| project name, timestamp \| sort by timestamp asc nulls last |
| Top n by measure            | SELECT TOP 100 name, COUNT(*) as Count FROM Mango GROUP BY name ORDER BY Count DESC | Mango \| summarize Count = count() by name \| top 100 by Count desc |
| Union                       | SELECT * FROM Mango UNION SELECT * FROM Apple | union Mango, Apple                              |
|                             | SELECT * FROM Mango WHERE timestamp > ... UNION SELECT * FROM Apple WHERE timestamp > ... | Mango \| where timestamp > ago(1d) \| union (Apple \| where timestamp > ago(1d)) |
| Join                        | SELECT * FROM Mango LEFT OUTER JOIN Apple ON Mango.operation_Id = Apple.operation_Id | Mango \| join kind = leftouter (Apple) on $left.operation_Id == $right.operation_Id |
| Nested queries              | SELECT * FROM Mango WHERE resultCode = (SELECT TOP 1 resultCode FROM Mango WHERE resultId = 7 ORDER BY timestamp DESC) | Mango \| where resultCode == toscalar(Mango \| where resultId == 7 \| top 1 by timestamp desc \| project resultCode) |
| Having                      | SELECT COUNT(*) FROM Mango GROUP BY name HAVING COUNT(*) > 3 | Mango \| summarize Count = count() by name \| where Count > 3 |