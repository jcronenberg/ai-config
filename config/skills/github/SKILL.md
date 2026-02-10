---
name: github
description: "Interact with GitHub using the `gh` CLI. Focus on summarizing issues and PRs to determine priorities without code inspection."
---

# GitHub Skill

Use the `gh` CLI to interact with GitHub. Always specify `--repo owner/repo` when not in a git directory, or use URLs directly.

**Goal:** Quickly assess the project's status by listing and summarizing issues and PRs. Do NOT investigate the codebase (reading files, searching code) to understand these items unless explicitly asked.

## Workflow

1.  **List Issues & PRs:** Get a high-level view of what's open.
    ```bash
    gh issue list --repo owner/repo --limit 100
    gh pr list --repo owner/repo --limit 100
    ```

2.  **Summarize & Prioritize:**
    *   Read the titles and labels.
    *   For items that seem important (e.g., "bug", "critical", "security", recent activity), view their details and comments to understand the context.
    *   ```bash
        gh issue view <number> --repo owner/repo --comments
        gh pr view <number> --repo owner/repo --comments
        ```
    *   **Output:** Provide a concise summary of the key issues and PRs. Suggest what seems to be high priority based *only* on the activity, labels, and descriptions you read via `gh`.

## Pull Requests (CI & Checks)

If a PR is of interest, check its status without reading code:

*   **Check CI Status:** `gh pr checks <number> --repo owner/repo`
*   **List Runs:** `gh run list --repo owner/repo --limit 5`
*   **View Failures:** `gh run view <run-id> --repo owner/repo --log-failed`

## JSON Output

For scripting or filtering, use `--json` and `--jq`:

```bash
gh issue list --repo owner/repo --json number,title,labels --jq '.[] | "\(.number): \(.title) [\(.labels[].name)]"'
```
