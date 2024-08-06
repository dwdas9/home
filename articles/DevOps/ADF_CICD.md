---
layout: default
title: ADF-CI-CD
parent: AzureDevOps
nav_order: 4
---


# ADF -  Dev to PROD using GitHub workflows and Azure Pipelines

Moving your Azure Data Factory from Dev to PROD can be CI/CDed using GitHub Actions Workflows or using Azure DevOps Pipelines.

[Main Article](https://learn.microsoft.com/en-us/azure/data-factory/continuous-integration-delivery)

> ADF uses ARM templates to store the configuration of pipelines, datasets, data flows, etc.

There are two methods to deploy a data factory to another environment:

- **Automated deployment** using Data Factory's integration with Azure Pipelines or GitHub workflows.
- **Manual deployment** by uploading a Resource Manager template using Data Factory UX integration with Azure Resource Manager.

## Using GitHub

**Set Up Version Control**
- **Connect ADF with GitHub**: Open your ADF in the development environment. Go to the "Manage" tab and connect your ADF to a GitHub repository.
- **Continuous Integration (CI)**: Develop and test your ADF pipelines, datasets, and linked services. Commit and push your changes to the GitHub repository.

**Create a GitHub Actions Workflow**
Use this YAML code for your workflow:

```yaml
name: ADF CI

on:
  push:
    branches:
      - main  # or your development branch

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout code
      uses: actions/checkout@v2

    - name: Set up .NET
      uses: actions/setup-dotnet@v1
      with:
        dotnet-version: '3.x'

    - name: Restore dependencies
      run: dotnet restore

    - name: Build
      run: dotnet build --no-restore

    - name: Publish artifacts
      uses: actions/upload-artifact@v2
      with:
        name: drop
        path: |
          ARMTemplateForFactory.json
          ARMTemplateParametersForFactory.json
```

**Continuous Deployment (CD)**
Create a deployment workflow in `.github/workflows`:

```yaml
name: ADF CD

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout code
      uses: actions/checkout@v2

    - name: Azure Login
      uses: azure/login@v1
      with:
        creds: ${{ secrets.AZURE_CREDENTIALS }}

    - name: Deploy ARM Template
      uses: azure/arm-deploy@v1
      with:
        resource-group: 'YOUR_RESOURCE_GROUP_NAME'
        template: './ARMTemplateForFactory.json'
        parameters: './ARMTemplateParametersForFactory.json'
        deployment-name: 'adf-deployment'
```

**Manage Parameters**
Set different values for production in your parameters file, like connections and dataset paths.

**Run the Workflow**
Push changes to the GitHub repository to trigger the CI workflow. After a successful build, the CD workflow will automatically deploy changes to the production ADF.

## Using Azure DevOps

**Set Up Version Control**
- **Connect ADF with Azure Repos**: Open your ADF in the development environment. Go to the "Manage" tab and connect your ADF to an Azure Repos Git repository.
- **Continuous Integration (CI)**: Develop and test your ADF pipelines, datasets, and linked services. Commit and push your changes to the Azure Repos Git repository.

**Create a Build Pipeline**
Go to Azure DevOps > Pipelines > Builds > New Pipeline. Select your Azure Repos Git repository. Use this YAML code:

```yaml
trigger:
  branches:
    include:
      - main  # or your development branch

pool:
  vmImage: 'ubuntu-latest'

steps:
- task: UseDotNet@2
  inputs:
    packageType: 'sdk'
    version: '3.x'
    installationPath: $(Agent.ToolsDirectory)/dotnet

- task: DotNetCoreCLI@2
  inputs:
    command: 'restore'
    projects: '**/*.csproj'

- task: DotNetCoreCLI@2
  inputs:
    command: 'build'
    projects: '**/*.csproj'

- task: PublishPipelineArtifact@1
  inputs:
    targetPath: '$(Build.ArtifactStagingDirectory)'
    artifact: 'drop'
```

**Continuous Deployment (CD)**
Create a release pipeline in Azure DevOps:

**Create a Release Pipeline**
1. Go to Azure DevOps > Pipelines > Releases > New pipeline.
2. Select an empty job, add an artifact, and choose the build pipeline you created.
3. Add a new stage for deployment.

Add a task to deploy the ARM template of your ADF in the deployment stage:

```yaml
- task: AzureResourceManagerTemplateDeployment@3
  inputs:
    deploymentScope: 'Resource Group'
    azureResourceManagerConnection: 'AzureRMConnection'
    subscriptionId: 'YOUR_SUBSCRIPTION_ID'
    action: 'Create Or Update Resource Group'
    resourceGroupName: 'YOUR_RESOURCE_GROUP_NAME'
    location: 'YOUR_RESOURCE_LOCATION'
    templateLocation: 'Linked artifact'
    csmFile: '$(System.DefaultWorkingDirectory)/_your-build-pipeline/drop/ARMTemplateForFactory.json'
    csmParametersFile: '$(System.DefaultWorkingDirectory)/_your-build-pipeline/drop/ARMTemplateParametersForFactory.json'
```

**Manage Parameters**
Set different values for production in your parameters file, like connections and dataset paths.

**Run the Pipeline**
Push changes to the Azure Repos Git repository to trigger the CI pipeline. After a successful build, the CD pipeline will automatically deploy changes to the production ADF.