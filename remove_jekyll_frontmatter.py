#!/usr/bin/env python3
"""
Script to remove Jekyll front matter from all markdown files.
This will remove YAML front matter blocks that start and end with '---'
"""

import os
import re
from pathlib import Path

def remove_jekyll_frontmatter(file_path):
    """Remove Jekyll front matter from a markdown file."""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Check if file starts with Jekyll front matter
        if content.startswith('---\n'):
            # Find the end of the front matter (second ---)
            # Use regex to match the front matter block
            pattern = r'^---\s*\n.*?\n---\s*\n'
            match = re.match(pattern, content, re.DOTALL)
            
            if match:
                # Remove the front matter block
                cleaned_content = content[match.end():]
                
                # Write the cleaned content back to the file
                with open(file_path, 'w', encoding='utf-8') as f:
                    f.write(cleaned_content)
                
                print(f"✅ Removed front matter from: {file_path}")
                return True
            else:
                print(f"⚠️  File starts with --- but no closing --- found: {file_path}")
                return False
        else:
            print(f"ℹ️  No front matter found in: {file_path}")
            return False
            
    except Exception as e:
        print(f"❌ Error processing {file_path}: {str(e)}")
        return False

def main():
    """Main function to process all markdown files."""
    # Get the docs directory
    docs_dir = Path("docs")
    
    if not docs_dir.exists():
        print("❌ docs directory not found!")
        return
    
    # Find all markdown files
    md_files = list(docs_dir.rglob("*.md"))
    
    print(f"Found {len(md_files)} markdown files to process...\n")
    
    processed_count = 0
    modified_count = 0
    
    for md_file in md_files:
        processed_count += 1
        if remove_jekyll_frontmatter(md_file):
            modified_count += 1
    
    print(f"\n📊 Summary:")
    print(f"   Total files processed: {processed_count}")
    print(f"   Files modified: {modified_count}")
    print(f"   Files unchanged: {processed_count - modified_count}")

if __name__ == "__main__":
    main()
