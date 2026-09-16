#!/usr/bin/env bash

STATE_FILE="/tmp/waybar_clock_state"
CACHE_FILE="/tmp/waybar_clock_khal_cache"

# Initialize state if it doesn't exist
if [ ! -f "$STATE_FILE" ]; then
    echo "0" > "$STATE_FILE"
fi

state=$(cat "$STATE_FILE")

case "$1" in
    toggle)
        state=$(( (state + 1) % 3 ))
        echo "$state" > "$STATE_FILE"
        pkill -RTMIN+9 waybar
        ;;
    *)
        # Trigger background cache update if needed (older than 50 seconds)
        if [ ! -f "$CACHE_FILE" ] || [ $(expr $(date +%s) - $(stat -c %Y "$CACHE_FILE" 2>/dev/null || echo 0)) -gt 50 ]; then
            (
                khal list now 7d 2>/dev/null > "${CACHE_FILE}.tmp"
                mv "${CACHE_FILE}.tmp" "$CACHE_FILE"
                if [ "$(cat "$STATE_FILE")" -eq 2 ]; then
                    pkill -RTMIN+9 waybar
                fi
            ) >/dev/null 2>&1 &
        fi

        if [ "$state" -eq 0 ]; then
            text=$(date +"%a %d %b %Y %H:%M")
            tooltip="<tt>$(cal | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g')</tt>"
        elif [ "$state" -eq 1 ]; then
            text=$(date +"%Y-%m-%d")
            tooltip="<tt>$(cal | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g')</tt>"
        else
            if [ -f "$CACHE_FILE" ]; then
                text=$(cat "$CACHE_FILE" | grep -v '^[A-Z][a-z]*, ' | grep -v '^\s*$' | head -n 1 | sed 's/  ::.*//' | sed 's/^[ \t]*//')
                tooltip=$(cat "$CACHE_FILE" | head -n 15 | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g')
            else
                text="Loading..."
                tooltip="Fetching schedule..."
            fi
            
            if [ -z "$text" ]; then
                text="No upcoming events"
            else
                text="$text"
            fi
        fi
        
        # Output JSON for Waybar
        tooltip=$(echo "$tooltip" | awk '{printf "%s\\n", $0}' | sed 's/\\n$//')
        
        echo "{\"text\": \"$text\", \"tooltip\": \"$tooltip\"}"
        ;;
esac
