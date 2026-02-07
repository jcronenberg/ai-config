#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
mkdir -p "$CLAUDE_DIR"

for item in "$SCRIPT_DIR"/claude/*; do
    name="$(basename "$item")"
    target="$CLAUDE_DIR/$name"
    src="$(realpath "$item")"

    if [ -L "$target" ]; then
        existing="$(readlink -f "$target")"
        if [ "$existing" = "$src" ]; then
            echo "  skip: $name (already linked)"
            continue
        fi
        rm "$target"
    elif [ -e "$target" ]; then
        echo "  warn: $target already exists"
        read -rp "  Replace with symlink? [y/N] " answer
        if [[ "$answer" =~ ^[Yy]$ ]]; then
            rm -rf "$target"
        else
            echo "  skip: $name"
            continue
        fi
    fi

    ln -s "$src" "$target"
    echo "  link: $name -> $src"
done

echo "Done."
