# Finding Issues (bisect)

## Understanding Git Bisect

### What is Bisect?
### Use Case: Find Which Commit Introduced a Bug
### How It Works: Binary Search

## Basic Bisect Workflow

### git bisect start - Start Binary Search
```bash
git bisect start
```

### git bisect bad - Mark Current as Bad
```bash
git bisect bad
git bisect bad [commit]
```

### git bisect good - Mark Known Good Commit
```bash
git bisect good [commit]
git bisect good abc1234
git bisect good HEAD~10
```

### git bisect reset - End Bisect Session
```bash
git bisect reset
```

## Complete Bisect Example

### Manual Testing
```bash
# 1. Start bisect
git bisect start

# 2. Mark current (broken) as bad
git bisect bad

# 3. Mark last known good commit
git bisect good v1.0

# 4. Git checks out middle commit
# Test your code...

# 5. Mark as good or bad
git bisect good  # or git bisect bad

# 6. Repeat until found
# Git will narrow down the problematic commit

# 7. End session
git bisect reset
```

## Automated Bisect

### Using a Test Script
```bash
git bisect start
git bisect bad
git bisect good v1.0
git bisect run ./test-script.sh
```

### Test Script Requirements
- Exit 0 for good commit
- Exit 1-127 (except 125) for bad commit
- Exit 125 to skip commit

### Example Test Script
```bash
#!/bin/bash
# test-script.sh

# Run tests
npm test

# Exit with test result
exit $?
```

## Advanced Bisect

### Skipping Commits
```bash
git bisect skip
git bisect skip v1.0..v1.5  # Skip range
```

### Visualizing Bisect
```bash
git bisect visualize
git bisect view
```

### Bisect Log
```bash
git bisect log
git bisect log > bisect.log
```

### Replaying Bisect
```bash
git bisect replay bisect.log
```

## Bisect Commands

### Check Status
```bash
git bisect log
```

### Terms (good/bad alternatives)
```bash
git bisect start --term-old=working --term-new=broken
git bisect working
git bisect broken
```

## Common Scenarios

### Finding Regression
```bash
# Feature worked in v1.0, broken in v2.0
git bisect start HEAD v1.0
git bisect run npm test
```

### Finding Performance Issue
```bash
git bisect start
git bisect bad  # Slow
git bisect good abc1234  # Fast
git bisect run ./benchmark.sh
```

## Writing Good Bisect Scripts

### Requirements
- Fast execution
- Clear pass/fail
- Repeatable
- No side effects

### Example: Python Tests
```bash
#!/bin/bash
python -m pytest tests/test_feature.py
exit $?
```

### Example: Build Check
```bash
#!/bin/bash
make clean
make || exit 125  # Skip if doesn't build
make test
```

## Best Practices

### Before Starting
- Ensure clean working directory
- Identify good and bad commits
- Have reliable test

### During Bisect
- Test thoroughly at each step
- Keep notes
- Don't make changes

### After Finding
- Verify the commit
- Understand the change
- Write test to prevent regression

## Bisect with Merge Commits

### First Parent Only
```bash
git bisect start --first-parent
```

## Troubleshooting

### Bisect Stuck
```bash
git bisect skip
git bisect reset
```

### Wrong Commit Marked
```bash
git bisect log > temp.log
# Edit temp.log
git bisect reset
git bisect replay temp.log
```

### Build Failures
```bash
# Skip commits that don't build
exit 125  # In test script
```

## Bisect Best Practices

### 1. Good Commit History
- Small, atomic commits
- Working code at each commit
- Clear commit messages

### 2. Reliable Tests
- Automated tests
- Deterministic results
- Fast execution

### 3. Clean Repository
- Committed changes
- No local modifications
- Updated dependencies

## Real-World Example

### Bug Hunt Workflow
```bash
# 1. Identify the issue
# Feature X broken in current main

# 2. Find last working version
git checkout v2.0
# Test - works!

# 3. Start bisect
git bisect start HEAD v2.0

# 4. Automate with test
git bisect run python test_feature_x.py

# 5. Result
# Bisect identifies commit abc1234

# 6. Investigate
git show abc1234
git log abc1234

# 7. Fix the issue
git checkout main
# Apply fix

# 8. Clean up
git bisect reset
```

## Bisect Alternatives

### Manual Binary Search
### Git Log with Filtering
### Blame for Line-specific Issues

## Performance Tips

### Fast Tests
### Parallel Testing (if possible)
### Skip Known Problematic Commits

## Integration with CI/CD

### Automated Bisect in Pipeline
### Bisect on Test Failures
### Historical Analysis
