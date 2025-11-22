# Background

In this guide, I will show you how to create and deploy an MkDocs site on GitHub. To get started, follow these steps:

1. **Create a GitHub Repository**  
   First, create a GitHub repository for your project. Once the repository is set up, clone it to your local environment and open it in VS Code.

2. **Create a Python Virtual Environment**  
   Open the terminal and navigate to the parent folder of your repository. Then, create a Python virtual environment using the following command:

   ```bash
   python -m venv venvmac
   source venvmac/bin/activate  # For Linux or macOS
   ```

3. **Install MkDocs and Dependencies**  
   Next, install MkDocs and additional dependencies. You can do this either by using a `requirements.txt` file or by running the following command directly:

   ```bash
   pip install --no-cache-dir mkdocs-material pymdown-extensions mkdocs-glightbox
   ```

   **Note:** The `mkdocs-material` is the main library, while the other libraries are additional extensions.

4. **Create the MkDocs Site**  
   To create a new site, run:

   ```bash
   mkdocs new .
   ```

   This will generate a folder structure like this:

   ```
   .
   ├─ docs/
   │  └─ index.md
   └─ mkdocs.yml
   ```

5. **Configure `mkdocs.yml`**  
   Open the `mkdocs.yml` file and add the following minimal configuration:

   ```yaml
   site_name: My site
   site_url: https://mydomain.org/mysite
   theme:
     name: material
   ```

6. **Add Content**  
   Add some Markdown pages inside the `docs` folder.

7. **Build and Serve Locally**  
   To check the site locally, run:

   ```bash
   mkdocs build
   mkdocs serve
   ```

   This should open the site in your browser for preview.

## Host on GitHub Pages

Now, let’s automate the deployment of your MkDocs site using GitHub Actions. At the root of your repository, create a new GitHub Actions workflow (e.g., `.github/workflows/ci.yml`) and paste the following contents:

### Create the Folder Structure

```yml
name: ci
on:
  push:
    branches:
      - master
      - main
permissions:
  contents: write
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Configure Git Credentials
        run: |
          git config user.name github-actions[bot]
          git config user.email 41898282+github-actions[bot]@users.noreply.github.com
      - uses: actions/setup-python@v5
        with:
          python-version: 3.x
      - run: echo "cache_id=$(date --utc '+%V')" >> $GITHUB_ENV
      - uses: actions/cache@v4
        with:
          key: mkdocs-material-${{ env.cache_id }}
          path: .cache
          restore-keys: |
            mkdocs-material-
      - run: pip install mkdocs-material mkdocs-glightbox
      - run: mkdocs gh-deploy --force
```

Now, whenever a new commit is pushed to the `master` or `main` branches, the static site is automatically built and deployed. Push your changes to see the workflow in action.

### Important:
If the GitHub Page doesn’t show up after a few minutes, go to your repository’s settings and ensure that the publishing source branch is set to `gh-pages`.

Your documentation should appear at:  
`https://<username>.github.io/<repository>`

## Troubleshooting: Missing Navigation

After deploying your MkDocs site, you might find that only the index page appears without any navigation menu. This common issue occurs when GitHub Pages is pointing to the wrong branch. Here's how the deployment process works and how to fix it.

### Understanding the gh-pages Branch

When you push changes to your `main` branch, the GitHub Actions workflow automatically builds your MkDocs site and pushes the generated HTML files to a separate branch called `gh-pages`. This branch contains the final static website that GitHub Pages serves to visitors.

```plaintext
main branch:                          gh-pages branch:
 docs/           (Markdown)         index.html      (Built HTML)
 mkdocs.yml      (Config)           assets/         (CSS, JS, images)
 .github/        (Workflow)         ...             (Other static files)
```

The `gh-pages` branch is automatically managed by the `mkdocs gh-deploy --force` command in your workflow. You should never modify this branch directlylet GitHub Actions handle it.



### The Fix

The solution is simple: configure GitHub Pages to use the `gh-pages` branch. Navigate to your repository's **Settings → Pages** and set:

- **Source:** "Deploy from a branch"
- **Branch:** `gh-pages`
- **Folder:** `/(root)`

![alt text](images/image.png)

> **Important:** Selecting `main/(root)` won't work with MkDocs Material because the workflow builds to a different branch.

After changing this setting, trigger a rebuild to ensure everything deploys correctly:

```bash
git commit --allow-empty -m "Trigger rebuild"
git push origin main
```

Watch the **Actions** tab in GitHub for the workflow to complete, then visit your site at `https://<username>.github.io/<repository>/`. The navigation should now appear properly.

If GitHub Pages isn't configured correctly, you may also encounter this deployment error:

![](images/20251122193639.png)

```
Error: Creating Pages deployment failed
Error: HttpError: Not Found
Error: Failed to create deployment (status: 404)
Ensure GitHub Pages has been enabled: https://github.com/<username>/<repository>/settings/pages
```

This 404 error means GitHub Actions can't deploy because the Pages service isn't enabled or the source branch isn't set. Go to **Settings → Pages**, ensure **Source** is set to "Deploy from a branch" with `gh-pages/(root)` selected, then re-run the workflow.

## Best Practices

Keep your workflow simple: store all source content in `main`, let GitHub Actions build and deploy automatically, and never touch the `gh-pages` branch manually. If your site doesn't update after pushing changes, check the workflow logs in the Actions tab for any build errors.
