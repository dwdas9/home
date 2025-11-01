# Merging Commands

## Understanding Merging

### What is a Merge?
### Concept: Fast-Forward vs Three-Way Merge

## Basic Merging

### git merge - Integrate Changes
```bash
git merge [branch-name]
git merge [branch-name] --no-ff  # Force merge commit
git merge --abort                 # Cancel merge during conflicts
```

## Types of Merges

### Fast-Forward Merge
### Three-Way Merge
### Squash Merge

## Handling Merge Conflicts

### Understanding Conflict Markers
```
<<<<<<< HEAD
Your changes
=======
Their changes
>>>>>>> branch-name
```

### Manual Resolution Steps

## Conflict Resolution Strategies

### Accept Theirs
### Accept Yours
### Manual Edit
### Use Merge Tool

## VS Code Integration

### Conflict Resolution Interface
### Accept Current Change / Accept Incoming Change

## Merge Tools
```bash
git mergetool
git config merge.tool [tool-name]
```

## After Resolving Conflicts
```bash
git add [resolved-files]
git commit
```

## Exercise: Create and Resolve Conflicts Intentionally

## Advanced Merge Options
```bash
git merge --squash [branch-name]
git merge --strategy-option theirs
git merge --strategy-option ours
```

## Best Practices

### Before Merging
### During Merge
### After Merge

## Common Scenarios

## Troubleshooting
