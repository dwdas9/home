# README

<ul>
  <li style="color: #333333;"> 
    <strong style="color: #007ACC;">Synapse Analytics</strong> (formerly 
    <span style="color: #FF4500;">Azure SQL Warehouse</span>) is Azure SQL Data Warehouse evolved into an ADLS-based engine that processes both structured and unstructured data.
  </li>

  <li style="color: #333333;"> 
    <strong style="color: #007ACC;">Azure Data Factory (ADF)</strong> is 
    <strong style="color: #FF6347;">NOT:</strong>
    <ul>
      <li style="color: #666666;"> A <span style="color: #FFB6C1;">data migration tool</span>.</li>
      <li style="color: #666666;"> Suited for <span style="color: #FFA07A;">streaming workloads</span>. Instead, use <span style="color: #20B2AA;">Event Hubs</span>, <span style="color: #3CB371;">IoT Hub</span>, or <span style="color: #6B8E23;">Spark Streaming with Kafka</span>.</li>
      <li style="color: #666666;"> Ideal for <span style="color: #B0C4DE;">complex transformations</span>. Opt for <span style="color: #4682B4;">Databricks</span> or <span style="color: #8A2BE2;">HDInsight</span>.</li>
      <li style="color: #666666;"> A <span style="color: #FFD700;">data storage solution</span>.</li>
    </ul>
  </li>

  <li style="color: #333333;"> 
    <strong style="color: #007ACC;">Dataset</strong> in 
    <span style="color: #DC143C;">ADF</span> is like a 
    <strong style="color: #8B4513;">bookmark</strong> to your data. It doesn't hold the data but points to where it is, whether that's a table, a file, or a folder. Think of it as an address.
  </li>
</ul>
