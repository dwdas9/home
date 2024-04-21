---
layout: default
title: Documentum-SharePoint Online
parent: M365
nav_order: 1
---

## Case study: Documentum to SharePoint Online and Azure Blob

For one of my clients, the Document Archving and ECM system used on-prem Documentum. This system was connected with  a large number of field offices scanning/importing contet through OpenText Intelligent Capture. The total licensing and  maintenace cost was exorbitant. There was non HA and DR. Moreover many departments used simple filesytem for archiving. When advising this client on enhancing their content management system, the focus was on overcoming the challenges posed by Documentum, particularly in terms of cost, integration difficulties, and user experience issues. The recommended strategy involved transitioning to SharePoint Online for active content management and Azure Blob Storage for archiving. This approach resulted in many benefits aligned with the client's need to reduce 'technical debt'.

### Challenges with Documentum

- **High Costs**: Licensing, hardware maintenance, and support costs were unnecessarily high.
- **Integration and User Experience Issues**: Difficulties in integrating with the Office 365 and Azure ecosystems, coupled with user experience challenges due to frequent maintenance issues with the Java applet in WebTop.

### The Strategic Shift
- **To SharePoint Online for Live Content**: For its cost-effectiveness, scalability, and seamless integration within the Office 365 ecosystem.
- **To Azure Blob for Archiving**: For its scalability and cost-efficiency in handling large volumes of archived(structured/Unstructured) data. There are many tiers, the hot(low latency) cool(infrequent access)

### Key Benefits of the Transition
1. **Enhanced Mapping Features**: SharePoint Online supports advanced mapping of Documentum structures, including advanced library configuration.
2. **Improved Access Control**: Superior ACL settings in SharePoint Online mirror Documentum's capabilities, offering more refined permission management.
3. **No Database Constraints**: Unlike previous SharePoint versions, SharePoint Online has no SQL server database size limit, eliminating on-prem system capacity issues.
4. **Advanced Content Management**: Supports the management of linked documents, renditions, and contentless objects, making the migration process straightforward.
5. **Direct Exports with OpenText**: OpenText Intellinget Capture's Microsoft SharePoint Export - Exports documents and data directly to SharePoint.
6. **ADF abd AZCopy** : Using these tools it was easily possible to move data to Azure blob storage.

By moving to SharePoint Online and Azure Blob Storage, the client resolved their current issues and also used advanced features and future-proofed their system.
