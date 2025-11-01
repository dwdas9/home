# GitHub Workflow Commands

## Understanding GitHub Workflow

### GitHub vs Git

## Cloning from GitHub

### git clone - Download Repository
```bash
git clone [url]
git clone [url] [directory-name]
git clone --depth 1 [url]  # Shallow clone
```

## Fork Workflow

### What is a Fork?
### How to Fork (On GitHub)
### Syncing Your Fork

## Working with Forks

### Adding Upstream Remote
```bash
git remote add upstream [original-repo-url]
git fetch upstream
git merge upstream/main
```

## Creating Pull Requests

### What is a Pull Request?
### PR Workflow
1. Fork repository
2. Create feature branch
3. Make changes
4. Push to your fork
5. Open pull request

### Pull Request Best Practices

## Updating Your PR
```bash
git push origin [branch-name]
git push --force-with-lease origin [branch-name]
```

## Code Review Process

### Responding to Feedback
### Making Changes
### Keeping PR Updated

## VS Code Integration

### GitHub Pull Requests Extension
### Creating PRs from VS Code
### Reviewing PRs in VS Code

## GitHub CLI (gh)
```bash
gh repo clone [repo]
gh pr create
gh pr list
gh pr checkout [number]
```

## Collaborator Workflow

### Direct Push Access
### Branch Protection Rules

## Common GitHub Workflows

### Open Source Contribution
### Team Collaboration
### Personal Projects

## GitHub Features

### Issues
### Projects
### Actions (CI/CD)
### Wiki
### Releases

## Best Practices

### Commit Messages
### PR Descriptions
### Branch Management
### Communication

## Troubleshooting

### PR Conflicts
### Failed CI Checks
### Permission Issues
