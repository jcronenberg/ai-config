---
name: pr-template
description: Generate a PR title and description template based on the current session's work
disable-model-invocation: true
allowed-tools: Bash, Read, Grep, Glob
---

# PR Template Generator

Generate a pull request title and description based on what was done in this conversation. **Do NOT create the PR. Only output the template as text for the user to copy and modify.**

## Instructions

1. Review the full conversation history to understand what was changed and why
2. Run `git diff` and `git log` to see the actual changes on the current branch vs the base branch
3. Generate a PR title and description
4. Output it as a markdown code block so it's easy to copy

## Output format

```
Title: <short title, under 70 characters>

---

<Summary: a few sentences or short bullet points explaining what this PR does and why>
```

Only add additional sections (like Changes, Test plan, etc.) if they genuinely add value beyond what the summary already says. Most PRs only need the summary.

## Rules

- NEVER run `gh pr create` or any command that creates/modifies remote state
- Be short and concise, not overly descriptive
- Don't use bullet points just for the sake of it — plain sentences are fine
- Don't pad the description with obvious or redundant information
- If there are multiple commits, reflect all of them, not just the latest
