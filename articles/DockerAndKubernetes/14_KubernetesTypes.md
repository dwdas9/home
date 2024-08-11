---
layout: default
title: Kubernetes Brands
parent: Docker
nav_order: 14
---

# <span style="color: blueviolet;Font-family: Segoe UI, sans-serif;">Types of Kubernetes</span>

Kubernetes is a system for managing containerized applications, but there are many ways to set it up based on your needs. The table below summriazes the various available kubernetes 'brands':

## <span style="color: MediumOrchid;Font-family: Segoe UI, sans-serif;">For the busy people:</span>
- **Development**: **Minikube**, **K3d**, **Docker Desktop Kubernetes**, and **Kind** are geared toward development and testing.
- **Production**: **Kubeadm**, **Rancher**, **K3s**, and managed services like **Amazon EKS**, **Google GKE**, and **Azure AKS** are suited for production environments.
- **Mixed Use**: **K3s** and **MicroK8s** can be used both in development and production, especially in edge computing and IoT.

## <span style="color: MediumOrchid;Font-family: Segoe UI, sans-serif;">Kubernetes Brands<span>

Here's the revised table with the "Environment" column removed:

| **Kubernetes Tool** | **Company/Provider** | **Best For** | **Single Machine Setup** | **Multi-Machine Setup** | **Used By** |
|----------------------|----------------------|--------------|--------------------------|-------------------------|-------------|
| **Minikube** | Kubernetes Community (CNCF) | Development | Yes | No | Individual developers, small startups. |
| **Kubeadm** | Kubernetes Community (CNCF) | Production | Yes (single node) | Yes | Enterprises, cloud service providers. |
| **Rancher** | SUSE | Production | Yes (for management) | Yes | Enterprises, companies managing multi-cloud or hybrid environments. |
| **K3s** | Rancher (SUSE) | Development/Production | Yes | Yes | IoT companies, edge computing solutions, small and medium enterprises. |
| **K3d** | Rancher (SUSE) | Development | Yes | No | Developers, small companies for testing multi-node setups. |
| **Docker Desktop Kubernetes** | Docker, Inc. | Development | Yes | No | Developers using Docker, small teams. |
| **MicroK8s** | Canonical (Ubuntu) | Development/Production | Yes | Yes | IoT and edge computing companies, startups. |
| **Amazon EKS** | Amazon Web Services (AWS) | Production | No | Yes | Large enterprises, companies using AWS. |
| **Google GKE** | Google Cloud | Production | No | Yes | Large enterprises, companies using Google Cloud. |
| **Azure AKS** | Microsoft Azure | Production | No | Yes | Enterprises, companies using Azure services. |
| **OpenShift** | Red Hat (IBM) | Production | Yes (for single node) | Yes | Enterprises needing integrated CI/CD, large companies in regulated industries. |
| **Kind (Kubernetes in Docker)** | Kubernetes Community (CNCF) | Development | Yes | No | Developers, CI/CD pipelines in tech companies. |
