---
name: video-download
description: Download videos from YouTube, Bilibili, Twitter/X and 1000+ sites with automatic best quality selection and MP4 conversion
---

# Video Download Skill

A powerful video download skill powered by yt-dlp and ffmpeg.

## Capabilities

- 🎬 Download from 1000+ video sites (YouTube, Bilibili, Twitter/X, TikTok, etc.)
- 📺 Automatic best quality selection
- 🔄 Automatic video/audio merge to MP4
- 🍪 Browser cookie support for premium content
- 📋 Playlist download support

## Usage

When user requests to download a video, use the `scripts/download.sh` script.

### Basic Download

```bash
./scripts/download.sh "VIDEO_URL"
```

### With Options

```bash
# Limit quality to 720p
./scripts/download.sh "VIDEO_URL" --quality 720

# Use browser cookies (for member-only content)
./scripts/download.sh "VIDEO_URL" --cookies safari

# Download entire playlist
./scripts/download.sh "PLAYLIST_URL" --playlist

# Specify output directory
./scripts/download.sh "VIDEO_URL" --output /path/to/dir
```

## Dependencies

- **yt-dlp**: Video download engine
- **ffmpeg**: Video/audio processing

Install on macOS:
```bash
brew install yt-dlp ffmpeg
```

## Configuration

Users can create `~/.config/video-download/config` to set default output directory:

```bash
OUTPUT_DIR="$HOME/Movies"
```
