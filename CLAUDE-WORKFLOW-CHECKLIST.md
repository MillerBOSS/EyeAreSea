# Claude Code Workflow Checklist

This document ensures systematic completion of tasks without dropping any steps.

## 🚨 **MANDATORY STEPS - NEVER SKIP**

### **1. Initial Assessment**
- [ ] Review existing PRs and issues **BEFORE** starting new work
- [ ] Check current git status and sync with remote
- [ ] Identify all incomplete tasks from previous sessions
- [ ] Create comprehensive TodoWrite list for multi-step tasks

### **2. During Work**
- [ ] Use TodoWrite tool to track ALL multi-step tasks
- [ ] Mark tasks as `in_progress` BEFORE starting work
- [ ] Mark tasks as `completed` IMMEDIATELY after finishing
- [ ] Never batch task completions - complete them one by one
- [ ] Monitor long-running processes (builds, Actions) until completion

### **3. GitHub Actions & CI/CD**
- [ ] **ALWAYS** monitor GitHub Actions until completion
- [ ] Check run status with `gh run list --limit 3`
- [ ] View detailed logs for failures with `gh run view [ID] --log-failed`
- [ ] Fix issues and retest **BEFORE** moving on
- [ ] Verify successful runs produce expected results

### **4. Repository Management**
- [ ] Verify branch protection is enabled
- [ ] Check repository settings (issues enabled, proper permissions)
- [ ] Handle PRs systematically - don't leave them hanging
- [ ] Ensure no sensitive data in commits
- [ ] Test workflow changes end-to-end

### **5. Build & Test Verification**
- [ ] Test builds both locally (if possible) and in CI
- [ ] Document build requirements and failures
- [ ] Verify submodules are properly initialized
- [ ] Check that code signing requirements are understood
- [ ] Document system requirements accurately

### **6. Documentation & Communication**
- [ ] Update CLAUDE.md with new requirements
- [ ] Create/update security documentation
- [ ] Provide clear status reports on what was completed
- [ ] Explain any failures and their root causes

### **7. Final Verification**
- [ ] All TodoWrite tasks marked completed
- [ ] All GitHub Actions runs successful
- [ ] All PRs handled (merged or closed with explanation)
- [ ] Repository settings properly configured
- [ ] Documentation updated and accurate
- [ ] No loose ends or incomplete processes

## 🔧 **Emergency Recovery Steps**

If you find dropped tasks:
1. **STOP** current work immediately
2. Create TodoWrite list of ALL incomplete items
3. Prioritize by impact and urgency
4. Complete each task fully before moving to next
5. Verify completion with tests/checks
6. Update this checklist if gaps found

## 📋 **Key Commands for Monitoring**

```bash
# Check GitHub Actions
gh run list --limit 5
gh run view [ID]
gh run view [ID] --log-failed

# Check PRs and Issues
gh pr list --limit 5
gh issue list --limit 5

# Repository status
git status --porcelain
git log --oneline -5

# Repository settings
gh repo view --json hasIssuesEnabled,hasProjectsEnabled
```

## ⚠️ **Common Failure Points**

1. **Not monitoring Actions to completion**
   - Set timers, check back frequently
   - Don't assume success without verification

2. **Leaving PRs unhandled**
   - Check for existing PRs at start of session
   - Close or merge before creating new work

3. **Missing repository security settings**
   - Branch protection must be enabled
   - Workflow permissions must be restricted

4. **Incorrect tool arguments**
   - Verify Claude Code CLI arguments: `--allowed-tools` not `--allow-tools`
   - Test workflow changes in isolation

5. **Incomplete documentation**
   - Always update CLAUDE.md with new requirements
   - Document both successes and failures

## 📊 **Success Metrics**

- [ ] Zero failed GitHub Actions runs
- [ ] Zero open PRs with incomplete work
- [ ] All TodoWrite tasks completed
- [ ] Repository fully configured and secured
- [ ] Documentation comprehensive and accurate
- [ ] Build process understood and documented

---

**Remember: It's better to complete fewer tasks fully than to leave many tasks incomplete.**