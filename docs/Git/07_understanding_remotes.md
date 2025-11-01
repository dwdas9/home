# Understanding Remotes

## What are Remote Repositories?

### Concept: Origin (Your Remote Repository)
### Concept: Upstream (Original When Forked)

## Viewing Remotes

### git remote - List Remotes
```bash
git remote
git remote -v              # Verbose (show URLs)
git remote show [remote]   # Detailed info
```

## Adding Remotes

### git remote add - Add Remote
```bash
git remote add origin [url]
git remote add upstream [url]
```

## Removing Remotes

### git remote remove - Remove Remote
```bash
git remote remove [name]
git remote rm [name]
```

## Renaming Remotes

### git remote rename - Rename Remote
```bash
git remote rename [old] [new]
```

## Changing Remote URLs
```bash
git remote set-url origin [new-url]
git remote get-url origin
```

## Multiple Remotes

### Working with Origin and Upstream
### Fork Workflow

## Remote Branches

### Viewing Remote Branches
### Tracking Remote Branches

## Understanding Remote Tracking

### What is a Tracking Branch?
### Setting Up Tracking

## Common Remote Configurations

### Single Remote (Origin)
### Multiple Remotes (Origin + Upstream)

## Best Practices

## Troubleshooting

### Remote Already Exists
### Remote Not Found
### Permission Denied
