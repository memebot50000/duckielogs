#!/bin/bash

USER="memebot50000"
REPO="duckielogs"
KEY_FILE="$HOME/key.txt"
REPO_DIR="$HOME/$REPO"

echo "Starting script..."

# Check if key file exists
if [ ! -f "$KEY_FILE" ]; then
    echo "Error: Key file not found at $KEY_FILE"
    exit 1
fi

# Read the key
KEY=$(cat "$KEY_FILE")
if [ -z "$KEY" ]; then
    echo "Error: Key file is empty"
    exit 1
fi

echo "Key read successfully"

# Check if repo directory exists
if [ ! -d "$REPO_DIR" ]; then
    echo "Error: Repository directory not found at $REPO_DIR"
    exit 1
fi

# Change to repo directory
cd "$REPO_DIR" || { echo "Error: Unable to change to repository directory"; exit 1; }

echo "Changed to repository directory"

# Check git status
git status
if [ $? -ne 0 ]; then
    echo "Error: Not a git repository or git not installed"
    exit 1
fi

echo "Attempting git push..."

# Attempt git push
git push https://$USER:$KEY@github.com/$USER/$REPO.git

if [ $? -eq 0 ]; then
    echo "Push successful!"
else
    echo "Push failed. Error code: $?"
    echo "Current remote URL:"
    git remote -v
fi
