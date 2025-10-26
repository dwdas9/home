# Creating Your First Feature Branch

You cloned the repo yesterday. Today you got a ticket. Build a new feature. Let's call it user authentication.

You don't work on `main`. Never work on `main`. Create a branch.

## The Daily Workflow

This is what you'll do every single day. The basic loop.

??? note "Step 1: Sync with main"
    
    Before you do anything, sync up. Someone might have pushed changes overnight. Working across multiple computers? In a large team? Your local `main` can get out of sync fast.

    **The Simple Case (Everything's Clean)**

    ```bash
    git checkout main
    git pull origin main
    ```

    This works 80% of the time. But what about the other 20%?

    ---

    ### Common Scenarios & Solutions

    ??? example "Scenario 1: You accidentally made commits on main"
        
        You forgot to create a branch. You committed directly to `main`. Now `git pull` fails.

        ```bash
        git pull origin main
        ```

        Error:

        ```
        error: Your local changes to the following files would be overwritten by merge:
            app.js
        Please commit your changes or stash them before you merge.
        ```

        **Solution: Save your work, then reset**

        ```bash
        # 1. Create a branch from your current position
        git branch feature/accidental-work

        # 2. Switch to main
        git checkout main

        # 3. Hard reset to match remote
        git reset --hard origin/main

        # 4. Your work is safe on feature/accidental-work
        git checkout feature/accidental-work
        ```

        Your commits are saved on the new branch. Your `main` is clean.

    ??? example "Scenario 2: You have uncommitted changes on main"
        
        You edited files on `main`. Now you can't pull.

        **Option 1: Stash and pull**

        ```bash
        # Save your changes temporarily
        git stash

        # Pull latest
        git pull origin main

        # Create a branch
        git checkout -b feature/new-work

        # Get your changes back
        git stash pop
        ```

        **Option 2: Discard the changes**

        If you don't need those changes:

        ```bash
        # Discard all uncommitted changes
        git checkout -- .

        # Pull latest
        git pull origin main
        ```

    ??? example "Scenario 3: Your main diverged from origin/main"
        
        You're on a different computer. Or someone force-pushed. Your `main` has different commits than remote.

        Check if you're diverged:

        ```bash
        git fetch origin
        git status
        ```

        You'll see:

        ```
        Your branch and 'origin/main' have diverged,
        and have 3 and 5 different commits each, respectively.
        ```

        **Solution: Hard reset to remote**

        ```bash
        # Make sure you're on main
        git checkout main

        # Fetch latest info
        git fetch origin

        # Hard reset to match remote exactly
        git reset --hard origin/main
        ```

        !!! danger "This discards your local commits"
            If you have commits you want to keep, save them first:
            ```bash
            git branch backup-main
            git reset --hard origin/main
            ```

    ??? example "Scenario 4: You have untracked files blocking the pull"
        
        You created new files. Git pull wants to bring in files with the same names.

        Error:

        ```
        error: The following untracked working tree files would be overwritten by merge:
            config.json
        Please move or remove them before you merge.
        ```

        **Solution 1: Move the files**

        ```bash
        # Rename your file
        mv config.json config.json.backup

        # Pull
        git pull origin main
        ```

        **Solution 2: Force clean (if you don't need the files)**

        ```bash
        # Remove all untracked files
        git clean -fd

        # Pull
        git pull origin main
        ```

        !!! warning "git clean is destructive"
            `-f` = force, `-d` = remove directories too. This deletes untracked files permanently.

    ??? danger "Nuclear Option: Start completely fresh"
        
        Nothing works. You want to discard everything and match remote exactly.

        **Method 1: Hard reset + clean**

        ```bash
        # Fetch latest from remote
        git fetch origin

        # Hard reset main to match origin/main
        git checkout main
        git reset --hard origin/main

        # Remove all untracked files and directories
        git clean -fdx
        ```

        `-f` = force  
        `-d` = directories  
        `-x` = ignored files too (like node_modules, .env)

        **Method 2: Delete and re-clone**

        When even the nuclear option fails:

        ```bash
        # Go up one directory
        cd ..

        # Delete the entire repo
        rm -rf repository-name

        # Clone fresh
        git clone https://github.com/username/repository-name.git
        cd repository-name
        ```

        This is the ultimate reset. Everything local is gone.

    ---

    ### Verification: Is my main clean?

    After syncing, verify you're good:

    ```bash
    # Check status
    git status
    ```

    You should see:

    ```
    On branch main
    Your branch is up to date with 'origin/main'.

    nothing to commit, working tree clean
    ```

    **Check if you match remote exactly:**

    ```bash
    git fetch origin
    git log main..origin/main --oneline
    ```

    If this shows nothing, you're in sync. If it shows commits, you're behind:

    ```bash
    git pull origin main
    ```

    **Check for uncommitted changes:**

    ```bash
    git diff
    ```

    Should show nothing.

    ---

    ### Quick Decision Tree

    ```mermaid
    flowchart TD
        A[Need to sync main] --> B{git status clean?}
        B -- Yes --> C[git pull origin main]
        B -- No --> D{Uncommitted changes?}
        D -- Yes --> E[git stash]
        D -- No --> F{Untracked files?}
        E --> C
        F -- Yes --> G[git clean -fd]
        F -- No --> H{Local commits?}
        G --> C
        H -- Yes --> I[git reset --hard origin/main]
        H -- No --> J[Nuclear: clean -fdx]
        I --> C
        J --> C
        
        style C fill:#e8f5e9
        style I fill:#ffebee
        style J fill:#d32f2f,color:#fff
    ```

    ---

    ### Common Errors & Fixes

    | Error | What it means | Fix |
    |-------|---------------|-----|
    | `Your local changes would be overwritten` | You have uncommitted changes | `git stash` or `git checkout -- .` |
    | `Your branch has diverged` | Your commits differ from remote | `git reset --hard origin/main` |
    | `untracked working tree files` | New local files conflict | `git clean -fd` |
    | `Cannot pull with rebase` | Outdated git config | `git pull origin main --no-rebase` |
    | `fatal: Not possible to fast-forward` | Commits on both sides | `git reset --hard origin/main` |

    ---

    !!! tip "Best Practice: Always fetch first"
        Get into the habit:
        ```bash
        git fetch origin
        git status
        git pull origin main
        ```
        
        `git fetch` downloads info without changing your files. You can see what's coming before you pull.

??? note "Step 2: Create your branch"
    
    ```bash
    git checkout -b feature/user-auth
    ```

    This creates a new branch called `feature/user-auth` and switches to it.

    One command. Two actions.

    !!! warning "Branch only exists locally"
        Right now, this branch is only on your machine. Remote doesn't know about it yet.

??? note "Step 3: Make changes"
    
    You write code. Edit files. Add new files. Normal work.

    Let's say you created `auth.js` and modified `app.js`.

    Check what changed:

    ```bash
    git status
    ```

    You'll see:

    ```
    On branch feature/user-auth
    Changes not staged for commit:
      modified:   app.js

    Untracked files:
      auth.js
    ```

??? note "Step 4: Stage your changes"
    
    ```bash
    git add .
    ```

    This stages everything. Or stage specific files:

    ```bash
    git add auth.js app.js
    ```

??? note "Step 5: Commit"
    
    ```bash
    git commit -m "Add user authentication module"
    ```

    A commit is a snapshot. You're saving the current state.

??? note "Step 6: Push to remote (first time)"
    
    ```bash
    git push -u origin feature/user-auth
    ```

    !!! important "The -u flag is critical"
        `-u` stands for `--set-upstream`. It does two things:
        
        1. Pushes your branch to remote
        2. Sets up tracking between local and remote
        
        You only need `-u` the first time.

    You'll see output like:

    ```
    Enumerating objects: 5, done.
    To https://github.com/username/repository.git
     * [new branch]      feature/user-auth -> feature/user-auth
    Branch 'feature/user-auth' set up to track remote branch 'feature/user-auth' from 'origin'.
    ```

    Your branch is now on remote. Your team can see it.

??? note "Step 7: Keep working"
    
    You're not done. You need to add password validation. Make the changes. Then:

    ```bash
    git add .
    git commit -m "Add password validation"
    git push
    ```

    !!! success "No more -u needed"
        Notice? Just `git push`. No `-u origin feature/user-auth`.
        
        That's the magic of `-u`. You set it up once. Git remembers.

    ```mermaid
    graph TB
        A[Edit files] --> B[git add .]
        B --> C[git commit -m 'msg']
        C --> D{First push?}
        D -- Yes --> E[git push -u origin branch]
        D -- No --> F[git push]
        E --> G[Edit more]
        F --> G
        G --> A
        
        style E fill:#ffebee
        style F fill:#c8e6c9
    ```

??? note "Step 8: Open a pull request"
    
    Your feature is done. Time to merge it into `main`.

    1. Go to GitHub/GitLab/Azure DevOps
    2. You'll see a banner: "feature/user-auth had recent pushes"
    3. Click "Compare & pull request"
    4. Write a good title and description
    5. Click "Create pull request"

    Your team will review. After approval, someone will merge.

## Working on a Teammate's Branch

Your teammate created `feature/payment-gateway`. You need to work on it.

First, fetch the latest:

```bash
git fetch origin
```

Then checkout the branch:

```bash
git checkout feature/payment-gateway
```

Git is smart. If the branch exists on remote but not locally, this command automatically:

1. Creates your local version
2. Sets up tracking

No `-b` needed. No `-u` needed.

Make your changes. Commit. Push.

```bash
git add .
git commit -m "Add Stripe integration"
git push
```

## Branch Naming Conventions

Your team probably has rules. Common patterns:

=== "Feature Branches"
    ```bash
    feature/user-authentication
    feature/payment-gateway
    feature/dark-mode
    ```
    For new functionality.

=== "Bug Fix Branches"
    ```bash
    bugfix/login-timeout
    fix/api-error-handling
    hotfix/critical-security-patch
    ```
    For fixing issues. `hotfix` is for urgent production fixes.

=== "Refactor Branches"
    ```bash
    refactor/database-layer
    refactor/cleanup-utils
    ```
    For code improvements without changing behavior.

=== "Ticket-Based Naming"
    ```bash
    JIRA-1234-user-auth
    feature/PROJ-567-add-export
    ```
    Including ticket numbers for traceability.


## Quick Command Reference

| Task | Command |
|------|---------|
| Create and switch to branch | `git checkout -b feature/name` |
| Switch to existing branch | `git checkout branch-name` |
| Pull latest changes | `git pull origin main` |
| Stage changes | `git add .` |
| Commit | `git commit -m "message"` |
| First push | `git push -u origin feature/name` |
| Subsequent pushes | `git push` |
| List local branches | `git branch` |
| Delete local branch | `git branch -d feature/name` |
| Delete remote branch | `git push origin --delete feature/name` |

## Advanced Topics

Everything below is optional. But useful to know.

### Understanding Git's Three States

??? abstract "How Git Thinks About Your Files"
    
    ```mermaid
    flowchart LR
        A[Working Directory] -->|git add| B[Staging Area]
        B -->|git commit| C[Local Repository]
        C -->|git push| D[Remote Repository]
        
        style A fill:#ffebee
        style B fill:#fff3e0
        style C fill:#e8f5e9
        style D fill:#e1f5ff
    ```
    
    **Working Directory** → Your actual files. What you see in VS Code.
    
    **Staging Area** → A holding zone. Files you've marked with `git add`. Think of it as a shopping cart before checkout.
    
    **Local Repository** → Committed snapshots. After `git commit`, your changes are saved in `.git/objects/`.
    
    **Remote Repository** → GitHub/GitLab/Azure DevOps. After `git push`, your changes are visible to the team.

### Switching Branches with Uncommitted Changes

??? example "Using git stash"
    
    You're on `feature/user-auth`. Your boss needs an urgent fix on `main`. But you have uncommitted changes.
    
    Git won't let you switch:
    
    ```
    error: Your local changes would be overwritten by checkout.
    Please commit your changes or stash them before you switch branches.
    ```
    
    **Option 1: Commit your work**
    
    ```bash
    git add .
    git commit -m "WIP: Authentication half done"
    git checkout main
    ```
    
    `WIP` stands for "Work In Progress".
    
    **Option 2: Stash your changes**
    
    ```bash
    git stash
    git checkout main
    # Fix the urgent issue
    # Commit and push
    
    # Come back
    git checkout feature/user-auth
    git stash pop
    ```
    
    Stash saves your changes temporarily. Your working directory is clean. When you come back, `git stash pop` restores everything.
    
    **Stash commands:**
    
    | Command | What it does |
    |---------|--------------|
    | `git stash` | Stash current changes |
    | `git stash pop` | Apply latest stash and remove it |
    | `git stash list` | Show all stashes |
    | `git stash apply` | Apply stash but keep it in stack |
    | `git stash drop` | Delete latest stash |

### Viewing Branches

??? info "Branch Listing Commands"
    
    **List local branches**
    
    ```bash
    git branch
    ```
    
    Output:
    
    ```
      feature/payment-gateway
    * feature/user-auth
      main
    ```
    
    The `*` shows your current branch.
    
    **List remote branches**
    
    ```bash
    git branch -r
    ```
    
    **List all branches**
    
    ```bash
    git branch -a
    ```
    
    **See more details**
    
    ```bash
    git branch -v
    ```
    
    Shows the last commit on each branch:
    
    ```
      feature/payment-gateway  a3f2c1d Add Stripe integration
    * feature/user-auth        b7e9f3a Add password validation
      main                     c4d8e2f Update README
    ```

### Deleting Branches

??? example "How to Delete Branches"
    
    Your feature is merged. Clean up.
    
    **Delete local branch**
    
    ```bash
    git checkout main
    git branch -d feature/user-auth
    ```
    
    Safe delete. Git won't let you delete if there are unmerged changes.
    
    **Force delete**
    
    ```bash
    git branch -D feature/user-auth
    ```
    
    Use when you really want to throw away the branch.
    
    !!! danger "Force delete is destructive"
        `-D` doesn't check if your changes are merged. Use carefully.
    
    **Delete remote branch**
    
    ```bash
    git push origin --delete feature/user-auth
    ```

### Common Branching Workflows

??? abstract "GitHub Flow - Simple & Popular"
    
    One main branch. Short-lived feature branches.
    
    ```mermaid
    gitGraph
        commit
        commit
        branch feature/login
        checkout feature/login
        commit
        commit
        checkout main
        merge feature/login
        commit
        branch feature/payment
        checkout feature/payment
        commit
        commit
        checkout main
        merge feature/payment
        commit
    ```
    
    **The flow:**
    
    1. Branch from `main`
    2. Work on feature
    3. Open pull request
    4. Code review
    5. Merge to `main`
    6. Deploy immediately
    
    !!! success "When to use"
        - Fast-moving projects
        - Continuous deployment
        - Small to medium teams

??? abstract "Git Flow - Structured Releases"
    
    Multiple long-lived branches. More structured.
    
    ```mermaid
    gitGraph
        commit
        branch develop
        checkout develop
        commit
        branch feature/login
        checkout feature/login
        commit
        commit
        checkout develop
        merge feature/login
        branch release/1.0
        checkout release/1.0
        commit
        checkout main
        merge release/1.0 tag: "v1.0"
        checkout develop
        merge release/1.0
    ```
    
    **The branches:**
    
    - `main` → Production code. Always deployable.
    - `develop` → Integration branch. Next release code.
    - `feature/*` → New features. Branch from `develop`.
    - `release/*` → Release preparation. Branch from `develop`.
    - `hotfix/*` → Emergency fixes. Branch from `main`.
    
    !!! success "When to use"
        - Scheduled releases
        - Multiple versions in production
        - Enterprise projects

### Understanding Merge Conflicts

??? warning "How Conflicts Happen & Resolution"
    
    Two people edit the same file. Same line. Different changes. Both push to remote.
    
    The second person gets a conflict.
    
    **What a conflict looks like**
    
    ```javascript
    function login(username, password) {
    <<<<<<< HEAD
        return authenticateUser(username, password);
    =======
        return validateAndAuthenticate(username, password);
    >>>>>>> feature/bob
    }
    ```
    
    - `<<<<<<< HEAD` → What's in the target branch (usually `main`)
    - `=======` → The divider
    - `>>>>>>> feature/bob` → What's in your branch
    
    **Resolving a conflict**
    
    1. Open the file
    2. Decide what to keep
    3. Edit the file. Remove the conflict markers.
    
        ```javascript
        function login(username, password) {
            return validateAndAuthenticate(username, password);
        }
        ```
    
    4. Stage the resolved file
    
        ```bash
        git add login.js
        ```
    
    5. Complete the merge
    
        ```bash
        git commit -m "Resolve merge conflict in login.js"
        ```
    
    **Avoiding conflicts**
    
    - Pull often
    - Communicate with your team
    - Small commits
    - Modular code

## What's Next?

You've got branching down. You know the daily workflow. You understand staging, committing, pushing.

Next up: Pull Requests. Code reviews. How to merge into `main`. The collaboration workflow.

Practice this workflow a few times. It'll become muscle memory.