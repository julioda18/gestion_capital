---
name: code-review
description: Two-axis review of the current diff — checks standards compliance AND spec fidelity. Run before opening a PR.
disable-model-invocation: true
allowed-tools: Read, Grep, Glob, Bash
---

# /code-review

> ⚠️ CRITICAL PROHIBITION: DO NOT EDIT, CREATE, OR DELETE ANY CODE. DO NOT FIX THE ISSUES YOU FIND.
> YOUR ONLY JOB IS TO REVIEW THE DIFF AND OUTPUT TEXT. IF YOU EDIT ANY SOURCE CODE FILE, YOU HAVE FAILED THIS INSTRUCTION.

## Process

1. `git diff main...HEAD` (or HEAD~1 if no main)
2. `git log main..HEAD --oneline`
3. Read full files, not just diff context
4. Cross-check against `RULES.md`, docs/, and project conventions

## Axis 1: Standards

- Correctness: off-by-one, null handling, error paths, race conditions
- Security: injection risks, missing auth, secrets in code
- N+1 queries, unnecessary allocations
- Convention violations from RULES.md or project standards
- Missing tests for new logic
- Over-engineering: unnecessary abstractions, unused parameters

## Axis 2: Spec fidelity

- Does the code match what the issue/spec asked for?
- Are there edge cases the spec didn't cover that the code should handle?
- Does it do things NOT in scope?

## Output format

```
## Review

### Critical
- file:line — issue — suggested fix

### High
- file:line — issue — suggested fix

### Medium
- file:line — issue — suggested fix

### Low
- file:line — issue — suggested fix

## Verdict
**SHIP** | **FIX FIRST** | **REWORK**
```
