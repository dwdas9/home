# Stash Commands

## Understanding Stash

### What is Stash?
### Use Case: Switch Branches Quickly Without Committing Incomplete Work

## Creating Stashes

### git stash - Temporarily Save Changes
```bash
git stash
git stash push
git stash save "message"          # Deprecated but still works
git stash push -m "message"       # Modern way
```

### Stashing Specific Files
```bash
git stash push [file]
git stash push -m "message" [file]
```

### Including Untracked Files
```bash
git stash -u
git stash --include-untracked
```

### Including Ignored Files
```bash
git stash -a
git stash --all
```

## Viewing Stashes

### git stash list - View All Stashes
```bash
git stash list
```

### Viewing Stash Contents
```bash
git stash show
git stash show -p              # Show full diff
git stash show stash@{n}
```

## Applying Stashes

### git stash pop - Apply and Remove Latest Stash
```bash
git stash pop
git stash pop stash@{n}
```

### git stash apply - Apply Without Removing
```bash
git stash apply
git stash apply stash@{n}
```

## Removing Stashes

### git stash drop - Remove Stash
```bash
git stash drop
git stash drop stash@{n}
```

### git stash clear - Remove All Stashes
```bash
git stash clear
```

## Creating Branches from Stash
```bash
git stash branch [branch-name]
git stash branch [branch-name] stash@{n}
```

## Understanding Stash Reference

### Stash Naming: stash@{n}
- stash@{0} - Most recent
- stash@{1} - Previous
- stash@{2} - Earlier, etc.

## Common Workflows

### Quick Branch Switch
```bash
git stash
git checkout other-branch
# Do work
git checkout original-branch
git stash pop
```

### Experimental Changes
```bash
git stash
# Try different approach
# If doesn't work:
git stash pop  # Get back original changes
```

### Clean Working Directory
```bash
git stash -u  # Stash everything
# Now working directory is clean
```

## VS Code Integration

### Stash Operations in Source Control
### Viewing Stashes
### Applying Stashes

## Stash vs Commit

### When to Stash
- Temporary changes
- Incomplete work
- Quick context switch

### When to Commit
- Complete work
- Logical checkpoint
- Want to share/track

## Advanced Stash Usage

### Partial Stashing
```bash
git stash -p
git stash --patch
```

### Stash with Untracked Only
```bash
git stash -u -k
```

## Best Practices

### Naming Stashes
### Regular Cleanup
### Don't Rely on Stash for Backup

## Common Scenarios

### Accidentally Stashed
### Stash Pop Conflicts
### Lost Stash

## Troubleshooting

### Merge Conflicts After Pop
### Can't Find Stash
### Accidentally Cleared Stashes
