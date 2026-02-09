---
name: topic-summary
description: Summarize the current session into a topic-based org-roam note, appending if it exists or creating a new one
disable-model-invocation: true
argument-hint: "<topic>"
allowed-tools: Read, Write, Bash, Grep, Glob
---

# Topic Summary

Summarize what was accomplished/learned in this conversation for the given topic and save it to an org-roam note in `/notes/roam/`.

The topic is provided as the argument to this skill.

## Instructions

1. Take the topic from the argument
2. Search `/notes/roam/` for an existing file matching the topic:
   - Use Grep to search for `#+title:` lines that match the topic (case-insensitive)
   - If a matching file is found, append to it
   - If no matching file is found, create a new one
3. Review the full conversation history
4. Summarize what was discussed, learned, built, or fixed related to that topic
5. Write it in org-mode format

## When appending to an existing file

- Add a new second-level heading (`**`) under the most fitting top-level heading, or create a new top-level heading if none fit
- Use a timestamp in the heading: `** <YYYY-MM-DD> <brief description>`
- Keep the existing file structure intact

## When creating a new file

Use this org-roam format:

```org
:PROPERTIES:
:ID:       <generate a UUID with uuidgen>
:END:
#+title: <Topic>
#+filetags:

* Notes
** <YYYY-MM-DD> <brief description>
- Bullet points summarizing what was discussed/learned
```

Name the file: `/notes/roam/<timestamp>-<topic_lowercase_underscored>.org`
where timestamp is `YYYYMMDDHHmmss` (use current time).
