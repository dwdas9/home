## Background

Azure data factory is same old in Fabric.

## Pipelines in Microsoft Fabric

### **<span style="color:green;">Understand Pipelines</span>**  
- Pipelines encapsulate activities for data movement and processing.
- Graphical interface allows building complex pipelines with minimal coding.

### **<span style="color:green;">Core Pipeline Concepts</span>**  
#### **<span style="color:blue;">Activities</span>**: Executable tasks in a sequence. Two types:
  - **<span style="color:magenta;">Data Transformation</span>**: Transfers and transforms data (e.g., Copy Data, Data Flow, Notebook, Stored Procedure).
  - **<span style="color:magenta;">Control Flow</span>**: Implements loops, conditional branching, and manages variables.

#### **<span style="color:blue;">Parameters</span>**
Enable specific values for each run, increasing reusability.

#### **<span style="color:blue;">Pipeline Runs</span>**
Executed on-demand or scheduled. Unique run ID for tracking and reviewing each execution.

## Canvas for desinign piplines

Fabric offers a Canvas where you can build complex pipeliens without much coding:

![alt text](image-31.png)

## The Copy Data Activity

The **Copy Data** is the most important activity in data pipelines. Some pipelines only contain one Copy Data activity, thats all!

### The Copy Data Tool

![alt text](image-32.png)