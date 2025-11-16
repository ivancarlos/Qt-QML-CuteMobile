#!/usr/bin/env bash

# === Qt + Android (6.5.3) ===
export QT_BASE_DIR="${HOME}/qt"
export QT_DESKTOP_DIR="${HOME}/qt/6.5.3/gcc_64"
export QT_ANDROID_ARM64_DIR="${HOME}/qt/6.5.3/android_arm64_v8a"
export QT_ANDROID_ARMV7_DIR="${HOME}/qt/6.5.3/android_armv7"

export ANDROID_SDK_ROOT="${HOME}/Android/Sdk"
export ANDROID_HOME="${HOME}/Android/Sdk"
export ANDROID_NDK_ROOT="${HOME}/Android/Sdk/ndk/android-r11c-standalone-toolchain"

export JENV_VERSION=openjdk64-22.0.2
export JAVA_HOME="$(jenv javahome)"
export PATH="$QT_DESKTOP_DIR/bin:$PATH"


cmake -S . -B build_android && cd build_android || exit
#cmake --build . --parallel

exit 0

