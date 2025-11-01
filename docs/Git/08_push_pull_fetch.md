# Push, Pull, Fetch - Syncing Commands

## Understanding Sync Operations

### Push vs Pull vs Fetch

## Pushing Changes

### git push - Upload Commits
```bash
git push [remote] [branch]
git push origin main
git push -u origin [branch]     # Set upstream and push
git push --all                   # Push all branches
```

### Force Pushing (Use with Caution)
```bash
git push --force-with-lease     # Safe force push
git push --force                # Dangerous!
```

## Pulling Changes

### git pull - Fetch + Merge Automatically
```bash
git pull
git pull [remote] [branch]
git pull --rebase              # Rebase instead of merge
```

### What Pull Actually Does
1. Fetch changes from remote
2. Merge them into current branch

## Fetching Changes

### git fetch - Download Without Merging (Safer)
```bash
git fetch
git fetch [remote]
git fetch --all               # Fetch from all remotes
git fetch --prune             # Remove deleted remote branches
```

## Concept: Fetch vs Pull

### When to Use Fetch
- Want to review changes first
- Working on sensitive code
- Want more control

### When to Use Pull
- Quick updates
- Simple workflows
- Trust the changes

## Setting Upstream Branches
```bash
git push -u origin [branch]
git branch --set-upstream-to=origin/[branch]
```

## Viewing Remote State
```bash
git remote show origin
git branch -vv               # Show tracking branches
```

## Project: Push Portfolio to GitHub

## Common Workflows

### First Push
### Regular Updates
### After Rebasing

## Best Practices

### Before Pushing
### Before Pulling
### Handling Diverged Branches

## Troubleshooting

### Push Rejected
### Merge Conflicts After Pull
### Diverged Branches
### Authentication Issues
