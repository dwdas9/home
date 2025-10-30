0000000000000000000000000000000000## **Git Tutorial Syllabus: Command Mastery from Basics to Advanced**
### *Learn Git Through Commands - Practical, Real-World Focused*

---

### **Module 1: Getting Started**

1. **Setup & First Commands**
   - Installing Git
   - `git config --global user.name "Your Name"`
   - `git config --global user.email "your@email.com"`
   - Essential configuration for associating work with your identity
   - **Quick Win**: Configure Git in 2 minutes

---

### **Module 2: Core Commands - The Daily Essentials**

2. **Repository Basics**
   - `git init` - Create a new repository
   - `git clone [url]` - Download existing project
   - **Concept**: What is a repository (local vs remote)?
   - **Exercise**: Clone a real project from GitHub

3. **The Fundamental Workflow**
   - `git status` - Check state of working directory
   - `git add [file]` or `git add .` - Stage changes
   - `git commit -m "message"` - Save snapshot locally
   - `git commit -a -m "message"` - Stage and commit tracked files
   - `git commit --amend` - Modify last commit
   - **Concept**: Working Directory → Staging Area → Repository
   - **VS Code**: Using Source Control panel
   - **Project**: Build a portfolio website with meaningful commits

4. **Viewing History**
   - `git log` - View commit history
   - `git log --oneline` - Condensed view
   - `git log --graph --oneline --all` - Visual branch history
   - `git show [commit]` - View specific commit
   - `git diff` - See unstaged changes
   - `git diff --staged` - See staged changes
   - **VS Code**: Using Timeline and GitLens

---

### **Module 3: Branching Commands**

5. **Branch Operations**
   - `git branch` - List branches
   - `git branch [branch-name]` - Create new branch
   - `git checkout [branch-name]` - Switch branches
   - `git checkout -b [branch-name]` - Create and switch
   - `git switch [branch-name]` - Modern way to switch branches
   - `git branch -d [branch-name]` - Delete branch
   - `git branch -D [branch-name]` - Force delete
   - **Concept**: Why branches matter (parallel development)
   - **VS Code**: Bottom-left branch switcher
   - **Scenario**: Feature development workflow

6. **Merging Commands**
   - `git merge [branch-name]` - Integrate changes
   - `git merge --no-ff [branch-name]` - Force merge commit
   - `git merge --abort` - Cancel merge during conflicts
   - **Concept**: Fast-forward vs three-way merge
   - **Handling Conflicts**: Manual resolution
   - **VS Code**: Conflict resolution interface
   - **Exercise**: Create and resolve conflicts intentionally

---

### **Module 4: Remote Repository Commands**

7. **Understanding Remotes**
   - `git remote -v` - List remotes
   - `git remote add origin [url]` - Add remote
   - `git remote remove [name]` - Remove remote
   - `git remote rename [old] [new]` - Rename remote
   - **Concept**: Origin (your remote repository)
   - **Concept**: Upstream (original when forked)

8. **Syncing Commands - Push, Pull, Fetch**
   - `git push [remote] [branch]` - Upload commits
   - `git push -u origin [branch]` - Set upstream and push
   - `git push --force-with-lease` - Safe force push
   - `git pull` - Fetch + Merge automatically
   - `git fetch` - Download without merging (safer)
   - `git fetch --all` - Fetch from all remotes
   - **Concept**: Fetch downloads changes safely, Pull fetches and merges
   - **When to use what**: Fetch for safety, Pull for quick updates
   - **Project**: Push portfolio to GitHub

9. **GitHub Workflow Commands**
   - `git clone [url]` - Download repository
   - Fork workflow (on GitHub)
   - Creating Pull Requests
   - **VS Code**: GitHub Pull Requests extension

---

### **Module 5: Undo & Fix Commands (Essential Survival)**

10. **Undoing Changes**
    - `git restore [file]` - Discard working directory changes
    - `git restore --staged [file]` - Unstage files
    - `git reset HEAD [file]` - Unstage (older way)
    - `git reset --soft HEAD~1` - Undo commit, keep changes staged
    - `git reset --mixed HEAD~1` - Undo commit, unstage changes
    - `git reset --hard HEAD~1` - Undo commit, discard changes
    - `git revert [commit]` - Create new commit that undoes changes
    - **Concept**: Reset vs Revert (when to use which)
    - **Common Scenarios**: "I committed to wrong branch!"
    - **VS Code**: Undo last commit option

