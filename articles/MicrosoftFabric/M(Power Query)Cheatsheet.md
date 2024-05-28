---
layout: default
title: M(Power Query Formula Lang) Cheatsheet
parent: MicrosoftFabric
nav_order: 4
---

## **M Language** Cheatsheet for Data Transformation

The **M langugage**, also knowne as **Power Query Formula Language** is the formula language used in Power Query, a data connectivity and data preparation technology in Excel and Power BI. M is designed for data manipulation and transformation. This cheatsheet covers the basics and common transformations in M language.

#### **Basic Syntax**
- **Comments**: 
  ```m
  // Single-line comment
  /* Multi-line comment */
  ```

- **Variables**: 
  ```m
  let
      VariableName = Expression
  in
      VariableName
  ```

#### **Data Types**
- **Numeric**: `1`, `1.0`
- **Text**: `"Hello"`
- **Boolean**: `true`, `false`
- **Null**: `null`
- **List**: `{1, 2, 3}`
- **Record**: `[FieldName = Value]`
- **Table**: `#table({"Column1", "Column2"}, {{1, "A"}, {2, "B"}})`

#### **Basic Functions**
- **Text Functions**:
  ```m
  Text.Length("Hello")               // Returns 5
  Text.Upper("Hello")                // Returns "HELLO"
  Text.Lower("HELLO")                // Returns "hello"
  Text.Combine({"Hello", "World"}, " ") // Returns "Hello World"
  ```

- **Numeric Functions**:
  ```m
  Number.Round(1.234, 2)             // Returns 1.23
  Number.Abs(-5)                     // Returns 5
  Number.Power(2, 3)                 // Returns 8
  ```

- **Date Functions**:
  ```m
  Date.FromText("2024-05-28")        // Returns a date value
  Date.Year(DateTime.LocalNow())     // Returns the current year
  Date.AddDays(DateTime.LocalNow(), 5) // Adds 5 days to the current date
  ```

- **Logical Functions**:
  ```m
  if condition then trueValue else falseValue
  // Example:
  if 1 > 0 then "Positive" else "Negative" // Returns "Positive"
  ```

#### **Table Functions**
- **Creating a Table**:
  ```m
  #table({"Column1", "Column2"}, {{1, "A"}, {2, "B"}})
  ```

- **Adding a Column**:
  ```m
  Table.AddColumn(Source, "NewColumn", each [Column1] * 2)
  ```

- **Renaming Columns**:
  ```m
  Table.RenameColumns(Source, {{"OldColumnName", "NewColumnName"}})
  ```

- **Removing Columns**:
  ```m
  Table.RemoveColumns(Source, {"ColumnToRemove"})
  ```

- **Filtering Rows**:
  ```m
  Table.SelectRows(Source, each [Column1] > 1)
  ```

- **Grouping Rows**:
  ```m
  Table.Group(Source, {"ColumnToGroupBy"}, {{"NewColumnName", each List.Sum([ColumnToSum]), type number}})
  ```

#### **List Functions**
- **Creating a List**:
  ```m
  {1, 2, 3, 4, 5}
  ```

- **List Transformations**:
  ```m
  List.Transform({1, 2, 3}, each _ * 2)  // Returns {2, 4, 6}
  List.Sum({1, 2, 3})                    // Returns 6
  List.Contains({1, 2, 3}, 2)            // Returns true
  ```

#### **Common Transformations in Power Query**
- **Changing Data Types**:
  ```m
  Table.TransformColumnTypes(Source, {{"ColumnName", type number}})
  ```

- **Merging Queries**:
  ```m
  Table.NestedJoin(Table1, {"KeyColumn"}, Table2, {"KeyColumn"}, "NewColumn")
  ```

- **Appending Queries**:
  ```m
  Table.Combine({Table1, Table2})
  ```

- **Pivoting Columns**:
  ```m
  Table.Pivot(Source, List.Distinct(Source[ColumnToPivot]), "ColumnToPivot", "ValueColumn")
  ```

- **Unpivoting Columns**:
  ```m
  Table.UnpivotOtherColumns(Source, {"ColumnToKeep"}, "Attribute", "Value")
  ```

### Example Transformation Script

Here’s a simple example of a data transformation script in M:

```m
let
    // Load data from a source
    Source = Excel.Workbook(File.Contents("C:\Data\Example.xlsx"), null, true),
    Sheet = Source{[Name="Sheet1"]}[Data],
    
    // Rename columns
    RenamedColumns = Table.RenameColumns(Sheet, {{"Column1", "ProductID"}, {"Column2", "SalesAmount"}}),
    
    // Change data types
    ChangedTypes = Table.TransformColumnTypes(RenamedColumns, {{"ProductID", Int64.Type}, {"SalesAmount", type number}}),
    
    // Filter rows
    FilteredRows = Table.SelectRows(ChangedTypes, each [SalesAmount] > 100),
    
    // Add a calculated column
    AddedColumn = Table.AddColumn(FilteredRows, "SalesTax", each [SalesAmount] * 0.1),
    
    // Sort the table
    SortedTable = Table.Sort(AddedColumn, {{"SalesAmount", Order.Descending}})
in
    SortedTable
```

### Conclusion

M languge is very useful for ETL. For example, you want to ingest data using Dataflow in Fabric. For the transformation you would definiately prefer M over other options.