# Background

Here, I will show you the very basics, the must haves when you want to work on a git setup. We will use github as the platform. Even thgouh the concepts will be same if you used Azure Devops.

I will focus on how its done using mainly the terminal. So that, when you use the VS Code features you will know that what commands run in the backend.

## Step 1 - Clone the repository

### Clone the repo

To clone a repository to your local machine using the terminal on a Mac, follow these steps:

### 1. **Open Terminal**
   - Press `Command (⌘) + Space`, type **Terminal**, and press `Enter`.

### 2. **Navigate to the Desired Directory**
   Decide where you want to clone the repository. Use `cd` (change directory) to move to the appropriate folder.

   ```sh
   cd ~/Documents
   ```

   (Replace `~/Documents` with your preferred location.)

### 3. **Clone the Repository**
   Run the following command:

   ```sh
   git clone <repository-url>
   ```

   For example, if the repository URL is:

   ```
   https://github.com/username/repository.git
   ```

   Then the command would be:

   ```sh
   git clone https://github.com/username/repository.git
   ```

   If using SSH:

   ```sh
   git clone git@github.com:username/repository.git
   ```

### 4. **Navigate into the Cloned Repository**
   ```sh
   cd repository
   ```

   (Replace `repository` with the actual repository name.)

### 5. **Verify the Clone**
   Run:

   ```sh
   git status
   ```

   If successful, you should see something like:

   ```
   On branch main
   Your branch is up to date with 'origin/main'.
   ```

Now, you can start working on the repository locally! 🚀

## Step 2: Fetch and Pull



## **Scenario: Starting on a Local Repository and Creating a Feature Branch**

### **Step 1: Check if the Repository is Up-to-Date**
Before creating a new branch, ensure your local repository is up-to-date with the remote repository.

```bash
git fetch origin
```

### **What Does `git fetch origin` Do?**
- It **retrieves the latest changes** from the remote repository **without modifying your local files**.
- It **syncs remote tracking branches** (e.g., `origin/main`), but your local branches remain unchanged.
- It is **not a full sync**, but an update of Git’s knowledge of remote branches.

#### **Is `git fetch` a Sync?**
- **Yes, but only for tracking purposes.** It updates Git’s knowledge of the remote repo without changing local files.
- It’s like saying: *"Hey Git, get the latest changes, but don’t apply them to my work yet."*

### **Step 2: Check for New Updates**
After fetching, check what new commits exist on the remote branch:

```bash
git log main..origin/main --oneline
```

This shows **commits that exist in `origin/main` but not in your local `main`**.

### **Step 3: Update Your Local Main Branch**
If you want to update your local `main` branch to match the latest remote version:

```bash
git checkout main
git pull origin main
```

### **Step 4: Create a Feature Branch**
Once your `main` branch is updated, create a new feature branch:

```bash
git checkout -b feature/xxx
```

### **Step 5: What Happens If You Run `git fetch` on `feature/xxx`?**
| **Your Local Branch (`feature/xxx`)** | **Exists Remotely?** | **What `git fetch` Does?** |
|--------------------------------|----------------|----------------------|
| Only exists locally  | ❌ No  | Does nothing to your branch. Just fetches other remote updates. |
| Not tracking remote | ✅ Yes | Fetches remote updates but **does not** update local branch. You need to set tracking manually. |
| Already tracking remote | ✅ Yes | Updates `origin/feature/xxx` but **does not merge into your local `feature/xxx`** until you pull or rebase. |

### **Step 6: Set Tracking for the Feature Branch (If Needed)**
If the branch exists remotely but isn't tracked locally:

```bash
git branch --set-upstream-to=origin/feature/xxx feature/xxx
git pull
```

### **Step 7: Make Changes and Push the Branch**
After making your changes, commit and push the branch to remote:

```bash
git add .
git commit -m "Your commit message here"
git push origin feature/xxx
```

### **Step 8: Merge the Feature Branch (After PR Approval)**
Once the pull request is approved, merge the branch into `main`:

```bash
git checkout main
git pull origin main
git merge feature/xxx
```

If you no longer need the feature branch, delete it:

```bash
git branch -d feature/xxx  # Delete locally
git push origin --delete feature/xxx  # Delete remotely
```

---

## **Understanding `git fetch` and Its Options**

### **What is `origin` in Git?**
- `origin` is the **default alias** for the remote repository.
- When you run `git fetch origin`, it fetches the latest updates from the remote repository **without modifying your local branches**.

### **Can You Run `git fetch` Without `origin`?**
Yes, you can run:

```bash
git fetch
```

#### **What Happens?**
- It fetches updates from **all** remote repositories.
- If you have only one remote (`origin`), this is **the same as** `git fetch origin`.

#### **Example: Multiple Remotes**
If you have two remotes:
- `origin` (your fork)
- `upstream` (the original repo)

You can fetch updates from both:

```bash
git fetch origin  # Fetches from your fork
git fetch upstream  # Fetches from the original repo
```

### **Common `git fetch` Options**
| Command                 | What it does? |
|-------------------------|--------------|
| `git fetch origin`      | Fetches only from `origin` (default remote). |
| `git fetch`             | Fetches from **all remotes**. |
| `git fetch upstream`    | Fetches from `upstream` (if configured). |
| `git fetch --prune`     | Removes deleted remote branches locally. |
| `git fetch --all`       | Fetches from **all remotes** at once. |

---