## What is Dataverse?

Dataverse is Power Platform's Database - for simplicty.

## What are Dataverse verions?

- Microsoft Dataverse: Premium edition. Requires PowerApps subscription.
- Dataverse for Teams: Free edition.

## Dataverse Storage - behind the scenes

![alt text](images\howdataverse.png)

## <span style="color: Indigo;Font-family: Segoe UI, sans-serif;">Dataverse vs. MSSQL Tables: A Quick Comparison</span>

Hello readers! Hope you had a wonderful day. Today, let's explore one of the important aspects of Power Platform: Dataverse. How does it differ from other options like MSSQL? What's its importance? Let's find out!

### <span style="color: Chocolate;Font-family: Segoe UI, sans-serif;">Long story short</span>

Dataverse and MSSQL, while both store data in tables within the Microsoft ecosystem, there are many differences between them. Here is a quick breakdown to help you understand the key differences:

<table border="1" style="border-collapse: collapse;">
  <tr style="background-color:#d9e6f2;">
    <th>Feature</th>
    <th>Dataverse</th>
    <th>MSSQL</th>
  </tr>
  <tr style="background-color:#fdebd0;">
    <td>Schema</td>
    <td>Flexible</td>
    <td>Fixed</td>
  </tr>
  <tr style="background-color:#eaf2f8;">
    <td>Data Types</td>
    <td>Various (<span style="color: #FF8C00;">complex</span> included)</td>
    <td>Similar (<span style="color: #FF8C00;">granular control</span>)</td>
  </tr>
  <tr style="background-color:#fdebd0;">
    <td>Relationships</td>
    <td>Built-in</td>
    <td>Foreign Keys</td>
  </tr>
  <tr style="background-color:#eaf2f8;">
    <td>Data Manipulation</td>
    <td>User-friendly interface (<span style="color: #4169E1;">low-code</span>)</td>
    <td>T-SQL (code), Programming languages</td>
  </tr>
  <tr style="background-color:#fdebd0;">
    <td>Security</td>
    <td>RBAC (<span style="color: #800080;">roles</span>), Auditing</td>
    <td>Manual setup, Auditing (configuration needed)</td>
  </tr>
  <tr style="background-color:#eaf2f8;">
    <td>Table Types</td>
    <td>Standard, Virtual, Custom, Elastic (<span style="color: #FF8C00;">limited</span>)</td>
    <td>Base, Temporary, Views, Table-Valued Functions</td>
  </tr>
  <tr style="background-color:#fdebd0;">
    <td>Views</td>
    <td>Limited (<span style="color: #FF8C00;">virtual tables</span>)</td>
    <td>Traditional views (<span style="color: #FF8C00;">complex</span>)</td>
  </tr>
  <tr style="background-color:#eaf2f8;">
    <td>Business Logic (Table Level)</td>
    <td>Power Automate workflows</td>
    <td>Stored Procedures, Triggers</td>
  </tr>
  <tr style="background-color:#fdebd0;">
    <td>Business Logic (Column Level)</td>
    <td>Validation Rules, Workflows</td>
    <td>Constraints, Triggers</td>
  </tr>
  <tr style="background-color:#eaf2f8;">
    <td>Ideal for</td>
    <td>User-friendly app development, Built-in security, Power Platform Integration</td>
    <td>Complex data management, Granular control, Complex data models</td>
  </tr>
</table>


**Table Types:**
Also, here are some differences between the types of tables allowed in both.

| Feature | Dataverse | MSSQL |
|---|---|---|
| Standard Tables | ✓ | ✓ |
| Virtual Tables (simplified data views) | ✓ | Views (complex data views) |
| Custom Tables (more control) | ✓ |  |
| Elastic Tables (large datasets) | ✓ (limited) |  |

### <span style="color: DodgerBlue;Font-family: Segoe UI, sans-serif;">How to choose?</span>

- For Power Platform users, Dataverse stands out as the go-to choice. User-friendly interface and low-code approach make it ideal for simple data models. Built-in security and lots of OOTB tables for various applications will give you a head start. These pre-built tables can be used immediately and further customized for specific needs.
- Alternatively, choose MSSQL if you have a complex data model, want to build things from scratch and want to store a huge volume of data.

![alt text](images\db_vs_dataverse-1.jpg)

