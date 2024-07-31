### Case Study: Moving Azure Data Factory (ADF) from Development to Production using CI/CD with GitHub and Azure DevOps

#### Background:
You have an Azure Data Factory (ADF) set up in your development environment. Now, you need to move it to production smoothly and automatically using Continuous Integration and Continuous Deployment (CI/CD).

### Using GitHub

#### Steps to Follow with GitHub:

1. **Set Up Version Control**:
   - **Connect ADF with GitHub**:
     - Open your ADF in the development environment.
     - Go to the "Manage" tab and connect your ADF to a GitHub repository.

2. **Continuous Integration (CI)**:
   - **Save Changes**:
     - Develop and test your ADF pipelines, datasets, and linked services.
     - Commit and push your changes to the GitHub repository.

3. **Create a GitHub Actions Workflow**:
   - **Create a Workflow**:
     - In your GitHub repository, go to the "Actions" tab and set up a new workflow.
     - Use the following simple YAML code for your workflow:

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

4. **Continuous Deployment (CD)**:
   - **Create a Deployment Workflow**:
     - Add another workflow file in `.github/workflows` for deployment.

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

5. **Manage Parameters**:
   - **Set Parameters**:
     - In your parameters file, set different values for production, like connections and dataset paths.

6. **Run the Workflow**:
   - **Automate Deployment**:
     - Push changes to the GitHub repository to trigger the CI workflow.
     - After a successful build, the CD workflow will automatically deploy changes to the production ADF.

### Using Azure DevOps

#### Steps to Follow with Azure DevOps:

1. **Set Up Version Control**:
   - **Connect ADF with Azure Repos**:
     - Open your ADF in the development environment.
     - Go to the "Manage" tab and connect your ADF to an Azure Repos Git repository.

2. **Continuous Integration (CI)**:
   - **Save Changes**:
     - Develop and test your ADF pipelines, datasets, and linked services.
     - Commit and push your changes to the Azure Repos Git repository.

3. **Create a Build Pipeline**:
   - **Build Pipeline in Azure DevOps**:
     - Go to Azure DevOps > Pipelines > Builds > New Pipeline.
     - Select your Azure Repos Git repository.
     - Use the following simple YAML code for your pipeline:

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

4. **Continuous Deployment (CD)**:
   - **Create a Release Pipeline**:
     - Go to Azure DevOps > Pipelines > Releases > New pipeline.
     - Select an empty job, add an artifact, and choose the build pipeline you created.
     - Add a new stage for deployment.

   - **Deploy Task**:
     - In the deployment stage, add a task to deploy the ARM template of your ADF. This will typically include `ARMTemplateForFactory.json` and `ARMTemplateParametersForFactory.json`.

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

5. **Manage Parameters**:
   - **Set Parameters**:
     - In your parameters file, set different values for production, like connections and dataset paths.

6. **Run the Pipeline**:
   - **Automate Deployment**:
     - Push changes to the Azure Repos Git repository to trigger the CI pipeline.
     - After a successful build, the CD pipeline will automatically deploy changes to the production ADF.

