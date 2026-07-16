#!/usr/bin/env bash

# This script lists all agy (antigravity-cli) conversations.
# First wofi shows the list of past conversations with context.
# Second wofi shows details and an option to launch it.

HISTORY_FILE="$HOME/.gemini/antigravity-cli/history.jsonl"
if [ ! -f "$HISTORY_FILE" ]; then
    echo "History file not found: $HISTORY_FILE"
    exit 1
fi

mapfile -t RAW_CONVERSATIONS < <(awk '
{
    display=""
    cid=""
    workspace=""
    is_slash=0

    if (match($0, /"display":"([^"\\]*(\\.[^"\\]*)*)"/)) {
        display = substr($0, RSTART+11, RLENGTH-12)
    }
    if (match($0, /"conversationId":"([a-zA-Z0-9-]+)"/)) {
        cid = substr($0, RSTART+18, RLENGTH-19)
    }
    if (match($0, /"workspace":"([^"]+)"/)) {
        workspace = substr($0, RSTART+13, RLENGTH-14)
    }
    if (match($0, /"type":"slash_command"/)) {
        is_slash=1
    }

    if (cid == "") {
        last_display = display
        last_workspace = workspace
        last_is_slash = is_slash
    } else {
        if (!(cid in seen)) {
            seen[cid] = 1
            order[++count] = cid
            
            if (display != "" && is_slash == 0) {
                titles[cid] = display
            } else if (last_display != "" && last_is_slash == 0) {
                titles[cid] = last_display
            } else {
                titles[cid] = "No context available"
            }
            
            if (workspace != "") {
                workspaces[cid] = workspace
            } else if (last_workspace != "") {
                workspaces[cid] = last_workspace
            } else {
                workspaces[cid] = "Unknown Directory"
            }
        }
        last_display = ""
        last_workspace = ""
        last_is_slash = 0
    }
}
END {
    for (i = count; i > 0; i--) {
        c = order[i]
        title = titles[c]
        ws = workspaces[c]
        gsub(/\\n/, " ", title)
        gsub(/\\r/, "", title)
        print c "|||" ws "|||" title
    }
}
' "$HISTORY_FILE")

if [ ${#RAW_CONVERSATIONS[@]} -eq 0 ]; then
    echo "No conversations found in history."
    exit 0
fi

declare -A ID_TO_WS
declare -A ID_TO_TITLE
WOFI_INPUT=()

for line in "${RAW_CONVERSATIONS[@]}"; do
    cid="${line%%|||*}"
    rest="${line#*|||}"
    ws="${rest%%|||*}"
    title="${rest#*|||}"
    
    ID_TO_WS["$cid"]="$ws"
    ID_TO_TITLE["$cid"]="$title"
    
    short_title="${title:0:80}"
    if [ ${#title} -gt 80 ]; then
        short_title="${short_title}..."
    fi
    
    WOFI_INPUT+=("$cid | $ws | $short_title")
done

# First Wofi Menu
if command -v wofi >/dev/null 2>&1; then
    SELECTION=$(printf "%s\n" "${WOFI_INPUT[@]}" | wofi --show dmenu -i -p "Select Conversation:" --width 900 --lines 15)
else
    # Fallback to fzf if wofi is somehow not available
    SELECTION=$(printf "%s\n" "${WOFI_INPUT[@]}" | fzf --prompt="Select Conversation: ")
fi

if [ -z "$SELECTION" ]; then
    exit 0
fi

# Extract UUID
UUID=$(echo "$SELECTION" | awk '{print $1}')
WS="${ID_TO_WS[$UUID]}"
TITLE="${ID_TO_TITLE[$UUID]}"

# Instead of a second wofi, we launch a floating kitty terminal.
# We create a temporary script to handle the info display and user prompt.
TMP_SCRIPT="/tmp/agy_launch_${UUID}.sh"
cat << 'EOF' > "$TMP_SCRIPT"
#!/usr/bin/env bash
clear
echo -e '\e[1;36m=== Conversation Info ===\e[0m'
echo -e "\e[1;32mDirectory:\e[0m $1"
echo -e "\e[1;32mID:\e[0m $2"
echo -e "\e[1;32mContext:\e[0m $3"
echo ""
read -r -p $'Press \e[1;33mENTER\e[0m to launch, or \e[1;31mCtrl+C\e[0m to cancel...'
# Once they hit enter, launch the conversation
exec agy --conversation="$2"
EOF
chmod +x "$TMP_SCRIPT"

# Safely escape variables for the shell command
SAFE_WS=$(printf "%q" "$WS")
SAFE_UUID=$(printf "%q" "$UUID")
SAFE_TITLE=$(printf "%q" "$TITLE")
SAFE_TMP_SCRIPT=$(printf "%q" "$TMP_SCRIPT")

if command -v kitty >/dev/null 2>&1; then
    # Launch floating kitty using the user's defined waybar-kitty class
    kitty --class waybar-kitty --directory "$WS" -e "$TMP_SCRIPT" "$WS" "$UUID" "$TITLE" &
else
    # Fallback
    cd "$WS" && agy --conversation="$UUID"
fi
