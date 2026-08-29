#!/usr/bin/env bash

ARTIST_FILE="/tmp/waybar-mpris-artist"
ART_FILE="/tmp/waybar-mpris-art.png"
STATUS_FILE="/tmp/waybar-mpris-status"

# Ensure temp files exist to prevent read errors
touch "$ARTIST_FILE" "$STATUS_FILE" "$ART_FILE"

# Clean up files on exit
trap 'rm -f "$ARTIST_FILE" "$STATUS_FILE" "$ART_FILE"' EXIT

update_metadata() {
    # Listen to metadata changes from any player
    playerctl metadata --follow --format '{{ artist }}|{{ mpris:artUrl }}|{{ status }}' 2>/dev/null | while read -r line; do
        artist=$(echo "$line" | awk -F'|' '{print $1}')
        art=$(echo "$line" | awk -F'|' '{print $2}')
        status=$(echo "$line" | awk -F'|' '{print $3}')

        echo "$artist" > "$ARTIST_FILE"
        echo "$status" > "$STATUS_FILE"

        if [[ "$status" == "Stopped" || -z "$status" ]]; then
            echo "" > /tmp/waybar-mpris-art-path
        else
            if [[ "$art" == file://* ]]; then
                # Decode URL encoded filepath
                filepath=$(echo "${art#file://}" | python3 -c "import sys, urllib.parse; print(urllib.parse.unquote(sys.stdin.read().strip()))")
                cp "$filepath" "$ART_FILE" 2>/dev/null
                echo "$ART_FILE" > /tmp/waybar-mpris-art-path
            elif [[ "$art" == http* ]]; then
                curl -s "$art" -o "$ART_FILE" &
                echo "$ART_FILE" > /tmp/waybar-mpris-art-path
            else
                # Hide image
                echo "" > /tmp/waybar-mpris-art-path
            fi
        fi
        
        # Signal Waybar to update the image module (signal 8)
        pkill -RTMIN+8 waybar
    done
}

# Run metadata loop in background
update_metadata &
METADATA_PID=$!

trap 'kill $METADATA_PID 2>/dev/null; rm -f "$ARTIST_FILE" "$STATUS_FILE" "$ART_FILE"' EXIT

format_output() {
    title="$1"
    artist=$(cat "$ARTIST_FILE" 2>/dev/null)
    status=$(cat "$STATUS_FILE" 2>/dev/null)

    if [[ "$status" == "Stopped" || -z "$status" ]]; then
        echo '{"text": "♫ Nothing Playing", "class": "inactive", "tooltip": "No media playing"}'
    else
        # Determine status icon
        icon="▶"
        if [[ "$status" == "Paused" ]]; then
            icon="⏸"
        fi

        # HTML escape for Pango markup
        title=$(echo "$title" | sed 's/&/&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\\"/g')
        artist=$(echo "$artist" | sed 's/&/&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\\"/g')
        
        # Format the JSON line for Waybar
        if [[ -z "$artist" ]]; then
            echo "{\"text\": \"$icon $title\", \"class\": \"${status,,}\", \"tooltip\": \"$title\"}"
        else
            echo "{\"text\": \"$icon $title\n<span font_size='smaller' alpha='70%'>$artist</span>\", \"class\": \"${status,,}\", \"tooltip\": \"$title\n$artist\"}"
        fi
    fi
}

# The main scrolling loop using zscroll
zscroll -l 22 \
        --delay 0.3 \
        --match-command "playerctl status 2>/dev/null || echo Stopped" \
        --match-text "Playing" "--scroll 1" \
        --match-text "Paused" "--scroll 0" \
        --update-check true "playerctl metadata title 2>/dev/null" \
        | while read -r scrolled_title; do
            format_output "$scrolled_title"
          done
