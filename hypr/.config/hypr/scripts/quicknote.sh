#!/usr/bin/env bash

# Quick note script
NOTES_DIR="$HOME/Notes"
mkdir -p "$NOTES_DIR"

# Prompt for a filename directly in the terminal
echo -n "Enter note name (leave empty for timestamp): "
read INPUT

# If input is empty, fallback to a timestamp
if [ -z "$INPUT" ]; then
    FILENAME="note-$(date +%Y-%m-%d_%H-%M-%S).md"
else
    # Replace spaces with hyphens (optional, but good for obsidian links)
    FILENAME="${INPUT// /-}"
    
    # Ensure it ends with .md
    if [[ "$FILENAME" != *.md ]]; then
        FILENAME="$FILENAME.md"
    fi
fi


# Open neovim with the new file
nvim "$NOTES_DIR/$FILENAME"
