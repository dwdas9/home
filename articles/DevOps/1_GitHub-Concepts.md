---
layout: default
title: GitHub Concepts
parent: AzureDevOps
nav_order: 1
has_children: true
---

<details open markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

# <span style="color: blueviolet;Font-family: Segoe UI, sans-serif;">Getting started with GitHub</span>

## <span style="color: MediumOrchid;Font-family: Segoe UI, sans-serif;">Repositories, Branches, Push, Pull, Commit</span>
   - Repositories
   - Branches
   - Push
   - Pull
   - Commits

## <span style="color: MediumOrchid;Font-family: Segoe UI, sans-serif;">Understanding GitHub Actions</span>

In this article, I'll explain the core concepts of GitHub Actions using simple language and minimal words.

[Further reading.](https://docs.github.com/en/actions/about-github-actions/understanding-github-actions)

### <span style="color: PaleVioletRed ">For the Busy Readers</span>

GitHub Actions is a tool to automate code building and deployment tasks. With GitHub Actions, you create **workflows**. These workflows are YAML files inside the `.github/workflows` folder in your project. Workflows contain jobs, and jobs contain steps. Steps can be simple commands, scripts, or pre-built actions from the GitHub community.

<p style="
    margin: 20px 0;
    font-size: 18px;
    color: #333;
    font-family: 'Comic Sans MS', cursive, sans-serif;
    background-color: #ffeb3b; /* Light yellow background */
    padding: 10px;
    border-radius: 8px; /* Rounded corners */
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2); /* Shadow for depth */
    display: inline-block; /* Shrink to fit content */
">
   GitHub Action is a tool. GitHub Actions Workflow is the output of the tool.
</p>


### <span style="color: PaleVioletRed ">Key Concepts in GitHub Actions</span>

Here are the key terms you will hear most of the time when dealing with GitHub Actions:

1. **Workflows**: YAML files inside the `.github/workflows` folder.
2. **Jobs**: Workflows contain jobs, which are sets of steps.
3. **Steps**: Jobs are made up of steps that run commands, scripts, or actions.
4. **Runners**: Servers that execute the jobs (can be GitHub-provided or self-hosted).

**How It Works:**
1. **Trigger**: An event, like pushing code or creating a pull request, triggers the workflow.
2. **Workflow Activation**: The specified workflow for that trigger starts running.
3. **Jobs Execution**: Jobs within the workflow run, either independently or in sequence.
4. **Runners**: Jobs use virtual machines provided by GitHub or self-hosted machines to run.

### <span style="color: PaleVioletRed">Example Workflow</span>
You commit code to your repository. The workflow is triggered. Your code is built, tested, and deployed automatically.

> GitHub provides virtual machines for Linux, Windows, and macOS.

### <span style="color: PaleVioletRed">Anatomy of a GitHub Workflow</span>

A GitHub Actions workflow is written as a YAML file inside the `.github/workflows` directory of a project/repository. Each workflow is stored as a separate YAML file in your code repository.

This is how a typical workflow YAML file looks:

```yaml
name: CI

on:
  push:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - name: Build
      run: make build
```

1. **name**: This workflow is named "CI" (Continuous Integration). You can name it anything you like.
2. **on**: This workflow runs when there is a push to the `main` branch.
3. **jobs**: This workflow has one job named `build`.
4. **runs-on**: This job runs on an `ubuntu-latest` virtual machine.
5. **steps**: 
    - **Checkout code**: Uses `actions/checkout@v3` to pull the code.
    - **Build**: Runs the `make build` command to build the project.
