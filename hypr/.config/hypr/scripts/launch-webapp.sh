#!/usr/bin/env fish

# Launch a website in chromium webapp mode
set URL $argv[1]

if test -z "$URL"
  echo "Usage: launch-webapp <URL>"
  exit 1
end

helium --app="$URL" &
