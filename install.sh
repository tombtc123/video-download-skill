#!/bin/bash

# ============================================================================
# Video Download Skill - Installation Script
# ============================================================================

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}  Video Download Skill - Installer${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Detect OS
OS="unknown"
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
    OS="windows"
fi

echo -e "${YELLOW}Detected OS:${NC} $OS"
echo ""

# Check and install dependencies
install_deps() {
    echo -e "${YELLOW}Checking dependencies...${NC}"
    
    local need_yt_dlp=false
    local need_ffmpeg=false
    
    if ! command -v yt-dlp &> /dev/null; then
        need_yt_dlp=true
        echo -e "  ${RED}✗${NC} yt-dlp not found"
    else
        echo -e "  ${GREEN}✓${NC} yt-dlp installed"
    fi
    
    if ! command -v ffmpeg &> /dev/null; then
        need_ffmpeg=true
        echo -e "  ${RED}✗${NC} ffmpeg not found"
    else
        echo -e "  ${GREEN}✓${NC} ffmpeg installed"
    fi
    
    if [[ "$need_yt_dlp" = true ]] || [[ "$need_ffmpeg" = true ]]; then
        echo ""
        echo -e "${YELLOW}Installing missing dependencies...${NC}"
        
        case $OS in
            macos)
                if command -v brew &> /dev/null; then
                    [[ "$need_yt_dlp" = true ]] && brew install yt-dlp
                    [[ "$need_ffmpeg" = true ]] && brew install ffmpeg
                else
                    echo -e "${RED}Error: Homebrew not found. Please install Homebrew first.${NC}"
                    echo "Visit: https://brew.sh"
                    exit 1
                fi
                ;;
            linux)
                if command -v apt &> /dev/null; then
                    sudo apt update
                    [[ "$need_yt_dlp" = true ]] && sudo apt install -y yt-dlp
                    [[ "$need_ffmpeg" = true ]] && sudo apt install -y ffmpeg
                elif command -v dnf &> /dev/null; then
                    [[ "$need_yt_dlp" = true ]] && sudo dnf install -y yt-dlp
                    [[ "$need_ffmpeg" = true ]] && sudo dnf install -y ffmpeg
                else
                    echo -e "${RED}Error: No supported package manager found.${NC}"
                    exit 1
                fi
                ;;
            windows)
                if command -v winget &> /dev/null; then
                    [[ "$need_yt_dlp" = true ]] && winget install yt-dlp.yt-dlp
                    [[ "$need_ffmpeg" = true ]] && winget install ffmpeg
                else
                    echo -e "${RED}Error: winget not found.${NC}"
                    exit 1
                fi
                ;;
        esac
    fi
}

# Make scripts executable
setup_scripts() {
    echo ""
    echo -e "${YELLOW}Setting up scripts...${NC}"
    
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    chmod +x "$SCRIPT_DIR/scripts/download.sh"
    
    echo -e "  ${GREEN}✓${NC} Scripts configured"
}

# Create config directory
setup_config() {
    echo ""
    echo -e "${YELLOW}Setting up configuration...${NC}"
    
    CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/video-download"
    mkdir -p "$CONFIG_DIR"
    
    if [[ ! -f "$CONFIG_DIR/config" ]]; then
        echo "# Video Download Configuration" > "$CONFIG_DIR/config"
        echo "# OUTPUT_DIR=\"\$HOME/Downloads\"" >> "$CONFIG_DIR/config"
        echo -e "  ${GREEN}✓${NC} Config file created at $CONFIG_DIR/config"
    else
        echo -e "  ${GREEN}✓${NC} Config file already exists"
    fi
}

# Main
install_deps
setup_scripts
setup_config

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}  ✅ Installation Complete!${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "Usage:"
echo -e "  ${YELLOW}./scripts/download.sh \"VIDEO_URL\"${NC}"
echo ""
