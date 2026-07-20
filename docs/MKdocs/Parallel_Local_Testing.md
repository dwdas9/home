# Testing MKDocs Locally

This website is made using Material for MKDocs framework. Its essentially few markdown files which I create and the framework compiles them into html pages and puts in a github branch, from where GitHub pages serves them.

So far so good. But, everytime I make a change to the website, I need to push the changes to GitHub and wait for it to build. This can be time-consuming and frustrating, especially if you are making a lot of changes.

To make the process easier, you can test your MKDocs site locally before deploying it to GitHub Pages. Let me show you how.


> Note: If the venv is already created, all you have to do is run the two commands command `source venvmac/bin/activate`  and then `mkdocs serve` and your page will be available at `http://127.0.0.1:8000/`.

## Quick Start


??? info "Step 1:  Create the script `createvenv.command` with the following content:"
    Just create a file and copy the content below into it. You can name the file anything you want, but make sure to keep the `.command` extension. This is a shell script that will set up a virtual environment for you. This is for mac OS.

    ``` bash

            #!/bin/bash

            # Can run anytime. Safe. Run it to make a fully working mkdocs venv with no integration issue with current docs.
            # This script sets up a venv and MkDocs environment for macOS.

            #This version is for macOS. For Windows, use createvenv.bat. Just go to the folder and double click the file.

            echo "Setting up MkDocs environment..."

            # Step 1: Clean up any existing virtual environment
            if [ -d "venvmac" ]; then
                echo "Removing existing virtual environment..."
                rm -rf venvmac
            fi

            # Step 2: Create new virtual environment
            echo "Creating new virtual environment..."
            python3 -m venv venvmac

            # Step 3: Activate virtual environment
            echo "Activating virtual environment..."
            source venvmac/bin/activate

            # Step 4: Upgrade pip and install packages
            echo "Installing required packages..."
            pip install --upgrade pip
            pip install --no-cache-dir mkdocs-material pymdown-extensions mkdocs-glightbox

            # Step 5: Verify installation
            echo "Verifying installation..."
            python --version
            pip list | grep mkdocs

            echo "Setup complete! Virtual environment is activated."
            echo "To activate this environment later, run: source venvmac/bin/activate"

            # Keep terminal window open
            read -p "Press Enter to close..."
    ```    


??? info "Step 2:  Run these commands in terminal:"

    ```bash
    chmod +x createvenv.command
    ./createvenv.command
    ``` 

??? info "Step 3:  Run these commands in terminal:"

    ```bash
    mkdocs build
    mkdocs serve
    ``` 


Your site will be available at `http://127.0.0.1:8000/`. Any changes you make to the markdown files will be immediately visible in the browser.

## Troubleshooting Sidebar/Navigation Not Updating

Sometimes, changes made to `mkdocs.yml` (such as updating the sidebar navigation) may not appear in your local site. This is often caused by an old `mkdocs serve` process running in the background, browser cache issues, or stale build files in the `site` folder.

**How to check and resolve:**

1. **Check for old mkdocs serve processes:**  
    - In VS Code, check the Terminal panel for any terminals that are already running `mkdocs serve` or Python processes. Stop or close these terminals before starting a new one.  
    - On Windows, open Task Manager and look for any `python.exe` or `mkdocs` processes.  
    - Alternatively, use PowerShell:  
      ```powershell
      Get-Process | Where-Object { $_.ProcessName -match "python|mkdocs" }
      ```
2. **Stop all old mkdocs/Python processes:**  
    - In Task Manager, right-click and end the processes.  
    - In PowerShell:  
      ```powershell
      Get-Process | Where-Object { $_.ProcessName -match "python|mkdocs" } | Stop-Process
      ```
3. **Delete the `site` folder:**  
    - Manually delete the folder, or use PowerShell:  
      ```powershell
      Remove-Item -Recurse -Force site
      ```
4. **Restart mkdocs serve:**  
    - Open a new terminal and run `mkdocs serve` again.
5. **Clear your browser cache:**  
    - Old cached pages may show outdated navigation. Refresh or clear cache before reloading the site.

**Summary:**  
Always ensure only one `mkdocs serve` process is running, your browser cache is cleared, and the `site` folder is rebuilt to see the latest navigation changes.

## Common Issues

!!! Failure "OSError"
    OSError: [Errno 48] Address already in use. 

This happens when your browser is already using the default port (8000). You can either stop that server or change the port for mkdocs by using the command `mkdocs serve -p 8001` to run it on port 8001.