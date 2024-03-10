---
layout: default
title: SharePoint Mini Role
parent: SharePoint Office 365
nav_order: 6
---

# Understanding SharePoint's MinRole in SP 2016 & 2019 on-prem

The evolution of Microsoft SharePoint to the 2016 and 2019 versions brought a significant change with the introduction of MinRole farm topology. Unlike the 2010 and 2013 versions where any service could run on any server, MinRole assigns specific roles to servers in a SharePoint farm. This means certain services are designated to run on specific servers, streamlining the setup, enhancing performance, and making it easier to scale and plan the farm's capacity. This new approach addresses the need for efficient farm operation and optimal server deployment, marking a move towards more structured and efficient SharePoint environments.

In SharePoint's MinRole topology, server roles are organized into three main categories to optimize the farm's performance, scalability, and manageability. Here's a simplified overview using tables to clarify the structure and purpose of each role:

### 1. Dedicated Roles

Dedicated roles are ideal for large, scalable farms, focusing on specific functions to enhance performance and scalability.

| **Role**         | **Description**                                                                                       |
|------------------|-------------------------------------------------------------------------------------------------------|
| **Front-end**    | Optimized for high performance; handles user traffic and requests with service applications and components. |
| **Application**  | Supports background processes like Timer Jobs and search crawl requests; designed for high throughput.    |
| **Distributed Cache** | Manages high-speed caching for specific data types; does not support High Availability (HA) by default.   |
| **Search**       | Executes search-related functionalities, such as indexing; requires specific configuration for search roles. |

![dedicated_roles](image-10.png)
*From Microsoft Site*

### 2. Shared Roles

Shared roles combine functionalities for medium-scale farms, enabling them to utilize fewer servers while still maintaining a high level of service.

| **Role**                    | **Description**                                                                                                     |
|-----------------------------|---------------------------------------------------------------------------------------------------------------------|
| **Front-end with Distributed Cache** | Combines Front-end and Distributed Cache roles on a single server, requiring comprehensive system support.          |
| **Application with Search**         | Merges Application and Search roles on one server, also demanding full system requirements for effective hosting.   |

![alt text](image-11.png)
*From Microsoft Site*

### 3. Special Roles

Special roles cater to specific scenarios like development, testing, or non-standard service configurations.

| **Role**             | **Description**                                                                                           |
|----------------------|-----------------------------------------------------------------------------------------------------------|
| **Single-Server Farm**| Replaces Standalone Install mode, suitable mainly for development and testing, requiring SQL server setup outside the role. |
| **Custom**           | Allows for manual management of service applications and services, offering full control over service instances.          |

![alt text](image-12.png)
*From Microsoft Site*

**Configuring SharePoint Farms with MinRole**

MinRole simplifies the configuration and expansion of SharePoint farms. It prescribes specific roles for servers, ensuring optimal performance and resource utilization. This topology supports a variety of farm setups, from simple, non-high availability configurations to large, high-availability farms tailored for specific needs such as content hosting, service application provision, or search services.

**MinRole Deployment and Management**

Deploying a SharePoint farm with MinRole involves specifying server roles during setup, which SharePoint then uses to configure necessary services. This approach not only simplifies deployment but also ensures that services are tailored to the farm's specific needs, improving efficiency and performance.

**Flexibility Beyond MinRole**

For those requiring customization beyond the MinRole presets, SharePoint allows for a Custom role, offering the flexibility to manually configure services on servers. This option supports scenarios where a farm's needs extend beyond the standard MinRole configurations, allowing for tailored service deployment.

**Conclusion**

MinRole represents a significant advancement in SharePoint farm topology, offering structured deployment, improved performance, and simplified management. By aligning server roles with specific services, SharePoint farms can operate more efficiently, with predictable performance and scalability. Whether adopting the streamlined MinRole approach or opting for custom configurations, SharePoint administrators can now deploy and manage their environments with greater ease and flexibility, ensuring their farms are optimized for their specific organizational needs.

---