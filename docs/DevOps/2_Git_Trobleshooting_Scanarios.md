![](images/20250629141608.png)

# Git Branch Not Visible in VS Code

## The Problem

A developer could see their branch `feature/DasSomeFeatureName` in the Azure DevOps web interface but it wasn't showing up in VS Code's branch selector.

## What Didn't Work

The developer tried refreshing VS Code's Git integration by clicking the refresh icon in the Source Control panel. This performed push/pull operations but didn't resolve the visibility issue.

## The Solution

Running the following command in the terminal fixed the issue:

```bash
git fetch --all
```

## Why This Happened

When a branch is created remotely (through web interface or by another developer), your local Git repository doesn't automatically know about it. The VS Code refresh button primarily handles push/pull operations for tracked branches, but doesn't fetch information about new remote branches.

## Key Takeaway

!!! tip "Quick Fix"
    If you can't see a remote branch in VS Code, run `git fetch --all` to update your local repository with all remote branch information.

## Troubleshooting Steps

### 1. Check Available Branches
```bash
# List all branches (local and remote)
git branch -a
```

### 2. Fetch Remote Information
```bash
# Fetch from all remotes
git fetch --all

# Or fetch from specific remote
git fetch origin
```

### 3. Create Local Branch from Remote
```bash
# Create and switch to local branch tracking remote
git checkout -b feature/DasSomeFeatureName origin/feature/DasSomeFeatureName
```

### 4. VS Code Manual Refresh *(Often doesn't work)*
- Press `Ctrl+Shift+P` (or `Cmd+Shift+P` on Mac)
- Type "Git: Refresh" and execute
- Or click branch name in bottom-left corner to open branch picker

!!! warning "Limitation"
    VS Code's built-in refresh often only handles push/pull for existing branches and may not fetch information about new remote branches.

## Alternative Commands

```bash
# Verify remote configuration
git remote -v

# Switch to existing remote branch
git checkout feature/DasSomeFeatureName
```

The `git fetch` command updates your local repository's knowledge of remote branches without affecting your working directory.