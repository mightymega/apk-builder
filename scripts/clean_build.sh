#!/data/data/com.termux/files/usr/bin/bash
echo "🧹 Cleaning up previous builds..."

BUILD_DIR="./template/build"

if [ -d "$BUILD_DIR" ]; then
    rm -rf "$BUILD_DIR"
    echo "✅ Previous builds cleaned!"
else
    echo "❌ No previous builds found!"
fi
