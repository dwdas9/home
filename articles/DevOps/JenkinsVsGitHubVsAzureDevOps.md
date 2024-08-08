---
layout: default
title: Jenkins Vs GitHub Vs AzureDevOps
parent: AzureDevOps
nav_order: 1
---

<details open markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

<img src="images/2024-08-08-15-25-58.png" alt="Description of the image" style="max-width: 100%; height: auto; border: 1px solid #ddd; border-radius: 4px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);" onmouseover="this.style.transform='scale(2)'" onmouseout="this.style.transform='scale(1)'">

# <span style="color: blueviolet;Font-family: Segoe UI, sans-serif;">Jenkins Vs GitHub Vs Azure DevOps</span>

CI/CD tools help automate the process of building, testing, and deploying code. This is super important for big projects with multiple environments and strict deployment rules.

In this article, I will give you a quick summary of the popular CI/CD tools.

<p style="color: #006600; font-family: 'Trebuchet MS', Helvetica, sans-serif; background-color: #e6ffe6; padding: 15px; border-left: 5px solid #00cc66;">
For busy people, GitHub is the best. It's very well integrated with VS Code and has everything in one place – repositories, version control, CI/CD, and many VS Code extensions. It makes development work very convenient and efficient.
</p>

## <span style="color: MediumOrchid;Font-family: Segoe UI, sans-serif;">Jenkins</span>

### <span style="color: PaleVioletRed ">What is Jenkins?</span>
Jenkins is an open-source CI/CD software mainly based on Java. It helps with CI/CD, but for version control, you need to use something else like GitHub.

### <span style="color: PaleVioletRed ">Hosting</span>
Jenkins is self-hosted, meaning you need to install and manage it on your infrastructure, whether on-premise or on cloud services like Azure, AWS, or Google Cloud.

### <span style="color: PaleVioletRed ">Pricing</span>
Jenkins is free software, but you will have to pay for the infrastructure, servers, maintenance, and everything else.

### <span style="color: PaleVioletRed ">Best For</span>
If your company prefers open-source tools and needs a lot of customization, Jenkins is a good choice. You can control everything and customize it heavily. But remember, you have to handle all the infrastructure, installation, maintenance, and troubleshooting yourself. Companies like **Netflix**, **Etsy**, and **Yahoo** use Jenkins. Note, Jenkins doesn't come with version control like Git, which you'll need for CI/CD projects.

## <span style="color: MediumOrchid;Font-family: Segoe UI, sans-serif;">GitHub</span>

GitHub is the most popular, the easiest, and the most all-in-one choice for CI/CD. It provides version control and CI/CD all as a service. You can have your own runners too (servers) for hybrid setups and to reduce costs. Personally, this is my first choice.

### <span style="color: PaleVioletRed ">What is GitHub Actions?</span>
The CI/CD part of GitHub is done using GitHub Actions. These are just workflows for building, deploying, etc., written in a .yml file.

### <span style="color: PaleVioletRed ">Hosting</span>
GitHub Actions is cloud-based. It uses GitHub’s infrastructure, so you don’t need to manage any servers. But you can have your own runners (hybrid setup) if you want more customization and don't want to pay a lot for services.

### <span style="color: PaleVioletRed ">Pricing</span>
- Free for public repositories.
- For private repositories, a number of hosted runner minutes are included with each pricing tier. Additional minutes cost $0.008 per minute for Linux.

### <span style="color: PaleVioletRed ">Best For</span>
- The easiest, most all-in-one solution with version control (GitHub repositories) and CI/CD (GitHub Actions) together.
- Examples: **Facebook**, **Airbnb**, many open-source projects.

## <span style="color: MediumOrchid;Font-family: Segoe UI, sans-serif;">Azure DevOps</span>

### <span style="color: PaleVioletRed ">What is Azure DevOps?</span>
Azure DevOps is a collection of development tools by Microsoft that supports the entire software development lifecycle, including Git repositories, CI/CD pipelines, and more. It was earlier known as TFS.

So, like GitHub, it also has its own repositories and version control. It can connect easily with Git repositories as well.

### <span style="color: PaleVioletRed ">Hosting</span>
Azure DevOps offers both cloud and self-hosted options. You can use Microsoft’s cloud infrastructure or set up your own servers.

### <span style="color: PaleVioletRed ">Pricing</span>
- Free for open-source projects with up to 10 parallel jobs.
- Basic plan: Free for the first 5 users, then $6 per user/month with one free pipeline.
- Additional pipelines start at $40/month for cloud-hosted or $15/month for self-hosted.

### <span style="color: PaleVioletRed ">Best For</span>
- Teams heavily invested in the Microsoft ecosystem.
- Organizations needing integration with Azure services.
- Examples: **Microsoft**, **Adobe**, **Accenture**.

## <span style="color: MediumOrchid;Font-family: Segoe UI, sans-serif;">Let's put the comparison in a table</span>

| CI Tool           | Open Source | Hosting         | Free Version | Build Agent Pricing                                  | Supported Platforms                  |
|-------------------|-------------|-----------------|--------------|-----------------------------------------------------|--------------------------------------|
| **GitHub Actions**| No          | Cloud           | Yes          | Additional minutes start at $0.008 per minute       | Linux, Windows, macOS                |
| **Jenkins**       | Yes         | Self-hosted     | Yes          | Free                                                | Linux, Windows, macOS                |
| **GitLab CI**     | No          | Cloud/Self-hosted| Yes         | Additional units start at $10 for 1,000 minutes     | Linux, Windows, macOS, Docker        |
| **Azure DevOps**  | No          | Cloud/Self-hosted| Yes         | Additional pipelines start at $15/month (self-hosted)| Linux, Windows, macOS                |