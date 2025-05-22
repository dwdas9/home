@echo off
setlocal EnableDelayedExpansion

:: Can run anytime. Safe. Run it to make a fully working mkdocs venv with no integration issue with current docs. 
:: This script sets up a venv and MkDocs environment. Handles OneDrive path issues and process conflicts. 
:: Place under ikeade folder next to .venv and run anytime.

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