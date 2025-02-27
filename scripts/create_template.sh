#!/data/data/com.termux/files/usr/bin/bash
echo "🔧 Creating a new application template..."

read -p "Enter the name for the new app template: " app_name
TEMPLATE_DIR="./template/$app_name"

if [ -d "$TEMPLATE_DIR" ]; then
    echo "❌ Template already exists!"
    exit 1
fi

mkdir -p "$TEMPLATE_DIR/res" "$TEMPLATE_DIR/assets"
cp template/AndroidManifest.xml "$TEMPLATE_DIR/AndroidManifest.xml"
cp template/MainActivity.java "$TEMPLATE_DIR/MainActivity.java"

echo "🎉 New template created at: $TEMPLATE_DIR"
