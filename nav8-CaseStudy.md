---
layout: default
title: Case Studies
nav_order: 8
---

## Table of Contents
- [Overview](#overview)
  - [Cleanup, Validate and Sort JSON Files using Azure Functions](#cleanup-validate-and-sort-json-files-using-azure-functions)


# Overview

In this handy bunch of Python scripts, you'll find a bunch of quick-fixes and smart hacks primarily meant for folks working in Data Engineering and Data Science.

## Cleanup, Validate and Sort JSON Files using Azure Functions

In our project, we faced an issue with a plethora of JSON files obtained from a web API using Python. Since Python defaultly utilises ASCII formatting, the JSON data in our files used single quotes, which deviated from the standard JSON format (utilizing double quotes ""). Our objective was to transform this data into UTF-8 format and validate each file against a specific JSON schema. Based on the validation results, files would be sorted into either a "silver" or an "error" container. [Read more...](articles/Misc/JsonValidator/BulkJsonValidator.html)


---

© D Das  
📧 [das.d@hotmail.com](mailto:das.d@hotmail.com) | [ddasdocs@gmail.com](mailto:ddasdocs@gmail.com)