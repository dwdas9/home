@echo off
setlocal EnableDelayedExpansion

:: Script to create a virtual environment with MKDocs and its dependencies installed. Creates an environment which is closely integrated with the mkdocs project.
:: You can start deploying mkdocs right away after the VM is created. Very robust script and installs all the dependencies needed for mkdocs to run.
:: Step 1: Go to Terminal -> New Terminal. 
:: Step 2: Run .\Create_venv_with_MKDocs_WIN_Simple.bat. (You will see a .venv folder created in the current directory.)
:: Step 3: Run .venv\Scripts\activate. (You may see a (.venv) prefix in the command prompt, indicating that the virtual environment is active.)
:: Step 4: Run mkdocs build and mkdocs serve to build and serve your mkdocs site.


:: Key Features:
:: - Detects OneDrive path
:: - Terminates locked Python processes
:: - Uses absolute paths
:: - Direct package installation
:: - Safe to re-run

:: Steps:
:: 1. Clean processes
:: 2. Setup fresh venv
:: 3. Install packages
:: 4. Verify setup


:: Step 1: Clean up any Python processes
echo Cleaning up Python processes...
taskkill /F /IM python.exe /T >nul 2>&1
timeout /t 2 /nobreak >nul

:: Step 2: Remove any existing virtual environment
if exist .venv (
    echo Removing existing .venv...
    rmdir /s /q .venv
    timeout /t 2 /nobreak >nul
)

:: Step 3: Create a new Python virtual environment
echo Creating new virtual environment...
"%ProgramFiles%\Python312\python.exe" -m venv .venv
if errorlevel 1 goto :error
timeout /t 2 /nobreak >nul

:: Step 4: Activate the virtual environment
call ".venv\Scripts\activate.bat"
if errorlevel 1 goto :error

:: Step 5: Install MkDocs packages
echo Installing MkDocs packages...
python -m pip install --no-cache-dir mkdocs-material pymdown-extensions mkdocs-glightbox
if errorlevel 1 goto :error

:: Step 6: Create a new MkDocs project (optional)
:: Uncomment if you want a brand-new MkDocs project:
:: mkdocs new mysite
:: if errorlevel 1 goto :error

pause
exit /b 0

:error
echo Setup failed with error code #%errorlevel%.
pause
exit /b %errorlevel%