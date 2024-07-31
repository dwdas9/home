GitHub Actions is a continuous integration and continuous delivery (CI/CD) platform that allows you to automate your build, test, and deployment pipeline. You can create workflows that run tests whenever you push a change to your repository, or that deploy merged pull requests to production.

You can automate the steps in your deployment process by using a workflow. Each time you make a change to your code and commit the change to your Git repository, the workflow runs your predefined process. A workflow can verify whether your Bicep code meets your quality standards, then automate the actions to deploy your resources to Azure. The process is defined in a workflow definition that you create.

GitHub Actions is a feature of GitHub. GitHub also hosts the Git repositories you use to store and share your code with your collaborators. When you store your Bicep code on GitHub, GitHub Actions can access your code to automate your deployment processes. In this unit, you'll learn about GitHub Actions.

What is a workflow?
A workflow is a configurable repeatable process that's defined in a file that's used to test and deploy your code. A workflow consists of all the steps, in the proper order, that you need to execute.

When you work with GitHub Actions, you define your workflow configuration in a YAML file. Because a workflow YAML file is a code file, the file is stored with your Bicep code in your Git repository in a folder named .github/workflows. A YAML file is a structured-text file, similar to a Bicep structured-text file. You can create and edit a YAML file with any text editor. In this module, you'll use Visual Studio Code as the editor. The GitHub web interface provides tools that you can use to view and edit your workflow YAML file, to collaborate on your workflow definition, and to manage different versions of your workflow file by using commits and branches.


Runners
Until now, you've deployed your Bicep files from your local computer. After you write a Bicep template, you deploy it to Azure by using the Azure CLI or Azure PowerShell. These tools use your computer's resources to submit the template to Azure. They use your personal identity to authenticate you to Azure and to verify that you have the permissions to deploy the resources.

A workflow also needs access to a computer or GPU with the correct operating system and hardware platform so it can execute the deployment actions. GitHub Actions uses runners, which are computers that are configured to run deployment steps for a workflow. Each runner already has the Bicep and Azure tooling you used in earlier modules, so it can do the same things you do from your own computer. Instead of a human executing commands, the GitHub Actions service instructs the runner to run the steps that you've defined in the workflow YAML file.

GitHub Actions provides multiple types of runners for different operating systems, such as Linux or Windows, and different sets of tools. GitHub manages these runners, so you don't have to maintain any compute infrastructure for the runners. The runners sometimes are called GitHub-hosted runners or hosted runners because they're hosted on your behalf. When your workflow runs, a hosted runner is automatically created. When your workflow is finished running, the hosted runner is automatically deleted. You can't access hosted runners directly, so it's important that your workflow contains all the steps necessary to deploy your solution.

Triggers
You use a trigger to instruct GitHub Actions when to run your workflow. You can choose from multiple types of triggers. For now, you'll use a manual trigger to tell GitHub Actions when to start running your workflow. Later in this module, you'll learn more about other types of triggers.

Diagram that shows a trigger initiating a workflow.

![](images/custom-image-2024-08-01-01-08-03.png)




[Read More](https://docs.github.com/en/actions/writing-workflows)

[Read More](https://learn.microsoft.com/en-us/training/modules/build-first-bicep-deployment-pipeline-using-github-actions/2-understand-github-actions)