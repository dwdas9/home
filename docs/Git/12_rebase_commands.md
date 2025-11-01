# Rebase Commands

## Understanding Rebase

### What is Rebase?
### Concept: Rebase Creates Linear History, Avoids Merge Commits

## Basic Rebase

### git rebase - Replay Commits on New Base
```bash
git rebase [branch]
git rebase main
git rebase origin/main
```

### Rebase Workflow
```bash
# On feature branch
git checkout feature
git rebase main
```

## Interactive Rebase

### git rebase -i - Interactive Rebase (Edit History)
```bash
git rebase -i HEAD~n
git rebase -i [commit]
```

### Interactive Rebase Options
- `pick` - Use commit
- `reword` - Use commit, edit message
- `edit` - Use commit, stop for amending
- `squash` - Combine with previous
- `fixup` - Like squash, discard message
- `drop` - Remove commit

## Continuing Rebase

### git rebase --continue - Continue After Resolving Conflicts
```bash
# After resolving conflicts
git add [resolved-files]
git rebase --continue
```

### git rebase --skip - Skip Problematic Commit
```bash
git rebase --skip
```

### git rebase --abort - Cancel Rebase
```bash
git rebase --abort
```

## Rebase vs Merge

### Visual Comparison
```
Before Rebase:          After Rebase:
  A---B---C main          A---B---C---D'---E' main
   \                      
    D---E feature
```

### When to Use Rebase
- Cleaning feature branch history
- Local commits not pushed
- Want linear history

### When to Use Merge
- Feature branches with multiple developers
- Public branches
- Want to preserve history

## Golden Rule: Never Rebase Public/Shared Commits

### Why?
- Rewrites history
- Causes conflicts for others
- Breaks collaboration

### Safe Rebase Zones
- Local commits
- Your feature branches
- Before pushing

## Interactive Rebase Use Cases

### Squashing Commits
```bash
git rebase -i HEAD~3
# Change last 2 commits to 'squash'
```

### Reordering Commits
```bash
git rebase -i HEAD~5
# Rearrange lines in editor
```

### Editing Commit Messages
```bash
git rebase -i HEAD~3
# Change 'pick' to 'reword'
```

### Removing Commits
```bash
git rebase -i HEAD~3
# Change 'pick' to 'drop' or delete line
```

## Advanced Rebase

### Rebase onto Different Base
```bash
git rebase --onto [newbase] [oldbase] [branch]
```

### Autosquash
```bash
git commit --fixup [commit]
git rebase -i --autosquash [commit]
```

## When: Cleaning Feature Branch Before Merging

### Typical Workflow
```bash
# On feature branch with messy history
git rebase -i HEAD~10
# Squash, reorder, clean up
git push --force-with-lease origin feature
# Now create clean PR
```

## Exercise: Squash Multiple Commits into One

## Handling Rebase Conflicts

### Resolution Process
1. Git stops at conflict
2. Resolve conflicts
3. `git add [files]`
4. `git rebase --continue`

## Best Practices

### Before Rebasing
- Ensure clean working directory
- Check you're on correct branch
- Understand what you're rebasing

### During Rebase
- Resolve conflicts carefully
- Test after each conflict resolution
- Use --abort if unsure

### After Rebase
- Test thoroughly
- Use --force-with-lease if pushing
- Communicate with team

## Common Scenarios

### Update Feature Branch
```bash
git checkout feature
git rebase main
```

### Clean Up Before PR
```bash
git rebase -i HEAD~5
```

### Fix Diverged Branch
```bash
git fetch origin
git rebase origin/main
```

## Troubleshooting

### Rebase Conflicts
### Lost Commits During Rebase
### Can't Push After Rebase
### Accidentally Rebased Public Branch
