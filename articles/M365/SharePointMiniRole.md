---
layout: default
title: SharePoint Mini Role
parent: M365
nav_order: 6
---
- [SharePoint 2016 MinRole](#sharepoint-2016-minrole)
    - [Before 2016:](#before-2016)
    - [SharePoint 2016/2019:](#sharepoint-20162019)
      - [Dedicated MinRole:](#dedicated-minrole)
      - [Special MiniRole:](#special-minirole)
      - [Shared MiniRoles:](#shared-miniroles)


# SharePoint 2016 MinRole

### Before 2016:

Say, you had two servers. You could install **any** service on either of them, in **any combination**. E,g,:

- **Server 1**: Web Front-End + Search + Central Administration
- **Server 2**: Indexing + Application Services

This freedom, and lack of guidance, gave a lot of flexibility. But, you had to be careful about performance issues.

### SharePoint 2016/2019:

**MinRole** is just a **best combination** of services. Now adminstrator know beforehand, what mix is best. It's not just advice, its shown as a radio  button during installation.

Also, like before, you can still install 'anything anywhere' by clicking 'Custom' MiniRole optioin. This is how the new installer shows them:

![alt text](image-6.png)

#### Dedicated MinRole:

- **Front-End**
- **Application**
- **Distributed Cache**
- **Search**

![dedicated_roles](image-10.png)
*From Microsoft Site*


#### Special MiniRole:

- **Single-Farm**: All-in-one. Before called, Standalone Install mode. Used for Dev.
- **Custom**: Anything-anywhere. The-way-you-like-it

![alt text](image-12.png)
*From Microsoft Site*

#### Shared MiniRoles:

- **Front-End + Distributed Cache**
- **Application +  Search**

![alt text](image-11.png)
*From Microsoft Site*


Long story short: MinRole is just 'best mix of SharePoint services' as per Microsoft.

---