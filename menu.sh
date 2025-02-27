#!/data/data/com.termux/files/usr/bin/bash

# Function to display the menu
show_menu() {
    clear
    echo "====================================="
    echo "   🚀 Termux APK Builder Menu        "
    echo "====================================="
    echo "1️⃣  Setup Environment"
    echo "2️⃣  Build APK"
    echo "3️⃣  View Built APKs"
    echo "4️⃣  Exit"
    echo "====================================="
    read -p "Select an option: " choice
    case $choice in
        1) bash setup.sh ;;
        2) bash build_apk.sh ;;
        3) ls -lh template/build/final.apk ;;
        4) echo "Exiting..."; exit 0 ;;
        *) echo "❌ Invalid option! Try again."; sleep 1; show_menu ;;
    esac
}

# Run the menu
show_menu
