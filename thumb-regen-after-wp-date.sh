#!/usr/bin/env bash

DATE_THRESHOLD="2025-03-25 00:00:00"

# Get ID and title, tab‑separated
ATTACHMENTS=$(wp db query "
    SELECT ID, post_title
    FROM wp_posts
    WHERE post_type = 'attachment'
      AND post_mime_type = 'image/png'
      AND post_date >= '$DATE_THRESHOLD'
    COLLATE utf8mb4_unicode_ci;
" --skip-column-names)

if [ -z "$ATTACHMENTS" ]; then
    echo "No matching PNG images found after $DATE_THRESHOLD."
    exit 0
fi

# Count rows
IMAGE_COUNT=$(printf '%s\n' "$ATTACHMENTS" | wc -l | tr -d ' ')

echo "Found $IMAGE_COUNT PNG images after $DATE_THRESHOLD."
echo "Starting thumbnail regeneration..."

# Feed each line "ID<TAB>Title" to bash -c
printf '%s\n' "$ATTACHMENTS" | while IFS=$'\t' read -r id title; do
    if wp media regenerate "$id" --yes >/dev/null 2>&1; then
        echo "SUCCESS: ID $id - \"$title\""
    else
        echo "FAIL:    ID $id - \"$title\""
    fi
done

echo "Finished regenerating $IMAGE_COUNT images."
