#!/bin/bash

# ============================================================================
# Video Download Script
# Download videos from YouTube, Bilibili, Twitter/X, and 1000+ other sites
# https://github.com/tombtc123/video-download-skill
# ============================================================================

VERSION="1.0.0"

# Default configuration
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/video-download"
CONFIG_FILE="$CONFIG_DIR/config"

# Default values (can be overridden by config file)
DEFAULT_OUTPUT_DIR="$HOME/Downloads"
OUTPUT_DIR=""
QUALITY=""
USE_PLAYLIST=false
COOKIES_BROWSER=""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Load config file if exists
load_config() {
    if [[ -f "$CONFIG_FILE" ]]; then
        source "$CONFIG_FILE"
    fi
    # Use default if OUTPUT_DIR not set
    OUTPUT_DIR="${OUTPUT_DIR:-$DEFAULT_OUTPUT_DIR}"
}

# Show version
show_version() {
    echo "video-download v$VERSION"
}

# Show help
show_help() {
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}  Video Download Script v$VERSION${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo -e "${YELLOW}Usage:${NC}"
    echo "  download.sh <URL> [options]"
    echo ""
    echo -e "${YELLOW}Options:${NC}"
    echo "  -q, --quality <RES>     Set max resolution (e.g., 720, 1080, 4k)"
    echo "  -p, --playlist          Download entire playlist"
    echo "  -c, --cookies <BROWSER> Use browser cookies (safari/chrome/firefox/edge)"
    echo "  -o, --output <DIR>      Set output directory"
    echo "  -v, --version           Show version"
    echo "  -h, --help              Show this help"
    echo ""
    echo -e "${YELLOW}Examples:${NC}"
    echo "  download.sh \"https://www.youtube.com/watch?v=xxx\""
    echo "  download.sh \"https://www.bilibili.com/video/BVxxx\" -q 720"
    echo "  download.sh \"https://x.com/user/status/xxx\" -c safari"
    echo "  download.sh \"https://www.youtube.com/playlist?list=xxx\" -p"
    echo ""
    echo -e "${YELLOW}Supported Sites:${NC}"
    echo "  YouTube, Bilibili, Twitter/X, TikTok, Instagram, Vimeo,"
    echo "  and 1000+ more sites supported by yt-dlp"
    echo ""
    echo -e "${YELLOW}Configuration:${NC}"
    echo "  Create $CONFIG_FILE to set defaults:"
    echo "    OUTPUT_DIR=\"/path/to/videos\""
    echo ""
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

# Check dependencies
check_dependencies() {
    local missing=()
    
    if ! command -v yt-dlp &> /dev/null; then
        missing+=("yt-dlp")
    fi
    
    if ! command -v ffmpeg &> /dev/null; then
        missing+=("ffmpeg")
    fi
    
    if [[ ${#missing[@]} -gt 0 ]]; then
        echo -e "${RED}Error: Missing required dependencies: ${missing[*]}${NC}"
        echo ""
        echo "Install with:"
        echo "  macOS:   brew install ${missing[*]}"
        echo "  Ubuntu:  sudo apt install ${missing[*]}"
        echo "  Windows: winget install ${missing[*]}"
        exit 1
    fi
}

# Parse arguments
URL=""
while [[ $# -gt 0 ]]; do
    case $1 in
        -q|--quality)
            QUALITY="$2"
            shift 2
            ;;
        -p|--playlist)
            USE_PLAYLIST=true
            shift
            ;;
        -c|--cookies)
            COOKIES_BROWSER="$2"
            shift 2
            ;;
        -o|--output)
            OUTPUT_DIR="$2"
            shift 2
            ;;
        -v|--version)
            show_version
            exit 0
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        -*)
            echo -e "${RED}Error: Unknown option $1${NC}"
            echo "Use --help for usage information"
            exit 1
            ;;
        *)
            if [[ -z "$URL" ]]; then
                URL="$1"
            fi
            shift
            ;;
    esac
done

# Load configuration
load_config

# Check dependencies
check_dependencies

# Validate URL
if [[ -z "$URL" ]]; then
    echo -e "${RED}Error: Please provide a video URL${NC}"
    echo ""
    show_help
    exit 1
fi

# Ensure output directory exists
mkdir -p "$OUTPUT_DIR"

# Build yt-dlp command
YT_DLP_ARGS=()

# Format selection
if [[ -n "$QUALITY" ]]; then
    YT_DLP_ARGS+=(-f "bestvideo[height<=$QUALITY]+bestaudio/best[height<=$QUALITY]")
else
    YT_DLP_ARGS+=(-f "bestvideo+bestaudio/best")
fi

# Output format
YT_DLP_ARGS+=(--merge-output-format mp4)

# Output path
YT_DLP_ARGS+=(-o "$OUTPUT_DIR/%(title)s.%(ext)s")

# Playlist handling
if [[ "$USE_PLAYLIST" = false ]]; then
    YT_DLP_ARGS+=(--no-playlist)
fi

# Cookies
if [[ -n "$COOKIES_BROWSER" ]]; then
    YT_DLP_ARGS+=(--cookies-from-browser "$COOKIES_BROWSER")
fi

# Progress bar
YT_DLP_ARGS+=(--progress)

# Show download info
echo ""
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}  📥 Starting Download...${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "  ${YELLOW}URL:${NC}    $URL"
echo -e "  ${YELLOW}Output:${NC} $OUTPUT_DIR"
[[ -n "$QUALITY" ]] && echo -e "  ${YELLOW}Max Quality:${NC} ${QUALITY}p"
[[ -n "$COOKIES_BROWSER" ]] && echo -e "  ${YELLOW}Cookies:${NC} $COOKIES_BROWSER"
[[ "$USE_PLAYLIST" = true ]] && echo -e "  ${YELLOW}Mode:${NC} Playlist"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Execute download
yt-dlp "${YT_DLP_ARGS[@]}" "$URL"
EXIT_CODE=$?

# Show result
echo ""
if [[ $EXIT_CODE -eq 0 ]]; then
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}  ✅ Download Complete!${NC}"
    echo -e "  ${YELLOW}Saved to:${NC} $OUTPUT_DIR"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
else
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${RED}  ❌ Download Failed${NC}"
    echo -e "  Please check the URL and try again"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    exit 1
fi
