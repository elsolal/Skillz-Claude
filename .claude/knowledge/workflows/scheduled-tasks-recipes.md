# Cloud Scheduled Tasks Recipes

Convert D-EPCT+R workflows to cloud-hosted `/schedule` tasks when the work context is fully on GitHub (no local uncommitted state needed).

**When to use `/schedule` instead of RALPH:**
- The task operates on committed code only (GitHub repo, not local checkout)
- You want it to run unattended (overnight, daily, weekly)
- You don't need to interact during execution
- Examples: PR review, audit, doc sync, CI triage, dependency check

**When NOT to use `/schedule` (use RALPH instead):**
- You're working on uncommitted local files
- The workflow needs interactive checkpoints (STOP CHECKPOINTs)
- You need a highly customized workflow within your current checkout
- You need real-time feedback in your terminal

---

## Recipe 1: Automated PR Review (daily)

Replace manual `/pr-review #123` with a daily scan of all open PRs.

```bash
/schedule create \
  --repo owner/my-app \
  --cron "0 8 * * 1-5" \
  --prompt "Review all open PRs on this repo. For each PR:
1. Run the 3-pass review (Correctness → Readability → Performance)
2. Post a comment with findings using gh pr comment
3. If CRITICAL issues found, add the 'needs-fix' label

Skip PRs labeled 'wip' or 'draft'. Focus on PRs updated in the last 24h."
```

## Recipe 2: Daily Security Audit

Run the security-auditor skill on a schedule.

```bash
/schedule create \
  --repo owner/my-app \
  --cron "0 6 * * *" \
  --prompt "Run a security audit on this repo:
1. Check for exposed secrets in recent commits (git log --diff-filter=A -p -- '*.env' '*.key' '*.pem' HEAD~10)
2. Check dependencies for known vulnerabilities (npm audit / pip audit)
3. Scan for OWASP Top 10 patterns in recently changed files (git diff HEAD~10 --name-only)
4. If issues found, create a GitHub issue with label 'security' and severity level.
5. If no issues, do nothing (don't create noise)."
```

## Recipe 3: Auto-Dev for GitHub Issues (overnight batch)

Convert `/auto-dev` to a scheduled task that picks up the next P0 story and implements it overnight. Only works for issues where all context is in the GitHub issue body (no local state needed).

```bash
/schedule create \
  --repo owner/my-app \
  --cron "0 22 * * 1-5" \
  --prompt "Find the highest priority open issue labeled 'ready-for-dev' and 'P0':
1. Read the issue (gh issue view)
2. Create a feature branch: feature/<issue-number>-<slug>
3. Explore the codebase to understand the architecture
4. Plan the implementation (write the plan as a comment on the issue)
5. Implement the code + tests
6. Run lint, types, tests — fix if broken
7. Do the 3-pass review (Correctness, Readability, Performance) — fix CRITICAL issues
8. Commit with proper message format: feat|fix(scope): description. Refs: #<issue>
9. Push and create a PR linked to the issue (Closes #<issue>)
10. Remove the 'ready-for-dev' label, add 'in-review'

If no P0 issue found, do nothing."
```

**Limitations vs local RALPH:**
- Can't access uncommitted files
- Can't use local MCP servers that aren't configured in the cloud environment
- Can't interact with the user mid-execution
- Fresh repo clone each time (no local state persistence between runs)

## Recipe 4: Discovery → Issues (weekly planning batch)

Convert `/auto-discovery` to a weekly scheduled task that takes a roadmap file and creates stories.

```bash
/schedule create \
  --repo owner/my-app \
  --cron "0 9 * * 1" \
  --prompt "Read docs/roadmap.md and identify any items marked 'TODO' or 'Next':
1. For each item, check if a GitHub issue already exists (search by title)
2. If no issue exists, run a lightweight discovery:
   - Write a PRD section (Problem, Solution, Features, Success Criteria)
   - Break into stories (INVEST format, max size L)
   - Create GitHub issues with labels: 'story', 'auto-generated'
3. Comment on the roadmap item with links to created issues
4. Create a summary issue: 'Weekly Planning Batch - <date>' with all created issues listed."
```

## Recipe 5: Doc Sync (weekly)

Keep documentation in sync with code changes.

```bash
/schedule create \
  --repo owner/my-app \
  --cron "0 7 * * 1" \
  --prompt "Check if documentation is out of date:
1. Compare README.md install instructions against actual package.json scripts
2. Check if API docs match the actual route handlers (scan src/app/api/)
3. Check if CHANGELOG.md has entries for all commits since last tag
4. If gaps found, create a PR with fixes. Title: docs: sync documentation with code
5. If everything is in sync, do nothing."
```

---

## Managing scheduled tasks

```bash
# List all scheduled tasks
/schedule list

# View details of a specific task
/schedule get <task-id>

# Update a task's schedule
/schedule update <task-id> --cron "0 9 * * *"

# Delete a task
/schedule delete <task-id>

# Run a task immediately (for testing)
/schedule run <task-id>
```

## Best practices

1. **Start with `/schedule run`** to test the prompt before setting a real cron — verify the output is what you expect.
2. **Be explicit in the prompt** — the cloud agent has no memory of previous runs. Every prompt should be self-contained.
3. **Use "if nothing to do, do nothing"** — avoid creating noise (empty PRs, "no issues found" comments).
4. **Label managed artifacts** — use labels like `auto-generated`, `scheduled-task` so you can filter them in GitHub.
5. **Set up a review task** — one scheduled task that reviews the work of other scheduled tasks (the "shift supervisor" pattern).
