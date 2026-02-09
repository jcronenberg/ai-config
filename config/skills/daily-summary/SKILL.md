---
name: daily-summary
description: Summarize the current session's work into an org-mode daily file
disable-model-invocation: true
allowed-tools: Read, Write, Bash
---

# Daily Summary

Summarize what was accomplished in this conversation session and append it to `/notes/roam/daily/$(date +%Y-%m-%d).org`.

## Instructions

1. Review the full conversation history
2. Identify what was discussed, explored, fixed, or built
3. Write a concise org-mode summary
4. Append it to the daily file (create if it doesn't exist)
   - If creating a new file, include the org-roam header shown below.

## File Header (for new files)

```org
:PROPERTIES:
:ID:       <generate a UUID with uuidgen>
:END:
#+title: <YYYY-MM-DD>
#+filetags: daily <YYYY> <YYYY-MM>
```

## Session Format

Use this org-mode structure (only include sections if they have content):

```org
* <timestamp> Session Summary
** What was done
- Concise bullet points of accomplishments
** Key findings / decisions
- Important things learned or decided
** Open items
- Anything left unfinished
```