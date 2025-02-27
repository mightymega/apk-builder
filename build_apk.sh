#!/data/data/com.termux/files/usr/bin/bash
echo "🚀 Building APK..."
sleep 1

# Define paths
WORKDIR=$(pwd)
BINDIR="$WORKDIR/bin"
TEMPLATEDIR="$WORKDIR/template"

# Compile Java files to class files
echo "🔨 Compiling Java..."
mkdir -p "$TEMPLATEDIR/bin"
javac -d "$TEMPLATEDIR/bin" -source 8 -target 8 "$TEMPLATEDIR/MainActivity.java"

# Convert to DEX format
echo "🔁 Converting to DEX..."
dx --dex --output="$TEMPLATEDIR/classes.dex" "$TEMPLATEDIR/bin"

# Package the APK
echo "📦 Packaging APK..."
mkdir -p "$TEMPLATEDIR/build"
aapt package -f -m -F "$TEMPLATEDIR/build/unsigned.apk" -M "$TEMPLATEDIR/AndroidManifest.xml" -I "$BINDIR/android.jar" -S "$TEMPLATEDIR/res" -A "$TEMPLATEDIR/assets"

# Add DEX to APK
echo "📌 Adding DEX..."
cd "$TEMPLATEDIR/build"
zip -u unsigned.apk ../classes.dex

# Align the APK
echo "📏 Aligning APK..."
zipalign -v 4 unsigned.apk aligned.apk

# Sign the APK
echo "✍️ Signing APK..."
apksigner sign --ks "$WORKDIR/bin/debug.keystore" --ks-pass pass:password --out final.apk aligned.apk

echo "🎉 Build complete! Your APK is at $TEMPLATEDIR/build/final.apk"
