---
name: tdd
description: Test-driven development with red-green-refactor. Builds features one vertical slice at a time.
---

# /tdd

## Process

### Red
1. Write a failing test that describes the desired behavior
2. Run the test — it must fail (red)
3. If it passes, the test is wrong — fix it

### Green
4. Write the minimum code to make the test pass
5. Run the test — it must pass (green)
6. If it fails, go back to step 4

### Refactor
7. Clean up: remove duplication, improve names, simplify
8. Run tests again — still green
9. Commit

## Rules

- **One vertical slice at a time.** Not all tests for the feature.
- **Test behavior, not implementation.** Mock only at trust boundaries.
- **Prefer state-based testing** over interaction testing.
- **Test edge cases:** empty input, null, overflow, auth failure, concurrent access.
- **Test the public API** of each module, not private methods.
- **Name tests as:** `test_[unit]_[scenario]_[expected]`

## Guard

If test suite doesn't exist:
1. Create test infrastructure (one line import, one conftest/setup)
2. Skip TDD for: docs, copy, renaming, formatting, cosmetics
