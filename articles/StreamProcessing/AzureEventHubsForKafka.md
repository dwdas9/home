# Setup Azure Event Hubs to work with Kafka

Here I will show you how to use your Azure Event Hubs to work with Apache Kafka without doing any installation of Kafka.

Note: This feature in Azure is only for standard, premium and dedicated tiers.

## Overview

Azure event Hub **Natively** suppots Kafka. This means, it provides Kafka endpoint on an event hub. Using, this users can connect with Kafka using Kafka protocol. There is no code change reuiqred. You only have to do some configuration changes. You just have to connect to the Event Hubs Kafka endpoint rather than a Kafka cluster which you usually point to.

## Kafka vs Azure Event Hubs

They are very very similar. But, keep in mind Azure Event Hub is Micorosf's propertory(secret) product. Its not open source like Kafka. Also, Azure Event Hub uses different english names for the common concepts. Here is a table which you should be familar with:

Kafka Name	Event Hubs Name
Cluster	Namespace
Topic	An event hub
Partition	Partition
Consumer Group	Consumer Group
Offset	Offset

