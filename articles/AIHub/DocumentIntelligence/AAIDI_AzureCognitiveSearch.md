
# Integrate AI Search and Azure AI Document Intelligence

## Overview

In this module, you'll learn how to create a AI Search custom skill that calls a model in Azure AI Document Intelligence to improve indexing documents.

Learning objectives
Describe how a custom skill can enrich content passed through an Azure AI Search pipeline.
Build a custom skill that calls an Azure AI Document Intelligence solution to index data from forms.


## Case Study

You have thousands of marriage certificates stored in a data lake and wish to search them using key-value pairs (e.g., "Girlfriend_Name = 'Rita'"). You are evaluating two options:

### Solution 1 - ADLS Files -> Azure Cognitive Search

You implement Azure Cognitive Search, which will automatically process the files by opening them, performing OCR, and indexing the extracted data. It offers many built-in features, including sentiment analysis. However, the cornerstone of effective search capabilities is the quality of the OCR output. Since the OCR provided by Azure Cognitive Search is basic, any search functionality relying on this OCR output may yield suboptimal results.

### Solution 2 - ADLS Files -> Azure AI Document Intelligence -> Azure Cognitive Search

By creating a custom extraction model tailored for your marriage certificates, Azure AI Document Intelligence can provide highly accurate OCR results. After processing the certificates with this custom model, you then index the extracted data using Azure Cognitive Search. This approach enables robust search capabilities that significantly surpass the effectiveness of using Azure Cognitive Search's basic OCR alone.


## How to implement Solution 2

To integrate Azure AI Document Intelligence into the AI Search indexing process:

Use AAIDI document model(prebuilt/custom) to extract data from the marriage certificates.
Write a web service that can integrate custom skill with Azure AI Document Intelligence resource. In this module, you'll use an Azure Function to host this service.
Add a custom web API skill, with the correct configuration to the AI Search skillset. This skill should be configured to send requests to the web service.

## What is a skill in Azure Cognitive Search

Skills are like identifying the language of documents, recognizing logos, or detecting names of places. Skills can pre-built or custom-built. During the indexing process, these skills are applied one after another, to make the ocred data more searchable.

They add more Indexing data to make Azure cognitive search better.

### Types of custom skill

#### Azure Machine Learning (AML) Custom Skills
You can use a model from Azure Machine Learning to create a custom skill.

#### Custom Web API Skills
These are simply custom skills provided as web api. The connect to services like Azure Document Intellingece etc.


## Build an Azure AI Document Intelligence custom skill



---
## Appendix

### Stages of Indexing process

There are five stages to the indexing process:

Document Cracking. In document cracking, the indexer opens the content files and extracts their content.
Field Mappings. Fields such as titles, names, dates, and more are extracted from the content. You can use field mappings to control how they're stored in the index.
Skillset Execution. In the optional skillset execution stage, custom AI processing is done on the content to enrich the final index.
Output field mappings. If you're using a custom skillset, its output is mapped to index fields in this stage.
Push to index. The results of the indexing process are stored in the index in Azure AI Search.
