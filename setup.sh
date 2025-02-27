#!/data/data/com.termux/files/usr/bin/bash
echo "🔧 Setting up Termux APK Builder..."
sleep 1

# Request storage access
termux-setup-storage

# Update and install necessary tools
echo "📦 Installing dependencies..."
pkg update -y && pkg upgrade -y
pkg install openjdk-17 dx aapt zipalign apksigner wget unzip -y

# Create required directories
mkdir -p bin template scripts

# Download Apktool
echo "📥 Downloading Apktool..."
wget -q https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/linux/apktool -O bin/apktool
chmod +x bin/apktool

# Generate debug keystore if it doesn’t exist
if [ ! -f "bin/debug.keystore" ]; then
    echo "🔑 Generating debug keystore..."
    keytool -genkey -v -keystore bin/debug.keystore -storepass password -keypass password -alias debug -keyalg RSA -keysize 2048 -validity 10000
fi

# Copy android.jar from Termux system
echo "📥 Copying Android framework..."
cp /data/data/com.termux/files/usr/share/aapt/android.jar bin/android.jar

# Verify installation
if command -v dx && command -v aapt && command -v zipalign && command -v apksigner; then
    echo "✅ All tools installed successfully!"
else
    echo "❌ Error: Some tools failed to install."
    exit 1
fi

echo "🎉 Setup complete! Run ./menu.sh to access the interactive UI."
