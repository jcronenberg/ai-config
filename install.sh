#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

usage() {
    echo "Usage: $0 [claude|gemini]"
    exit 1
}

if [ $# -lt 1 ]; then
    usage
fi

MODE="$1"

link_item() {
    local src="$1"
    local target="$2"

    if [ -L "$target" ]; then
        existing="$(readlink -f "$target")"
        if [ "$existing" = "$src" ]; then
            echo "  skip: $(basename "$target") (already linked)"
            return
        fi
        rm "$target"
    elif [ -e "$target" ]; then
        echo "  warn: $target already exists"
        read -rp "  Replace with symlink? [y/N] " answer
        if [[ "$answer" =~ ^[Yy]$ ]]; then
            rm -rf "$target"
        else
            echo "  skip: $(basename "$target")"
            return
        fi
    fi

    ln -s "$src" "$target"
    echo "  link: $(basename "$target") -> $src"
}

if [ "$MODE" = "claude" ]; then
    DEST_DIR="$HOME/.claude"
    echo "Installing for Claude to $DEST_DIR..."
    mkdir -p "$DEST_DIR"
    for item in "$SCRIPT_DIR/config"/*; do
        [ -e "$item" ] || continue
        name="$(basename "$item")"
        if [ "$name" = "CONFIG.md" ]; then
            link_item "$(realpath "$item")" "$DEST_DIR/CLAUDE.md"
        else
            link_item "$(realpath "$item")" "$DEST_DIR/$name"
        fi
    done

elif [ "$MODE" = "gemini" ]; then
    GEMINI_DIR="$HOME/.gemini"
    echo "Installing for Gemini to $GEMINI_DIR..."
    mkdir -p "$GEMINI_DIR"
    
    # Install skills directory as a whole
    if [ -d "$SCRIPT_DIR/config/skills" ]; then
        link_item "$(realpath "$SCRIPT_DIR/config/skills")" "$GEMINI_DIR/skills"
    fi

    # Install GEMINI.md to ~/.gemini/
    if [ -f "$SCRIPT_DIR/config/CONFIG.md" ]; then
        link_item "$(realpath "$SCRIPT_DIR/config/CONFIG.md")" "$GEMINI_DIR/GEMINI.md"
    fi

else
    usage
fi

echo "Done."
