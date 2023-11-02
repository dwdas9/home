---
layout: default
title: Azure SDK For Python Scripts
nav_order: 8
---

## Table of Contents
- [Overview](#overview)
  - [Azure SDK: Clean, Validate, \& Migrate JSONs](#azure-sdk-clean-validate--migrate-jsons)
  - [Azure SDK: Flatten JSONs](#azure-sdk-flatten-jsons)



# Overview

This article provides real-world examples of Python scripts from projects that I worked on that use the Azure SDK for Python to work with Azure Storage. These scripts can be useful in a variety of situations.

## <p style="color: blueviolet; font-family: Arial, sans-serif;font-size: medium;"><strong>Azure SDK: Clean, Validate, & Migrate JSONs</strong></p>

<span style="color: navy;">**Problem:**</span>
**JSON files in the source_container** are stored with **single quotes**, leading to **invalid schema issues**.

<span style="color: darkgreen;">**Solution:**</span> 

- **Change encoding** to **UTF-8**.
- **Modify single quotes** to **double quotes**.
- **Validate against a JSON schema** post-modification.
- **Move Data:** Move to **dest_container**.
- **Optinal:** Convert to an Azure Function.

**Tech stack:** ADLS, Azure SDK/Libs, Azure Functions. [Read more...](articles/Misc/JsonValidator/BulkJsonValidator.html)


## <p style="color: RosyBrown; font-family: Arial, sans-serif;font-size: medium;"><strong>Azure SDK: Flatten JSONs</strong></p>

<span style="color: navy;">**Problem:**</span>
The source container has a lot of JSON files in nested format. They need to be flattened.

<span style="color: darkgreen;">**Solution:**</span> 

- **Flatten** the source json files using Azure SDK(libs), BlobServiceClient
- **Move** the files to a destination container or simply replace the source files
- **Optinal:** Convert to an Azure Function.

**Tech stack:** ADLS, Azure SDK For Python, Azure Functions. [Read more...](articles/Misc/JsonFlatternerAzureSDK/JsonFlatAzureSDK.html)


---

© D Das  
📧 [das.d@hotmail.com](mailto:das.d@hotmail.com) | [ddasdocs@gmail.com](mailto:ddasdocs@gmail.com)