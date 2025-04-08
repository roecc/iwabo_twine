#!/bin/bash

# === CONFIGURATION ===
DOWNLOADS="$HOME/Downloads"
TARGET="$(pwd)"  # Target folder is the current directory
FILENAME="iwabo_twine.html"
NEWNAME="index.html"
CHECK_INTERVAL=5  # Check every 5 seconds

# === START WATCHING ===
echo "Watching for $FILENAME in $DOWNLOADS every $CHECK_INTERVAL seconds..."

while true; do
    if [ -f "$DOWNLOADS/$FILENAME" ]; then
        echo "[$(date)] Found $FILENAME — moving and committing..."

        # Remove existing index.js if it exists (force delete)
        rm -f "$TARGET/$NEWNAME"

        # Move and rename the file
        mv "$DOWNLOADS/$FILENAME" "$TARGET/$NEWNAME"

        # Change to target folder
        cd "$TARGET" || exit 1

        # Git workflow
        sleep "$CHECK_INTERVAL"
        git add -A
        sleep "$CHECK_INTERVAL"
        git commit -m "latest update"
        sleep "$CHECK_INTERVAL"
        git push

        echo "[$(date)] Done. Waiting for next file..."
    fi

    sleep "$CHECK_INTERVAL"
done
