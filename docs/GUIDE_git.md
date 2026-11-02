# GUIDE_git.md — Agentic Git Patterns

## Essential prompts (work with any agent)

| Prompt | What it does |
|---|---|
| `Start a new Git repo here` | `git init` |
| `Commit these changes` | `git commit -m "msg"` |
| `Review changes made today` | `git log --since=this-morning` |
| `Integrate latest changes from main` | Merge/rebase/ff |
| `Sort out this git mess for me` | Fix merge conflicts, rebase issues |
| `Find and recover my code that does X` | Search reflog + branches |
| `Use git bisect to find when this bug was introduced: ...` | Binary search for bug origin |

## Commit discipline

- One concern per commit
- Descriptive messages: `type(scope): description`
- `git diff --stat` before commit to verify scope
- Never `--no-verify`
- Never commit secrets, binaries, compiled outputs

## History rewriting

| Prompt | Effect |
|---|---|
| `Undo last commit` | `git reset --soft HEAD~1` |
| `Remove uv.lock from that last commit` | Fine-grained commit surgery |
| `Combine last three commits with a better commit message` | Squash + rewrite |
| `Rewrite history to remove file X from all commits` | `git filter-branch` / `git filter-repo` |

History is a deliberately authored story, not a transcript.

## Worktree pattern for parallel sessions

```bash
git worktree add ../project-feature-x feature-x
# Run agent in ../project-feature-x without context pollution
```

3-5 worktrees = 3-5 parallel agent sessions. This is the single biggest productivity unlock.

## Review patterns

- `git log main..HEAD --oneline` → understand branch history
- `git diff main...HEAD` → review changes against base
- `git diff --stat HEAD~1` → quick scope check before commit

## Recovery

Agents navigate merge conflicts by reasoning about intent:
- Read both sides' changes
- Understand what each was trying to do
- Combine correctly
- Verify with tests

Prompt: `Sort out this git mess for me` — works for failed cherry-picks, partial rebases, mixed staging.
