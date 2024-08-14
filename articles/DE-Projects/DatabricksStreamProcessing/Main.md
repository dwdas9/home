# Overview

This is a pipeline project and  shows a standard stream processing implementation. The pipeline has four stages, ingest, process, store and analysis.

The data is ingested from two sources, then we perform join on related records from each stream, and then calculate the average in real-time. The results are stored for further analysis.

Scenario: A taxi company collects data about each taxi trip. For this scenario, we assume there are two separate devices sending data. The taxi has a meter that sends information about each ride — the duration, distance, and pickup and dropoff locations. A separate device accepts payments from customers and sends data about fares. To spot ridership trends, the taxi company wants to calculate the average tip per mile driven, in real time, for each neighborhood.