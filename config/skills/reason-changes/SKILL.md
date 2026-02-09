---
name: reason-changes
description: Deep analysis of code changes for errors, logic issues, and best practices
disable-model-invocation: true
allowed-tools: Bash, Read, Grep, Glob
---

# Reason Changes

Deeply analyze the current code changes to find real problems. Use the conversation context to understand intent.

## Instructions

1. Get the full diff (`git diff` and `git diff --staged`)
2. For each changed file, read the full file (not just the diff) to understand the surrounding context
3. Identify the language/framework and its idioms
4. Analyze the changes thoroughly

## What to look for

- Logic errors, off-by-ones, wrong conditions, unreachable code
- Missing error handling where failure is realistically possible
- Resource leaks (unclosed files/connections, missing cleanup)
- Race conditions, deadlocks, unsafe concurrent access
- Security issues (injection, unsanitized input at boundaries, hardcoded secrets)
- API misuse or incorrect assumptions about library behavior
- Edge cases the code doesn't handle
- Violations of the project's existing patterns and conventions
- Language-specific pitfalls (e.g. ownership issues in Rust, null safety, integer overflow)
- Potential future issues or fragile patterns that could break with likely changes
- Nitpicks and minor concerns — include them but clearly label them as such

## Output

For each finding:
- File and location
- What the issue is
- Why it matters
- A suggested fix (brief)

Categorize findings by severity:
- **Bug**: will cause incorrect behavior
- **Warning**: could cause issues under certain conditions
- **Nitpick**: minor concern, up to the author to decide

If everything looks good, say so — don't manufacture issues.

## Rules

- Do NOT modify any files
- Read surrounding code to avoid false positives
- Prioritize real bugs over style, but include everything
