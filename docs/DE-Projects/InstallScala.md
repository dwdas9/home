# <span style="color: #7A3DAA; font-family: Segoe UI, sans-serif;">Installing Scala on Windows

Scala can be installed on Windows using Coursier tool. It's basically a command line tool which opens up when you click on the scala installer exe. Follow these steps to install scala on Windows. 

### <span style="color: #653090; font-family: Segoe UI, sans-serif;">Download and Install Scala

- [Download the .zip file and open it](https://github.com/coursier/coursier/releases/latest/download/cs-x86_64-pc-win32.zip).
- Run the `cs-x86_64-pc-win32.exe` file.
- A Command Prompt window will open. When prompted, press `Y` to proceed.


<img src="images/2024-08-14-17-06-23.png" alt="Description of the image" style="max-width: 100%; height: auto; border: 1px solid #ddd; border-radius: 4px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">



### <span style="color: #653090; font-family: Segoe UI, sans-serif;">Set Up Environment Variables

<p style="color: #006600; font-family: 'Trebuchet MS', Helvetica, sans-serif; background-color: #e6ffe6; padding: 15px; border-left: 5px solid #00cc66;">
The installation might not automatically set `SCALA_HOME` and add the `\bin` folder to your PATH. This setup is necessary for Scala to work properly.
</p>

After the installation, you need to manually add `SCALA_HOME` and `SCALA_HOME\data\bin` to your system's PATH.

<img src="images/2024-08-14-17-48-22.png" alt="Description of the image" style="max-width: 100%; height: auto; border: 1px solid #ddd; border-radius: 4px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">


> Note: Scala's bin should be in the path. Else, you won't be able to run it from command prompt.

<img src="images/2024-08-14-17-57-31.png" alt="Description of the image" style="max-width: 100%; height: auto; border: 1px solid #ddd; border-radius: 4px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">

