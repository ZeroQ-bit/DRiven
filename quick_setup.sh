#!/bin/bash

# Quick Setup Script - Use Pre-Configured Templates
# This script sets up DRiven with the working NUC configuration

set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}=== DRiven Quick Setup (Using Pre-configured NUC Setup) ===${NC}"
echo ""

# Check if running as root
if [[ $EUID -ne 0 ]]; then
    echo -e "${RED}Error: This script must be run as root${NC}"
    exit 1
fi

# Create necessary directories
echo -e "${YELLOW}Creating directory structure...${NC}"
mkdir -p riven/riven/rivenfrontend
mkdir -p riven/postgres
mkdir -p zurg/config
mkdir -p /mnt/zurg/__all__
mkdir -p /mnt/library

echo -e "${GREEN}✓ Directories created${NC}"

# Copy template files if they don't exist
echo -e "${YELLOW}Setting up configuration files...${NC}"

if [ ! -f "riven/riven/riven/settings.json" ]; then
    if [ -f "riven/riven/riven/settings.json.template" ]; then
        cp riven/riven/riven/settings.json.template riven/riven/riven/settings.json
        echo -e "${GREEN}✓ Copied settings.json template${NC}"
    fi
fi

# Set proper permissions
echo -e "${YELLOW}Setting permissions...${NC}"
chmod 755 riven riven/riven zurg

echo ""
echo -e "${GREEN}=== Configuration Complete ===${NC}"
echo ""
echo -e "${YELLOW}NEXT STEPS:${NC}"
echo ""
echo "1. Edit the following files with your API keys:"
echo "   - riven/.env (add PUID, PGID, TZ)"
echo "   - zurg/.env (add REAL_DEBRID_API_KEY)"
echo "   - riven/riven/riven/settings.json (add all API keys)"
echo ""
echo "2. To get your API keys:"
echo "   - Real-Debrid: https://real-debrid.com/account/credentials"
echo "   - Plex Token: Right-click Plex server > Copy server address"
echo "   - mdblist API: https://mdblist.com/preferences/api"
echo ""
echo "3. Start the services:"
echo "   cd riven"
echo "   docker-compose up -d"
echo ""
echo "4. Access Riven:"
echo "   Frontend: http://YOUR_IP:3000"
echo "   Backend: http://YOUR_IP:8080"
echo ""
echo -e "${GREEN}For detailed setup instructions, see SETUP_GUIDE.md${NC}"
