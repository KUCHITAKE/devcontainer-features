#!/bin/bash -i

set -e

# Get options from environment variables
VERSION="${VERSION:-"stable"}"
CHANNEL="${CHANNEL:-"stable"}"
ENABLE_WEB_SUPPORT="${ENABLEWEBSUPPORT:-"true"}"


echo "Installing Flutter SDK..."
echo "Version/Channel: $VERSION"
echo "Channel: $CHANNEL"
echo "Enable Web Support: $ENABLE_WEB_SUPPORT"

# Install Flutter dependencies
install_dependencies() {
    echo "Installing Flutter dependencies..."
    
    if [ -x "/usr/bin/apt-get" ]; then
        apt-get update -y
        apt-get install -y --no-install-recommends \
            git \
            curl \
            unzip \
            xz-utils \
            zip \
            libglu1-mesa
    elif [ -x "/sbin/apk" ]; then
        apk add --no-cache \
            git \
            curl \
            unzip \
            xz \
            zip
    else
        echo "Unsupported package manager"
        exit 1
    fi
}

# Get Flutter download URL
get_flutter_download_url() {
    local version_or_channel=$1
    local channel=$2
    local arch=$(uname -m)
    
    # Map architecture names
    case $arch in
        x86_64)
            arch_suffix="x64"
            ;;
        aarch64|arm64)
            arch_suffix="arm64"
            ;;
        *)
            echo "Unsupported architecture: $arch" >&2
            exit 1
            ;;
    esac
    
    # Determine the download URL based on version/channel
    if [ "$version_or_channel" = "latest" ] || [ "$version_or_channel" = "stable" ]; then
        # Get the latest stable version from Flutter releases API
        local latest_version=$(curl -s "https://storage.googleapis.com/flutter_infra_release/releases/releases_linux.json" | \
            grep -A 10 '"channel": "stable"' | head -20 | \
            grep '"version":' | head -1 | \
            sed 's/.*"version": "\([^"]*\)".*/\1/')
        
        if [ -z "$latest_version" ]; then
            echo "Error: Could not determine latest stable version" >&2
            exit 1
        fi
        
        echo "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${latest_version}-stable.tar.xz"
    elif [ "$version_or_channel" = "beta" ]; then
        # Get the latest beta version
        local latest_version=$(curl -s "https://storage.googleapis.com/flutter_infra_release/releases/releases_linux.json" | \
            grep -A 10 '"channel": "beta"' | head -20 | \
            grep '"version":' | head -1 | \
            sed 's/.*"version": "\([^"]*\)".*/\1/')
        
        if [ -z "$latest_version" ]; then
            echo "Error: Could not determine latest beta version" >&2
            exit 1
        fi
        
        echo "https://storage.googleapis.com/flutter_infra_release/releases/beta/linux/flutter_linux_${latest_version}-beta.tar.xz"
    elif [ "$version_or_channel" = "dev" ]; then
        # Get the latest dev version
        local latest_version=$(curl -s "https://storage.googleapis.com/flutter_infra_release/releases/releases_linux.json" | \
            grep -A 10 '"channel": "dev"' | head -20 | \
            grep '"version":' | head -1 | \
            sed 's/.*"version": "\([^"]*\)".*/\1/')
        
        if [ -z "$latest_version" ]; then
            echo "Error: Could not determine latest dev version" >&2
            exit 1
        fi
        
        echo "https://storage.googleapis.com/flutter_infra_release/releases/dev/linux/flutter_linux_${latest_version}-dev.tar.xz"
    else
        # For specific versions, use the version number in the URL
        echo "https://storage.googleapis.com/flutter_infra_release/releases/${channel}/linux/flutter_linux_${version_or_channel}-${channel}.tar.xz"
    fi
}

# Install dependencies
install_dependencies

# Create Flutter installation directory
FLUTTER_HOME="/opt/flutter"
mkdir -p "$FLUTTER_HOME"

# Determine which version/channel to use
if [ "$VERSION" = "latest" ] || [ "$VERSION" = "stable" ] || [ "$VERSION" = "beta" ] || [ "$VERSION" = "dev" ]; then
    # Use the VERSION as channel
    download_channel="$VERSION"
else
    # Use the specified CHANNEL for specific versions
    download_channel="$CHANNEL"
fi

# Get download URL
download_url=$(get_flutter_download_url "$VERSION" "$download_channel")
echo "Downloading Flutter from: $download_url"

# Download Flutter
temp_dir=$(mktemp -d)
flutter_archive="$temp_dir/flutter.tar.xz"

echo "Downloading to: $flutter_archive"
echo "Temporary directory: $temp_dir"

# Test URL accessibility first
if command -v curl >/dev/null 2>&1; then
    echo "Testing URL accessibility..."
    if ! curl -I -s --fail "$download_url" >/dev/null; then
        echo "Error: Unable to access Flutter download URL: $download_url"
        echo "Please check your internet connection or try a different version."
        exit 1
    fi
fi

curl -sfL "$download_url" -o "$flutter_archive"

# Verify download
if [ ! -f "$flutter_archive" ] || [ ! -s "$flutter_archive" ]; then
    echo "Error: Flutter download failed or file is empty"
    exit 1
fi

echo "Download completed successfully. File size: $(du -h "$flutter_archive" | cut -f1)"

# Extract Flutter
echo "Extracting Flutter SDK..."
tar -xf "$flutter_archive" -C "$temp_dir"

# Move Flutter to installation directory
mv "$temp_dir/flutter"/* "$FLUTTER_HOME/"

# Clean up temporary files
rm -rf "$temp_dir"

# Set up Flutter environment
echo "Setting up Flutter environment..."

# Add Flutter to PATH for all users
cat >> /etc/environment << EOF
PATH="/opt/flutter/bin:\$PATH"
EOF

# Add Flutter to current session PATH
export PATH="/opt/flutter/bin:$PATH"

# Create symlinks for global access
ln -sf /opt/flutter/bin/flutter /usr/local/bin/flutter
ln -sf /opt/flutter/bin/dart /usr/local/bin/dart

# Set proper permissions
chown -R root:root "$FLUTTER_HOME"
chmod -R 755 "$FLUTTER_HOME"

# Configure Flutter
echo "Configuring Flutter..."

# Initialize git repository in Flutter directory to avoid git-related errors
cd "$FLUTTER_HOME"
if [ ! -d ".git" ]; then
    echo "Initializing git repository for Flutter..."
    git init
    git config user.email "devcontainer@example.com"
    git config user.name "DevContainer"
    git add .
    git commit -m "Initial Flutter installation"
fi

# Return to original directory
cd - > /dev/null

# Disable analytics
flutter config --no-analytics

# Enable web support if requested
if [ "$ENABLE_WEB_SUPPORT" = "true" ]; then
    echo "Enabling Flutter web support..."
    flutter config --enable-web
fi

# Pre-download dependencies to speed up first use
echo "Pre-downloading Flutter dependencies..."
flutter precache --web

# Run flutter doctor to verify installation
echo "Verifying Flutter installation..."
flutter doctor

echo "Flutter SDK installation completed successfully!"
echo "Flutter version:"
flutter --version