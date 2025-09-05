#!/bin/bash
# build_debug_apk.sh
# Flutter Debug APK build helper script

echo "🚀 Debug APK build शुरू हो रहा है..."
flutter clean
flutter pub get
flutter build apk --debug

APK_PATH="build/app/outputs/flutter-apk/app-debug.apk"

if [ -f "$APK_PATH" ]; then
  echo "✅ Debug APK बन चुका है!"
  echo "📂 APK location: $APK_PATH"
else
  echo "❌ APK build नहीं हो पाया, error चेक करें।"
fi
