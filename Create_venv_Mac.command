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