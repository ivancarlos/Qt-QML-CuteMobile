#!/usr/bin/env bash
set -e

QT_VERSION=6.5.3
JENV_VERSION=openjdk64-17.0.16
NDK=26.2.11394342
ANDROID_ABI=armeabi-v7a
ANDROID_PLATFORM=android-33

#android-platform-manager.sh profile-load  Qt-QML-CuteMobile

# === Qt ${QT_VERSION} (ajuste se o caminho for outro) ===
export QT_BASE_DIR="${HOME}/qt"
export QT_HOST_DIR="${QT_BASE_DIR}/${QT_VERSION}/gcc_64"

QT_ANDROID_ARM64_DIR="${QT_BASE_DIR}/${QT_VERSION}/android_arm64_v8a"
QT_ANDROID_ARMV7_DIR="${QT_BASE_DIR}/${QT_VERSION}/android_armv7"

export QT_ANDROID_DIR="${QT_ANDROID_ARMV7_DIR}"
#export QT_ANDROID_DIR="${QT_ANDROID_ARM64_DIR}"

# === Android SDK/NDK ===
export ANDROID_SDK_ROOT="${HOME}/Android/Sdk"
export ANDROID_HOME="${ANDROID_SDK_ROOT}"
export ANDROID_NDK_ROOT="${ANDROID_SDK_ROOT}/ndk/${NDK}"

# === Java (via jenv, como você já usa) ===
export JENV_VERSION=${JENV_VERSION}
export JAVA_HOME="$(jenv javahome)"

# Coloca as ferramentas de Qt (host + android) no PATH
export PATH="${QT_ANDROID_DIR}/bin:${QT_HOST_DIR}/bin:${PATH}"

# Muito importante para Qt cross-compiled:
export QT_HOST_PATH="${QT_HOST_DIR}"

BUILD_DIR="build-android-${ANDROID_ABI}"
rm -rf "${BUILD_DIR}"
cmake -E make_directory "${BUILD_DIR}"
cd "${BUILD_DIR}"

# Usa o qt-cmake do Qt Android
qt-cmake .. \
    -DQT_HOST_PATH="${QT_HOST_PATH}" \
    -DANDROID_ABI=${ANDROID_ABI} \
    -DANDROID_PLATFORM=${ANDROID_PLATFORM}

    # -DQT_ANDROID_COMPILE_SDK_VERSION=33 \
    # -DQT_ANDROID_MIN_SDK_VERSION=21 \
    # -DQT_ANDROID_TARGET_SDK_VERSION=33

# CMake Warning:
#   Manually-specified variables were not used by the project:
#
#     QT_ANDROID_COMPILE_SDK_VERSION
#     QT_ANDROID_MIN_SDK_VERSION
#     QT_ANDROID_TARGET_SDK_VERSION

# Compila
cmake --build .

exit 0
