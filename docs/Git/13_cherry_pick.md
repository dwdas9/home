# Cherry-pick Commands

## Understanding Cherry-pick

### What is Cherry-pick?
### Use Case: Apply Bug Fix from One Branch to Another Without Merging Everything

## Basic Cherry-pick

### git cherry-pick - Apply Specific Commit to Current Branch
```bash
git cherry-pick [commit]
git cherry-pick abc1234
```

## Cherry-picking Multiple Commits

### Multiple Individual Commits
```bash
git cherry-pick [commit1] [commit2] [commit3]
```

### Range of Commits
```bash
git cherry-pick [commit1]..[commit2]
git cherry-pick [commit1]^..[commit2]  # Include commit1
```

## Cherry-pick Options

### Apply Without Committing
```bash
git cherry-pick --no-commit [commit]
git cherry-pick -n [commit]
```

### Edit Commit Message
```bash
git cherry-pick --edit [commit]
git cherry-pick -e [commit]
```

### Sign-off
```bash
git cherry-pick --signoff [commit]
git cherry-pick -s [commit]
```

## Handling Cherry-pick Conflicts

### git cherry-pick --continue - Continue After Conflict
```bash
# After resolving conflicts
git add [resolved-files]
git cherry-pick --continue
```

### git cherry-pick --abort - Cancel Operation
```bash
git cherry-pick --abort
```

### git cherry-pick --skip - Skip Current Commit
```bash
git cherry-pick --skip
```

## Common Use Cases

### Scenario 1: Hotfix to Multiple Versions
```bash
# Bug fixed in main
git checkout main
git commit -m "Fix critical bug"

# Apply to release branch
git checkout release-1.0
git cherry-pick abc1234

# Apply to another release
git checkout release-2.0
git cherry-pick abc1234
```

### Scenario 2: Backporting Features
```bash
# Feature in development branch
git checkout develop
# Note commit hash

# Backport to stable
git checkout stable
git cherry-pick [feature-commit]
```

### Scenario 3: Moving Commits Between Branches
```bash
# Accidentally committed to main
git checkout main
git log  # Note commit hash

# Create feature branch
git checkout -b feature
git cherry-pick [commit-hash]

# Remove from main
git checkout main
git reset --hard HEAD~1
```

## Cherry-pick vs Merge vs Rebase

| Operation | Use Case | Changes History |
|-----------|----------|-----------------|
| Cherry-pick | Specific commits | No (creates new commit) |
| Merge | All commits | No |
| Rebase | All commits | Yes |

## Finding Commits to Cherry-pick

### Using git log
```bash
git log --oneline --graph main..feature
git log --oneline --author="name"
```

### Using git reflog
```bash
git reflog
```

## Cherry-pick with Mainline Parent

### For Merge Commits
```bash
git cherry-pick -m 1 [merge-commit]
```

## Best Practices

### Before Cherry-picking
- Identify exact commit needed
- Check target branch
- Ensure clean working directory

### After Cherry-picking
- Test thoroughly
- Verify commit message
- Check for conflicts

### When to Cherry-pick
- Hotfixes to multiple branches
- Backporting specific features
- Recovering lost commits

### When NOT to Cherry-pick
- Regular feature merging (use merge/rebase)
- Many related commits (use merge)
- Full branch integration

## Scenario: Hotfix to Multiple Versions

### Complete Workflow
```bash
# 1. Fix bug in main
git checkout main
git commit -m "Fix: Critical security issue"
COMMIT_HASH=$(git rev-parse HEAD)

# 2. Apply to v2.0
git checkout release-v2.0
git cherry-pick $COMMIT_HASH
git push origin release-v2.0

# 3. Apply to v1.9
git checkout release-v1.9
git cherry-pick $COMMIT_HASH
git push origin release-v1.9
```

## Advanced Cherry-pick

### Cherry-pick from Another Repository
```bash
git remote add other-repo [url]
git fetch other-repo
git cherry-pick other-repo/main~3
```

### Cherry-pick with Strategy
```bash
git cherry-pick -X theirs [commit]
git cherry-pick -X ours [commit]
```

## Troubleshooting

### Merge Conflicts
### Empty Commits
### Cherry-pick of Merge Commit
### Already Applied

## Reverting Cherry-picks
```bash
git revert [cherry-picked-commit]
```