11. **Stash Commands**
    - `git stash` - Temporarily save changes
    - `git stash save "message"` - Stash with description
    - `git stash list` - View all stashes
    - `git stash pop` - Apply and remove latest stash
    - `git stash apply` - Apply without removing
    - `git stash apply stash@{n}` - Apply specific stash
    - `git stash drop` - Remove stash
    - `git stash clear` - Remove all stashes
    - **Use Case**: Switch branches quickly without committing incomplete work
    - **VS Code**: Stash operations in Source Control

---

### **Module 6: Advanced Commands (Power User)**

12. **Rebase Commands**
    - `git rebase [branch]` - Replay commits on new base
    - `git rebase -i HEAD~n` - Interactive rebase (edit history)
    - `git rebase --continue` - Continue after resolving conflicts
    - `git rebase --abort` - Cancel rebase
    - `git rebase --skip` - Skip problematic commit
    - **Concept**: Rebase creates linear history, avoids merge commits
    - **Golden Rule**: Never rebase public/shared commits
    - **Interactive Rebase**: Squash, reorder, edit, or drop commits
    - **When**: Cleaning feature branch before merging
    - **Exercise**: Squash multiple commits into one

13. **Cherry-pick Commands**
    - `git cherry-pick [commit]` - Apply specific commit to current branch
    - `git cherry-pick [commit1] [commit2]` - Multiple commits
    - `git cherry-pick [commit1]..[commit2]` - Range of commits
    - `git cherry-pick --no-commit [commit]` - Apply without committing
    - `git cherry-pick --continue` - Continue after conflict
    - `git cherry-pick --abort` - Cancel operation
    - **Use Case**: Apply bug fix from one branch to another without merging everything
    - **Scenario**: Hotfix to multiple versions

14. **Reflog Commands (The Safety Net)**
    - `git reflog` - View history of HEAD movements
    - `git reflog show [branch]` - Reflog for specific branch
    - `git reset --hard HEAD@{n}` - Recover to previous state
    - `git checkout HEAD@{n}` - View previous state
    - `git branch [name] HEAD@{n}` - Create branch from reflog
    - **Concept**: Reflog logs every action that modified HEAD - your undo history
    - **Use Case**: Recover accidentally deleted commits or branches
    - **Exercise**: "Accidentally" delete commits, then recover them

---

### **Module 7: Inspection & Comparison Commands**

15. **Advanced Inspection**
    - `git log --author="name"` - Filter by author
    - `git log --since="2 weeks ago"` - Time-based filtering
    - `git log --grep="keyword"` - Search commit messages
    - `git log -p` - Show diff in each commit
    - `git log -- [file]` - History of specific file
    - `git blame [file]` - See who changed each line
    - `git show [commit]:[file]` - View file at specific commit
    - `git diff [branch1]..[branch2]` - Compare branches
    - `git diff [commit1] [commit2]` - Compare commits
    - **VS Code**: GitLens for inline blame and history

16. **Finding Issues**
    - `git bisect start` - Start binary search for bugs
    - `git bisect bad` - Mark current as bad
    - `git bisect good [commit]` - Mark known good commit
    - `git bisect reset` - End bisect session
    - **Use Case**: Find which commit introduced a bug

---

### **Module 8: Cleaning & Maintenance Commands**

17. **Cleanup Commands**
    - `git clean -n` - Preview what will be removed
    - `git clean -f` - Remove untracked files
    - `git clean -fd` - Remove untracked files and directories
    - `git clean -fx` - Include ignored files
    - `git gc` - Garbage collection (optimize repository)
    - `git prune` - Remove unreachable objects

---

### **Module 9: Collaboration & Workflow Commands**

18. **Tags & Releases**
    - `git tag` - List tags
    - `git tag [tag-name]` - Create lightweight tag
    - `git tag -a [tag-name] -m "message"` - Annotated tag
    - `git tag -d [tag-name]` - Delete local tag
    - `git push origin [tag-name]` - Push tag to remote
    - `git push origin --tags` - Push all tags
    - **Concept**: Semantic versioning (v1.0.0, v1.1.0, v2.0.0)

19. **Workflow Patterns**
    - **GitHub Flow**: main + feature branches + PRs
    - **Git Flow**: main + develop + feature/release/hotfix
    - `.gitignore` file essentials
    - Commit message conventions
    - Branch naming strategies
    - **Case Study**: How professional teams work

---

### **Module 10: Configuration & Aliases**

20. **Productivity Commands**
    - `git config --list` - View all settings
    - `git config --global alias.st status` - Create aliases
    - `git config --global alias.co checkout`
    - `git config --global alias.br branch`
    - `git config --global alias.lg "log --graph --oneline"`
    - **Useful Aliases**: Speed up common operations
    - Setting default editor
    - Setting merge tool

