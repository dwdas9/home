# Reflog Commands - The Safety Net

## Understanding Reflog

### What is Reflog?
### Concept: Reflog Logs Every Action That Modified HEAD - Your Undo History

## Viewing Reflog

### git reflog - View History of HEAD Movements
```bash
git reflog
git reflog show
git reflog --all
```

### git reflog show - Reflog for Specific Branch
```bash
git reflog show [branch]
git reflog show main
```

## Understanding Reflog Output

### Reading Reflog Entries
```
abc1234 HEAD@{0}: commit: Add feature
def5678 HEAD@{1}: checkout: moving from main to feature
ghi9012 HEAD@{2}: commit: Fix bug
```

### Reflog Reference Format
- `HEAD@{0}` - Current position
- `HEAD@{1}` - Previous position
- `HEAD@{2}` - Earlier position
- `HEAD@{2.hours.ago}` - Time-based reference

## Recovering with Reflog

### git reset --hard HEAD@{n} - Recover to Previous State
```bash
git reset --hard HEAD@{n}
git reset --hard HEAD@{5}
```

### git checkout HEAD@{n} - View Previous State
```bash
git checkout HEAD@{n}
git checkout HEAD@{10}
```

### git branch [name] HEAD@{n} - Create Branch from Reflog
```bash
git branch recovery HEAD@{5}
git branch backup HEAD@{yesterday}
```

## Use Case: Recover Accidentally Deleted Commits or Branches

### Scenario 1: Deleted Branch Recovery
```bash
# Accidentally deleted branch
git branch -D feature

# Find the commit
git reflog

# Recreate branch
git branch feature HEAD@{1}
# or
git checkout -b feature [commit-hash]
```

### Scenario 2: Hard Reset Recovery
```bash
# Accidentally reset
git reset --hard HEAD~5

# Find lost commits
git reflog

# Recover
git reset --hard HEAD@{1}
```

### Scenario 3: Amended Commit Recovery
```bash
# Amended commit, lost original
git reflog

# Find original
git branch original-commit HEAD@{1}
```

## Exercise: "Accidentally" Delete Commits, Then Recover Them

### Practice Workflow
```bash
# 1. Create some commits
git commit -m "Commit 1"
git commit -m "Commit 2"
git commit -m "Commit 3"

# 2. "Accidentally" delete them
git reset --hard HEAD~3

# 3. Use reflog to recover
git reflog
git reset --hard HEAD@{1}
```

## Reflog for Specific Branches
```bash
git reflog show main
git reflog show origin/main
git reflog show --all
```

## Reflog with Time References

### Time-based Recovery
```bash
git reflog show HEAD@{1.hour.ago}
git reflog show HEAD@{yesterday}
git reflog show HEAD@{2.days.ago}
git reflog show HEAD@{2023-01-15}
```

## Reflog Expiration

### Understanding Reflog Lifetime
- Default: 90 days for reachable commits
- Default: 30 days for unreachable commits

### Configuring Reflog Expiration
```bash
git config gc.reflogExpire 120.days
git config gc.reflogExpireUnreachable 60.days
```

### Manual Reflog Cleanup
```bash
git reflog expire --expire=now --all
git gc --prune=now
```

## Advanced Reflog Usage

### Filtering Reflog
```bash
git reflog --grep="commit"
git reflog --since="2 weeks ago"
```

### Reflog for Specific Files
```bash
git log -g -- [file]
```

## Common Recovery Scenarios

### Recovering Deleted Branch
```bash
git reflog | grep branch-name
git branch branch-name [commit-hash]
```

### Recovering After Rebase
```bash
git reflog
git reset --hard HEAD@{before-rebase}
```

### Recovering After Merge
```bash
git reflog
git reset --hard HEAD@{before-merge}
```

### Finding Lost Stash
```bash
git fsck --unreachable | grep commit
git show [commit-hash]
```

## Reflog vs Log

| Feature | git log | git reflog |
|---------|---------|------------|
| Shows | Commit history | HEAD movements |
| Scope | Repository | Local only |
| After reset | Changes | Unchanged |
| Duration | Forever | 90 days default |

## Best Practices

### When to Use Reflog
- Recovering deleted commits/branches
- Undoing complex operations
- Finding what you did earlier
- Emergency recovery

### Limitations
- Local only (not in remote)
- Expires after 90 days
- Not shared with collaborators

## Emergency Recovery Workflow

### 1. Stay Calm
### 2. Don't Make More Changes
### 3. Check Reflog
```bash
git reflog
```
### 4. Identify the Good State
### 5. Recover
```bash
git reset --hard HEAD@{n}
# or
git branch recovery HEAD@{n}
```

## Troubleshooting

### Can't Find Commit in Reflog
### Reflog Shows Too Many Entries
### Commits Older Than 90 Days
### Reflog After Repository Clone
