---
layout: default
title: Project - C# - WSS 3 Bulk ingestion
parent: M365
nav_order: 9
---
### Document Migration to SharePoint WSS 3.0 Using C#.NET

Our client had a large number of documents saved on their network drives and wanted to move them to SharePoint WSS 3.0. They were excited about using the new features of WSS 3.0 to make document management easier and more efficient.

#### The Challenge

However, the migration task came with several technical challenges. The large volume of documents made the transfer process time-consuming and complex. Important metadata like creation and modification dates, along with author information, was getting lost during the migration, disrupting record-keeping and compliance. The need to rename files and folders for better organization and consistency was not easy to handle. Additionally, SharePoint's restrictions on file and folder names caused issues with invalid characters, needing manual intervention.

#### A Custom Solution

To solve these problems, we developed a custom C# solution using the SharePoint Object Model. This approach allowed us to automate the upload process, ensure metadata integrity, provide flexibility in renaming, and handle invalid characters efficiently.

#### Key Features of the Solution

The solution included automated uploads that allowed bulk document uploads directly from network drives to SharePoint. We also developed custom code to preserve important metadata like the original creation date, modification date, and author information. The solution provided functionality to rename files and folders as per the client's needs, and it included automated detection and correction of invalid characters in filenames.

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

The migration of documents to SharePoint WSS 3.0 allowed the client to use the robust features of WSS 3.0, making it easier for them to move to MOSS 2007 later.

---
© D Das  
📧 [das.d@hotmail.com](mailto:das.d@hotmail.com) | [ddasdocs@gmail.com](mailto:ddasdocs@gmail.com)