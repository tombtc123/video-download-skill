# Video Download Skill

<div align="center">

![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)
![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux%20%7C%20Windows-lightgrey.svg)

**A powerful video download script powered by yt-dlp and ffmpeg**

[简体中文](./README_CN.md) | English

</div>

---

## ✨ Features

- 🎬 **1000+ Sites** - YouTube, Bilibili, Twitter/X, TikTok, Instagram, and more
- 📺 **Best Quality** - Automatically selects the highest available quality
- 🔄 **Auto Merge** - Combines video and audio into MP4 format
- 🍪 **Cookie Support** - Access premium/member-only content
- 📋 **Playlist Support** - Download entire playlists
- ⚙️ **Configurable** - Custom output directory and settings

## 📦 Installation

### Prerequisites

Install the required dependencies:

**macOS (Homebrew)**
```bash
brew install yt-dlp ffmpeg
```

**Ubuntu/Debian**
```bash
sudo apt update
sudo apt install yt-dlp ffmpeg
```

**Windows (winget)**
```bash
winget install yt-dlp.yt-dlp
winget install ffmpeg
```

### Install Script

```bash
# Clone the repository
git clone https://github.com/tombtc123/video-download-skill.git

# Make script executable
chmod +x video-download-skill/scripts/download.sh

# (Optional) Add to PATH
echo 'export PATH="$PATH:$HOME/video-download-skill/scripts"' >> ~/.zshrc
source ~/.zshrc
```

## 🚀 Usage

### Basic Download

```bash
./scripts/download.sh "https://www.youtube.com/watch?v=VIDEO_ID"
```

### Options

| Option | Description |
|--------|-------------|
| `-q, --quality <RES>` | Set maximum resolution (720, 1080, 4k) |
| `-p, --playlist` | Download entire playlist |
| `-c, --cookies <BROWSER>` | Use browser cookies (safari/chrome/firefox) |
| `-o, --output <DIR>` | Set output directory |
| `-h, --help` | Show help message |

### Examples

```bash
# Download with max 720p quality
./scripts/download.sh "https://www.bilibili.com/video/BVxxx" -q 720

# Download using Safari cookies (for member-only content)
./scripts/download.sh "https://www.bilibili.com/video/BVxxx" -c safari

# Download to specific directory
./scripts/download.sh "https://youtu.be/xxx" -o ~/Movies

# Download entire playlist
./scripts/download.sh "https://www.youtube.com/playlist?list=xxx" -p
```

## ⚙️ Configuration

Create a config file at `~/.config/video-download/config`:

```bash
# Default output directory
OUTPUT_DIR="$HOME/Movies/Downloads"
```

## 🤖 Use with AI Assistants

This skill is designed to work with AI coding assistants like Claude Code / Gemini Code Assist.

Place the `.skills/video-download` folder in your workspace, and the AI will automatically use this script when you ask to download videos.

**Example prompts:**
- "Download this video: https://..."
- "帮我下载这个视频: https://..."

## 📋 Supported Sites

This tool supports all sites supported by [yt-dlp](https://github.com/yt-dlp/yt-dlp/blob/master/supportedsites.md), including:

- YouTube
- Bilibili
- Twitter / X
- TikTok
- Instagram
- Vimeo
- Twitch
- And 1000+ more...

## 📄 License

MIT License - See [LICENSE](./LICENSE) for details.

## 🙏 Acknowledgments

- [yt-dlp](https://github.com/yt-dlp/yt-dlp) - The powerful download engine
- [ffmpeg](https://ffmpeg.org/) - Video processing toolkit
