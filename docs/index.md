# Welcome to Das Digital Digest

Hello! I am Das and welcome to my page. Here I share my work and learnings as a Data Engineer and AI enthusiast. Most things come from daily work and real projects, not heavy theory. My idea is to keep it simple, practical, and easy to follow.

## About Me



!!! Quote "Early Life"

    I was born in West Bengal, India. When I was just a few months old, my father’s transferable job took us to many places in India and South East Asia. I studied in different Army schools across India. During the last semester of my master’s, I was hired by HCL Technologies and seconded to Singapore after my internship. Since then, I’ve moved between Singapore, Amsterdam, and Canada, often returning to Singapore as my wife (then girlfriend) was studying there, including her PhD and postdocs. Today, we live in Singapore with our daughter, and my wife works as a scientist/Senior Assistant Director in a public sector R&D agency.

!!! Example "Education"

    I have a B.Sc. (Hons) in Physics with a minor in Mathematics from the University of Calcutta, and a Master’s in Computer Application from West Bengal University of Technology.


!!! Abstract "Professional Journey"

    I started my career as a final-year intern at [HCL Technologies](https://www.hcltech.com/), working on .NET and MSSQL. After my internship, I was seconded to Singapore. Since 2007, I have worked across Singapore, Canada, and Amsterdam on Data and ECM projects, mainly on Microsoft platforms. Since 2017, I worked mainly on Azure and Government Cloud migration projects. I currently work as Senior Manager/Data Engineer at IRAS (Ministry of Finance, Singapore), supporting data migration to Azure Government Commercial Cloud (GCC). Over the years, I have gained experience in both services and product companies, across government and private sectors.



## Projects and responsibilities

??? tabs "Data & ETL Migration to Azure Government Commercial Cloud (GCC)"
    === "Project and Team"
        - **Project:** Data and ETL Migration from On-Prem to Azure Government Commercial Cloud (GCC) 
        - **Role:** Senior Manager / Data Engineer  
        - **Duration:** Mar 2025 – Present  
        - **Team:** 20+ members across Data Engineering, Digital Infrastructure, Data Science, and AI  
        - **Objective:**  
            - Migrate on-prem SQL tables to Synapse Analytics (Serverless Delta Lake tables and Dedicated Pool) using Azure Data Factory and PySpark (Synapse Spark Pool).  
            - Rewrite SAS SQL scripts into PySpark for Synapse Spark Pool.  
            - Transition Hadoop/Hive ETL workflows to Synapse Serverless with ADLS.  
            - Collaborate with Data Scientists and ML Engineers on data preparation and integration tasks.  

    === "Tech Stack"
        - Azure Government Commercial Cloud (GCC)  
        - Azure Data Factory  
        - Synapse Analytics (Dedicated & Serverless)  
        - ADLS  
        - PySpark / Synapse Spark Pool  
        - Hadoop / Hive
        - Azure DevOps  
        - GitHub Copilot  
        - MLflow / Kedro  

    === "Responsibilities"
        - Migrated data from on-prem SQL tables to Azure Synapse (Dedicated & Serverless) using ADF and PySpark.  
        - (In-progress)Migrating 120+ Hadoop/Hive ETL workflows to Synapse-ADLS.  
        - (In-progress)Converting legacy SAS SQL scripts into PySpark for Synapse Spark Pool.  
        - Provided technical guidance on PySpark Script optimization and best practices.  
        - Worked with Data Scientists to refine datasets for model development.  
        - Provided CI/CD pipeline guidance using Azure DevOps.  
        - Conducted PoC comparing Kedro and MLflow for MLOps.  
        - Supported user access and security in Azure GCC. 
        - Worked with other government agency teams to onboard GitHub Copilot and worked with vendors to resolve security issues.  
        - Coordinated across internal departments and external contractors for delivery.  


??? tabs "Data Engineering and Gen-AI Solutions for Global Retail"
    === "Project and Team"
        - Project: Enterprise Data Engineering and Knowledge Solutions – Global Retail (INGKA / IKEA)
        - Role: Assistant Manager / Data Engineer
        - Duration: Sep 2024 – Mar 2025
        - Team: Global Analytics Team – Data Engineering, BI, CRM, Infrastructure, and AI Solutions
        
        **Background:**  
        As part of the **Global Analytics team**, I worked on developing and supporting enterprise-scale data engineering solutions. The platform ingested data from multiple sources including Dynamics CRM, Dynamics Business Central, SQL Server, SharePoint, and Google BigQuery. Data ingestion was powered by **Databricks Autoloader**, with transformations built on **DBT and Databricks**.  
        
        In parallel, I contributed as an architect for a strategic **Gen-AI chatbot initiative (Ikano Chatbot)** to be embedded within the IKEA website. The solution combined **Ikano APIs for product data ingestion** with **vector database storage** for static knowledge, enabling **GPT-3.5 powered contextual responses** to customer product queries.  

        **Objectives:**  
        - Develop and support ELT pipelines on Azure, DBT, and Databricks for enterprise reporting.  
        - Optimize data pipelines for runtime efficiency and cost savings.  
        - Migrate legacy Hive-based workloads into **Databricks Unity Catalog**.  
        - Ensure seamless integration of structured/unstructured data from CRM, ERP, SharePoint, and BigQuery.  
        - Architect and prototype the IKEA **Gen-AI chatbot** leveraging APIs, vector DBs, and GPT-3.5.  

    === "Tech Stack"
        - Azure (ADLS, Azure DevOps, ARM Templates)  
        - Databricks (Repos, Delta Lake, Autoloader, Unity Catalog)  
        - DBT (SQL/ELT transformations)  
        - Power BI  
        - Dynamics CRM / Dynamics Business Central  
        - SharePoint  
        - Google BigQuery  
        - REST APIs (Ikano, Dynamics, internal systems)  
        - Weaviate (Vector Database)  
        - LangChain  
        - GPT-3.5 / GitHub Copilot  
        - Terraform & ARM Templates (infra automation, evaluation)  
        - GitHub-Jekyll / MkDocs / GitBook (internal knowledge platform, evaluation)  

    === "Role & Responsibilities"
        - Designed and supported **ELT pipelines** across Azure, Databricks, DBT, and Power BI.  
        - Optimized workflows, cutting runtime by ~50% and reducing storage costs by two-thirds.  
        - Engineered **ADLS storage solutions** (hot/cool/archive tiers) via ARM templates, ensuring secure access with SAS tokens.  
        - Partnered with IT for **Azure subscription, RBAC, and resource group management**.  
        - Evaluated **Terraform vs ARM templates** for DR management in hybrid Azure + Databricks environments.  
        - Architected migration strategy from **Hive to Databricks Unity Catalog**.  
        - Built multi-modal **RAG pipelines (Weaviate + LangChain + GPT-3.5)** consuming Ikano REST APIs for the **IKEA chatbot**.  
        - Prototyped **corporate knowledge platforms** (MkDocs, GitHub-Jekyll, GitBook) for internal documentation and learning.  

    === "Key Achievements"
        - Delivered a **scalable ELT platform** integrating CRM, ERP, and BigQuery data sources.  
        - Achieved ~50% **runtime reduction** and significant **cost savings** in data storage/processing.  
        - Successfully piloted the **Ikano GPT-3.5 chatbot**, demonstrating Gen-AI product Q&A for IKEA.com.  
        - Defined a **standardized Unity Catalog migration blueprint** for enterprise adoption.  
        - Proposed and prototyped an **internal knowledge hub**, improving accessibility of technical documentation.  


??? tabs "Enterprise Data Engineering and Cloud Migration"
    === "Project and Team"
        - **Project:** Enterprise Data Migration and Application Modernization for a Fintech Giant 
        - **Role**: Analyst / Lead  
        - **Duration**: Sep 2019 – Apr 2023  
        - **Team**: Cross-functional team of Data Engineers, BI Developers, and Application Engineers spread across Singapore and USA  
        - Objective:  
            - Build and manage end-to-end ETL pipelines migrating data from on-premises systems and CMS to Azure cloud platforms.  
            - Integrate and modernize ETL workflows using Power Platform, Azure Functions, and PySpark.  
            - Deploy scalable storage and CI/CD pipelines for cloud adoption.  
            - Deliver proof-of-concepts for real-time streaming, orchestration, and distributed data processing.  
            - Support business applications through Power Platform, workflow automation, and reporting.  

    === "Tech Stack"
        - Azure (ADLS, Azure SQL DB, Synapse, Azure Functions, Azure DevOps)  
        - MongoDB  
        - Hadoop (PySpark, JARs, Hive)  
        - ARM Templates  
        - Power Platform (Dataflows, Power Apps, Power Automate, AI Builder)  
        - Dataverse  
        - SharePoint  
        - Power BI  
        - Kafka & Spark Streaming  
        - Event Hubs / Azure Stream Analytics / HDInsight  
        - Apache Airflow (Dockerized)  

    === "Role & Responsibilities"
        - Built and managed ETL pipelines migrating data from on-prem systems and CMS to ADLS, MongoDB, and Azure SQL DB.  
        - Created ETL workflows using Power Platform Dataflows and Azure Functions.  
        - Integrated on-prem PySpark with ADLS using Hadoop JARs, Azure SDKs, and ADF integration runtimes.  
        - Developed and resolved issues in CI/CD pipelines on Azure DevOps.  
        - Deployed ADLS storage accounts and configurations using ARM templates.  
        - Developed Power Apps (Canvas & Model-Driven), integrating with Dataverse, SharePoint, MSSQL, and APIs.  
        - Automated workflows using Power Automate, AI Builder, and Azure Logic Apps.  
        - Generated Power BI reports from SharePoint Lists, Excel, and CMS datasets.  
        - Delivered POCs for:  
            - Real-time event-driven data pipelines using Azure Stream Analytics, Event Hubs, and HDInsight.  
            - Real-time music data pipeline integrating Kafka, Spark Streaming, and MongoDB in Dockerized environments.  
            - Orchestration workflows with Apache Airflow on Docker and multi-node Spark clusters with Hive/MSSQL.  
        - Authored technical documentation to support knowledge transfer and project handovers.  
        - Contributed to project management and cross-team coordination, including timelines, status updates, and mentoring junior developers.  



??? tabs "ETL Modernization and Infrastructure Migration to Azure"
    === "Project and Team"
        - **Project:** ETL Modernization and Infrastructure Migration to Azure  
        - **Role**: Solution Architect / Data Engineering Lead  
        - **Duration**: Jan 2017 – Sep 2019  
        - **Team**: 15 members including Data Engineers, ETL Developers, Azure Infrastructure Specialists, and cross-functional stakeholders  
        - **Objective**:  
            - Migrate legacy on-prem Windows Servers and SQL Server databases to Azure VM and Azure SQL PaaS.  
            - Modernize SSIS ETL pipelines for document and metadata processing.  
            - Enable scalable, automated, and highly available data workflows in Azure.  
            - Reduce on-prem maintenance cost and operational risk.  

    === "Tech Stack"
        - Azure VMs (Windows Server 2016)  
        - Azure SQL Database (PaaS)  
        - SSIS / SSRS  
        - SQL Server Management Studio  
        - Power BI  
        - Docker (for legacy ECM apps)  
        - SharePoint Online  

    === "Role & Responsibilities"
        - Designed Azure-based architecture, including VM sizing, SQL PaaS, and high availability planning.  
        - Migrated on-prem SSIS ETL packages to Azure VM-hosted SQL Server, optimizing for performance and reliability.  
        - Re-engineered SSIS packages to process document metadata from legacy ECM systems efficiently.  
        - Built Azure SQL tables and schemas to capture document and operational data.  
        - Implemented automation for metadata extraction, validation, and ingestion from multiple sources.  
        - Configured Azure DR and HA strategies, including geo-redundant backups and site recovery.  
        - Conducted POCs for performance tuning of SSIS workflows and SSRS reporting.  
        - Collaborated with cross-functional teams and vendors to provision Azure infrastructure and ensure secure access.  
        - Developed technical documentation, deployment guides, and trained internal teams on new cloud-based ETL workflows.  
        - Monitored pipeline performance post-migration and ensured data quality and integrity.  

    === "Key Achievements"
        - Successfully migrated all on-prem SSIS ETL workflows to Azure VMs and Azure SQL.  
        - Reduced infrastructure maintenance cost by ~40% by leveraging Azure PaaS and VM-based ETL hosting.  
        - Improved ETL execution performance by ~50% through optimized SSIS workflows and SQL tuning.  
        - Enabled high availability and disaster recovery for mission-critical financial data.  



??? tabs "Multi-Country Document Ingestion and Metadata ETL"
    === "Project and Team"
    - Project: Multi-Country Document Ingestion and Metadata ETL
    - Role: Solution Architect / Lead Data Engineer
    - Duration: Sep 2014 – Dec 2016
    - Team: 12 members including .NET Developers, ETL Engineers, and Infra Support
    - **Domain:** Financial Services / Banking
        **Background**:  
        A global bank with branches across Southeast Asia faced strict data compliance requirements that mandated each country’s data remain within its local environment. The bank captured documents from multiple channels — RightFax servers, MFD machines, front-office uploads, and email. Metadata for these documents arrived in XML control files, which had to be parsed, validated, and stored alongside the content in **OpenText Documentum servers** and SQL Server databases. The complexity stemmed from managing **50+ ETL pipelines across Singapore, Vietnam, Indonesia, Malaysia, Thailand, Philippines, and Australia**, each with its own PROD, QA, DR, and SIT servers.  

        **Objectives**:  

        - Build and manage scalable ETL pipelines for XML metadata and document ingestion.  
        - Ensure country-specific data residency and compliance.  
        - Store content in **OpenText Documentum** while persisting metadata in SQL Server for analytics and reporting.  
        - Standardize ETL deployment and monitoring across 7 countries and 50+ processes.  
        - Improve reliability with automated error handling, validation, and monitoring frameworks.  

    === "Tech Stack"
        - OpenText Capture (Captiva)  
        - OpenText Documentum (Content Storage)  
        - Microsoft SQL Server 2012  
        - SQL Server Integration Services (SSIS)  
        - SQL Server Management Studio (SSMS 2012)  
        - C# / .NET Framework 4.5  
        - Visual Studio 2012  
        - Windows Server 2012  
        - ADODB (data access)  

    === "Role & Responsibilities"
        - Designed and implemented ETL pipelines for **XML metadata ingestion** using SSIS and .NET utilities.  
        - Integrated Captiva with Documentum for seamless content ingestion and metadata synchronization.  
        - Developed .NET components for file monitoring, XML validation, and pipeline orchestration.  
        - Designed SQL Server schemas, staging tables, and optimized bulk-load strategies.  
        - Automated deployment and configuration management across multiple country environments.  
        - Implemented **error handling, retry logic, and proactive monitoring** for 50+ pipelines.  
        - Performed performance tuning on SSIS packages and SQL queries to handle peak volumes.  

    === "Key Achievements"
        - Delivered and maintained **50+ ETL pipelines across 7 SEA countries**, ensuring full **regulatory compliance**.  
        - Enabled seamless content storage in **Documentum** with metadata pushed to SQL Server for analytics.  
        - Reduced ingestion failures and manual interventions with automated XML validation and error recovery.  
        - Improved ETL throughput by ~40% through SSIS and SQL performance tuning.  
        - Established a standardized ETL framework and monitoring model, cutting maintenance overhead significantly.  



??? tabs "High-Volume XML Ingestion and ETL Upgrade"
    === "Project and Team"
    - **Project**: High-Volume XML Ingestion and ETL Upgrade
    - **Role**: Solution Architect / Lead Data Engineer
    - **Duration**: Feb 2012 – Sep 2014
    - **Team**: 20 members including ETL Developers, Data Engineers, and QA specialists
    - **Domain:** Oil & Gas / Energy
    - **Objective**:
        - Ingest and process large volumes of XML-based control files received from multiple channels (branches, vendors).
        - Parse and store document metadata into SQL Server for analytics and reporting.
        - Automate and monitor data pipelines for reliability and error handling.
        - Migrate and modernize initial manual/legacy ingestion scripts to robust SSIS packages. 

    === "Tech Stack"
        - Microsoft SQL Server 2008 / 2008 R2  
        - SQL Server Integration Services (SSIS 2008)  
        - SQL Server Management Studio (SSMS 2008)  
        - C# / .NET Framework 3.5 / 4.0  
        - Visual Studio 2008  
        - Windows Server 2008 R2  
        - PowerShell v2 (for monitoring scripts)  
        - Excel (reporting & analytics)  

    === "Role & Responsibilities"
        - Designed end-to-end ETL architecture to ingest XML control files from network folders.  
        - Developed .NET-based utilities for file monitoring, validation, and pre-processing.  
        - Built and optimized SSIS packages for automated XML parsing and loading into SQL Server.  
        - Implemented error handling, logging, and notification mechanisms to ensure pipeline reliability.  
        - Collaborated with analysts to design SQL schemas and staging tables for efficient querying and analytics.  
        - Monitored ETL pipelines and resolved runtime issues, ensuring data consistency and integrity.  
        - Generated dashboards and reports using Excel and SQL queries for business stakeholders.  
        - Documented ETL workflows, scripts, and operational procedures for knowledge sharing.  
        - Trained junior developers and data engineers on XML parsing, SSIS best practices, and pipeline monitoring.  


??? tabs "SDL Tridion & SharePoint 2010 – ECM Data Ingestion Workflows – SDL Netherlands B.V."
    === "Project and Team"
        - **Client/Company:** SDL Dev Labs (Now [RWS](https://www.rws.com/content-management/tridion/) Group)  
        - **Role:** Technical Engineer  
        - **Duration:** May – Dec 2011  
        - **Team:** 10 members (Product Team for ECM/WCM solutions) 
        - **Domain:** Web Content Management / Enterprise Content Management 
        - **Objective:**  
            - Design and implement data ingestion workflows from digital documents to SharePoint CMS and Tridion WCM.  
            - Ensure metadata extraction, content transformation, and proper publication pipeline.  
            - Provide technical support to customers for seamless WCM/ECM operations.  

    === "Tech Stack"
        - SDL Tridion Product Suite  
        - SharePoint 2010 / SharePoint Designer 2010  
        - SQL Server 2008  
        - Visual Studio 2008  
        - C#.NET, VBA  

    === "Role & Responsibilities"
        - Developed end-to-end **data ingestion workflows**: digital documents → OCR-based metadata extraction → SharePoint CMS.  
        - Built workflows for content lifecycle: initial creation in SharePoint → editing and publication in Tridion.  
        - Provided ongoing **technical support** to customers and internal teams.  
        - Ensured high quality and reliability of content workflows, improving customer satisfaction.  
        - Received recognition for delivering excellent support and contributing to improved **CSAT scores**.  


??? tabs "SharePoint 2007 – Standalone to Farm Migration & Portal Redesign"
    === "Project and Team"
        - **Role:** Senior Software Engineer  
        - **Duration:** Jun 2009 – Apr 2011  
        - **Team:** 10 members (developers, infra engineers, DBAs)  
        - **Domain:** Logistics / Supply Chain
        - **Objective:**  
            - Redesign the standalone SharePoint setup into a **6-server farm** (2 Web, 2 Application, 2 SQL in Active/Passive Cluster).  
            - Migrate ~10 site collections into the new farm environment.  
            - Improve scalability, availability, and content management through governance policies.  
            - Standardize document and collaboration practices using MOSS 2007 features.  
            - Integrate proprietary and third-party plug-ins (Ontolica Search, custom components).  

    === "Tech Stack"
        - SharePoint 2007 (MOSS)
        - SharePoint Designer 2007, SharePoint Capacity Planner  
        - Ontolica Search for SharePoint  
        - SQL Server 2008 R2 Enterprise (Failover Cluster), SQL Server Management Studio  
        - Visual Studio 2005 (C# .NET, HTML, CSS, jQuery, .NET Framework 3.5 SP1)  
        - Windows Server 2003 R2 SP2, IIS 6  
        - Version Control: Visual Source Safe 2005  

    === "Role & Responsibilities"
        **Planning & Assessment**  

        - Analyzed existing SharePoint 2007 environment, customizations, and third-party tools.  
        - Prepared farm architecture and governance strategy (roles, responsibilities, policies, deployment strategies).  

        **SQL Server & Farm Deployment**  

        - Installed and configured a **2-node SQL Server 2008 Failover Cluster**.  
        - Installed IIS, .NET Framework, MOSS 2007; set up farm-level configs (trace logs, SSL, user/role mgmt).  

        **Migration & Enhancement**  

        - Migrated site collections using **stsadm backup/restore**; resolved migration issues via testing.  
        - Enhanced migrated sites with additional features and configurations.  

        **Development**  

        - Built custom SharePoint components: Web Parts, Application Pages, Workflows, Field Types, Controls.  
        - Integrated advanced search capabilities using **Ontolica Search**.  
        - Developed C# utilities:  

            - **List Security Manager** (granular list/library permissions).  
            - **List Copy Tool** (copy lists with metadata, history, and permissions).  
            - Automated list cleanup and content deletion utilities.  

        - Customized open-source **SharePoint Content Deployment Wizard** to business requirements.  


??? tabs "SSIS & SQL Server – Automated XML Data Ingestion Pipelines"
    === "Background & Objective"
        A major bank ingested data from multiple business units and branch offices across Southeast Asia. The data was captured from multiple channels such as fax servers, MFD machines, and emails. Each business unit dropped its data extracts into designated shared folders along with XML-based control files containing metadata (batch IDs, references, processing status).

        The objective was to design and automate **ETL pipelines** that would:

        - Continuously monitor incoming folders for new XML control files and associated content.
        - Parse and validate XML metadata and document extracts.
        - Transform and standardize data for compliance and analytics.
        - Load structured results into **SQL Server databases** for downstream reporting.

        - **Role:** Senior Software Engineer  
        - **Duration:** Mar 2008 – Jun 2009  
        - **Team:** 10 members (developers, infra engineers, DBAs)  
        - **Domain:** Logistics / Supply Chain

    === "Solution Approach" 
        - **File Monitoring:** Configured **ForEach Loop Containers** with File System Tasks to detect and process new XML files arriving in shared folders.  
        - **XML Parsing:** Used the **XML Source Component** in Data Flow Tasks to extract structured metadata (batch IDs, customer references, timestamps).  
        - **Document Data Extraction:** Linked referenced content files using Flat File Sources and custom **C# Script Tasks** for non-standard formats.  
        - **Transformation:** Applied **Derived Columns, Lookups, and Conditional Splits** to validate, standardize, and enrich records against reference tables.  
        - **Loading:** Loaded cleansed data into **SQL Server staging and transaction tables** via OLE DB Destinations, with stored procedures handling merge/update logic.  
        - **Error Handling & Logging:** Configured event handlers and custom error tables to capture failed records, enabling operational monitoring and quick fixes.  

    === "Tech Stack"  
        - SQL Server 2008 (Backend Database)  
        - SSIS (SQL Server Integration Services)  
        - File System Task & ForEach Loop Container (folder monitoring)  
        - XML Source Component, Flat File Source  
        - Data Flow Task (transformations)  
        - C# Script Task (custom parsing/edge cases)  
        - SQL Server Management Studio (SSMS)  
        - Windows Server 2003 R2  

    === "Role & Responsibilities"  
        - Designed database schemas and staging models for XML-driven ingestion.  
        - Built SSIS workflows for folder monitoring, XML parsing, and structured loading.  
        - Implemented custom **C# logic** in Script Tasks for edge-case parsing.  
        - Developed transformation logic (validation, lookups, error redirection).  
        - Coordinated deployment and migration across multiple environments (PROD, QA, DR, SIT).  
        - Provided ongoing production support and incident resolution.  

??? tabs "SharePoint 2007 – Publishing Portal Content Transformation"
    === "Project and Team"
        - **Project:** Content Transformation and Migration to SharePoint 2007 Publishing Portal
        - **Role:** Senior Software Engineer
        - **Duration:** Aug 2007 – Mar 2008
        - **Team:** 10 members (developers, designers, and IT administrators)
        - **Domain:** Financial Services / Banking
        - **Objective:**  
            - Consolidate static site content into a unified SharePoint 2007 Publishing Portal.  
            - Transform and migrate legacy content, images, and documents while preserving structure and metadata.  
            - Design portal layout, master pages, and branding for an improved user experience.  
            - Support multilingual content with SharePoint variations and InfoPath integration.  
            - Provide post-implementation support and end-user training.  

    === "Tech Stack"
        - SharePoint 2007 (Publishing Portal, Page, Picture, and Document Libraries, Lists)  
        - SharePoint Designer 2007, Adobe Photoshop  
        - SQL Server 2005 + SQL Server Management Studio  
        - Visual Studio 2005 (C# .NET, HTML, CSS, jQuery)  
        - Windows Server 2003 + IIS 6  

    === "Role & Responsibilities"
        - Performed **content transformation analysis**, ensuring UTF compliance and stripping redundant HTML while retaining links and images.  
        - Replicated site structure within SharePoint, creating and organizing libraries, lists, and pages.  
        - Customized portal design (layouts, master pages) using SharePoint Designer and Photoshop to meet branding requirements.  
        - Migrated:  
            - Static content → SharePoint Page Libraries  
            - Images → Picture Libraries (updating references in content)  
            - Documents and assets → Document Libraries (preserving links)  
            - Events, links, and other items → corresponding SharePoint Lists  
        - Integrated **InfoPath forms** and **variations** for multilingual support.  
        - Provided post-implementation support, resolving technical issues and ensuring smooth adoption.  
        - Conducted **end-user training sessions** and collaborated with cross-functional teams (content creators, designers, IT admins).  
        - Documented migration steps, customizations, and scripts, while monitoring content for quality and continuous improvement.  


??? tabs "WSS 3.0 – Migration of Network Documents to SharePoint"
    === "Project and Team"
        - **Project:** Document Migration from Network Drives to SharePoint WSS 3.0  
        - **Role:** Software Engineer  
        - **Duration:** Feb 2007 – Aug 2007  
        - **Team:** 1 Project Manager + 3 Developers
        - **Domain:** Financial Services / Banking
        - **Objective:**  
            - Migrate documents from network drives into SharePoint WSS 3.0.  
            - Preserve key metadata (creation date, modification date, author) during migration.  
            - Build a custom migration utility in C# to accelerate uploads.  
            - Upgrade WSS 3.0 to SP2 as a prerequisite for future migration to MOSS 2007.  

    === "Tech Stack"
        - SharePoint WSS 3.0 / SP2  
        - Windows Server 2003 + IIS 6  
        - Visual Studio 2005 (C#)  
        - SQL Server 2005  

    === "Role & Responsibilities"
        - Developed a custom C# migration tool to upload documents into WSS 3.0.  
        - Collaborated with users during the migration process, resolving errors and enhancing the tool based on feedback.  
        - Ensured document metadata integrity (author, creation date, modification date) during migration.  
        - Supported manual pre-sorting of documents to improve migration efficiency.  
        - Upgraded SharePoint WSS 3.0 to SP2 in preparation for transition to MOSS 2007.  



## Contact

For questions, suggestions, or contributions:
- Email: [das.d@hotmail.com](mailto:das.d@hotmail.com)
- Documentation Repository: [GitHub](https://github.com/dwdas9/home)