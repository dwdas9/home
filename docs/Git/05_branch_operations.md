# Branch Operations

## Understanding Branches

### What are Branches?
### Why Branches Matter (Parallel Development)

## Listing Branches

### git branch - List Branches
```bash
git branch
git branch -a      # All branches (local + remote)
git branch -r      # Remote branches only
git branch -v      # Verbose (show last commit)
```

## Creating Branches

### git branch - Create New Branch
```bash
git branch [branch-name]
git branch [branch-name] [start-point]
```

## Switching Branches

### git checkout - Switch Branches (Traditional)
```bash
git checkout [branch-name]
git checkout -b [branch-name]  # Create and switch
```

### git switch - Modern Way to Switch Branches
```bash
git switch [branch-name]
git switch -c [branch-name]  # Create and switch
```

## Deleting Branches

### git branch -d - Delete Branch
```bash
git branch -d [branch-name]    # Safe delete
git branch -D [branch-name]    # Force delete
```

## Renaming Branches
```bash
git branch -m [old-name] [new-name]
git branch -m [new-name]  # Rename current branch
```

## Branch Management

### Viewing Branch Information
### Tracking Branches

## VS Code Integration

### Bottom-Left Branch Switcher

## Scenario: Feature Development Workflow

## Best Practices

### Branch Naming Conventions
### When to Create Branches
### Branch Lifecycle

## Common Patterns

## Troubleshooting
