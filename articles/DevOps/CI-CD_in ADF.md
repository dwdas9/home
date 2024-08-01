[Main Article](https://learn.microsoft.com/en-us/azure/data-factory/continuous-integration-delivery)


In ADF, CI/CD means moving Data Factory pipelines from Dev to PROD(One env to another). ADF uses ARM templates to store configuration of Pipelines, datasets, data flows etc.

There are two  methods to deploy a data factory to another environment:

- Automated deployment using Data Factory's integration with Azure Pipelines
- Manually upload a Resource Manager template using Data Factory UX integration with Azure Resource Manager.