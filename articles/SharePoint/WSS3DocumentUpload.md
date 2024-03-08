---
layout: default
title: C# - WSS 3 Bulk ingestion
parent: SharePoint
nav_order: 1
---
### Streamlining Document Migration to SharePoint WSS 3.0: A Technical Insight

Our client had tons of documents saved on their network drives and wanted to move everything over to SharePoint WSS 3.0. They were really looking forward to using all the new features WSS 3.0 offers to make handling documents easier and more efficient.

#### The Challenge

However, what seemed like a straightforward migration task quickly unveiled several technical challenges:

1. **Tedious Document Transfer**: The sheer volume of documents made the transfer process time-consuming and complex.
2. **Preserving Metadata**: Critical document metadata such as creation and modification dates, along with author information, was lost in the migration process, disrupting record-keeping and compliance.
3. **Renaming Limitations**: The need to rename files and folders for better organization and consistency could not be easily addressed.
4. **Invalid Characters**: SharePoint's restrictions on file and folder names presented issues with invalid characters, requiring manual intervention.

#### A Custom Solution

To overcome these hurdles, we developed a custom C# solution using the SharePoint Object Model. This  approach allowed for automating the upload process, ensuring metadata integrity, providing flexibility in renaming, and handling invalid characters efficiently.

#### Key Features of the Solution

- **Automated Uploads**: Bulk document uploads directly from network drives to SharePoint.
- **Metadata Preservation**: Custom code to maintain the original creation date, modification date, and author information.
- **Flexibility in Renaming**: Provided functionality to rename files and folders as per the client's needs
- **Invalid Character Handling**: Automated detection and correction of invalid characters in filenames.

#### The C# Code Snippet

Below is a simplified version of the C# code snippet that was used:

```csharp
using System;
using Microsoft.SharePoint;

namespace SharePointMigrationHelper
{
    class Program
    {
        static void Main(string[] args)
        {
            string siteUrl = "http://sharepointserver/sites/mrvl";
            string libraryName = "Documents";
            string filePath = @"C:\networkdrive\document.docx";
            string fileName = "document.docx";

            // Example metadata
            DateTime creationDate = new DateTime(2020, 1, 1);
            string createdBy = "CreatorName";

            using (SPSite site = new SPSite(siteUrl))
            {
                using (SPWeb web = site.OpenWeb())
                {
                    SPFolder libraryFolder = web.Folders[libraryName];
                    byte[] fileContent = System.IO.File.ReadAllBytes(filePath);
                    
                    SPFile uploadedFile = libraryFolder.Files.Add(fileName, fileContent, true);
                    
                    SPListItem item = uploadedFile.Item;
                    item["Created"] = creationDate;
                    item["Author"] = web.EnsureUser(createdBy);
                    item.Update();
                }
            }

            Console.WriteLine("Document uploaded successfully with metadata.");
        }
    }
}
```

#### Conclusion

The migration of documents to 3.0 let the client use robust features of WSS 3.0 and it made it easier from them to move to MOSS 2007.

---
© D Das  
📧 [das.d@hotmail.com](mailto:das.d@hotmail.com) | [ddasdocs@gmail.com](mailto:ddasdocs@gmail.com)