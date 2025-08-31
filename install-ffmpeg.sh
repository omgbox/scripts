#!/usr/bin/env bash
set -euo pipefail
INSTALL_DIR="/usr/local/bin"
TMP_DIR="$(mktemp -d)"
ARCH="$(uname -m)"

# Select correct build based on architecture
case "$ARCH" in
  x86_64) BUILD="ffmpeg-release-amd64-static.tar.xz" ;;
  aarch64) BUILD="ffmpeg-release-arm64-static.tar.xz" ;;
  *) echo "Unsupported architecture: $ARCH"; exit 1 ;;
esac

# Download and extract
cd "$TMP_DIR"
wget -q "https://johnvansickle.com/ffmpeg/releases/${BUILD}"
tar -xf "$BUILD"
cd ffmpeg-*-static

# Install ffmpeg and ffprobe
sudo cp ffmpeg ffprobe "$INSTALL_DIR"

# Clean up
rm -rf "$TMP_DIR"

# Confirm installation
echo "✅ FFmpeg and ffprobe installed to $INSTALL_DIR"
echo "🎬 FFmpeg version: $(ffmpeg -version | head -n 1)"
echo "🔍 ffprobe version: $(ffprobe -version | head -n 1)"

