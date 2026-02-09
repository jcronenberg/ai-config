---
name: verify-changes
description: Run sanity checks on staged/unstaged changes before committing
disable-model-invocation: true
allowed-tools: Bash, Read, Grep, Glob
---

# Verify Changes

Run pre-commit sanity checks. Do NOT analyze the code logic or suggest improvements. Only flag mechanical issues.

## Checks to run

### 1. Staging check
- Run `git status` and `git diff` (staged and unstaged)
- Flag files that were modified but not staged — could be forgotten
- Flag untracked files that look related to the changes (e.g. same directory, similar name)
- Flag staged files that look unrelated (e.g. unintended debug files, build artifacts, `.env`, credentials)
- Present a clear summary of what's staged vs not and flag anything suspicious

### 2. Spelling check
- Check changed files (from `git diff --name-only`) for obvious spelling errors in comments, strings, and documentation
- Only flag clear misspellings, not code identifiers or domain-specific terms
- Use the conversation context to understand what's domain-specific

### 3. Project tests and linters
- Detect the project type and run the appropriate test/lint commands if they exist:
  - `Makefile` / `CMakeLists.txt`: `make test`, `make check`, or similar
  - `package.json`: `npm test`, `npm run lint`
  - `Cargo.toml`: `cargo test`, `cargo clippy`
  - `pyproject.toml` / `setup.py`: `pytest`, `ruff`, `flake8`
  - `Gemfile`: `bundle exec rake test`, `rubocop`
  - `.github/workflows`: check what CI runs for hints
  - Pre-commit hooks: run `pre-commit run --files <changed files>` if `.pre-commit-config.yaml` exists
- If no test/lint setup is detected, skip and say so
- Only run what's already configured in the project, don't install anything

## Output

Present results as a short checklist:
- Staging: OK / issues found
- Spelling: OK / issues found
- Tests: OK / failed / skipped (no test setup)
- Linters: OK / failed / skipped (no lint setup)

Only show details for items with issues.

## Rules

- Do NOT analyze code quality or suggest refactors
- Do NOT modify any files
- Do NOT create commits
