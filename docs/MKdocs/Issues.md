# Mkdocs Issues

## GitHub Pages & gh-pages Branch Troubleshooting
Only the index page shows, and navigation is missing.

## Cause
The branch is not selected as `gh-pages/root`.

![alt text](images/image.png)

## What is gh-pages?
The `gh-pages` branch serves static website content. MkDocs with GitHub Actions:
1. Builds documentation from `main`
2. Updates `gh-pages`
3. Deploys to GitHub Pages

## Key Points
1. Never modify `gh-pages` directly
2. Let GitHub Actions handle deployment
3. Managed by the workflow in `ci.yml`

## GitHub Pages Settings

### Initial Setup Issue
Selecting `main/(root)` won't work with MkDocs Material.

### Correct Configuration
1. Go to **Settings → Pages**
2. Set:
    - Source: "Deploy from a branch"
    - Branch: `gh-pages`
    - Folder: `/(root)`

## How It Works

### Source Content (`main` branch)
```plaintext
main/
├── docs/           # Markdown files
├── mkdocs.yml      # MkDocs config
└── .github/        # GitHub Actions workflow
```

### Built Site (`gh-pages` branch)
```plaintext
gh-pages/
├── index.html      # HTML files
├── assets/         # CSS, JS, images
└── ...             # Other static files
```

## Troubleshooting Steps

1. Change GitHub Pages settings:
```markdown
Settings → Pages → Branch: gh-pages/(root)
```

2. Trigger a new build:
```bash
git commit --allow-empty -m "Trigger rebuild"
git push origin main
```

3. Verify deployment:
- Check Actions tab
- Wait for "GitHub Pages deployment" check
- Visit: `https://username.github.io/repository/`

## Best Practices
- Keep source in `main`
- Let GitHub Actions manage `gh-pages`
- Never modify `gh-pages` directly
- Check workflow logs if site doesn't update

Deployment handled by:
```yaml
- name: Build and Deploy
  run: |
     mkdocs build
     mkdocs gh-deploy --force
```
