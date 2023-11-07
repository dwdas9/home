---
layout: default
title: Pyspark Ubuntu Docker Setup
nav_exclude: true
---

## Table of contents

- [Setting Up a Dockerized Spark Environment on Ubuntu for Windows](#setting-up-a-dockerized-spark-environment-on-ubuntu-for-windows)
  - [](#)
  - [Background](#background)
  - [Steps](#steps)


# <span class="c29 c32">Setting Up a Dockerized Spark Environment on Ubuntu for Windows</span>

## <span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 624.00px; height: 624.00px;">![](images/image7.jpg)</span>

## <span class="c21">Background</span>

<span class="c15">In this guide, I'll demonstrate how to create an Ubuntu Docker image fine-tuned for Python and Spark. We'll see how to connect the environment to Visual Studio Code using the Dev Containers extension. This VS extension allows you to work within a containerized environment seamlessly, offering the impression that all processes are running natively on your local machine. Ubuntu was selected as the base image due to its renowned stability, comprehensive</span> <span class="c2">apt-get</span><span class="c15"> system for handling packages, and flexibility in managing system-level packages or mimicking production setups. We considered other options like Python-focused images (e.g.,  </span><span class="c2">python:3.9-slim</span><span class="c1">,), Alpine Linux for its minimalism and security, and Debian which parallels Ubuntu's benefits but lacks some commercial features.</span>

## <span>Steps</span>

1.  <span class="c4">Create the Dockerfile</span>

1.  <span class="c1">Create a new file in your project directory called Dockerfile. Ensure it has no extension.</span>
2.  <span class="c1">Navigate to your desired location on Windows.</span>
3.  <span class="c1">Right-click, select New, and then choose Folder.</span>
4.  <span class="c1">Inside this new folder, right-click and choose New followed by Text Document.</span>
5.  <span class="c15">Rename the new document to Dockerfile. Ensure you remove the .txt ending. (Note: The file should have</span> <span class="c9">no extension</span><span class="c1">.)</span>
6.  <span class="c1">Open the file using Notepad, insert the provided code, then save and close.</span>

* * *

<span class="c1"></span>

<span class="c1"></span>

<a id="t.e544a075b43d8ab11c49a5f5756c374a32947cc5"></a><a id="t.0"></a>

<table class="c31">

<tbody>

<tr class="c19">

<td class="c27" colspan="1" rowspan="1">

<span class="c16"># Base the image on Ubuntu 20.04</span><span class="c13">  
FROM ubuntu:20.04  

</span><span class="c16"># Set non-interactive mode to prevent prompts during build</span><span class="c13">  
ENV DEBIAN_FRONTEND=noninteractive  

</span><span class="c16"># Update the package list</span><span class="c13">  
RUN apt-get update  

</span><span class="c16"># Install software-properties-common for repo management</span><span class="c13">  
RUN apt-get install software-properties-common -y  

</span><span class="c16"># Add the 'deadsnakes' PPA for newer Python versions</span><span class="c13">  
RUN add-apt-repository ppa:deadsnakes/ppa  

</span><span class="c16"># Update package list post-PPA addition</span><span class="c13">  
RUN apt-get update  

</span><span class="c16"># Install Python 3.9 and pip3</span><span class="c13">  
RUN apt-get install -y python3.9 python3-pip  

</span><span class="c16"># Install headless OpenJDK 11</span><span class="c13">  
</span><span class="c16"># Choosing headless JDK for a smaller footprint without GUI libs</span><span class="c13">  
</span><span class="c16"># Using OpenJDK for its open-source, transparent, and community-driven nature</span><span class="c13">  
RUN apt-get install -y openjdk-11-jdk-headless  

</span><span class="c16"># Install the PySpark library</span><span class="c13 c29">  
RUN pip3 install pyspark</span>

</td>

</tr>

</tbody>

</table>

<span class="c14"></span>

1.  <span class="c4">Build the docker Image</span>

1.  <span class="c1">In your terminal, go to the project directory with the Dockerfile and run the following command:</span>

<a id="t.1a85e10d89d46b5a12e22b637ce5d626b1822f59"></a><a id="t.1"></a>

<table class="c23">

<tbody>

<tr class="c19">

<td class="c26" colspan="1" rowspan="1">

<span class="c13">docker build -t pyspark-ubuntu-image .</span>

</td>

</tr>

</tbody>

</table>

<span class="c4"></span>

<span class="c15">The name</span> <span class="c6">pyspark-ubuntu-image</span><span class="c15">is your chosen Docker image name, and</span> <span class="c6">.</span><span class="c1"> means the Dockerfile is in the current folder</span>

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 624.00px; height: 280.00px;">![](images/image9.png)</span>

1.  <span class="c4">Run the docker container</span>

<span class="c1">Once the image is successfully built, you can run a container from it, using:</span>

1.  <span class="c9">Command prompt</span><span class="c1">:</span>

1.  <span class="c1">Open command prompt as an administrator</span>
2.  <span class="c1">Run the following command</span>

<a id="t.ecc82130ee12d51a255be98ca47a6691a32fd869"></a><a id="t.2"></a>

<table class="c3">

<tbody>

<tr class="c19">

<td class="c24" colspan="1" rowspan="1">

<span class="c13">docker run -it --name my_pyspark_ubuntu_cont pyspark-ubuntu-image /bin/bash</span>

</td>

</tr>

</tbody>

</table>

1.  <span class="c1">If successful, you'll enter the container's shell</span>

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 624.00px; height: 182.67px;">![](images/image6.png)</span>

1.  <span class="c15">In Docker Desktop's container window, you'll see</span> <span class="c2">my_pyspark_ubuntu_cont</span><span class="c1"> listed as running.</span>

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 624.00px; height: 184.00px;">![](images/image8.png)</span>

1.  <span class="c4">Using Docker Desktop</span>

1.  <span class="c1">Launch Docker Desktop from the system tray.</span>
2.  <span class="c15">In the</span><span class="c2">Images</span> <span class="c15">tab, locate and hit</span><span class="c2"> Run</span><span class="c1"> for `pyspark-ubuntu-image`.</span>
3.  <span class="c1">Name your container and keep other settings default.</span>
4.  <span class="c15">In the</span> <span class="c2">Containers</span><span class="c1"> tab, find the container using the name you provided.</span>

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 624.00px; height: 277.33px;">![](images/image1.png)</span>

1.  <span class="c4">Configure VS Code and connect with the remote container</span>

1.  <span class="c9">Install Visual Studio Code Dev Containers Extension</span>

1.  <span class="c1">Open Visual Studio Code.</span>
2.  <span class="c1">Go to Extensions (or press Ctrl+Shift+X).</span>
3.  <span class="c15">Search for</span> <span class="c2">Dev Containers</span><span class="c1">.</span>
4.  <span class="c15">Click</span> <span class="c2">Install</span> <span class="c1">on the relevant result.</span>

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 624.00px; height: 260.00px;">![](images/image5.png)</span>

1.  <span class="c4">Connect to the remote container</span>

1.  <span class="c1">In the bottom-left of VS Code, click the "Open Remote Window" icon.</span>
2.  <span class="c1">At the top search window, a menu will appear.</span>
3.  <span class="c15">Choose</span> <span class="c2">Attach to Running Container</span><span class="c1">.</span>

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 624.00px; height: 464.00px;">![](images/image3.png)</span>

1.  <span class="c1">Locate and click on your active container in the list.</span><span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 518.00px; height: 80.80px;">![](images/image2.png)</span>

<span class="c1"></span>

1.  <span class="c1">VS Code will launch a new window connected to that container.</span>

1.  <span class="c4">Enable Jupyter notebook support extension</span>

1.  <span class="c1">While VS code is connect with the container enable/install Jupyter notebook support extension</span>

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 624.00px; height: 213.33px;">![](images/image4.png)</span>

1.  <span class="c4">Running jupyter notebooks</span>

<span class="c1">The environment is ready to handle Python scripts, Jupyter notebooks (.ipynb files), and execute big data operations, analytics, and machine learning processes using Spark in Python.</span>

1.  <span class="c4">For python files</span>

<span class="c15">Simply open any `.py` file and run it directly within VS Code.</span>

1.  <span class="c9">For Jupyter Notebooks</span><span class="c1">:</span>

<span class="c4">Note:</span>

1.  <span class="c1">When executing a notebook, you'll need to select the appropriate kernel.</span>
2.  <span class="c1">You might be prompted to install the `ipykernel` package, especially when you try to run a Python cell for the first time.</span>

<span class="c28"></span>

<span style="overflow: hidden; display: inline-block; margin: 0.00px 0.00px; border: 0.00px solid #000000; transform: rotate(0.00rad) translateZ(0px); -webkit-transform: rotate(0.00rad) translateZ(0px); width: 624.00px; height: 441.33px;">![](images/image10.png)</span>

1.  <span class="c1">To preemptively install `ipykernel`, open a terminal in VS Code and enter</span>

<a id="t.4bacb4708341a608e12fc9a9ff0cf402597de475"></a><a id="t.3"></a>

<table class="c23">

<tbody>

<tr class="c19">

<td class="c26" colspan="1" rowspan="1">

<span class="c13">pip install ipykernel</span>

</td>

</tr>

</tbody>

</table>

<span class="c1"></span>

<span class="c1"></span>

<span class="c1"></span>

<span class="c1"></span>

<div>

<span>D Das(das.d@hotmail.com)</span>

</div>