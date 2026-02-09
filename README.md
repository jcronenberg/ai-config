# ai-config

Personal configuration for AI coding tools. Currently contains:
- **Claude Code**: Skills and CLAUDE.md templates.
- **Gemini CLI**: Skills converted from the Claude configuration.

**Warning:** Parts of this configuration were AI-generated and not fully human-reviewed. Only run the install script and use these skills inside a secure, sandboxed environment.

## Install

```sh
# For Claude Code
./install.sh claude

# For Gemini CLI
./install.sh gemini
```

- `claude` mode: 
    - Symlinks everything under `config/` into `~/.claude/`.
    - Symlinks `config/CONFIG.md` to `~/.claude/CLAUDE.md`.
- `gemini` mode: 
    - Symlinks `config/skills/*` into `~/.gemini/skills/`.
    - Symlinks `config/CONFIG.md` to `~/.gemini/GEMINI.md`.