---

### **Module 11: Real-World Problem Solving**

21. **Common Problems & Solutions**
    - "Detached HEAD state" - What and how to fix
    - "Can't push - rejected" - Understanding and fixing
    - "Merge conflicts" - Resolving strategies
    - "Accidentally committed sensitive data" - Removing from history
    - "Lost commits" - Using reflog to recover
    - "Wrong branch" - Moving commits between branches
    - **Troubleshooting Guide**: Step-by-step solutions

22. **Complete Workflow Scenarios**
    - Solo developer workflow
    - Team collaboration (multiple developers)
    - Open source contribution (fork → PR)
    - Emergency hotfix procedure
    - Release management
    - **Hands-on**: Practice all scenarios

---

### **Bonus: Quick Reference**

23. **Command Cheat Sheet**
    - Daily commands quick reference
    - VS Code keyboard shortcuts
    - Git aliases compilation
    - Command comparison table
    - **Downloadable PDF**: Printable cheat sheet

---

## **What Makes This Syllabus Command-Focused:**

✅ **Top 12 Essential Commands** covered comprehensively  
✅ **Command-First Approach**: Every lesson teaches actual commands  
✅ **Practical Examples**: Real scenarios for each command  
✅ **VS Code Integration**: IDE shortcuts alongside terminal commands  
✅ **Progressive Complexity**: Basic → Intermediate → Advanced  
✅ **Problem-Solving Focus**: Common issues and their command solutions  
✅ **Hands-On**: Every module has practical exercises  

**Total**: 23 lessons, ~70+ commands mastered, 10-12 hours of focused learning

---

The **MkDocs YAML**:

```yaml
- Git:
      - 1. Getting Started:
          - Setup & First Commands: 'DevOps/Git/1_Setup_First_Commands.md'
      
      - 2. Core Commands - Daily Essentials:
          - Repository Basics (init, clone): 'DevOps/Git/2_Repository_Basics.md'
          - The Fundamental Workflow (status, add, commit): 'DevOps/Git/2.1_Fundamental_Workflow.md'
          - Viewing History (log, show, diff): 'DevOps/Git/2.2_Viewing_History.md'
      
      - 3. Branching Commands:
          - Branch Operations (branch, checkout, switch): 'DevOps/Git/3_Branch_Operations.md'
          - Merging Commands (merge, conflicts): 'DevOps/Git/3.1_Merging_Commands.md'
      
      - 4. Remote Repository Commands:
          - Understanding Remotes (remote commands): 'DevOps/Git/4_Understanding_Remotes.md'
          - Push, Pull, Fetch - Syncing Commands: 'DevOps/Git/4.1_Push_Pull_Fetch.md'
          - GitHub Workflow Commands: 'DevOps/Git/4.2_GitHub_Workflow.md'
      
      - 5. Undo & Fix Commands:
          - Undoing Changes (restore, reset, revert): 'DevOps/Git/5_Undoing_Changes.md'
          - Stash Commands: 'DevOps/Git/5.1_Stash_Commands.md'
      
      - 6. Advanced Commands:
          - Rebase Commands: 'DevOps/Git/6_Rebase_Commands.md'
          - Cherry-pick Commands: 'DevOps/Git/6.1_Cherry_Pick_Commands.md'
          - Reflog Commands - The Safety Net: 'DevOps/Git/6.2_Reflog_Commands.md'
      
      - 7. Inspection & Comparison:
          - Advanced Inspection Commands: 'DevOps/Git/7_Advanced_Inspection.md'
          - Finding Issues (bisect): 'DevOps/Git/7.1_Finding_Issues.md'
      
      - 8. Cleaning & Maintenance:
          - Cleanup Commands (clean, gc, prune): 'DevOps/Git/8_Cleanup_Commands.md'
      
      - 9. Collaboration & Workflow:
          - Tags & Releases Commands: 'DevOps/Git/9_Tags_Releases.md'
          - Workflow Patterns & Best Practices: 'DevOps/Git/9.1_Workflow_Patterns.md'
      
      - 10. Configuration & Productivity:
          - Configuration & Aliases: 'DevOps/Git/10_Config_Aliases.md'
      
      - 11. Real-World Problem Solving:
          - Common Problems & Command Solutions: 'DevOps/Git/11_Common_Problems.md'
          - Complete Workflow Scenarios: 'DevOps/Git/11.1_Workflow_Scenarios.md'
      
      - 12. Quick Reference:
          - Command Cheat Sheet: 'DevOps/Git/12_Command_Cheat_Sheet.md'
```