# Advanced Inspection Commands

## Advanced Log Filtering

### Filtering by Author
```bash
git log --author="name"
git log --author="John\|Jane"  # Multiple authors
git log --committer="name"
```

### Time-based Filtering
```bash
git log --since="2 weeks ago"
git log --until="2023-01-01"
git log --since="2023-01-01" --until="2023-12-31"
git log --after="yesterday"
git log --before="1 week ago"
```

### Searching Commit Messages
```bash
git log --grep="keyword"
git log --grep="bug\|fix"
git log -i --grep="keyword"  # Case insensitive
git log --all --grep="pattern"
```

### Content Search
```bash
git log -S "function_name"  # Find when text was added/removed
git log -G "regex_pattern"  # Regex version
git log -p -S "text"        # Show diff
```

## Viewing Commit Details

### git log -p - Show Diff in Each Commit
```bash
git log -p
git log -p -2               # Last 2 commits with diff
git log -p [file]           # Diffs for specific file
```

### Patch Statistics
```bash
git log --stat
git log --shortstat
git log --numstat
```

## File History

### git log -- [file] - History of Specific File
```bash
git log -- [file]
git log -p -- [file]
git log --follow -- [file]  # Follow renames
```

### Who Changed What
```bash
git log -p --follow -- [file]
git whatchanged [file]
```

## Blame - Line-by-Line History

### git blame - See Who Changed Each Line
```bash
git blame [file]
git blame -L 10,20 [file]           # Specific lines
git blame -L 10,+5 [file]           # 5 lines from line 10
git blame -e [file]                 # Show email
git blame --date=short [file]       # Short date format
```

### Advanced Blame
```bash
git blame -w [file]                 # Ignore whitespace
git blame -M [file]                 # Detect moved lines
git blame -C [file]                 # Detect copied lines
```

## Viewing Files at Specific Commits

### git show [commit]:[file] - View File at Specific Commit
```bash
git show [commit]:[file]
git show HEAD~3:src/app.js
git show main:README.md
```

## Comparing Branches

### git diff [branch1]..[branch2] - Compare Branches
```bash
git diff main..feature
git diff main...feature             # Common ancestor
git diff --stat main..feature
git diff --name-only main..feature
```

## Comparing Commits

### git diff [commit1] [commit2] - Compare Commits
```bash
git diff abc1234 def5678
git diff HEAD~5 HEAD
git diff HEAD~5..HEAD
```

## Finding Commits

### By Content Change
```bash
git log -S "function_name" --oneline
git log -G "regex_pattern" --oneline
```

### By File
```bash
git log -- path/to/file
git log --all -- path/to/file
```

### By Commit Message
```bash
git log --grep="feature"
git log --all --grep="bug"
```

## VS Code Integration

### GitLens Features
- Inline blame annotations
- File history view
- Commit search
- Line history

### Timeline View
- File change history
- Quick navigation

## Advanced Comparison

### Three-way Diff
```bash
git diff main...feature
```

### Word Diff
```bash
git diff --word-diff
git diff --color-words
```

### Ignore Whitespace
```bash
git diff -w
git diff --ignore-all-space
```

## Log Formatting

### Custom Format
```bash
git log --pretty=format:"%h - %an, %ar : %s"
git log --pretty=format:"%h %s" --graph
git log --oneline --decorate --graph --all
```

### Predefined Formats
```bash
git log --pretty=oneline
git log --pretty=short
git log --pretty=full
git log --pretty=fuller
```

## Finding Merge Commits
```bash
git log --merges
git log --no-merges
git log --first-parent
```

## File Annotations

### Last Modifier
```bash
git log -1 -- [file]
git log -1 --format="%an" -- [file]
```

### Change Frequency
```bash
git log --pretty=format: --name-only | sort | uniq -c | sort -rg
```

## Best Practices

### Effective Searching
### Performance Optimization
### Using Aliases

## Common Use Cases

### Find When Bug Introduced
### Track Feature Development
### Audit Code Changes
### Review Author Contributions

## Troubleshooting

### Slow Log Operations
### Too Many Results
### Missing File History
