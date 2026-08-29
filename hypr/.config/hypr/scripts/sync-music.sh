#!/usr/bin/env bash

# Define colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}Starting music synchronization to Navidrome server (192.168.254.103)...${NC}"
echo "----------------------------------------------------------------------"

# Use rsync with --info=progress2 to show a global progress bar for the entire transfer
rsync -avz --info=progress2 /home/amiel/Music/nicotine/ josh@192.168.254.103:/home/josh/navidrome/music/

echo "----------------------------------------------------------------------"

# Check if rsync succeeded
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✔ Sync completed successfully!${NC}"
else
    echo -e "${RED}✘ Sync encountered an error. Please check the output above.${NC}"
fi

echo ""
read -n 1 -s -r -p "Press any key to close this window..."
echo ""
