---
layout: default
title: CMS Migration to Azure Blob
parent: DE-Projects
nav_order: 1
---

### Project Overview: Migrating and Enabling Search for Archived PDF Data in Azure Blob Storage

The client, had several hundred GBs of archived data, mostly in PDF format, stored in another CMS. The CMS incurred heavy licensing fees and was on-prem without any DR or HA.


The goal was to move this data to Azure Blob Storage and enable efficient search capabilities to improve accessibility and enable DR and reduce maintance costs from the current CMS system.

### Solution Implementation

We began by assessing the existing data structure, which was organized by deparment. We developed a migration plan to transfer the data in batches, ensuring minimal disruption to the client’s operations.

**Tools Used**:
- Azure Blob Storage
- PowerShell & AzCopy for scripting and automating the data migration process
- Azure Cognitive Search for indexing the content of the PDF files
- Azure Storage Explorer for manual verification and management of the files
- Azure SDKs for custom development and integration tasks

The migration process involved extracting data from the legacy CMS and staging it in a network folder. Using PowerShell scripts and AzCopy, we transferred these files to Azure Blob Storage, preserving the original directory structure by using paths in the blob names.

To enable searching within the uploaded PDFs, we set up Azure Cognitive Search. This involved creating a data source connected to the Azure Blob Storage container, defining an index to capture necessary metadata and content fields, and configuring an indexer to handle text extraction from PDFs.

The indexer was scheduled to run periodically to ensure that new files were indexed promptly. This setup allowed users to perform efficient searches on the archived PDF data using the Azure Cognitive Search REST API or SDKs, providing quick and reliable access to the information stored in the cloud.

### Outcome

The project successfully moved the client’s archived PDF data to Azure Blob Storage and enabled search capabilities through Azure Cognitive Search. This solution provided the client with improved data accessibility and better search functionality. The use of tools and technologies from 2017 ensured a maintainable solution that met the client’s needs effectively.