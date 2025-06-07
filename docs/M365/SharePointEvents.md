
## SharePoint 2007 Event Receiver Project

In this article I will show you how to Develop an event receiver in C# to handle item added, updated, or deleted events in a specific SharePoint document library. This article can be used from SharePoint 2007 till SharePoint 2013 without much changes. 

### Event Receivers

Using Event Receiver we can write custom code(e.g. send a mail) whenever something is done to a list or library item. Note: Nowadays SharePoint is moving towards Webhooks as it is lightweight and more efficient.

### Event Receivers Types

* **Synchronous event receivers:** These receivers run before or after the event. E.g. Before SharePoint saves an updated item(Before Item Updated)
* **Asynchronous event receivers:** This work after an event has happened. E.g. Sene a mail after an event is added.

### Let's get started

#### Step 1: Create SharePoint Document Library

1. Open your SharePoint site using a web browser.
2. Navigate to the desired site where you want to create the document library.
3. Click on "Site Actions" -> "View All Site Content" -> "Create".
4. Select "Document Library" from the list of available templates.
5. Provide a name for the document library (e.g., "Custom Documents").
6. Click "Create" to create the document library.

#### Step 2: Create Visual Studio Project

1. Open Visual Studio 2008 or later.
2. Create a new SharePoint project:
   - File -> New -> Project.
   - Select "SharePoint" from the installed templates.
   - Choose "Empty SharePoint Project" and provide a name (e.g., "SharePointEventReceiverProject").
   - Click "OK" to create the project.

#### Step 3: Add Event Receiver Class

1. Right-click on the project in Solution Explorer.
2. Select "Add" -> "New Item".
3. Choose "Event Receiver" and provide a name for the class (e.g., "CustomDocumentLibraryEventReceiver").
4. Click "Add" to add the event receiver class to the project.

#### Step 4: Implement Event Receiver Logic

```csharp

//Das, 2010

using Microsoft.SharePoint;

namespace SharePointEventReceiverProject
{
    public class CustomDocumentLibraryEventReceiver : SPItemEventReceiver
    {
        public override void ItemAdded(SPItemEventProperties properties)
        {
            base.ItemAdded(properties);
            // Write your custom code here
            // Example: Send email notification or update metadata
        }

        public override void ItemUpdated(SPItemEventProperties properties)
        {
            base.ItemUpdated(properties);
            // Write your custom code here
            // Example: Log changes or trigger workflows
        }

        public override void ItemDeleted(SPItemEventProperties properties)
        {
            base.ItemDeleted(properties);
            // Perform actions when an item is deleted from the document library
            // Example: Archive deleted items or update related records
        }
    }
}
```

#### Step 5: Deploy using Feature

1. Right-click on the project in Solution Explorer.
2. Select "Add" -> "New Item".
3. Choose "Feature" and provide a name for the feature (e.g., "CustomEventReceiverFeature").
4. Open the feature XML file (Feature.xml) and add an EventReceiver element to specify the event receiver class.
5. Set the ReceiverAssembly and ReceiverClass attributes to reference the event receiver assembly and class.
6. Build the SharePoint project to generate the event receiver assembly (.dll).
7. Deploy the event receiver assembly to the SharePoint server using the feature:
   - Activate the feature at the site collection or site level where the document library is located.
   - Verify that the event receiver is attached to the document library.