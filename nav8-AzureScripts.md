---
layout: default
title: Azure SDK For Python Scripts
nav_order: 8
---

## <span style="color: Chocolate;Font-family: Segoe UI, sans-serif;">Table of Contents</span>


- [Overview](#overview)
  - [Azure SDK: Clean, Validate, \& Migrate JSONs](#azure-sdk-clean-validate--migrate-jsons)
  - [Azure SDK: Flatten JSONs](#azure-sdk-flatten-jsons)

# <span style="color: SlateGray;">Overview</span>

This article includes practical examples of Python scripts from my own projects, using the Azure SDK for Python to interact with Azure Storage. These scripts are applicable in numerous scenarios.


## <span style="color: blueviolet;">Azure SDK: Clean, Validate, & Migrate JSONs</span>

<span style="color: navy;">**Problem:**</span>
**JSON files in the source_container** are stored with **single quotes**, leading to **invalid schema issues**.

<span style="color: darkgreen;">**Solution:**</span> 

- **Change encoding** to **UTF-8**.
- **Modify single quotes** to **double quotes**.
- **Validate against a JSON schema** post-modification.
- **Move Data:** Move to **dest_container**.
- **Optinal:** Convert to an Azure Function.

**Tech stack:** ADLS, Azure SDK/Libs, Azure Functions. [Read more...](articles/Misc/JsonValidator/BulkJsonValidator.html)

## <span style="color: ForestGreen;">Azure SDK: Flatten JSONs</span>


<span style="color: SteelBlue;">**Problem:**</span>
The source container has a lot of JSON files in nested format. They need to be flattened.

<span style="color: DarkSalmon;">**Solution:**</span> 

- **Flatten** the source json files using Azure SDK(libs), BlobServiceClient
- **Move** the files to a destination container or simply replace the source files
- **Optinal:** Convert to an Azure Function.

**Tech stack:** ADLS, Azure SDK For Python, Azure Functions. [Read more...](articles/Misc/JsonFlatternerAzureSDK/JsonFlatAzureSDK.html)

---

© D Das  
📧 [das.d@hotmail.com](mailto:das.d@hotmail.com) | [ddasdocs@gmail.com](mailto:ddasdocs@gmail.com)