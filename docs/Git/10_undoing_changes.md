# Undoing Changes

## Understanding Undo Operations

### The Three Levels of Undo
1. Working Directory
2. Staging Area
3. Repository

## Discarding Working Directory Changes

### git restore - Discard Working Directory Changes
```bash
git restore [file]
git restore .
git checkout -- [file]  # Old way
```

## Unstaging Files

### git restore --staged - Unstage Files
```bash
git restore --staged [file]
git reset HEAD [file]        # Older way
```

## Undoing Commits

### git reset - Undo Commits

#### Soft Reset (Keep Changes Staged)
```bash
git reset --soft HEAD~1
git reset --soft [commit]
```

#### Mixed Reset (Keep Changes Unstaged) - Default
```bash
git reset HEAD~1
git reset --mixed HEAD~1
git reset [commit]
```

#### Hard Reset (Discard Changes) - Dangerous!
```bash
git reset --hard HEAD~1
git reset --hard [commit]
```

## Creating Reverse Commits

### git revert - Create New Commit That Undoes Changes
```bash
git revert [commit]
git revert HEAD
git revert --no-commit [commit]
```

## Concept: Reset vs Revert

### When to Use Reset
- Local commits not pushed
- Want to remove commits from history
- Working alone

### When to Use Revert
- Commits already pushed
- Shared branches
- Want to preserve history

## Amending Last Commit

### git commit --amend
```bash
git commit --amend -m "new message"
git commit --amend --no-edit
```

## Common Scenarios

### "I committed to wrong branch!"
```bash
# On wrong-branch
git log  # Note the commit hash
git reset --hard HEAD~1

# Switch to correct branch
git checkout correct-branch
git cherry-pick [commit-hash]
```

### "I need to undo my last 3 commits"
```bash
git reset --soft HEAD~3
# Make changes
git commit -m "Combined commit"
```

### "I committed sensitive data"
```bash
git reset --hard HEAD~1
# If already pushed, see Module 9: Accidental Commits
```

## VS Code Integration

### Undo Last Commit Option
### Discard Changes

## Comparing Undo Commands

| Command | Scope | Safe? | Changes History? |
|---------|-------|-------|------------------|
| restore | Working/Staging | Yes | No |
| reset | Commits | Dangerous | Yes (local) |
| revert | Commits | Yes | No |

## Best Practices

### Before Undoing
### After Undoing
### Communication

## Troubleshooting

### Can't Undo Push
### Lost Work After Hard Reset
### Conflicts After Revert
