---
layout: default
title: Kubernetes Brands
parent: Docker
nav_order: 14
---

# <span style="color: blueviolet;Font-family: Segoe UI, sans-serif;">Types of Kubernetes</span>

Kubernetes is a system for managing containerized applications, but there are many ways to set it up based on your needs. The table below summriazes the various available kubernetes offerings:

## <span style="color: MediumOrchid;Font-family: Segoe UI, sans-serif;">Kubernetes Brands<span>

| **Kubernetes Tool** | **Company/Provider** | **Best For** | **Environment** | **Single Machine Setup** | **Multi-Machine Setup** | **Installation Glimpse** |
|----------------------|----------------------|--------------|-----------------|--------------------------|-------------------------|--------------------------|
| **Minikube** | Kubernetes Community (CNCF) | Local development and testing | Local, Development | Yes | No | Install via package manager (brew on macOS, choco on Windows) and run `minikube start`. |
| **Kubeadm** | Kubernetes Community (CNCF) | Production environments, full control | On-Premises, Cloud | Yes (single node) | Yes | Install Docker, kubeadm, kubelet, and kubectl, then initialize with `kubeadm init` and join nodes with `kubeadm join`. |
| **Rancher** | SUSE | Multi-cluster management, enterprise environments | On-Premises, Cloud, Hybrid | Yes (for management) | Yes | Install Rancher on Docker (`docker run` command) or via Helm chart on an existing Kubernetes cluster. |
| **K3s** | Rancher (SUSE) | Lightweight Kubernetes, edge computing, IoT | Edge, IoT, Development | Yes | Yes | Install via a single command: `curl -sfL https://get.k3s.io | sh -` on each node. |
| **K3d** | Rancher (SUSE) | Local multi-node Kubernetes clusters | Local, Development | Yes | No | Install K3d via package manager and create a cluster using `k3d cluster create mycluster --agents 2`. |
| **Docker Desktop Kubernetes** | Docker, Inc. | Local development and integration with Docker | Local, Development | Yes | No | Enable Kubernetes in Docker Desktop settings and wait for it to start. |
| **MicroK8s** | Canonical (Ubuntu) | Lightweight Kubernetes, IoT, Edge, CI/CD pipelines | Local, Edge, Development, CI/CD | Yes | Yes | Install with `snap install microk8s --classic`, then use `microk8s start`. |
| **Amazon EKS** | Amazon Web Services (AWS) | Managed Kubernetes service, production environments | Cloud | No | Yes | Set up via AWS Management Console or CLI, configure using eksctl or AWS CloudFormation. |
| **Google GKE** | Google Cloud | Managed Kubernetes service, production environments | Cloud | No | Yes | Set up via Google Cloud Console or CLI, configure with gcloud commands. |
| **Azure AKS** | Microsoft Azure | Managed Kubernetes service, production environments | Cloud | No | Yes | Set up via Azure Portal or CLI, configure using Azure CLI commands. |
| **OpenShift** | Red Hat (IBM) | Enterprise Kubernetes with additional PaaS features | On-Premises, Cloud, Hybrid | Yes (for single node) | Yes | Install via the OpenShift installer or on an existing Kubernetes cluster with `oc` CLI tools. |
| **Kind (Kubernetes in Docker)** | Kubernetes Community (CNCF) | Kubernetes testing and CI environments | Local, CI/CD | Yes | No | Install via package manager and create clusters using `kind create cluster`. |

## <span style="color: MediumOrchid;Font-family: Segoe UI, sans-serif;">So, let's summarize</span>

Kubernetes is a powerful tool used to manage containerized applications in a cloud or on-premises environment. But there are different ways to set up Kubernetes depending on what you need. 

- **Minikube** is like a quick start for developers. It’s very easy to set up on your laptop and is good for learning or trying out Kubernetes on a small scale.
- **Kubeadm** is for those who want to set up Kubernetes in a more serious, production-ready environment. It gives you more control but needs a bit more work.
- **Rancher** is best if you have many Kubernetes clusters and want an easy way to manage them all. It’s very popular in companies.
- **K3s** is a lightweight version of Kubernetes, perfect for small devices or when you don’t have many resources. 
- **Docker Desktop** has Kubernetes built in, so if you’re already using Docker, this is a very convenient option.
- **Managed services like EKS, GKE, and AKS** are provided by big cloud companies like Amazon, Google, and Microsoft. They take care of most of the hard work for you, so you can focus on your apps.