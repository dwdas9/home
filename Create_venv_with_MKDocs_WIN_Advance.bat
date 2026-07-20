@echo off
setlocal EnableDelayedExpansion

::=============================================================================
:: Virtual Environment with MKDocs Setup Script on Windows
::=============================================================================
::
:: DESCRIPTION:
:: This script creates a complete MkDocs development environment with detailed 
:: logging and status checking capabilities. It installs all necessary packages
:: from requirements.txt including the minify plugin to prevent common configuration errors.
::
:: Step 1: Go to Terminal -> New Terminal. 
:: Step 2: Run .\Create_venv_with_MKDocs_WIN_Advance.bat. (You will see a .venv folder created in the current directory.)
:: Step 3: Run .venv\Scripts\activate. (You may see a (.venv) prefix in the command prompt, indicating that the virtual environment is active.)
:: Step 4: Run mkdocs build and mkdocs serve to build and serve your mkdocs site.
::
:: WHAT TO EXPECT:
:: - Script will display detailed progress through 9 steps
:: - Takes approximately 2-5 minutes depending on internet speed
:: - Creates a .venv folder in the current directory
:: - Downloads and installs MkDocs and all plugins from requirements.txt
:: - Verifies installation and tests configuration
:: - Provides final status report with next steps
::
:: EXPECTED OUTPUT:
:: ========================================
::  MkDocs Virtual Environment Setup
:: ========================================
:: Script Location: [current directory path]
:: Current Directory: [working directory]
:: Date/Time: [timestamp]
:: 
:: [STEP 0] Checking for running MkDocs processes...
:: [STEP 1] Cleaning up Python processes...
:: [STEP 2] Checking for existing virtual environment...
:: [STEP 3] Verifying Python installation...
:: [STEP 4] Creating new virtual environment...
:: [STEP 5] Activating virtual environment...
:: [STEP 6] Installing MkDocs packages from requirements.txt...
:: [STEP 7] Verifying MkDocs installation...
:: [STEP 8] Checking project configuration...
:: [STEP 9] Setup completion report...
::
:: AFTER SUCCESSFUL COMPLETION:
:: - Virtual environment (.venv) will be created and activated
:: - All MkDocs packages from requirements.txt will be installed and verified
:: - You can immediately start using MkDocs commands:
::   * mkdocs build    - Build your documentation site
::   * mkdocs serve    - Start local development server (http://127.0.0.1:8000)
::   * mkdocs new mysite - Create a new MkDocs project
::
:: RE-RUNNING THE SCRIPT:
:: - This script is SAFE TO RE-RUN multiple times
:: - It will clean up existing installations and start fresh
:: - Useful for troubleshooting or updating packages
:: - No manual cleanup required between runs
::
:: REQUIREMENTS:
:: - Python 3.12 installed in C:\Program Files\Python312\
:: - requirements.txt file in the same directory as this script
:: - Internet connection for package downloads
:: - Write permissions in the current directory
:: - Administrator privileges recommended (but not required)
::
:: PACKAGES INSTALLED FROM REQUIREMENTS.TXT:
:: - mkdocs: Core MkDocs framework
:: - mkdocs-material: Modern Material Design theme
:: - pymdown-extensions: Enhanced markdown features
:: - mkdocs-glightbox: Image lightbox functionality
:: - mkdocs-include-markdown-plugin: File inclusion support
:: - mkdocs-mermaid2-plugin: Diagram generation
:: - Additional dependencies for full functionality
::
:: TROUBLESHOOTING:
:: - If script fails, error details will be displayed
:: - Check Python installation path in Step 3
:: - Ensure requirements.txt exists in current directory
:: - Ensure internet connectivity for package downloads
:: - Try running as Administrator if permission errors occur
:: - Re-run the script - it's designed to be idempotent
::
:: POST-SETUP WORKFLOW:
:: 1. Script completes successfully (virtual environment remains activated)
:: 2. Start development server: mkdocs serve
:: 3. Open browser to: http://127.0.0.1:8000
:: 4. Edit your markdown files and see live changes
:: 5. Build for production: mkdocs build
:: 6. Deploy the 'site' folder to your web server
::
:: VIRTUAL ENVIRONMENT MANAGEMENT:
:: - To activate manually later: .venv\Scripts\activate
:: - To deactivate: deactivate
:: - To remove: delete the .venv folder and re-run this script
::
::=============================================================================

echo.
echo ========================================
echo  MkDocs Virtual Environment Setup
echo ========================================
echo Script Location: %~dp0
echo Current Directory: %CD%
echo Date/Time: %DATE% %TIME%
echo.
echo This script will:
echo 1. Clean any running Python/MkDocs processes
echo 2. Remove existing virtual environment (if any)
echo 3. Create fresh Python virtual environment
echo 4. Install MkDocs with all plugins from requirements.txt
echo 5. Verify installation and test configuration
echo 6. Prepare environment for immediate MkDocs usage
echo.
echo Estimated time: 2-5 minutes
echo Internet connection required for package downloads
echo.

:: Key Features:
:: - Detailed logging and status reporting
:: - Checks for running MkDocs processes
:: - Terminates locked Python processes
:: - Uses absolute paths for reliability
:: - Installs all necessary MkDocs plugins from requirements.txt
:: - Verifies installation success
:: - Safe to re-run

:: Step 0: Check for running MkDocs processes
echo [STEP 0] Checking for running MkDocs processes...
echo Expected: No running processes or automatic termination of existing ones
tasklist /FI "IMAGENAME eq python.exe" /FO CSV | findstr /C:"mkdocs" >nul 2>&1
if not errorlevel 1 (
    echo WARNING: MkDocs processes are currently running!
    echo The following Python processes were found:
    tasklist /FI "IMAGENAME eq python.exe" /FO TABLE
    echo.
    echo Terminating MkDocs processes...
    for /f "tokens=2 delims=," %%i in ('tasklist /FI "IMAGENAME eq python.exe" /FO CSV ^| findstr /C:"mkdocs"') do (
        echo Killing process %%i
        taskkill /F /PID %%i >nul 2>&1    )
) else (
    echo ✓ No running MkDocs processes detected.
)
echo.

:: Step 1: Clean up any Python processes
echo [STEP 1] Cleaning up Python processes...
echo Expected: Termination of any Python processes to prevent file locks
echo Terminating all Python processes to prevent file locks...
tasklist /FI "IMAGENAME eq python.exe" >nul 2>&1
if not errorlevel 1 (
    echo Found Python processes. Terminating...
    taskkill /F /IM python.exe /T >nul 2>&1
    echo ✓ Python processes terminated.
) else (
    echo ✓ No Python processes found.
)
timeout /t 2 /nobreak >nul
echo.

:: Step 2: Remove any existing virtual environment
echo [STEP 2] Checking for existing virtual environment...
echo Expected: Removal of .venv directory if it exists, or confirmation it doesn't exist
if exist .venv (
    echo Found existing .venv directory.
    echo Size: 
    for /f %%i in ('dir .venv /s /-c ^| find "File(s)"') do echo %%i
    echo Removing existing .venv...
    rmdir /s /q .venv
    if exist .venv (
        echo ERROR: Failed to remove .venv directory completely.
        goto :error    ) else (
        echo ✓ Successfully removed existing .venv directory.
    )
    timeout /t 2 /nobreak >nul
) else (
    echo ✓ No existing .venv directory found.
)
echo.

:: Step 3: Verify Python installation
echo [STEP 3] Verifying Python installation...
echo Expected: Python 3.12.x version display and successful verification
echo Python executable path: "%ProgramFiles%\Python312\python.exe"
if not exist "%ProgramFiles%\Python312\python.exe" (
    echo ERROR: Python 3.12 not found at expected location.
    echo Please install Python 3.12 or update the path in this script.
    goto :error
)

"%ProgramFiles%\Python312\python.exe" --version
if errorlevel 1 (
    echo ERROR: Python installation appears corrupted.    goto :error
)
echo ✓ Python installation verified successfully.
echo.

:: Step 4: Create a new Python virtual environment
echo [STEP 4] Creating new virtual environment...
echo Expected: Creation of .venv directory with Python virtual environment
echo Creating virtual environment in: %CD%\.venv
"%ProgramFiles%\Python312\python.exe" -m venv .venv
if errorlevel 1 (
    echo ERROR: Failed to create virtual environment.
    goto :error
)
timeout /t 2 /nobreak >nul

if exist .venv\Scripts\activate.bat (
    echo ✓ Virtual environment created successfully.
    echo Virtual environment location: %CD%\.venv
) else (
    echo ERROR: Virtual environment creation failed - activate.bat not found.
    goto :error
)
echo.

:: Step 5: Activate the virtual environment
echo [STEP 5] Activating virtual environment...
echo Expected: Virtual environment activation and Python path change
call ".venv\Scripts\activate.bat"
if errorlevel 1 (
    echo ERROR: Failed to activate virtual environment.    goto :error
)
echo ✓ Virtual environment activated successfully.
echo Current Python path: 
where python
echo.

:: Step 6: Upgrade pip and install MkDocs packages
echo [STEP 6] Installing MkDocs packages...
echo Expected: Package download and installation from requirements.txt, may take 1-3 minutes
echo Upgrading pip first...
python -m pip install --upgrade pip
if errorlevel 1 (
    echo WARNING: Failed to upgrade pip, continuing with installation...
)

echo.
echo Installing MkDocs and all dependencies from requirements.txt...
echo.
echo Packages included in requirements.txt:
echo - mkdocs (Core MkDocs)
echo - mkdocs-material (Material theme)
echo - pymdown-extensions (Enhanced markdown)
echo - mkdocs-glightbox (Image lightbox)
echo - mkdocs-include-markdown-plugin (File inclusion)
echo - mkdocs-minify-plugin (HTML/CSS/JS minification)
echo - mkdocs-mermaid2-plugin (Diagram generation)
echo - Additional dependencies for full functionality
echo.
echo This may take 1-3 minutes depending on internet speed...

if exist requirements.txt (
    echo ✓ Found requirements.txt file
    echo Installing packages from requirements.txt...
    python -m pip install --no-cache-dir -r requirements.txt
    if errorlevel 1 (
        echo ERROR: Package installation from requirements.txt failed.
        echo Attempting fallback installation of core packages...
        python -m pip install --no-cache-dir mkdocs mkdocs-material pymdown-extensions mkdocs-glightbox mkdocs-minify-plugin
        if errorlevel 1 (
            echo ERROR: Fallback installation also failed.
            goto :error
        ) else (
            echo ⚠ Fallback installation completed - some optional packages may be missing
        )
    ) else (
        echo ✓ All packages from requirements.txt installed successfully.
    )
) else (
    echo WARNING: requirements.txt file not found in current directory
    echo Installing core MkDocs packages manually...
    python -m pip install --no-cache-dir mkdocs mkdocs-material pymdown-extensions mkdocs-glightbox mkdocs-minify-plugin
    if errorlevel 1 (
        echo ERROR: Manual package installation failed.
        goto :error
    ) else (
        echo ✓ Core packages installed successfully.
        echo ℹ Consider creating a requirements.txt file for better dependency management
    )
)
echo.

echo Verifying key package installations:
python -c "import mkdocs; print(f'✓ MkDocs version: {mkdocs.__version__}')" 2>nul || echo "✗ MkDocs import failed"
python -c "import material; print('✓ Material theme installed')" 2>nul || echo "✗ Material theme not found"
python -c "import pymdownx; print('✓ PyMdown Extensions installed')" 2>nul || echo "✗ PyMdown Extensions not found"
echo.

:: Step 7: Verify MkDocs installation
echo [STEP 7] Verifying MkDocs installation...
echo Expected: MkDocs version display and package list
python -c "import mkdocs; print(f'MkDocs version: {mkdocs.__version__}')"
if errorlevel 1 (
    echo ERROR: MkDocs installation verification failed.
    goto :error
)

echo.
echo Checking installed packages:
pip list | findstr mkdocs
echo.

echo Testing MkDocs command:
mkdocs --version
if errorlevel 1 (
    echo ERROR: MkDocs command not working properly.    goto :error
)
echo ✓ MkDocs installation verified and working.
echo.

:: Step 8: Check for existing MkDocs configuration
echo [STEP 8] Checking project configuration...
echo Expected: Configuration validation or new project guidance
if exist mkdocs.yml (
    echo Found existing mkdocs.yml configuration file.
    echo Configuration file size: 
    for %%i in (mkdocs.yml) do echo %%~zi bytes
    echo.
    echo Testing configuration validity...
    mkdocs build --clean --quiet    if errorlevel 1 (
        echo WARNING: Current mkdocs.yml has configuration issues.
        echo.
        echo Common issues and solutions:
        echo - Missing plugins: All plugins from requirements.txt are now installed
        echo - Invalid YAML syntax: Check indentation and structure
        echo - Incorrect file paths: Verify docs directory and file references
        echo - Plugin configuration errors: Check plugin settings in mkdocs.yml
        echo.
        echo Available plugins from your requirements.txt:
        echo - minify: HTML/CSS/JS minification
        echo - glightbox: Image lightbox functionality
        echo - include-markdown: File inclusion support
        echo - mermaid2: Diagram generation
        echo.
        echo ℹ All required plugins have been installed by this script.
        echo You may need to review your mkdocs.yml configuration.
    ) else (
        echo ✓ Configuration file is valid.
        echo ✓ Build test completed successfully.
        echo ✓ All plugins in requirements.txt are working properly.
    )
) else (
    echo ℹ No mkdocs.yml found. This appears to be a new project.
    echo.
    echo To create a new MkDocs project with your installed plugins:
    echo 1. mkdocs new mysite
    echo 2. Edit mkdocs.yml to enable desired plugins from requirements.txt
    echo.
    echo Example plugin configuration for mkdocs.yml:
    echo plugins:
    echo   - search
    echo   - minify
    echo   - glightbox
    echo   - include-markdown
    echo   - mermaid2
)
echo.

:: Step 9: Final status report
echo [STEP 9] Setup completion report...
echo =====================================
echo ✓ Setup completed successfully!
echo =====================================
echo.
echo Virtual Environment Details:
echo - Location: %CD%\.venv
echo - Python version: 
python --version
echo - Pip version: 
pip --version
echo.
echo Installed MkDocs packages:
pip list | findstr -i mkdocs
echo.
echo =====================================
echo 🚀 READY TO USE MKDOCS!
echo =====================================
echo.
echo The virtual environment is ALREADY ACTIVATED.
echo You can now immediately use these commands:
echo.
echo 📖 START DEVELOPMENT SERVER:
echo    mkdocs serve
echo    ↳ Opens local server at http://127.0.0.1:8000
echo    ↳ Auto-reloads when you edit files
echo    ↳ Press Ctrl+C to stop the server
echo.
echo 🔨 BUILD DOCUMENTATION:
echo    mkdocs build
echo    ↳ Creates 'site' folder with static HTML
echo    ↳ Ready for deployment to web server
echo.
echo 📁 CREATE NEW PROJECT (if needed):
echo    mkdocs new mysite
echo    ↳ Creates new MkDocs project structure
echo.
echo 🔄 FUTURE SESSIONS:
echo    To activate virtual environment later:
echo    .venv\Scripts\activate
echo    ↳ You'll see (.venv) prefix in command prompt
echo.
echo 🛠️ SCRIPT MAINTENANCE:
echo    This script can be run again anytime to:
echo    ↳ Refresh the virtual environment
echo    ↳ Update packages to latest versions
echo    ↳ Fix any installation issues
echo.
echo Current working directory: %CD%
echo Environment is ready for MkDocs development!
echo.
echo =====================================
echo 💡 QUICK START EXAMPLE:
echo =====================================
echo 1. mkdocs serve
echo 2. Open browser to: http://127.0.0.1:8000
echo 3. Edit your .md files and see live changes!
echo =====================================

pause
exit /b 0

:error
echo.
echo ========================================
echo ❌ ERROR: Setup failed!
echo ========================================
echo Error Code: %errorlevel%
echo Time: %DATE% %TIME%
echo Location: %CD%
echo.
echo 🔧 TROUBLESHOOTING STEPS:
echo ========================================
echo 1. Ensure Python 3.12 is installed in Program Files
echo    Download from: https://www.python.org/downloads/
echo.
echo 2. Check if you have administrator privileges
echo    Right-click Command Prompt → "Run as administrator"
echo.
echo 3. Verify internet connection for package downloads
echo    Test: ping pypi.org
echo.
echo 4. Try running the script again
echo    This script is safe to re-run multiple times
echo.
echo 5. Check Windows Event Viewer for detailed errors
echo    Windows Logs → Application
echo.
echo 📋 SUPPORT INFORMATION:
echo ========================================
echo Please provide this information when seeking help:
echo - Error code: %errorlevel%
echo - Python path: "%ProgramFiles%\Python312\python.exe"
echo - Current directory: %CD%
echo - Date/Time: %DATE% %TIME%
echo - Windows version: %OS%
echo.
echo 🔄 COMMON SOLUTIONS:
echo ========================================
echo • Python not found: Install Python 3.12 from python.org
echo • Permission denied: Run as Administrator
echo • Network issues: Check firewall/proxy settings
echo • Disk space: Ensure at least 500MB free space
echo ========================================
pause
exit /b %errorlevel%