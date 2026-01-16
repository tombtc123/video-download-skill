# 视频下载工具

<div align="center">

![版本](https://img.shields.io/badge/版本-1.0.0-blue.svg)
![协议](https://img.shields.io/badge/协议-MIT-green.svg)
![平台](https://img.shields.io/badge/平台-macOS%20%7C%20Linux%20%7C%20Windows-lightgrey.svg)

**基于 yt-dlp 和 ffmpeg 的强大视频下载脚本**

[English](./README.md) | 简体中文

</div>

---

## ✨ 功能特性

- 🎬 **支持 1000+ 网站** - YouTube、Bilibili、Twitter/X、TikTok、Instagram 等
- 📺 **自动最佳画质** - 自动选择可用的最高画质
- 🔄 **自动合并** - 将视频和音频合并为 MP4 格式
- 🍪 **Cookie 支持** - 下载会员专享内容
- 📋 **播放列表支持** - 批量下载整个播放列表
- ⚙️ **可配置** - 自定义输出目录和设置

## 📦 安装

### 前置依赖

首先安装必需的工具：

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

### 安装脚本

```bash
# 克隆仓库
git clone https://github.com/YOUR_USERNAME/video-download-skill.git

# 添加执行权限
chmod +x video-download-skill/scripts/download.sh

# (可选) 添加到 PATH
echo 'export PATH="$PATH:$HOME/video-download-skill/scripts"' >> ~/.zshrc
source ~/.zshrc
```

## 🚀 使用方法

### 基本下载

```bash
./scripts/download.sh "https://www.bilibili.com/video/BVxxx"
```

### 命令选项

| 选项 | 说明 |
|------|------|
| `-q, --quality <分辨率>` | 设置最大分辨率 (720, 1080, 4k) |
| `-p, --playlist` | 下载整个播放列表 |
| `-c, --cookies <浏览器>` | 使用浏览器 cookies (safari/chrome/firefox) |
| `-o, --output <目录>` | 设置输出目录 |
| `-h, --help` | 显示帮助信息 |

### 使用示例

```bash
# 限制最大 720p 画质
./scripts/download.sh "https://www.bilibili.com/video/BVxxx" -q 720

# 使用 Safari cookies 下载（获取大会员画质）
./scripts/download.sh "https://www.bilibili.com/video/BVxxx" -c safari

# 下载到指定目录
./scripts/download.sh "https://youtu.be/xxx" -o ~/Movies

# 下载整个播放列表
./scripts/download.sh "https://www.youtube.com/playlist?list=xxx" -p
```

## ⚙️ 配置文件

创建配置文件 `~/.config/video-download/config`：

```bash
# 默认输出目录
OUTPUT_DIR="$HOME/Movies/Downloads"
```

## 🤖 配合 AI 助手使用

本工具专为 AI 编程助手（如 Claude Code / Gemini Code Assist）设计。

将 `.skills/video-download` 文件夹放在你的工作区中，当你让 AI 下载视频时，它会自动使用这个脚本。

**示例对话：**
- "帮我下载这个视频: https://..."
- "Download this video: https://..."

## 📋 支持的网站

本工具支持 [yt-dlp](https://github.com/yt-dlp/yt-dlp/blob/master/supportedsites.md) 支持的所有网站，包括：

- YouTube
- Bilibili (B站)
- Twitter / X
- TikTok (抖音国际版)
- Instagram
- Vimeo
- Twitch
- 以及 1000+ 其他网站...

## 📄 开源协议

MIT License - 详见 [LICENSE](./LICENSE)

## 🙏 致谢

- [yt-dlp](https://github.com/yt-dlp/yt-dlp) - 强大的下载引擎
- [ffmpeg](https://ffmpeg.org/) - 视频处理工具包
