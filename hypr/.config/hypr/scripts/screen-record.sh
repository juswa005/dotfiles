#!/usr/bin/env bash

# screen-record.sh
# A script for recording the screen with gpu-screen-recorder on Hyprland

RECORDINGS_DIR="$HOME/Videos/Recordings"
mkdir -p "$RECORDINGS_DIR"

# File to store process ID
PIDFILE="/tmp/screen-record-gsr.pid"
# File to store output filename
OUTFILE="/tmp/screen-record-gsr.out"

check_dependencies() {
    local deps=("gpu-screen-recorder" "slurp" "notify-send" "pgrep" "pkill")
    for dep in "${deps[@]}"; do
        if ! command -v "$dep" >/dev/null 2>&1; then
            echo "Error: Required dependency '$dep' not found."
            exit 1
        fi
    done
}

start_recording() {
    local mode="$1"

    # Check if already recording
    if pgrep -x "gpu-screen-reco" >/dev/null 2>&1 || pgrep -f "^gpu-screen-recorder" >/dev/null 2>&1; then
        notify-send "Screen Recorder" "Already recording."
        exit 1
    fi

    # Select region using slurp format required by gpu-screen-recorder (WxH+X+Y)
    local geom
    geom=$(slurp -f "%wx%h+%x+%y" 2>/dev/null)
    if [ -z "$geom" ]; then
        # Selection cancelled
        exit 0
    fi

    # Generate filename
    local timestamp
    timestamp=$(date +'%Y-%m-%d_%H-%M-%S')
    local filename="$RECORDINGS_DIR/Recording-${timestamp}.mp4"

    # Base recording command using gpu-screen-recorder
    # Note: On Hyprland, the selected region MUST be fully contained within a single monitor.
    local -a cmd=(gpu-screen-recorder -w "$geom" -f 60 -k h264 -c mp4 -o "$filename")
    local notification_msg=""

    if [ "$mode" = "audio" ]; then
        # gpu-screen-recorder natively supports multiple audio inputs and gracefully handles fallbacks.
        # Capturing both default_output (desktop) and default_input (mic)
        cmd+=( -a default_output -a default_input )
        notification_msg="Recording started (Audio)"
    else
        notification_msg="Recording started (Silent)"
    fi

    # Start recording
    "${cmd[@]}" > /tmp/gsr-error.log 2>&1 &
    local pid=$!

    # Wait briefly to verify it didn't crash immediately (e.g. permission or region errors)
    sleep 0.5
    if ! kill -0 "$pid" 2>/dev/null; then
        notify-send "Screen Recorder" "Failed to start recording. Check region or permissions."
        exit 1
    fi

    # Save PID and filename
    echo "$pid" > "$PIDFILE"
    echo "$filename" > "$OUTFILE"

    # Send notification
    notify-send "Screen Recorder" "$notification_msg"
}

stop_recording() {
    if pgrep -x "gpu-screen-reco" >/dev/null 2>&1; then
        # Stop the current gpu-screen-recorder process
        if [ -f "$PIDFILE" ]; then
            local pid
            pid=$(cat "$PIDFILE")
            kill -INT "$pid" 2>/dev/null
        fi
        # Fallback if PID file didn't work
        pkill -INT -x "gpu-screen-reco" 2>/dev/null

        # Wait until encoding finishes
        if [ -f "$PIDFILE" ]; then
            local pid
            pid=$(cat "$PIDFILE")
            while kill -0 "$pid" 2>/dev/null; do
                sleep 0.5
            done
            rm -f "$PIDFILE"
        else
            while pgrep -x "gpu-screen-reco" >/dev/null 2>&1; do
                sleep 0.5
            done
        fi

        # Show the saved filename
        local filename=""
        if [ -f "$OUTFILE" ]; then
            filename=$(cat "$OUTFILE")
            rm -f "$OUTFILE"
        fi

        if [ -n "$filename" ]; then
            local basename
            basename=$(basename "$filename")
            notify-send "Screen Recorder" "Recording saved:\n$basename"
        else
            notify-send "Screen Recorder" "Recording saved."
        fi
    else
        # Fail gracefully if nothing is recording
        notify-send "Screen Recorder" "No recording in progress."
        exit 0
    fi
}

# Main
check_dependencies

case "$1" in
    audio)
        start_recording "audio"
        ;;
    silent)
        start_recording "silent"
        ;;
    stop)
        stop_recording
        ;;
    *)
        echo "Usage: $0 {audio|silent|stop}"
        exit 1
        ;;
esac
