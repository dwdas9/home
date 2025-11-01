# Viewing History

## Viewing Commit History

### git log - View Commit History
```bash
git log
git log --oneline
git log --graph --oneline --all
git log -n 5  # Last 5 commits
```

## Viewing Specific Commits

### git show - View Specific Commit
```bash
git show [commit]
git show HEAD
git show HEAD~1
```

## Viewing Changes

### git diff - See Changes
```bash
git diff              # Unstaged changes
git diff --staged     # Staged changes
git diff HEAD         # All changes since last commit
git diff [commit1] [commit2]
```

## Advanced Log Options

### Filtering and Formatting
```bash
git log --author="name"
git log --since="2 weeks ago"
git log --grep="keyword"
git log -p  # Show patches
```

## Visual History

### Graph View
```bash
git log --graph --oneline --all --decorate
```

## VS Code Integration

### Using Timeline
### Using GitLens Extension

## Comparing Branches
```bash
git log main..feature
git log --left-right main...feature
```

## File History
```bash
git log -- [file]
git log -p [file]
```

## Best Practices

## Common Use Cases
